Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB321C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989162064A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989162064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCJwO-0003DY-IQ
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 04:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iCJOR-0002hc-VE
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iCJOQ-0004Pv-Jb
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:08:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48878)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iCJOQ-0004Oy-9J
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:08:22 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5220C356F9
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 08:08:21 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id q10so4518755wro.22
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 01:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xATpn9gkkJpKGqIBeLkk1WAFIkbpTrWqf1TP3ewJ8MQ=;
 b=bXlnxFDVjHaiv/t7Rmt8XzRU0V9hmwlZly6CiYbB9XYhuJczr/E//UybVlXbRvxcaD
 7KH0RZn2VR9BRzmjv2nR290MZF6pQxVTVI1p7T/EkcvWo9bnixyg3hVzKFQ4t+FFRkVx
 ViTzKNUaG7ti9W36zR7o4Pwy9lYUFQy4jOPNOYmdgPpsekJMThVYqxL4wr0FtNMmlNv+
 KHfGTAtbftyjPqD48qkzJOfaEnFvt2ALhNJCkK/BOdLosPQGkp4dFQSVO+kHWfquJP88
 0znAcIwpnj2LOP8JIp5ndFstWeVb15vg/M1DBpJidEWnGUvbzeFdpgqz6Uc6lbdXQxrC
 Tp0Q==
X-Gm-Message-State: APjAAAVtdfBlhFbaF0HXAtVdrZvAm1rG8aoCfTgtm3Q9W7zZL4w8qnCo
 fbi8dy9Da0CsNAcqnBun9nZnZCxvnT4wHHH9p7UG+mLpsouHK0YM9QJ/Vc72Hk48kADtKjn//T/
 5xvybP+iVm40Zn5g=
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr13245787wma.111.1569226099997; 
 Mon, 23 Sep 2019 01:08:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwSw72rrjmGFti2WyFLHYX6xQfFdgIsu2h5mkvpex9QcWhB8cRlq66pDD/tXbrQO1cXTT1lwA==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr13245768wma.111.1569226099760; 
 Mon, 23 Sep 2019 01:08:19 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it.
 [79.36.61.170])
 by smtp.gmail.com with ESMTPSA id s1sm24520280wrg.80.2019.09.23.01.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 01:08:19 -0700 (PDT)
Date: Mon, 23 Sep 2019 10:08:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v3 2/2] target/i386: drop the duplicated definition of
 cpuid AVX512_VBMI marco
Message-ID: <20190923080816.hzfzikw5mx4n3ejn@steredhat>
References: <20190923063041.12420-1-tao3.xu@intel.com>
 <20190923063041.12420-3-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923063041.12420-3-tao3.xu@intel.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 23, 2019 at 02:30:41PM +0800, Tao Xu wrote:
> Drop the duplicated definition of cpuid AVX512_VBMI marco and rename it
> as CPUID_7_0_ECX_AVX512_VBMI.
> 
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>  target/i386/cpu.c           | 4 ++--
>  target/i386/cpu.h           | 3 +--
>  target/i386/hvf/x86_cpuid.c | 2 +-
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 9e0bac31e8..f87fe88259 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2412,7 +2412,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
>              CPUID_7_0_EBX_SMAP,
>          .features[FEAT_7_0_ECX] =
> -            CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
> +            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
>              CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
>              CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
>              CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
> @@ -2470,7 +2470,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
>              CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
>          .features[FEAT_7_0_ECX] =
> -            CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
> +            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
>              CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
>              CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
>              CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index fa4c4cad79..61f6287294 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -695,8 +695,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_7_0_EBX_AVX512VL          (1U << 31)
>  
>  /* AVX-512 Vector Byte Manipulation Instruction */
> -#define CPUID_7_0_ECX_AVX512BMI         (1U << 1)
> -#define CPUID_7_0_ECX_VBMI              (1U << 1)
> +#define CPUID_7_0_ECX_AVX512_VBMI       (1U << 1)

Since we're here, should we also update CPUID_7_0_ECX_VBMI2?

Thanks,
Stefano

