Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0A1ECE58D
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 02:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9B3206CD
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 02:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9B3206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ7NG-0007ZW-6W
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 22:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iJ7Md-00078M-D1
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 22:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iJ7Ma-000255-Kd
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 22:42:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49674)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iJ7Ma-000230-Bx
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 22:42:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 010492BF02;
 Sat, 12 Oct 2019 02:42:34 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94E6D5C1B2;
 Sat, 12 Oct 2019 02:42:33 +0000 (UTC)
Date: Fri, 11 Oct 2019 23:42:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH 2/2] target/i386: Add support for put/get PEBS registers
Message-ID: <20191012024232.GA832@habkost.net>
References: <1567056175-14275-1-git-send-email-luwei.kang@intel.com>
 <1567056175-14275-2-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567056175-14275-2-git-send-email-luwei.kang@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Sat, 12 Oct 2019 02:42:34 +0000 (UTC)
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 29, 2019 at 01:22:55PM +0800, Luwei Kang wrote:
> This patch add a new feature words for IA32_PERF_CAPABILITIES (RO)
> register that serve to expose PEBS output Intel PT feature.
> The registers relate with PEBS need to be set/get when PEBS output
> Intel PT is supported in guest.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>

Sorry for taking so long to take a look at the series.

What's the status of the kernel KVM patches for this?

> ---
>  target/i386/cpu.c | 20 ++++++++++++++++++++
>  target/i386/cpu.h |  4 ++++
>  target/i386/kvm.c | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 9e0bac3..7fe34c0 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1244,6 +1244,26 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              },
>          },
>      },
> +    [FEAT_PERF_CAPABILITIES] = {
> +        .type = MSR_FEATURE_WORD,
> +        .feat_names = {
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            "pebs-output-pt", NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .msr = {
> +            .index = MSR_IA32_PERF_CAPABILITIES,
> +            .cpuid_dep = {
> +                FEAT_1_ECX,
> +                CPUID_EXT_PDCM,
> +            },
> +        },
> +    },
>  };
>  
>  typedef struct X86RegisterInfo32 {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index d7cec36..0904004 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -347,6 +347,7 @@ typedef enum X86Seg {
>  #define MSR_IA32_PRED_CMD               0x49
>  #define MSR_IA32_CORE_CAPABILITY        0xcf
>  #define MSR_IA32_ARCH_CAPABILITIES      0x10a
> +#define MSR_IA32_PERF_CAPABILITIES      0x345
>  #define MSR_IA32_TSCDEADLINE            0x6e0
>  
>  #define FEATURE_CONTROL_LOCKED                    (1<<0)
> @@ -503,6 +504,7 @@ typedef enum FeatureWord {
>      FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
>      FEAT_ARCH_CAPABILITIES,
>      FEAT_CORE_CAPABILITY,
> +    FEAT_PERF_CAPABILITIES,
>      FEATURE_WORDS,
>  } FeatureWord;
>  
> @@ -754,6 +756,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  
>  #define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
>  
> +#define MSR_PERF_CAP_PEBS_VIA_PT        (1ULL << 16)
> +
>  /* Supported Hyper-V Enlightenments */
>  #define HYPERV_FEAT_RELAXED             0
>  #define HYPERV_FEAT_VAPIC               1
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 8023c67..c0dcc13 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2651,6 +2651,20 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>                  kvm_msr_entry_add(cpu, MSR_IA32_RTIT_ADDR0_A + i,
>                              env->msr_rtit_addrs[i]);
>              }
> +
> +            if (env->features[FEAT_PERF_CAPABILITIES] &
> +                                        MSR_PERF_CAP_PEBS_VIA_PT) {
> +                kvm_msr_entry_add(cpu, MSR_IA32_PEBS_ENABLE,
> +                                env->msr_pebs_enable);
> +                for (i = 0; i < num_architectural_pmu_fixed_counters; i++) {
> +                    kvm_msr_entry_add(cpu, MSR_RELOAD_FIXED_CTR0 + i,
> +                                env->msr_reload_fixed_ctr[i]);
> +                }
> +                for (i = 0; i < num_architectural_pmu_gp_counters; i++) {
> +                    kvm_msr_entry_add(cpu, MSR_RELOAD_PMC0 + i,
> +                                env->msr_reload_pmc[i]);
> +                }
> +            }
>          }
>  
>          /* Note: MSR_IA32_FEATURE_CONTROL is written separately, see
> @@ -2989,6 +3003,16 @@ static int kvm_get_msrs(X86CPU *cpu)
>          for (i = 0; i < addr_num; i++) {
>              kvm_msr_entry_add(cpu, MSR_IA32_RTIT_ADDR0_A + i, 0);
>          }
> +
> +        if (env->features[FEAT_PERF_CAPABILITIES] & MSR_PERF_CAP_PEBS_VIA_PT) {
> +            kvm_msr_entry_add(cpu, MSR_IA32_PEBS_ENABLE, 0);
> +            for (i = 0; i < num_architectural_pmu_fixed_counters; i++) {
> +                kvm_msr_entry_add(cpu, MSR_RELOAD_FIXED_CTR0 + i, 0);
> +            }
> +            for (i = 0; i < num_architectural_pmu_gp_counters; i++) {
> +                kvm_msr_entry_add(cpu, MSR_RELOAD_PMC0 + i, 0);
> +            }
> +        }
>      }
>  
>      ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, cpu->kvm_msr_buf);
> @@ -3268,6 +3292,18 @@ static int kvm_get_msrs(X86CPU *cpu)
>          case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
>              env->msr_rtit_addrs[index - MSR_IA32_RTIT_ADDR0_A] = msrs[i].data;
>              break;
> +        case MSR_IA32_PEBS_ENABLE:
> +            env->msr_pebs_enable = msrs[i].data;
> +            break;
> +        case MSR_RELOAD_FIXED_CTR0 ...
> +                                MSR_RELOAD_FIXED_CTR0 + MAX_FIXED_COUNTERS - 1:
> +            env->msr_reload_fixed_ctr[index - MSR_RELOAD_FIXED_CTR0] =
> +                                                                msrs[i].data;
> +            break;
> +        case MSR_RELOAD_PMC0 ...
> +                                MSR_RELOAD_PMC0 + MAX_GP_COUNTERS - 1:
> +            env->msr_reload_fixed_ctr[index - MSR_RELOAD_PMC0] = msrs[i].data;
> +            break;
>          }
>      }
>  
> -- 
> 1.8.3.1
> 

-- 
Eduardo

