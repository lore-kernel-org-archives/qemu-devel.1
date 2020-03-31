Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F21C2D0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348E920784
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWbXHgFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348E920784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJpi-0002fj-Cu
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 12:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jJJoz-00027R-AA
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jJJor-0007gJ-4z
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:32:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49777
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jJJor-0007g6-0M
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585672372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XieNtfkIuGf37R1Ct6MbojdTxe1Xg0SGMH8l0oHr/v4=;
 b=dWbXHgFy1g5o3OlnKzlTspSCIjkxp/ITB3WLcS56GhgQMfPIxzs1U7lbiVM0am54DDheb6
 aDZIE+DGhVy48HUJPNUHHlc7RgizlPjI0R5TKpBcKhubsMs+Cz051fl0EMiPQl5OpH1Hgp
 SD8fFvIo3xy3sJSt6Evqv733qUCldJM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-aMDsh0KhPYSeKamF17gOoQ-1; Tue, 31 Mar 2020 12:32:51 -0400
X-MC-Unique: aMDsh0KhPYSeKamF17gOoQ-1
Received: by mail-wm1-f69.google.com with SMTP id e16so678136wmh.5
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 09:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XieNtfkIuGf37R1Ct6MbojdTxe1Xg0SGMH8l0oHr/v4=;
 b=Xmx8kFHc9/+YcJa5MJFtGA1KF93b4cdylBaVi5uufRpqMdDtbD3rVHMH9MLZAQISlg
 1RaOJGVW2C17EJRA7USqNJoeZq502cvoiYd1QA9o3k3D+weu/It43RVwT8z39d7qKJrX
 UzOyjyVk50UrD1zM+2plr/UrfDaZmu+pzy40QzgVKyxkqVcQXhMEMzQbuAe3ixSmOsDN
 Ryzk12MdX6iOirQdfMCuIoi3Ug18eo3wpWTtkar5RYG0rXA0UADi86WL8a2Q/Dmqmpjw
 /3eCMDbjznlca/+LezdH0+ODHNO7VFE9711IoqHy6MGQLABLOQjstGHPfnEiVOdQRmjJ
 JyrA==
X-Gm-Message-State: AGi0PuZFEulSFnhu3w6HgJBseIgIO7Psrcun80KQZahqgRNvRZZ187wb
 QQNa11kqQ+A77DWgM3XCWdwPUKBsR5nDVH65eiwFYZgGw8uAMMcBlv5qqvVUObUPzfotLRUKMnl
 YWZJd6sQuzpJlBfc=
X-Received: by 2002:a05:600c:2284:: with SMTP id
 4mr869057wmf.103.1585672369926; 
 Tue, 31 Mar 2020 09:32:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypKCDfU2L4k8UU+LV7+PPCzuQvIFo2ldfb0XyeqmcTnZBpD7eQB+q057B7CeyVskURKQq5sr4g==
X-Received: by 2002:a05:600c:2284:: with SMTP id
 4mr869035wmf.103.1585672369643; 
 Tue, 31 Mar 2020 09:32:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b55d:5ed2:8a41:41ea?
 ([2001:b07:6468:f312:b55d:5ed2:8a41:41ea])
 by smtp.gmail.com with ESMTPSA id y189sm4623483wmb.26.2020.03.31.09.32.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:32:49 -0700 (PDT)
