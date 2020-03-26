Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59186C2D0F1
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 12:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319A12073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 12:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319A12073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHRvk-0002uT-BE
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 08:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <like.xu@linux.intel.com>) id 1jHRuY-0001sp-82
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 08:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <like.xu@linux.intel.com>) id 1jHRuX-0007qT-4Y
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 08:47:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:14044)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
 id 1jHRuW-0007kM-SU; Thu, 26 Mar 2020 08:47:01 -0400
IronPort-SDR: 3AJ5+34dz68nhnqrVD4bGtWOHQt7lKXbw0Jp1cquznmlwJRWd2lJWvKDOec40uOf2ArdrH9mYX
 SXKueToT25dg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2020 05:46:53 -0700
IronPort-SDR: yRhMi71P7Y+NC5PufaxjVPB1Phjhhz0iuF2fO2dgWp0giOiUdWSSPWcPDmKPYTJ4+POVQcSVln
 pkAY8iZITVNQ==
X-IronPort-AV: E=Sophos;i="5.72,308,1580803200"; d="scan'208";a="420687528"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.249.175.106])
 ([10.249.175.106])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2020 05:46:51 -0700
Subject: Re: [PATCH] i386/cpu: Expand MAX_FIXED_COUNTERS from 3 to 4 to for
 Icelake
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200317055413.66404-1-like.xu@linux.intel.com>
From: Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <4d7696af-b6d3-80b8-dd66-229f3d23ac5c@linux.intel.com>
Date: Thu, 26 Mar 2020 20:46:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317055413.66404-1-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.151
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Anyone to help review this change?

Thanks,
Like Xu

On 2020/3/17 13:54, Like Xu wrote:
> In the Intel SDM, "Table 18-2. Association of Fixed-Function
> Performance Counters with Architectural Performance Events",
> we may have a new fixed counter 'TOPDOWN.SLOTS' (since Icelake),
> which counts the number of available slots for an unhalted
> logical processor. Check commit 6017608936 in the kernel tree.
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>   target/i386/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 576f309bbf..ec2b67d425 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1185,7 +1185,7 @@ typedef struct {
>   #define CPU_NB_REGS CPU_NB_REGS32
>   #endif
>   
> -#define MAX_FIXED_COUNTERS 3
> +#define MAX_FIXED_COUNTERS 4
>   #define MAX_GP_COUNTERS    (MSR_IA32_PERF_STATUS - MSR_P6_EVNTSEL0)
>   
>   #define TARGET_INSN_START_EXTRA_WORDS 1
> 


