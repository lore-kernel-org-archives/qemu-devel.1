Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E46C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 23:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E517621848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 23:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E517621848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0w7D-0001l6-2N
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 19:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0w6Q-0001Jw-Ho
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0w6P-0001GC-E6
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:02:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0w6P-0001G2-6U
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:02:45 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 052B4796E7
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 23:02:44 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id z2so3911336wrt.6
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 16:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kmQVTk4NF7XpUi8RpDZc9GfK/iw6yFL51cCifX3n1ok=;
 b=cgWD4QMqw8PgLGHwI/dlA5IrOtgJsSTQgAOaiQSvDlOEGcSLTz0f3RG1ZQv/riKDit
 VHOgCFi6BV/08Ns7JkwfWszpWjodmEq3gg5/NynjuA9W6KTUOwDmvwwQ6BjA/WW09BPS
 Z7C9fgoNwTSlxQzFQGWr/X3U1au2FlFtZFulC9PuTyK4N6a5sCY2VtyO+Unb1Epoww8c
 bhg61KwbQ12aZ+eyE+KllIpKGkycFX91eR5++HnSGvu1s9dgd4L2SV2W6Byzea5BzZ/f
 Yncqx1ooIL2xhsUcJIamwTxE+iO3kW4ejDuRCR9Rkgkf8JMNASzOQEkFCUPNBsXcUEru
 MBdA==
X-Gm-Message-State: APjAAAU3PaXVahifFQPflmONJXrJXOmv2a+IMKYEc3otOo4vQ/yic7YX
 CrMx5Y4FrlF6Vr6g1J52grTdJmBl7Mwvqei7wuT2C3VKHwFifGBvNTXSDs0A4njngDkX0nWwVqV
 sRXDyHWe//GlMGQI=
X-Received: by 2002:adf:f0ce:: with SMTP id x14mr1215892wro.31.1566514962630; 
 Thu, 22 Aug 2019 16:02:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw+eQthuLSqmF7C2n8GS7RYzqQi6ASB9T+ssvnUGEgoQxNtMg02aB1D1t8DIs9SssHmNKP1zg==
X-Received: by 2002:adf:f0ce:: with SMTP id x14mr1215879wro.31.1566514962318; 
 Thu, 22 Aug 2019 16:02:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3?
 ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
 by smtp.gmail.com with ESMTPSA id e15sm697987wrj.74.2019.08.22.16.02.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 16:02:41 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190822225210.32541-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6e22e468-2f28-efdf-bb77-f4dae3d20f4f@redhat.com>
Date: Fri, 23 Aug 2019 01:02:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822225210.32541-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] i386: Omit all-zeroes entries from KVM
 CPUID table
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
Cc: Yumei Huang <yuhuang@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/08/19 00:52, Eduardo Habkost wrote:
> KVM has a 80-entry limit at KVM_SET_CPUID2.  With the
> introduction of CPUID[0x1F], it is now possible to hit this limit
> with unusual CPU configurations, e.g.:
> 
>   $ ./x86_64-softmmu/qemu-system-x86_64 \
>     -smp 1,dies=2,maxcpus=2 \
>     -cpu EPYC,check=off,enforce=off \
>     -machine accel=kvm
>   qemu-system-x86_64: kvm_init_vcpu failed: Argument list too long
> 
> This happens because QEMU adds a lot of all-zeroes CPUID entries
> for unused CPUID leaves.  In the example above, we end up
> creating 48 all-zeroes CPUID entries.
> 
> KVM already returns all-zeroes when emulating the CPUID
> instruction if an entry is missing, so the all-zeroes entries are
> redundant.  Skip those entries.  This reduces the CPUID table
> size by half while keeping CPUID output unchanged.
> 
> Reported-by: Yumei Huang <yuhuang@redhat.com>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1741508
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/kvm.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 8023c679ea..4e3df2867d 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1529,6 +1529,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>              c->function = i;
>              c->flags = 0;
>              cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
> +            if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
> +                /*
> +                 * KVM already returns all zeroes if a CPUID entry is missing,
> +                 * so we can omit it and avoid hitting KVM's 80-entry limit.
> +                 */
> +                cpuid_i--;
> +            }
>              break;
>          }
>      }
> @@ -1593,6 +1600,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>              c->function = i;
>              c->flags = 0;
>              cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
> +            if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
> +                /*
> +                 * KVM already returns all zeroes if a CPUID entry is missing,
> +                 * so we can omit it and avoid hitting KVM's 80-entry limit.
> +                 */
> +                cpuid_i--;
> +            }
>              break;
>          }
>      }
> 