Subject: Re: [PATCH] target/i386: do not set unsupported VMX secondary
 execution controls
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
References: <20200331162752.1209928-1-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f976c1b0-2f50-d9f6-0921-2fc8e25ddb80@redhat.com>
Date: Tue, 31 Mar 2020 18:32:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331162752.1209928-1-vkuznets@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/03/20 18:27, Vitaly Kuznetsov wrote:
> Commit 048c95163b4 ("target/i386: work around KVM_GET_MSRS bug for
> secondary execution controls") added a workaround for KVM pre-dating
> commit 6defc591846d ("KVM: nVMX: include conditional controls in /dev/kvm
> KVM_GET_MSRS") which wasn't setting certain available controls. The
> workaround uses generic CPUID feature bits to set missing VMX controls.
> 
> It was found that in some cases it is possible to observe hosts which
> have certain CPUID features but lack the corresponding VMX control.
> 
> In particular, it was reported that Azure VMs have RDSEED but lack
> VMX_SECONDARY_EXEC_RDSEED_EXITING; attempts to enable this feature
> bit result in QEMU abort.
> 
> Resolve the issue but not applying the workaround when we don't have
> to. As there is no good way to find out if KVM has the fix itself, use
> 95c5c7c77c ("KVM: nVMX: list VMX MSRs in KVM_GET_MSR_INDEX_LIST") instead
> as these [are supposed to] come together.
> 
> Fixes: 048c95163b4 ("target/i386: work around KVM_GET_MSRS bug for secondary execution controls")
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Queued, thanks.

Paolo

> ---
>  target/i386/kvm.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 69eb43d796e6..4901c6dd747d 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -106,6 +106,7 @@ static bool has_msr_arch_capabs;
>  static bool has_msr_core_capabs;
>  static bool has_msr_vmx_vmfunc;
>  static bool has_msr_ucode_rev;
> +static bool has_msr_vmx_procbased_ctls2;
>  
>  static uint32_t has_architectural_pmu_version;
>  static uint32_t num_architectural_pmu_gp_counters;
> @@ -490,21 +491,28 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
>      value = msr_data.entries[0].data;
>      switch (index) {
>      case MSR_IA32_VMX_PROCBASED_CTLS2:
> -        /* KVM forgot to add these bits for some time, do this ourselves.  */
> -        if (kvm_arch_get_supported_cpuid(s, 0xD, 1, R_ECX) & CPUID_XSAVE_XSAVES) {
> -            value |= (uint64_t)VMX_SECONDARY_EXEC_XSAVES << 32;
> -        }
> -        if (kvm_arch_get_supported_cpuid(s, 1, 0, R_ECX) & CPUID_EXT_RDRAND) {
> -            value |= (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EXITING << 32;
> -        }
> -        if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) & CPUID_7_0_EBX_INVPCID) {
> -            value |= (uint64_t)VMX_SECONDARY_EXEC_ENABLE_INVPCID << 32;
> -        }
> -        if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) & CPUID_7_0_EBX_RDSEED) {
> -            value |= (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EXITING << 32;
> -        }
> -        if (kvm_arch_get_supported_cpuid(s, 0x80000001, 0, R_EDX) & CPUID_EXT2_RDTSCP) {
> -            value |= (uint64_t)VMX_SECONDARY_EXEC_RDTSCP << 32;
> +        if (!has_msr_vmx_procbased_ctls2) {
> +            /* KVM forgot to add these bits for some time, do this ourselves. */
> +            if (kvm_arch_get_supported_cpuid(s, 0xD, 1, R_ECX) &
> +                CPUID_XSAVE_XSAVES) {
> +                value |= (uint64_t)VMX_SECONDARY_EXEC_XSAVES << 32;
> +            }
> +            if (kvm_arch_get_supported_cpuid(s, 1, 0, R_ECX) &
> +                CPUID_EXT_RDRAND) {
> +                value |= (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EXITING << 32;
> +            }
> +            if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &
> +                CPUID_7_0_EBX_INVPCID) {
> +                value |= (uint64_t)VMX_SECONDARY_EXEC_ENABLE_INVPCID << 32;
> +            }
> +            if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &
> +                CPUID_7_0_EBX_RDSEED) {
> +                value |= (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EXITING << 32;
> +            }
> +            if (kvm_arch_get_supported_cpuid(s, 0x80000001, 0, R_EDX) &
> +                CPUID_EXT2_RDTSCP) {
> +                value |= (uint64_t)VMX_SECONDARY_EXEC_RDTSCP << 32;
> +            }
>          }
>          /* fall through */
>      case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
> @@ -2060,6 +2068,9 @@ static int kvm_get_supported_msrs(KVMState *s)
>              case MSR_IA32_UCODE_REV:
>                  has_msr_ucode_rev = true;
>                  break;
> +            case MSR_IA32_VMX_PROCBASED_CTLS2:
> +                has_msr_vmx_procbased_ctls2 = true;
> +                break;
>              }
>          }
>      }
> 


