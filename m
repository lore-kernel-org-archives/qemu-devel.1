Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CD5C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE89207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE89207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDS9i-0007Tc-6a
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 07:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iDS8H-0006Ic-TL
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iDS8G-0007Te-4g
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:40:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iDS8A-0007FV-RY; Thu, 26 Sep 2019 07:40:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8EEE6307D851;
 Thu, 26 Sep 2019 11:40:17 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 181AF60C80;
 Thu, 26 Sep 2019 11:40:05 +0000 (UTC)
Date: Thu, 26 Sep 2019 13:40:03 +0200
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v4 8/9] target/arm/cpu64: max cpu: Support sve properties
 with KVM
Message-ID: <20190926114003.2jw5f5orkjrzdhvo@kamzik.brq.redhat.com>
References: <20190924113105.19076-1-drjones@redhat.com>
 <20190924113105.19076-9-drjones@redhat.com>
 <f8578400-c587-73f8-3517-6cc89cd56471@redhat.com>
 <20190926084117.xfshky2tyunzvvv2@kamzik.brq.redhat.com>
 <ea68a4f8-fbf2-3def-3815-f0dc64f81184@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea68a4f8-fbf2-3def-3815-f0dc64f81184@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 26 Sep 2019 11:40:17 +0000 (UTC)
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, armbru@redhat.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 12:01:36PM +0200, Auger Eric wrote:
> 
> 
> On 9/26/19 10:41 AM, Andrew Jones wrote:
> > On Thu, Sep 26, 2019 at 08:52:55AM +0200, Auger Eric wrote:
> >> Hi Drew,
> >>
> >> On 9/24/19 1:31 PM, Andrew Jones wrote:
> >>> Extend the SVE vq map initialization and validation with KVM's
> >>> supported vector lengths when KVM is enabled. In order to determine
> >>> and select supported lengths we add two new KVM functions for getting
> >>> and setting the KVM_REG_ARM64_SVE_VLS pseudo-register.
> >>>
> >>> This patch has been co-authored with Richard Henderson, who reworked
> >>> the target/arm/cpu64.c changes in order to push all the validation and
> >>> auto-enabling/disabling steps into the finalizer, resulting in a nice
> >>> LOC reduction.
> >>>
> >>> Signed-off-by: Andrew Jones <drjones@redhat.com>
> >>> ---
> >>>  docs/arm-cpu-features.rst |  36 +++++---
> >>>  target/arm/cpu64.c        | 167 +++++++++++++++++++++++++++++---------
> >>>  target/arm/kvm64.c        | 100 ++++++++++++++++++++++-
> >>>  target/arm/kvm_arm.h      |  12 +++
> >>>  tests/arm-cpu-features.c  | 105 +++++++++++++++++++++++-
> >>>  5 files changed, 368 insertions(+), 52 deletions(-)
> >>>
> >>> diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
> >>> index 1262fddc6201..939366f959cf 100644
> >>> --- a/docs/arm-cpu-features.rst
> >>> +++ b/docs/arm-cpu-features.rst
> >>> @@ -188,10 +188,17 @@ SVE CPU Property Dependencies and Constraints
> >>>  
> >>>    1) At least one vector length must be enabled when `sve` is enabled.
> >>>  
> >>> -  2) If a vector length `N` is enabled, then all power-of-two vector
> >>> -     lengths smaller than `N` must also be enabled.  E.g. if `sve512`
> >>> -     is enabled, then `sve128` and `sve256` must also be enabled,
> >>> -     but `sve384` is not required.
> >>> +  2) If a vector length `N` is enabled, then, when KVM is enabled, all
> >>> +     smaller, host supported vector lengths must also be enabled.  If
> >>> +     KVM is not enabled, then only all the smaller, power-of-two vector
> >>> +     lengths must be enabled.  E.g. with KVM if the host supports all
> >>> +     vector lengths up to 512-bits (128, 256, 384, 512), then if
> >>> +     `sve512` is enabled, `sve128`, `sve256`, and `sve384` must also
> >>> +     be enabled. Without KVM, `sve384` would not be required.
> >>> +
> >>> +  3) If KVM is enabled then only vector lengths that the host CPU type
> >>> +     support may be enabled.  If SVE is not supported by the host, then
> >>> +     no `sve*` properties may be enabled.
> >>>  
> >>>  SVE CPU Property Parsing Semantics
> >>>  ----------------------------------
> >>> @@ -210,20 +217,29 @@ SVE CPU Property Parsing Semantics
> >>>       disable the last enabled vector length (see constraint (1) of "SVE
> >>>       CPU Property Dependencies and Constraints").
> >>>  
> >>> -  4) If one or more `sve<N>` CPU properties are set `off`, but no `sve<N>`,
> >>> +  4) When KVM is enabled, if the host does not support SVE, then an error
> >>> +     is generated when attempting to enable any `sve*` properties.
> >>> +
> >>> +  5) When KVM is enabled, if the host does support SVE, then an error is
> >>> +     generated when attempting to enable any vector lengths not supported
> >>> +     by the host.
> >>> +
> >>> +  6) If one or more `sve<N>` CPU properties are set `off`, but no `sve<N>`,
> >>>       CPU properties are set `on`, then the specified vector lengths are
> >>>       disabled but the default for any unspecified lengths remains enabled.
> >>> -     Disabling a power-of-two vector length also disables all vector
> >>> -     lengths larger than the power-of-two length (see constraint (2) of
> >>> -     "SVE CPU Property Dependencies and Constraints").
> >>> +     When KVM is not enabled, disabling a power-of-two vector length also
> >>> +     disables all vector lengths larger than the power-of-two length.
> >>> +     When KVM is enabled, then disabling any supported vector length also
> >>> +     disables all larger vector lengths (see constraint (2) of "SVE CPU
> >>> +     Property Dependencies and Constraints").
> >>>  
> >>> -  5) If one or more `sve<N>` CPU properties are set to `on`, then they
> >>> +  7) If one or more `sve<N>` CPU properties are set to `on`, then they
> >>>       are enabled and all unspecified lengths default to disabled, except
> >>>       for the required lengths per constraint (2) of "SVE CPU Property
> >>>       Dependencies and Constraints", which will even be auto-enabled if
> >>>       they were not explicitly enabled.
> >>>  
> >>> -  6) If SVE was disabled (`sve=off`), allowing all vector lengths to be
> >>> +  8) If SVE was disabled (`sve=off`), allowing all vector lengths to be
> >>>       explicitly disabled (i.e. avoiding the error specified in (3) of
> >>>       "SVE CPU Property Parsing Semantics"), then if later an `sve=on` is
> >>>       provided an error will be generated.  To avoid this error, one must
> >>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> >>> index b7eff4e1e107..18dd5e24ec61 100644
> >>> --- a/target/arm/cpu64.c
> >>> +++ b/target/arm/cpu64.c
> >>> @@ -273,9 +273,18 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
> >>>       * any of the above.  Finally, if SVE is not disabled, then at least one
> >>>       * vector length must be enabled.
> >>>       */
> >>> +    DECLARE_BITMAP(kvm_supported, ARM_MAX_VQ);
> >>>      DECLARE_BITMAP(tmp, ARM_MAX_VQ);
> >>>      uint32_t vq, max_vq = 0;
> >>>  
> >>> +    /* Collect the set of vector lengths supported by KVM. */
> >>> +    bitmap_zero(kvm_supported, ARM_MAX_VQ);
> >>> +    if (kvm_enabled() && kvm_arm_sve_supported(CPU(cpu))) {
> >>> +        kvm_arm_sve_get_vls(CPU(cpu), kvm_supported);
> >>> +    } else if (kvm_enabled()) {
> >>> +        assert(!cpu_isar_feature(aa64_sve, cpu));
> >> why not set an error and propagate it instead?
> > 
> > This should never happen. We shouldn't be here if KVM is enabled and SVE
> > isn't supported. The question is how defensive do we want QEMU code?
> > We could just drop the check altogether if we don't want the assert, but
> > I'd rather keep it.
> > 
> >>> +    }
> >>> +
> >>>      /*
> >>>       * Process explicit sve<N> properties.
> >>>       * From the properties, sve_vq_map<N> implies sve_vq_init<N>.
> >>> @@ -293,10 +302,19 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
> >>>              return;
> >>>          }
> >>>  
> >>> -        /* Propagate enabled bits down through required powers-of-two. */
> >>> -        for (vq = pow2floor(max_vq); vq >= 1; vq >>= 1) {
> >>> -            if (!test_bit(vq - 1, cpu->sve_vq_init)) {
> >>> -                set_bit(vq - 1, cpu->sve_vq_map);
> >>> +        if (kvm_enabled()) {
> >>> +            /*
> >>> +             * For KVM we have to automatically enable all supported unitialized
> >>> +             * lengths, even when the smaller lengths are not all powers-of-two.
> >>> +             */
> >>> +            bitmap_andnot(tmp, kvm_supported, cpu->sve_vq_init, max_vq);
> >>> +            bitmap_or(cpu->sve_vq_map, cpu->sve_vq_map, tmp, max_vq);
> >>> +        } else {
> >>> +            /* Propagate enabled bits down through required powers-of-two. */
> >>> +            for (vq = pow2floor(max_vq); vq >= 1; vq >>= 1) {
> >>> +                if (!test_bit(vq - 1, cpu->sve_vq_init)) {
> >>> +                    set_bit(vq - 1, cpu->sve_vq_map);
> >>> +                }
> >>>              }
> >>>          }
> >>>      } else if (cpu->sve_max_vq == 0) {
> >>> @@ -308,23 +326,46 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
> >>>              return;
> >>>          }
> >>>  
> >>> -        /* Disabling a power-of-two disables all larger lengths. */
> >>> -        if (test_bit(0, cpu->sve_vq_init)) {
> >>> -            error_setg(errp, "cannot disable sve128");
> >>> -            error_append_hint(errp, "Disabling sve128 results in all vector "
> >>> -                              "lengths being disabled.\n");
> >>> -            error_append_hint(errp, "With SVE enabled, at least one vector "
> >>> -                              "length must be enabled.\n");
> >>> -            return;
> >>> -        }
> >>> -        for (vq = 2; vq <= ARM_MAX_VQ; vq <<= 1) {
> >>> -            if (test_bit(vq - 1, cpu->sve_vq_init)) {
> >>> -                break;
> >>> +        if (kvm_enabled()) {
> >>> +            /* Disabling a supported length disables all larger lengths. */
> >>> +            for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
> >>> +                if (test_bit(vq - 1, cpu->sve_vq_init) &&
> >>> +                    test_bit(vq - 1, kvm_supported)) {
> >>> +                    break;
> >>> +                }
> the above loop looks for the 1st disabled vq that is also supported, right?

Right

> >>> +            }
> >>> +            max_vq = vq <= ARM_MAX_VQ ? vq - 1 : ARM_MAX_VQ;
> >>> +            bitmap_andnot(cpu->sve_vq_map, kvm_supported,
> >>> +                          cpu->sve_vq_init, max_vq);
> >>> +            if (max_vq == 0 || bitmap_empty(cpu->sve_vq_map, max_vq)) {
> here we don't have anything enabled below the disabled one. So don't we
> have the culprit already?

Oh, you're right. We can drop the find_next_bit call. Thanks for catching
that.

> >>> +                vq = find_next_bit(kvm_supported, ARM_MAX_VQ, 0) + 1;
> >>> +                error_setg(errp, "cannot disable sve%d", vq * 128);
> >> isn't the one disabled max_vq? Do you really need to re-compute vq?

vq != max_vq here. max_vq is one smaller, even 0 if vq=1. So while vq
is already correct, as you've pointed out, we need to use specifically
that, not max_vq.

Thanks,
drew

