Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E71DC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE01D21A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE01D21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDRcD-0000x5-Df
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 07:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iDRao-0008JY-1m
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iDRam-0003Kz-U7
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:05:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iDRam-0003Kg-KG
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:05:48 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BAD7F4E924
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:05:47 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id j3so785897wrn.7
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 04:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YNMZVs9mLMq4h0BCak8cJMtaTNvbROG31YfMp9Sltp8=;
 b=DLoSnBbYpYE4Fcf1VPaDmrhueV8QSvJr20CEWG5PJh4V9UGo0IaLyGEf1ZWgamzvfV
 r2o1UuoWwlU2tdeaGbebvlxyGDtrjg9k3HhbcRneQ4yY7d6neXGG4qwmuwpQ2ken6JMD
 QUkY+9Pey7AmAUbxOtjfpxLlb/1slX+aEJ8A5LN+CpjjhSkvO0PMZ1oGLmbrdI7ubds0
 zJwILlmxlREGt5qZQJYpNaF30ZIwHjt1cpfKMDHYEhalMUR1EEi35fySuGqhFfS4DPrR
 bmLDDLUEn+0Xl7/YF7Dtq4108wYX4Skz02sIlfnFraMmYUEfgmKkmoBAuvMOs9LeuY5g
 9GJg==
X-Gm-Message-State: APjAAAVTRZq64eR/ROR6lp1bxp/LQ2mG1K5+w6Iwu9fgek6ar7+r3OT0
 +fvr+8/5TjOa7DVyIb9OakexP3ve1+sPVgRYGNOEtI7J3sB/6jQcUsA0xatPle3ps1jUFOeKUh3
 vXwvh3e1q8b4kh1k=
X-Received: by 2002:adf:f404:: with SMTP id g4mr2369761wro.353.1569495946103; 
 Thu, 26 Sep 2019 04:05:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy1ySfgcpB6CVtApiuHDyDZTICCPOtP2JRpMRN4StHHsg6uZG9z9xYtt3hcUOsH18yTE5STcQ==
X-Received: by 2002:adf:f404:: with SMTP id g4mr2369746wro.353.1569495945797; 
 Thu, 26 Sep 2019 04:05:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id s5sm2501040wro.27.2019.09.26.04.05.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 04:05:45 -0700 (PDT)
Subject: Re: [PATCH] i386: Add CPUID bit for CLZERO and XSAVEERPTR
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, qemu-devel@nongnu.org
References: <20190925214948.22212-1-bigeasy@linutronix.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6e6f96ae-b7b8-a610-5d54-27ab00c8d8c3@redhat.com>
Date: Thu, 26 Sep 2019 13:05:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925214948.22212-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/19 23:49, Sebastian Andrzej Siewior wrote:
> The CPUID bits CLZERO and XSAVEERPTR are availble on AMD's ZEN platform
> and could be passed to the guest.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> I tweaked the kernel to expose these flags and figured out that this is
> also missing in order see those bits in the guest.
> 
>  target/i386/cpu.c | 2 +-
>  target/i386/cpu.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index fbed2eb804e32..e00ef3c917391 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1113,7 +1113,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>      [FEAT_8000_0008_EBX] = {
>          .type = CPUID_FEATURE_WORD,
>          .feat_names = {
> -            NULL, NULL, NULL, NULL,
> +            "clzero", NULL, "xsaveerptr", NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, "wbnoinvd", NULL, NULL,
>              "ibpb", NULL, NULL, NULL,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 0732e059ec989..cc475c703fc4d 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -689,6 +689,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities*/
>  #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
>  
> +#define CPUD_800_008_EBX_CLZERO		(1U << 0) /* CLZERO instruction */
> +#define CPUD_800_008_EBX_XSAVEERPTR	(1U << 2) /* Always save/restore FP error pointers */
>  #define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)  /* Write back and
>                                                                               do not invalidate cache */
>  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
> 

Yup, queued this one.

Paolo

