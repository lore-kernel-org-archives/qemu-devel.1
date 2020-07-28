Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5634C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:12:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A732320714
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A732320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0EAH-0000WL-02
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 21:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jingqi.liu@intel.com>)
 id 1k0E7k-0005eR-Ut
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 21:09:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:61355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jingqi.liu@intel.com>)
 id 1k0E7i-0001ph-AU
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 21:09:44 -0400
IronPort-SDR: +/4/sIRekadl6QuHEeutLBE211EJmWSFwurvufu8fo8+mSZZR/tM+F0EWRnb34EkR+ec54WXWv
 XwLonS2iyFDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="212658095"
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; d="scan'208";a="212658095"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2020 18:09:33 -0700
IronPort-SDR: 1Dazf2mhTEslFcuCB98A6IGK/VRIez9cT9+WHLdYFlww6E4QQW6zAhQzlS8nEnYP+W/uGGs2Ls
 r+MXWfAcVBBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; d="scan'208";a="329874218"
Received: from jingqili-mobl.ccr.corp.intel.com (HELO [10.238.6.132])
 ([10.238.6.132])
 by orsmga007.jf.intel.com with ESMTP; 27 Jul 2020 18:09:32 -0700
Subject: Re: [PATCH] docs/nvdimm: add 'pmem=on' for the device dax backend file
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20200715025429.28657-1-jingqi.liu@intel.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Message-ID: <f9215aa3-bffe-210b-2eef-560532a57460@intel.com>
Date: Tue, 28 Jul 2020 09:09:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715025429.28657-1-jingqi.liu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31; envelope-from=jingqi.liu@intel.com;
 helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 21:09:34
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

Any comments for this patch ?

Thanks,

Jingqi

On 7/15/2020 10:54 AM, Liu, Jingqi wrote:
> At the end of live migration, QEMU uses msync() to flush the data to
> the backend storage. When the backend file is a character device dax,
> the pages explicitly avoid the page cache. It will return failure from msync().
> The following warning is output.
>
>      "warning: qemu_ram_msync: failed to sync memory range“
>
> So we add 'pmem=on' to avoid calling msync(), use the QEMU command line:
>
>      -object memory-backend-file,id=mem1,pmem=on,mem-path=/dev/dax0.0,size=4G
>
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> ---
>   docs/nvdimm.txt | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> index c2c6e441b3..31048aff5e 100644
> --- a/docs/nvdimm.txt
> +++ b/docs/nvdimm.txt
> @@ -243,6 +243,13 @@ use the QEMU command line:
>   
>       -object memory-backend-file,id=nv_mem,mem-path=/XXX/yyy,size=4G,pmem=on
>   
> +At the end of live migration, QEMU uses msync() to flush the data to the
> +backend storage. When the backend file is a character device dax, the pages
> +explicitly avoid the page cache. It will return failure from msync().
> +So we add 'pmem=on' to avoid calling msync(), use the QEMU command line:
> +
> +    -object memory-backend-file,id=mem1,pmem=on,mem-path=/dev/dax0.0,size=4G
> +
>   References
>   ----------
>   

