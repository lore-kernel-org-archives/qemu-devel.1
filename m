Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D367CC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 07:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA868218A5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 07:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA868218A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoNBl-0005If-UM
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 03:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59428)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jing2.liu@linux.intel.com>) id 1hoNBa-0004rF-MO
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 03:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jing2.liu@linux.intel.com>) id 1hoNBZ-0003wy-HU
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 03:20:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:10557)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
 id 1hoNBZ-0003uJ-7E
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 03:20:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Jul 2019 00:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,281,1559545200"; d="scan'208";a="195864081"
Received: from liujing-mobl.ccr.corp.intel.com (HELO [10.238.128.251])
 ([10.238.128.251])
 by fmsmga002.fm.intel.com with ESMTP; 19 Jul 2019 00:20:06 -0700
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1562823509-13072-1-git-send-email-jing2.liu@linux.intel.com>
 <c572cdd2-d0f4-2e06-99f8-302b798a04dd@linux.intel.com>
 <0f9763fe-af69-e057-9fb1-00527e636fe4@redhat.com>
From: Jing Liu <jing2.liu@linux.intel.com>
Message-ID: <0ffa32db-3615-16e0-71bf-a8c552c2fcfb@linux.intel.com>
Date: Fri, 19 Jul 2019 15:20:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0f9763fe-af69-e057-9fb1-00527e636fe4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
Subject: Re: [Qemu-devel] [PATCH v1] x86: Intel AVX512_BF16 feature enabling
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/18/2019 4:15 PM, Paolo Bonzini wrote:
> On 18/07/19 06:55, Jing Liu wrote:
>>>
>>> +            *eax = kvm_arch_get_supported_cpuid(cs->kvm_state, 0x7,
>>> +                                                count, R_EAX);
>> This needs to be firstly checked as follows, otherwise some
>> architectures would fail to compile.
>>
>> What about hvf and tcg CPUID 07 EAX value?
>>
>> +            /* Maximum ECX value for sub-leaves */
>> +            if (kvm_enabled()) {
>> +                *eax = kvm_arch_get_supported_cpuid(cs->kvm_state, 0x7,
>> +                                                    count, R_EAX);
>> +            } else if (hvf_enabled()) {
>> +                *eax = hvf_get_supported_cpuid(0x7, count, R_EAX);
>> +            } else {
>> +                *eax = 0;
>> +            }
>>
> 
> Good question.  You need to add a new property, for example
> cpuid_level_func7, whose code would be modeled around cpuid_level (and a
> field cpuid_min_level_func7 whose code would be modeled around
> cpuid_min_level).
> 
> Then CPUID[7,0].EAX is set automatically to 0 or 1 depending on whether
> BF16 is enabled or not.

Could I ask why don't we directly check BF16 enabling when
cpu_x86_cpuid(env, 7, 0, ...) during kvm_arch_init_vcpu ?

What is the use of the two new properties? Are they used for users
setting parameters when boot up guest, and why we need users setting 
func7 level?

I tried to implement the code as follows.

@@ -4293,13 +4313,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t 
index, uint32_t count,
      case 7:
          /* Structured Extended Feature Flags Enumeration Leaf */
          if (count == 0) {
-            *eax = 0; /* Maximum ECX value for sub-leaves */
+            /* Maximum ECX value for sub-leaves */
+            *eax = env->cpuid_level_func7;
[...]
+        } else if (count == 1) {
+            *eax = env->features[FEAT_7_1_EAX];
+            *ebx = 0;
+            *ecx = 0;
+            *edx = 0;
[...]
@@ -5075,6 +5101,10 @@ static void x86_cpu_expand_features(X86CPU *cpu, 
Error **errp)
          x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
          x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);

+       if ((env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_AVX512_BF16) &&
+            kvm_enabled()) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_level_func7, 1);
+        }
          /* Intel Processor Trace requires CPUID[0x14] */
          if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
               kvm_enabled() && cpu->intel_pt_auto_level) {
@@ -5098,6 +5128,9 @@ static void x86_cpu_expand_features(X86CPU *cpu, 
Error **errp)
      }

      /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly 
set */
+    if (env->cpuid_level_func7 == UINT32_MAX) {
+        env->cpuid_level_func7 = env->cpuid_min_level_func7;
+    }
      if (env->cpuid_level == UINT32_MAX) {
          env->cpuid_level = env->cpuid_min_level;
      }
@@ -5869,9 +5902,11 @@ static Property x86_cpu_properties[] = {
      DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
      DEFINE_PROP_UINT8("host-phys-bits-limit", X86CPU, 
host_phys_bits_limit, 0),
      DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),
+    DEFINE_PROP_UINT32("level-func7", X86CPU, env.cpuid_level_func7, 
UINT32_MAX),
      DEFINE_PROP_UINT32("level", X86CPU, env.cpuid_level, UINT32_MAX),
      DEFINE_PROP_UINT32("xlevel", X86CPU, env.cpuid_xlevel, UINT32_MAX),
      DEFINE_PROP_UINT32("xlevel2", X86CPU, env.cpuid_xlevel2, UINT32_MAX),
+    DEFINE_PROP_UINT32("min-level-func7", X86CPU, 
env.cpuid_min_level_func7, 0),
[...]

Thanks,
Jing


> 
> Paolo
> 

