Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42940C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 07:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D1320663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 07:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D1320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE6wj-0004gs-5l
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 03:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Colin.Xu@intel.com>) id 1jE6w3-0003vj-8T
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 03:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Colin.Xu@intel.com>) id 1jE6w1-0003PF-Bv
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 03:46:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:2549)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Colin.Xu@intel.com>) id 1jE6w1-0002hu-1n
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 03:46:45 -0400
IronPort-SDR: oL1HfekYzLcWqgnhNr7G8jWRqB4Qso5STAbhTIVDnTbpcqmPwAgF41vhK+4J+giftagh2YDbQa
 xWJlEidXbrAQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2020 00:46:39 -0700
IronPort-SDR: NKnRTRR+a7mhp14O9TshT8ztZ9sEREq61NC/+/XGTpfcWyIpCubKleNlvlWwmtShklfBOS71Pp
 uHyIboDHcVjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; d="scan'208";a="267875991"
Received: from coxu-arch-shz.sh.intel.com (HELO [10.239.160.52])
 ([10.239.160.52])
 by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2020 00:46:38 -0700
Subject: Re: [PULL 09/61] MAINTAINERS: Add entry for Guest X86 HAXM CPUs
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
 <1584394048-44994-10-git-send-email-pbonzini@redhat.com>
From: Colin Xu <Colin.Xu@intel.com>
Message-ID: <d9e9e44f-ba54-c2e7-01c8-72337d3f5993@intel.com>
Date: Tue, 17 Mar 2020 15:46:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584394048-44994-10-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.65
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
Reply-To: Colin.Xu@intel.com
Cc: Wenchao Wang <wenchao.wang@intel.com>, Hang Yuan <hang.yuan@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

For future HAX patch, once it's "Reviewed-by" haxm maintainers and other 
reviewers, do we need "SubmitAPullRequest" separately or you will do it 
together with other patches?

Colin

On 2020-03-17 05:26, Paolo Bonzini wrote:
> From: Colin Xu <colin.xu@intel.com>
>
> HAXM covers below files:
> include/sysemu/hax.h
> target/i386/hax-*
>
> V2: Add HAXM github page for wiki and issue tracking.
>
> Cc: Wenchao Wang <wenchao.wang@intel.com>
> Cc: Hang Yuan <hang.yuan@intel.com>
> Reviewed-by: Hang Yuan <hang.yuan@intel.com>
> Signed-off-by: Colin Xu <colin.xu@intel.com>
> Message-Id: <20200228012046.6629-1-colin.xu@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   MAINTAINERS | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32867bc..a88bc28 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -436,6 +436,17 @@ F: include/hw/block/dataplane/xen*
>   F: include/hw/xen/
>   F: include/sysemu/xen-mapcache.h
>   
> +Guest CPU Cores (HAXM)
> +---------------------
> +X86 HAXM CPUs
> +M: Wenchao Wang <wenchao.wang@intel.com>
> +M: Colin Xu <colin.xu@intel.com>
> +L: haxm-team@intel.com
> +W: https://github.com/intel/haxm/issues
> +S: Maintained
> +F: include/sysemu/hax.h
> +F: target/i386/hax-*
> +
>   Hosts
>   -----
>   LINUX

-- 
Best Regards,
Colin Xu


