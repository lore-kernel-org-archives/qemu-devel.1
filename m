Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BC6C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC268214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC268214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58596 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfikb-0004nI-5E
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38605)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hfij4-0003nt-Oa
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hfij3-0004Rg-NG
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:30:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hfij3-0004QU-H3
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:30:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so17231601wrm.8
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 03:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s2YvqycvtNztQgARyw45xRUHNiteTkGkqMMl25QJBWY=;
 b=pTLvEq/VwTLANcTH3KLYNe1DVVCE5ZSxY3zWjvRLWCc5iHY3cO1ysGNTfycETQqXfO
 RxHx1/jXI97eDP4B1Bn33l8BHHE/UIQVBAoKy1LKf9EEg6OFIZCmDscJJW0Vimcsx+IX
 0aSNpOi3NQ/jf6T/Li5amxHeMIj+eekrqQ+/h7B5Zht0cMI+DcVQSmv/TTi1lMQuXNM3
 KvMLC0RbGap2MUrn1h9bNGdaNCFidZk0ybq2QFDg+MND2SWRY64MkAXBRnXxdGjk9cy6
 FIGUdI7EaaB1pbX6yZ4eASN29GKVsGjk4Z8yndmU/+3MJWRlLuZJBBXlfFT3V++5uXIJ
 Vavw==
X-Gm-Message-State: APjAAAXm1ayh35P9bglOc8Tsyod59EVqC3DvWHhaYrtWwM5TnHeZVtYg
 qyMdKj7+6zTDuolvnpu8GwJp6g==
X-Google-Smtp-Source: APXvYqyRBx4Xk9UoPCkcaL7KvfYkg1zbdu+q/O3MS6nm4lZ1DmEOV2SrDCMIRgsWO706Gmtqk5x2nQ==
X-Received: by 2002:adf:f1d2:: with SMTP id z18mr1868725wro.262.1561458656500; 
 Tue, 25 Jun 2019 03:30:56 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id e11sm31840050wrc.9.2019.06.25.03.30.55
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 03:30:56 -0700 (PDT)
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20190624193913.28343-1-mreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <67508f65-6eda-bf80-533a-a86949328156@redhat.com>
Date: Tue, 25 Jun 2019 12:30:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624193913.28343-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2] i386/kvm: Fix build with -m32
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/19 9:39 PM, Max Reitz wrote:
> find_next_bit() takes a pointer of type "const unsigned long *", but the
> first argument passed here is a "uint64_t *".  These types are
> incompatible when compiling qemu with -m32.
> 
> Just use ctz64() instead.
> 
> Fixes: c686193072a47032d83cb4e131dc49ae30f9e5d
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  target/i386/kvm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index e4b4f5756a..31490bf8b5 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1043,14 +1043,15 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
>      CPUX86State *env = &cpu->env;
>      uint32_t r, fw, bits;
>      uint64_t deps;
> -    int i, dep_feat = 0;
> +    int i, dep_feat;
>  
>      if (!hyperv_feat_enabled(cpu, feature) && !cpu->hyperv_passthrough) {
>          return 0;
>      }
>  
>      deps = kvm_hyperv_properties[feature].dependencies;
> -    while ((dep_feat = find_next_bit(&deps, 64, dep_feat)) < 64) {
> +    while (deps) {
> +        dep_feat = ctz64(deps);
>          if (!(hyperv_feat_enabled(cpu, dep_feat))) {
>                  fprintf(stderr,
>                          "Hyper-V %s requires Hyper-V %s\n",
> @@ -1058,7 +1059,7 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
>                          kvm_hyperv_properties[dep_feat].desc);
>                  return 1;
>          }
> -        dep_feat++;
> +        deps &= ~(1ull << dep_feat);

Easier than using deposit64(), OK.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>      }
>  
>      for (i = 0; i < ARRAY_SIZE(kvm_hyperv_properties[feature].flags); i++) {
> 

