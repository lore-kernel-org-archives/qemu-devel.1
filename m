Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB9EC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58BF21019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58BF21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho6pn-0008B5-01
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 09:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41463)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1ho6pN-0007Ut-NG
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ho6pL-0006V9-FU
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:52:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ho6pJ-0006SZ-G2
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:52:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so28839278wrm.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 06:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9QAP+zuB4VlhBuAFrMWQBaK/7c9xoMqOvnQXoCtu7J4=;
 b=ga76ujqryovKGudRANitiuS6whr5wDuwW4LrANAodNtQRiiDCX96/w7XwpD7xyn6D6
 9SbOP16AMA+2HqhWRpG/EAuUea5AP9vzKNJ4rQQqkgepLM7GB50S11da9D2OkUDy/Tx8
 6eE/G+Z0jFWQKr2x6hqnFVbdsyAhlxDimZDHuSi/w1jgYPhqAbAVTKOuzMiLg6O+0z/J
 iJrP2IkefVY6DM5w/bcXWkRLvRW7cOHOUz3KgVZHyLI8pDIUhqXw6NSMR82umhW06yNF
 IfjZFyElzVetqM0qOOtpYA96X3CpzcWp8CKeMQ1Z8uspFC3hyW1+/65BIlpnGU9rDU7E
 ioAg==
X-Gm-Message-State: APjAAAUDIwhFndk7w0cCo1MgFpVMIJirUMdbDy7x3zeqFB5ITgo3p2L1
 ajWUOLqk5f9EIqyP5QgrA027Fg==
X-Google-Smtp-Source: APXvYqwZS1eBOhfUGcmC1NoDw7IwROg5e1gALVO2PCA3sAWkDXZN2T3zNvIG6J8vSRm7M0dXDoyyYA==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr51028807wrt.84.1563457922730; 
 Thu, 18 Jul 2019 06:52:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id z6sm23117310wrw.2.2019.07.18.06.52.01
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 06:52:02 -0700 (PDT)
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
References: <20190718134537.22356-1-den@openvz.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4620eddd-e500-25d2-a8b2-5c47eefc74ab@redhat.com>
Date: Thu, 18 Jul 2019 15:52:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718134537.22356-1-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 1/1] x86: add CPU flags supported inside
 libvirt
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
Cc: Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/07/19 15:45, Denis V. Lunev wrote:
> There are the following flags available in libvirt inside cpu_map.xm
>     <feature name='cvt16'>
>       <cpuid function='0x80000001' ecx='0x00040000'/>
>     </feature>
>     <feature name='cmt'> <!-- cqm -->
>       <cpuid eax_in='0x07' ecx_in='0x00' ebx='0x00001000'/>
>     </feature>
> We have faced the problem that QEMU does not start once these flags are
> present in the domain.xml.
> 
> This patch just adds proper names into the map.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
> CC: Peter Krempa <pkrempa@redhat.com>
> CC: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  target/i386/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 805ce95247..88ba4dad47 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -870,7 +870,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              "lahf-lm", "cmp-legacy", "svm", "extapic",
>              "cr8legacy", "abm", "sse4a", "misalignsse",
>              "3dnowprefetch", "osvw", "ibs", "xop",
> -            "skinit", "wdt", NULL, "lwp",
> +            "skinit", "wdt", "cvt16", "lwp",
>              "fma4", "tce", NULL, "nodeid-msr",
>              NULL, "tbm", "topoext", "perfctr-core",
>              "perfctr-nb", NULL, NULL, NULL,
> @@ -1044,7 +1044,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              "fsgsbase", "tsc-adjust", NULL, "bmi1",
>              "hle", "avx2", NULL, "smep",
>              "bmi2", "erms", "invpcid", "rtm",
> -            NULL, NULL, "mpx", NULL,
> +            "cmt", NULL, "mpx", NULL,
>              "avx512f", "avx512dq", "rdseed", "adx",
>              "smap", "avx512ifma", "pcommit", "clflushopt",
>              "clwb", "intel-pt", "avx512pf", "avx512er",
> 

Oops, nice catch!  I've queued the patch for 4.1.

Paolo

