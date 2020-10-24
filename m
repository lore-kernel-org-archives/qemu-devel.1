Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DDCC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 12:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D442225F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 12:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D442225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWIHD-0005R7-6C
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 08:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kWIFI-0003jD-4x
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 08:02:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:57016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kWIFC-00059K-4a
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 08:02:01 -0400
IronPort-SDR: zDuv+V/1hIGPa+pjU+W/RBsZH9oyBiOg368OQOsvHM4JTqswZxdhFiKc9s23qzdedTVZDE5Wau
 gmaslSbXklTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9783"; a="167864650"
X-IronPort-AV: E=Sophos;i="5.77,412,1596524400"; d="scan'208";a="167864650"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2020 05:01:51 -0700
IronPort-SDR: zMdpgpBjlOaviV5GV9llBZsph5bJko97SFOkMjTJO2MI9VykH9jCmg+qJGk2Gl5252gmrq+8c2
 TMWPgpkGRKMA==
X-IronPort-AV: E=Sophos;i="5.77,412,1596524400"; d="scan'208";a="534741634"
Received: from joy-optiplex-7040.sh.intel.com (HELO yzhao56-desk)
 ([10.239.13.16])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2020 05:01:45 -0700
Date: Sat, 24 Oct 2020 20:00:27 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v28 10/17] memory: Set DIRTY_MEMORY_MIGRATION when IOMMU
 is enabled
Message-ID: <20201024120027.GD11827@yzhao56-desk>
References: <1603449643-12851-1-git-send-email-kwankhede@nvidia.com>
 <1603449643-12851-11-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603449643-12851-11-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=134.134.136.65; envelope-from=yan.y.zhao@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 07:57:41
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: cohuck@redhat.com, cjia@nvidia.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com, artemp@nvidia.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
On Fri, Oct 23, 2020 at 04:10:36PM +0530, Kirti Wankhede wrote:
> mr->ram_block is NULL when mr->is_iommu is true, then fr.dirty_log_mask
> wasn't set correctly due to which memory listener's log_sync doesn't
> get called.
> This patch returns log_mask with DIRTY_MEMORY_MIGRATION set when
> IOMMU is enabled.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> ---
>  softmmu/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 403ff3abc99b..94f606e9d9d9 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1792,7 +1792,7 @@ bool memory_region_is_ram_device(MemoryRegion *mr)
>  uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
>  {
>      uint8_t mask = mr->dirty_log_mask;
> -    if (global_dirty_log && mr->ram_block) {
> +    if (global_dirty_log && (mr->ram_block || memory_region_is_iommu(mr))) {
>          mask |= (1 << DIRTY_MEMORY_MIGRATION);
>      }
>      return mask;
> -- 
> 2.7.0
> 

