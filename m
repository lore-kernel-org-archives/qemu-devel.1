Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33891C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0859E2074F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0859E2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHvX-0007CE-95
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jqHuK-0006CX-PI; Tue, 30 Jun 2020 11:10:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:60577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jqHuI-0006Q9-KI; Tue, 30 Jun 2020 11:10:48 -0400
IronPort-SDR: UdTqiIEhpIffiuNE3wq5ZK7IAvixNmBP6fDH3vPQLgMl/5Cmncdm0NlKs8Tq7FVb9NXdHxMafJ
 +8GTNgljY9Rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="147807098"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; d="scan'208";a="147807098"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 08:10:43 -0700
IronPort-SDR: 94vQ/0NliUIh9wcexFalpa33QqLFd3g0eZRY+9qIYCCfAPprrREWrZzBVpPvIDzqdbqMLW1NTi
 hkeHYuLxcitg==
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; d="scan'208";a="481223086"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.212.222.216])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 08:10:42 -0700
Subject: Re: [PATCH v3 3/4] hw/block/nvme: Fix pmrmsc register size
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200630110429.19972-1-philmd@redhat.com>
 <20200630110429.19972-4-philmd@redhat.com>
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <45a97bae-887c-2669-439e-08ec3e75113e@linux.intel.com>
Date: Tue, 30 Jun 2020 08:10:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630110429.19972-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.24;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 11:10:43
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 4:04 AM, Philippe Mathieu-Daudé wrote:
> The Persistent Memory Region Controller Memory Space Control
> register is 64-bit wide. See 'Figure 68: Register Definition'
> of the 'NVM Express Base Specification Revision 1.4'.
> 
> Fixes: 6cf9413229 ("introduce PMR support from NVMe 1.4 spec")
> Reported-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Cc: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> ---
>  include/block/nvme.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 71c5681912..82c384614a 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -21,7 +21,7 @@ typedef struct QEMU_PACKED NvmeBar {
>      uint32_t    pmrsts;
>      uint32_t    pmrebs;
>      uint32_t    pmrswtp;
> -    uint32_t    pmrmsc;
> +    uint64_t    pmrmsc;
>  } NvmeBar;
>  
>  enum NvmeCapShift {
> -- 2.21.3

This is good catch, though I wanted to highlight that this will still 
need to change as this register is not aligned properly and thus not in
compliance with spec.

Reviewed-by Andrzej Jakowski <andrzej.jakowski@linux.intel.com>

