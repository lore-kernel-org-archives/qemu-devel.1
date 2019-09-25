Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1753C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723FF2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723FF2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD7ko-0005RG-GM
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 09:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iD7k0-0004pN-EQ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iD7jw-0003Jd-Oa
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:54:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iD7jo-0003F7-QB; Wed, 25 Sep 2019 09:53:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6EFFD8980FE;
 Wed, 25 Sep 2019 13:53:47 +0000 (UTC)
Received: from [10.36.117.64] (ovpn-117-64.ams2.redhat.com [10.36.117.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 611C4608C0;
 Wed, 25 Sep 2019 13:53:44 +0000 (UTC)
From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v4 4/9] target/arm/cpu64: max cpu: Introduce sve<N>
 properties
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190924113105.19076-1-drjones@redhat.com>
 <20190924113105.19076-5-drjones@redhat.com>
Message-ID: <7b553340-7b4b-d14a-9d6c-0cdc40da1a36@redhat.com>
Date: Wed, 25 Sep 2019 15:53:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190924113105.19076-5-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Wed, 25 Sep 2019 13:53:47 +0000 (UTC)
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,

On 9/24/19 1:31 PM, Andrew Jones wrote:
> Introduce cpu properties to give fine control over SVE vector lengths.
> We introduce a property for each valid length up to the current
> maximum supported, which is 2048-bits. The properties are named, e.g.
> sve128, sve256, sve384, sve512, ..., where the number is the number of
> bits. See the updates to docs/arm-cpu-features.rst for a description
> of the semantics and for example uses.
> 
> Note, as sve-max-vq is still present and we'd like to be able to
> support qmp_query_cpu_model_expansion with guests launched with e.g.
> -cpu max,sve-max-vq=8 on their command lines, then we do allow
> sve-max-vq and sve<N> properties to be provided at the same time, but
> this is not recommended, and is why sve-max-vq is not mentioned in the
> document.  If sve-max-vq is provided then it enables all lengths smaller
> than and including the max and disables all lengths larger. It also has
> the side-effect that no larger lengths may be enabled and that the max
> itself cannot be disabled. Smaller non-power-of-two lengths may,
> however, be disabled, e.g. -cpu max,sve-max-vq=4,sve384=off provides a
> guest the vector lengths 128, 256, and 512 bits.
> 
> This patch has been co-authored with Richard Henderson, who reworked
> the target/arm/cpu64.c changes in order to push all the validation and
> auto-enabling/disabling steps into the finalizer, resulting in a nice
> LOC reduction.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  docs/arm-cpu-features.rst | 157 +++++++++++++++++++++++++++++--
>  target/arm/cpu.c          |  19 ++++
>  target/arm/cpu.h          |  19 ++++
>  target/arm/cpu64.c        | 190 +++++++++++++++++++++++++++++++++++++-
>  target/arm/helper.c       |  13 ++-
>  target/arm/monitor.c      |  12 +++
>  tests/arm-cpu-features.c  | 189 +++++++++++++++++++++++++++++++++++++
>  7 files changed, 587 insertions(+), 12 deletions(-)
> 
> diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
> index c79dcffb5556..1262fddc6201 100644
> --- a/docs/arm-cpu-features.rst
> +++ b/docs/arm-cpu-features.rst
> @@ -48,18 +48,28 @@ block in the script for usage) is used to issue the QMP commands.
>        (QEMU) query-cpu-model-expansion type=full model={"name":"max"}
>        { "return": {
>          "model": { "name": "max", "props": {
> -        "pmu": true, "aarch64": true
> +        "sve1664": true, "pmu": true, "sve1792": true, "sve1920": true,
> +        "sve128": true, "aarch64": true, "sve1024": true, "sve": true,
> +        "sve640": true, "sve768": true, "sve1408": true, "sve256": true,
> +        "sve1152": true, "sve512": true, "sve384": true, "sve1536": true,
> +        "sve896": true, "sve1280": true, "sve2048": true
I don't really understand why this gets printed unsorted as you
registered them in the logical order, any clue?

Note: This example is given with TCG or KVM with all those vectors
supported by the host.
>        }}}}
>  
> -We see that the `max` CPU type has the `pmu` and `aarch64` CPU features.
> -We also see that the CPU features are enabled, as they are all `true`.
> +We see that the `max` CPU type has the `pmu`, `aarch64`, `sve`, and many
> +`sve<N>` CPU features.  We also see that all the CPU features are
> +enabled, as they are all `true`.  (The `sve<N>` CPU features are all
> +optional SVE vector lengths.  See "SVE CPU Properties".)
>  
>  (2) Let's try to disable the PMU::
>  
>        (QEMU) query-cpu-model-expansion type=full model={"name":"max","props":{"pmu":false}}
>        { "return": {
>          "model": { "name": "max", "props": {
> -        "pmu": false, "aarch64": true
> +        "sve1664": true, "pmu": false, "sve1792": true, "sve1920": true,
> +        "sve128": true, "aarch64": true, "sve1024": true, "sve": true,
> +        "sve640": true, "sve768": true, "sve1408": true, "sve256": true,
> +        "sve1152": true, "sve512": true, "sve384": true, "sve1536": true,
> +        "sve896": true, "sve1280": true, "sve2048": true
>        }}}}
>  
>  We see it worked, as `pmu` is now `false`.
> @@ -75,7 +85,22 @@ We see it worked, as `pmu` is now `false`.
>  It looks like this feature is limited to a configuration we do not
>  currently have.
>  
> -(4) Let's try probing CPU features for the Cortex-A15 CPU type::
> +(4) Let's disable `sve` and see what happens to all the optional SVE
> +    vector lengths::
> +
> +      (QEMU) query-cpu-model-expansion type=full model={"name":"max","props":{"sve":false}}
> +      { "return": {
> +        "model": { "name": "max", "props": {
> +        "sve1664": false, "pmu": true, "sve1792": false, "sve1920": false,
> +        "sve128": false, "aarch64": true, "sve1024": false, "sve": false,
> +        "sve640": false, "sve768": false, "sve1408": false, "sve256": false,
> +        "sve1152": false, "sve512": false, "sve384": false, "sve1536": false,
> +        "sve896": false, "sve1280": false, "sve2048": false
> +      }}}}
> +
> +As expected they are now all `false`.
> +
> +(5) Let's try probing CPU features for the Cortex-A15 CPU type::
>  
>        (QEMU) query-cpu-model-expansion type=full model={"name":"cortex-a15"}
>        {"return": {"model": {"name": "cortex-a15", "props": {"pmu": true}}}}
> @@ -131,7 +156,125 @@ After determining which CPU features are available and supported for a
>  given CPU type, then they may be selectively enabled or disabled on the
>  QEMU command line with that CPU type::
>  
> -  $ qemu-system-aarch64 -M virt -cpu max,pmu=off
> +  $ qemu-system-aarch64 -M virt -cpu max,pmu=off,sve=on,sve128=on,sve256=on
> +
> +The example above disables the PMU and enables the first two SVE vector
> +lengths for the `max` CPU type.  Note, the `sve=on` isn't actually
> +necessary, because, as we observed above with our probe of the `max` CPU
> +type, `sve` is already on by default.

This holds with TCG and not KVM.

Also, based on our probe of
> +defaults, it would seem we need to disable many SVE vector lengths, rather
> +than only enabling the two we want.  This isn't the case, because, as
> +disabling many SVE vector lengths would be quite verbose, the `sve<N>` CPU
> +properties have special semantics (see "SVE CPU Property Parsing
> +Semantics").
> +
> +SVE CPU Properties
> +==================
> +
> +There are two types of SVE CPU properties: `sve` and `sve<N>`.  The first
> +is used to enable or disable the entire SVE feature, just as the `pmu`
> +CPU property completely enables or disables the PMU.  The second type
> +is used to enable or disable specific vector lengths, where `N` is the
> +number of bits of the length.  The `sve<N>` CPU properties have special
> +dependencies and constraints, see "SVE CPU Property Dependencies and
> +Constraints" below.  Additionally, as we want all supported vector lengths
> +to be enabled by default, then, in order to avoid overly verbose command
> +lines (command lines full of `sve<N>=off`, for all `N` not wanted), we
> +provide the parsing semantics listed in "SVE CPU Property Parsing
> +Semantics".
> +
> +SVE CPU Property Dependencies and Constraints
> +---------------------------------------------
> +
> +  1) At least one vector length must be enabled when `sve` is enabled.> +
> +  2) If a vector length `N` is enabled, then all power-of-two vector
> +     lengths smaller than `N` must also be enabled.  E.g. if `sve512`
> +     is enabled, then `sve128` and `sve256` must also be enabled,
> +     but `sve384` is not required.
I would remove the eg. part. reading that I tend to understand that the
user must pass ,sve128=on, sve256=on and sve512=on whereas example 6
says only sve512=on can be set and other lower ^2 values are auto-enabled.
> +
> +SVE CPU Property Parsing Semantics
> +----------------------------------
> +
> +  1) If SVE is disabled (`sve=off`), then which SVE vector lengths
> +     are enabled or disabled is irrelevant to the guest, as the entire
> +     SVE feature is disabled and that disables all vector lengths for
> +     the guest.  However QEMU will still track any `sve<N>` CPU
> +     properties provided by the user.  If later an `sve=on` is provided,
> +     then the guest will get only the enabled lengths.
> +
> +  2) If SVE is enabled (`sve=on`), but no `sve<N>` CPU properties are
> +     provided, then all supported vector lengths are enabled.
I understand from the code it also includes non ^2 values which is not
obvious.
> +
> +  3) If SVE is enabled, then an error is generated when attempting to
> +     disable the last enabled vector length (see constraint (1) of "SVE
> +     CPU Property Dependencies and Constraints").
the same happens if you attempt to disabled any lower ^2 value
> +
> +  4) If one or more `sve<N>` CPU properties are set `off`, but no `sve<N>`,
> +     CPU properties are set `on`, then the specified vector lengths are
> +     disabled but the default for any unspecified lengths remains enabled.
> +     Disabling a power-of-two vector length also disables all vector
> +     lengths larger than the power-of-two length (see constraint (2) of
> +     "SVE CPU Property Dependencies and Constraints").
So rephasing it:
disabling a non ^2 value only disable that one
disabling a ^2 value disables all larger lengths too
is that correct?

> +
> +  5) If one or more `sve<N>` CPU properties are set to `on`, then they
> +     are enabled and all unspecified lengths default to disabled, except
> +     for the required lengths per constraint (2) of "SVE CPU Property
> +     Dependencies and Constraints", which will even be auto-enabled if
> +     they were not explicitly enabled.
> +
> +  6) If SVE was disabled (`sve=off`), allowing all vector lengths to be
> +     explicitly disabled (i.e. avoiding the error specified in (3) of
> +     "SVE CPU Property Parsing Semantics"), then if later an `sve=on` is
> +     provided an error will be generated.  To avoid this error, one must
> +     enable at least one vector length prior to enabling SVE.
> +
> +SVE CPU Property Examples
> +-------------------------
> +
> +  1) Disable SVE::
> +
> +     $ qemu-system-aarch64 -M virt -cpu max,sve=off
> +
> +  2) Implicitly enable all vector lengths for the `max` CPU type::
> +
> +     $ qemu-system-aarch64 -M virt -cpu max
> +
> +  3) Only enable the 128-bit vector length::
> +
> +     $ qemu-system-aarch64 -M virt -cpu max,sve128=on
> +
> +  4) Disable the 256-bit vector length and all larger vector lengths
> +     since 256 is a power-of-two (this results in only the 128-bit length
> +     being enabled)::
> +
> +     $ qemu-system-aarch64 -M virt -cpu max,sve256=off
> +
> +  5) Enable the 128-bit, 256-bit, and 512-bit vector lengths::
> +
> +     $ qemu-system-aarch64 -M virt -cpu max,sve128=on,sve256=on,sve512=on
> +
> +  6) The same as (5), but since the 128-bit and 256-bit vector
> +     lengths are required for the 512-bit vector length to be enabled,
> +     then allow them to be auto-enabled::> +
> +     $ qemu-system-aarch64 -M virt -cpu max,sve512=on

You should also document
$ qemu-system-aarch64 -M virt -cpu max,sve512=off
as in that case this result in 128, 256 and 384. the fact you get non ^2
values is not obvious here because if you enable a ^2 value you onlt get
<= ^2 values.
> +
> +  7) Do the same as (6), but by first disabling SVE and then re-enabling it::
> +
> +     $ qemu-system-aarch64 -M virt -cpu max,sve=off,sve512=on,sve=on> +
> +  8) Force errors regarding the last vector length::
You mean those commands will generate errors, right?
> +
> +     $ qemu-system-aarch64 -M virt -cpu max,sve128=off
> +     $ qemu-system-aarch64 -M virt -cpu max,sve=off,sve128=off,sve=on
> +
> +SVE CPU Property Recommendations
> +--------------------------------
>  
> -The example above disables the PMU for the `max` CPU type.
> +The examples in "SVE CPU Property Examples" exhibit many ways to select
> +vector lengths which developers may find useful in order to avoid overly
> +verbose command lines.  However, the recommended way to select vector
> +lengths is to explicitly enable each desired length.  Therefore only
> +example's (1), (3), and (5) exhibit recommended uses of the properties.
>  
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 73be2ebfdd39..522fed95b339 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1199,6 +1199,19 @@ static void arm_cpu_finalizefn(Object *obj)
>  #endif
>  }
>  
> +void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
> +{
> +    Error *local_err = NULL;
> +
> +    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> +        arm_cpu_sve_finalize(cpu, &local_err);
> +        if (local_err != NULL) {
nit: !local_err
> +            error_propagate(errp, local_err);
> +            return;
not needed
> +        }
> +    }
> +}
> +
>  static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>  {
>      CPUState *cs = CPU(dev);
> @@ -1255,6 +1268,12 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    arm_cpu_finalize_features(cpu, &local_err);
> +    if (local_err != NULL) {
same
> +        error_propagate(errp, local_err);
> +        return;> +    }
> +
>      if (arm_feature(env, ARM_FEATURE_AARCH64) &&
>          cpu->has_vfp != cpu->has_neon) {
>          /*
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 297ad5e47ad8..11162484465a 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -184,8 +184,13 @@ typedef struct {
>  
>  #ifdef TARGET_AARCH64
>  # define ARM_MAX_VQ    16
> +void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
> +uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq);
>  #else
>  # define ARM_MAX_VQ    1
> +static inline void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp) { }
> +static inline uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
> +{ return 0; }
>  #endif
>  
>  typedef struct ARMVectorReg {
> @@ -915,6 +920,18 @@ struct ARMCPU {
>  
>      /* Used to set the maximum vector length the cpu will support.  */
>      uint32_t sve_max_vq;
> +
> +    /*
> +     * In sve_vq_map each set bit is a supported vector length of
> +     * (bit-number + 1) * 16 bytes, i.e. each bit number + 1 is the vector
> +     * length in quadwords.
> +     *
> +     * While processing properties during initialization, corresponding
> +     * sve_vq_init bits are set for bits in sve_vq_map that have been
> +     * set by properties.
> +     */
> +    DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ);
> +    DECLARE_BITMAP(sve_vq_init, ARM_MAX_VQ);
>  };
>  
>  void arm_cpu_post_init(Object *obj);
> @@ -1834,6 +1851,8 @@ static inline int arm_feature(CPUARMState *env, int feature)
>      return (env->features & (1ULL << feature)) != 0;
>  }
>  
> +void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp);
> +
>  #if !defined(CONFIG_USER_ONLY)
>  /* Return true if exception levels below EL3 are in secure state,
>   * or would be following an exception return to that level.
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 8cdb0c79fa7a..606e3eceb9c0 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -256,11 +256,152 @@ static void aarch64_a72_initfn(Object *obj)
>      define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
>  }
>  
> +void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
> +{
> +    /*
> +     * If any vector lengths are explicitly enabled with sve<N> properties,
> +     * then all other lengths are implicitly disabled.  If sve-max-vq is
> +     * specified then it is the same as explicitly enabling all lengths
> +     * up to and including the specified maximum, which means all larger
> +     * lengths will be implicitly disabled.  If no sve<N> properties
> +     * are enabled and sve-max-vq is not specified, then all lengths not
> +     * explicitly disabled will be enabled.  Additionally, all power-of-two
> +     * vector lengths less than the maximum enabled length will be
> +     * automatically enabled and all vector lengths larger than the largest
> +     * disabled power-of-two vector length will be automatically disabled.
> +     * Errors are generated if the user provided input that interferes with
> +     * any of the above.  Finally, if SVE is not disabled, then at least one
> +     * vector length must be enabled.
> +     */
> +    DECLARE_BITMAP(tmp, ARM_MAX_VQ);
> +    uint32_t vq, max_vq = 0;
> +
> +    /*
> +     * Process explicit sve<N> properties.
> +     * From the properties, sve_vq_map<N> implies sve_vq_init<N>.
> +     * Check first for any sve<N> enabled.
> +     */
> +    if (!bitmap_empty(cpu->sve_vq_map, ARM_MAX_VQ)) {
> +        max_vq = find_last_bit(cpu->sve_vq_map, ARM_MAX_VQ) + 1;
> +
> +        if (cpu->sve_max_vq && max_vq > cpu->sve_max_vq) {
> +            error_setg(errp, "cannot enable sve%d", max_vq * 128);
> +            error_append_hint(errp, "sve%d is larger than the maximum vector "
> +                              "length, sve-max-vq=%d (%d bits)\n",
> +                              max_vq * 128, cpu->sve_max_vq,
> +                              cpu->sve_max_vq * 128);
you could test directly if max_vq < cpu->sve_max_vq too which couldn't
be correct either. But as far as I understand this is caught in *
> +            return;
> +        }
> +
> +        /* Propagate enabled bits down through required powers-of-two. */
> +        for (vq = pow2floor(max_vq); vq >= 1; vq >>= 1) {
> +            if (!test_bit(vq - 1, cpu->sve_vq_init)) {
> +                set_bit(vq - 1, cpu->sve_vq_map);
> +            }
> +        }
> +    } else if (cpu->sve_max_vq == 0) {
> +        /*
> +         * No explicit bits enabled, and no implicit bits from sve-max-vq.
> +         */
> +        if (!cpu_isar_feature(aa64_sve, cpu)) {
> +            /* SVE is disabled and so are all vector lengths.  Good. */
> +            return;
> +        }
> +
> +        /* Disabling a power-of-two disables all larger lengths. */
> +        if (test_bit(0, cpu->sve_vq_init)) {> +            error_setg(errp, "cannot disable sve128");
> +            error_append_hint(errp, "Disabling sve128 results in all vector "
> +                              "lengths being disabled.\n");
> +            error_append_hint(errp, "With SVE enabled, at least one vector "
> +                              "length must be enabled.\n");
> +            return;
> +        }
> +        for (vq = 2; vq <= ARM_MAX_VQ; vq <<= 1) {
> +            if (test_bit(vq - 1, cpu->sve_vq_init)) {
> +                break;
> +            }
> +        }
> +        max_vq = vq <= ARM_MAX_VQ ? vq - 1 : ARM_MAX_VQ;
> +
> +        bitmap_complement(cpu->sve_vq_map, cpu->sve_vq_init, max_vq);
> +        max_vq = find_last_bit(cpu->sve_vq_map, max_vq) + 1;
> +    }
> +
> +    /*
> +     * Process the sve-max-vq property.
> +     * Note that we know from the above that no bit above
> +     * sve-max-vq is currently set.
> +     */
> +    if (cpu->sve_max_vq != 0) {
> +        max_vq = cpu->sve_max_vq;
> +
> +        if (!test_bit(max_vq - 1, cpu->sve_vq_map) &&
> +            test_bit(max_vq - 1, cpu->sve_vq_init)) {
> +            error_setg(errp, "cannot disable sve%d", max_vq * 128);
> +            error_append_hint(errp, "The maximum vector length must be "
> +                              "enabled, sve-max-vq=%d (%d bits)\n",
> +                              max_vq, max_vq * 128);
> +            return;
> +        }
> +
> +        /* Set all bits not explicitly set within sve-max-vq. */
> +        bitmap_complement(tmp, cpu->sve_vq_init, max_vq);
> +        bitmap_or(cpu->sve_vq_map, cpu->sve_vq_map, tmp, max_vq);
> +    }
> +
> +    /*
> +     * We should know what max-vq is now.  Also, as we're done
> +     * manipulating sve-vq-map, we ensure any bits above max-vq
> +     * are clear, just in case anybody looks.
> +     */
> +    assert(max_vq != 0);
> +    bitmap_clear(cpu->sve_vq_map, max_vq, ARM_MAX_VQ - max_vq);
> +
> +    /* Ensure all required powers-of-two are enabled. */
> +    for (vq = pow2floor(max_vq); vq >= 1; vq >>= 1) {
> +        if (!test_bit(vq - 1, cpu->sve_vq_map)) {
> +            error_setg(errp, "cannot disable sve%d", vq * 128);
> +            error_append_hint(errp, "sve%d is required as it "
> +                              "is a power-of-two length smaller than "
> +                              "the maximum, sve%d\n",
> +                              vq * 128, max_vq * 128);
* I think this will also catches the case where ,sve512=on,sve-max-vq=5
where the end-user did not explicitly disabled anything
> +            return;
> +        }
> +    }
> +
> +    /* From now on sve_max_vq is the actual maximum supported length. */
> +    cpu->sve_max_vq = max_vq;
> +}
> +
> +uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
> +{
> +    uint32_t bitnum;
> +
> +    /*
> +     * We allow vq == ARM_MAX_VQ + 1 to be input because the caller may want
> +     * to find the maximum vq enabled, which may be ARM_MAX_VQ, but this
> +     * function always returns the next smaller than the input.
> +     */
> +    assert(vq && vq <= ARM_MAX_VQ + 1);
> +
> +    bitnum = find_last_bit(cpu->sve_vq_map, vq - 1);
> +    return bitnum == vq - 1 ? 0 : bitnum + 1;
> +}
> +
>  static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *name,
>                                     void *opaque, Error **errp)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> -    visit_type_uint32(v, name, &cpu->sve_max_vq, errp);
> +    uint32_t value;
Shouldn't it be part of the previous patch?
> +
> +    /* All vector lengths are disabled when SVE is off. */
> +    if (!cpu_isar_feature(aa64_sve, cpu)) {
> +        value = 0;
> +    } else {
> +        value = cpu->sve_max_vq;
> +    }
> +    visit_type_uint32(v, name, &value, errp);
>  }
>  
>  static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
> @@ -279,6 +420,44 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
Independently on this patch I noticed that if sve_max_vq is out of
scope, an error is propagated but still the cpu->sve-max_vq is set.
>      error_propagate(errp, err);
>  }
>  
> +static void cpu_arm_get_sve_vq(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    uint32_t vq = atoi(&name[3]) / 128;
> +    bool value;
> +
> +    /* All vector lengths are disabled when SVE is off. */
> +    if (!cpu_isar_feature(aa64_sve, cpu)) {
> +        value = false;
> +    } else {
> +        value = test_bit(vq - 1, cpu->sve_vq_map);
> +    }
> +    visit_type_bool(v, name, &value, errp);
> +}
> +
> +static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    uint32_t vq = atoi(&name[3]) / 128;
> +    Error *err = NULL;
> +    bool value;
> +
> +    visit_type_bool(v, name, &value, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    if (value) {
> +        set_bit(vq - 1, cpu->sve_vq_map);
> +    } else {
> +        clear_bit(vq - 1, cpu->sve_vq_map);
> +    }
> +    set_bit(vq - 1, cpu->sve_vq_init);
> +}
> +
>  static void cpu_arm_get_sve(Object *obj, Visitor *v, const char *name,
>                              void *opaque, Error **errp)
>  {
> @@ -315,6 +494,7 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
>  static void aarch64_max_initfn(Object *obj)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> +    uint32_t vq;
>  
>      if (kvm_enabled()) {
>          kvm_arm_set_cpu_features_from_host(cpu);
> @@ -418,11 +598,17 @@ static void aarch64_max_initfn(Object *obj)
>          cpu->dcz_blocksize = 7; /*  512 bytes */
>  #endif
>  
> -        cpu->sve_max_vq = ARM_MAX_VQ;
>          object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
>                              cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
>          object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
>                              cpu_arm_set_sve, NULL, NULL, &error_fatal);
> +
> +        for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
> +            char name[8];
> +            sprintf(name, "sve%d", vq * 128);
> +            object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
> +                                cpu_arm_set_sve_vq, NULL, NULL, &error_fatal);
> +        }
>      }
>  }
>  
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 507026c9154b..f33284c247d5 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5351,6 +5351,13 @@ int sve_exception_el(CPUARMState *env, int el)
>      return 0;
>  }
>  
> +static uint32_t sve_zcr_get_valid_len(ARMCPU *cpu, uint32_t start_len)
> +{
> +    uint32_t start_vq = (start_len & 0xf) + 1;
> +
> +    return arm_cpu_vq_map_next_smaller(cpu, start_vq + 1) - 1;
> +}
> +
>  /*
>   * Given that SVE is enabled, return the vector length for EL.
>   */
> @@ -5360,13 +5367,13 @@ uint32_t sve_zcr_len_for_el(CPUARMState *env, int el)
>      uint32_t zcr_len = cpu->sve_max_vq - 1;
>  
>      if (el <= 1) {
> -        zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[1]);
> +        zcr_len = sve_zcr_get_valid_len(cpu, env->vfp.zcr_el[1]);
>      }
>      if (el <= 2 && arm_feature(env, ARM_FEATURE_EL2)) {
> -        zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[2]);
> +        zcr_len = sve_zcr_get_valid_len(cpu, env->vfp.zcr_el[2]);
>      }
>      if (arm_feature(env, ARM_FEATURE_EL3)) {
> -        zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[3]);
> +        zcr_len = sve_zcr_get_valid_len(cpu, env->vfp.zcr_el[3]);
>      }
>      return zcr_len;
>  }
> diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> index 4fddb6c252a3..e912ed2cefa0 100644
> --- a/target/arm/monitor.c
> +++ b/target/arm/monitor.c
> @@ -90,6 +90,8 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
>      return head;
>  }
>  
> +QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
> +
>  /*
>   * These are cpu model features we want to advertise. The order here
>   * matters as this is the order in which qmp_query_cpu_model_expansion
> @@ -98,6 +100,9 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
>   */
>  static const char *cpu_model_advertised_features[] = {
>      "aarch64", "pmu", "sve",
> +    "sve128", "sve256", "sve384", "sve512",
> +    "sve640", "sve768", "sve896", "sve1024", "sve1152", "sve1280",
> +    "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
>      NULL
>  };
>  
> @@ -185,6 +190,9 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>          if (!err) {
>              visit_check_struct(visitor, &err);
>          }
> +        if (!err) {
> +            arm_cpu_finalize_features(ARM_CPU(obj), &err);
> +        }
>          visit_end_struct(visitor, NULL);
>          visit_free(visitor);
>          if (err) {
> @@ -192,6 +200,10 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>              error_propagate(errp, err);
>              return NULL;
>          }
> +    } else {
> +        Error *err = NULL;
> +        arm_cpu_finalize_features(ARM_CPU(obj), &err);
> +        assert(err == NULL);
>      }
>  
>      expansion_info = g_new0(CpuModelExpansionInfo, 1);
> diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
> index 202bc0e3e823..9a2dd402b769 100644
> --- a/tests/arm-cpu-features.c
> +++ b/tests/arm-cpu-features.c
> @@ -13,6 +13,18 @@
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qjson.h"
>  
> +#if __SIZEOF_LONG__ == 8
> +#define BIT(n) (1UL << (n))
> +#else
> +#define BIT(n) (1ULL << (n))
> +#endif
> +
> +/*
> + * We expect the SVE max-vq to be 16. Also it must be <= 64
> + * for our test code, otherwise 'vls' can't just be a uint64_t.
> + */
> +#define SVE_MAX_VQ 16
> +
>  #define MACHINE    "-machine virt,gic-version=max "
>  #define QUERY_HEAD "{ 'execute': 'query-cpu-model-expansion', " \
>                       "'arguments': { 'type': 'full', "
> @@ -157,6 +169,173 @@ static void assert_bad_props(QTestState *qts, const char *cpu_type)
>      qobject_unref(resp);
>  }
>  
> +static uint64_t resp_get_sve_vls(QDict *resp)
> +{
> +    QDict *props;
> +    const QDictEntry *e;
> +    uint64_t vls = 0;
> +    int n = 0;
> +
> +    g_assert(resp);
> +    g_assert(resp_has_props(resp));
> +
> +    props = resp_get_props(resp);
> +
> +    for (e = qdict_first(props); e; e = qdict_next(props, e)) {
> +        if (strlen(e->key) > 3 && !strncmp(e->key, "sve", 3) &&
> +            g_ascii_isdigit(e->key[3])) {
> +            char *endptr;
> +            int bits;
> +
> +            bits = g_ascii_strtoll(&e->key[3], &endptr, 10);
> +            if (!bits || *endptr != '\0') {
> +                continue;
> +            }
> +
> +            if (qdict_get_bool(props, e->key)) {
> +                vls |= BIT((bits / 128) - 1);
> +            }
> +            ++n;
> +        }
> +    }
> +
> +    g_assert(n == SVE_MAX_VQ);
> +
> +    return vls;
> +}
> +
> +#define assert_sve_vls(qts, cpu_type, expected_vls, fmt, ...)          \
> +({                                                                     \
> +    QDict *_resp = do_query(qts, cpu_type, fmt, ##__VA_ARGS__);        \
> +    g_assert(_resp);                                                   \
> +    g_assert(resp_has_props(_resp));                                   \
> +    g_assert(resp_get_sve_vls(_resp) == expected_vls);                 \
> +    qobject_unref(_resp);                                              \
> +})
> +
> +static void sve_tests_default(QTestState *qts, const char *cpu_type)
> +{
> +    /*
> +     * With no sve-max-vq or sve<N> properties on the command line
> +     * the default is to have all vector lengths enabled. This also
> +     * tests that 'sve' is 'on' by default.
> +     */
> +    assert_sve_vls(qts, cpu_type, BIT(SVE_MAX_VQ) - 1, NULL);
> +
> +    /* With SVE off, all vector lengths should also be off. */
> +    assert_sve_vls(qts, cpu_type, 0, "{ 'sve': false }");
> +
> +    /* With SVE on, we must have at least one vector length enabled. */
> +    assert_error(qts, cpu_type, "cannot disable sve128", "{ 'sve128': false }");
> +
> +    /*
> +     * ---------------------------------------------------------------------
> +     *               power-of-two(vq)   all-power-            can      can
> +     *                                  of-two(< vq)        enable   disable
> +     * ---------------------------------------------------------------------
> +     * vq < max_vq      no                MUST*              yes      yes
> +     * vq < max_vq      yes               MUST*              yes      no
> +     * ---------------------------------------------------------------------
> +     * vq == max_vq     n/a               MUST*              yes**    yes**
> +     * ---------------------------------------------------------------------
> +     * vq > max_vq      n/a               no                 no       yes
> +     * vq > max_vq      n/a               yes                yes      yes
> +     * ---------------------------------------------------------------------
> +     *
> +     * [*] "MUST" means this requirement must already be satisfied,
> +     *     otherwise 'max_vq' couldn't itself be enabled.
> +     *
> +     * [**] Not testable with the QMP interface, only with the command line.
> +     */
> +
> +    /* max_vq := 8 */
> +    assert_sve_vls(qts, cpu_type, 0x8b, "{ 'sve1024': true }");
> +
> +    /* max_vq := 8, vq < max_vq, !power-of-two(vq) */
> +    assert_sve_vls(qts, cpu_type, 0x8f,
> +                   "{ 'sve1024': true, 'sve384': true }");
> +    assert_sve_vls(qts, cpu_type, 0x8b,
> +                   "{ 'sve1024': true, 'sve384': false }");
> +
> +    /* max_vq := 8, vq < max_vq, power-of-two(vq) */
> +    assert_sve_vls(qts, cpu_type, 0x8b,
> +                   "{ 'sve1024': true, 'sve256': true }");
> +    assert_error(qts, cpu_type, "cannot disable sve256",
> +                 "{ 'sve1024': true, 'sve256': false }");
> +
> +    /* max_vq := 3, vq > max_vq, !all-power-of-two(< vq) */
> +    assert_error(qts, cpu_type, "cannot disable sve512",
> +                 "{ 'sve384': true, 'sve512': false, 'sve640': true }");
> +
> +    /*
> +     * We can disable power-of-two vector lengths when all larger lengths
> +     * are also disabled. We only need to disable the power-of-two length,
> +     * as all non-enabled larger lengths will then be auto-disabled.
> +     */
> +    assert_sve_vls(qts, cpu_type, 0x7, "{ 'sve512': false }");
> +
> +    /* max_vq := 3, vq > max_vq, all-power-of-two(< vq) */
> +    assert_sve_vls(qts, cpu_type, 0x1f,
> +                   "{ 'sve384': true, 'sve512': true, 'sve640': true }");
> +    assert_sve_vls(qts, cpu_type, 0xf,
> +                   "{ 'sve384': true, 'sve512': true, 'sve640': false }");
> +}
> +
> +static void sve_tests_sve_max_vq_8(const void *data)
> +{
> +    QTestState *qts;
> +
> +    qts = qtest_init(MACHINE "-cpu max,sve-max-vq=8");
> +
> +    assert_sve_vls(qts, "max", BIT(8) - 1, NULL);
> +
> +    /*
> +     * Disabling the max-vq set by sve-max-vq is not allowed, but
> +     * of course enabling it is OK.
> +     */
> +    assert_error(qts, "max", "cannot disable sve1024", "{ 'sve1024': false }");
> +    assert_sve_vls(qts, "max", 0xff, "{ 'sve1024': true }");
> +
> +    /*
> +     * Enabling anything larger than max-vq set by sve-max-vq is not
> +     * allowed, but of course disabling everything larger is OK.
> +     */
> +    assert_error(qts, "max", "cannot enable sve1152", "{ 'sve1152': true }");
> +    assert_sve_vls(qts, "max", 0xff, "{ 'sve1152': false }");
> +
> +    /*
> +     * We can disable non power-of-two lengths smaller than the max-vq
> +     * set by sve-max-vq, but not power-of-two lengths.
> +     */
> +    assert_sve_vls(qts, "max", 0xfb, "{ 'sve384': false }");
you can also test ,sve384=on => 0x7
> +    assert_error(qts, "max", "cannot disable sve256", "{ 'sve256': false }");
> +
> +    qtest_quit(qts);
> +}
> +
> +static void sve_tests_sve_off(const void *data)
> +{
> +    QTestState *qts;
> +
> +    qts = qtest_init(MACHINE "-cpu max,sve=off");
> +
> +    /* SVE is off, so the map should be empty. */
> +    assert_sve_vls(qts, "max", 0, NULL);
> +
> +    /* The map stays empty even if we turn lengths on or off. */
> +    assert_sve_vls(qts, "max", 0, "{ 'sve128': true }");
> +    assert_sve_vls(qts, "max", 0, "{ 'sve128': false }");
> +
> +    /* With SVE re-enabled we should get all vector lengths enabled. */
> +    assert_sve_vls(qts, "max", BIT(SVE_MAX_VQ) - 1, "{ 'sve': true }");
> +
> +    /* Or enable SVE with just specific vector lengths. */
> +    assert_sve_vls(qts, "max", 0x3,
> +                   "{ 'sve': true, 'sve128': true, 'sve256': true }");
> +
> +    qtest_quit(qts);
> +}
> +
>  static void test_query_cpu_model_expansion(const void *data)
>  {
>      QTestState *qts;
> @@ -180,9 +359,12 @@ static void test_query_cpu_model_expansion(const void *data)
>      if (g_str_equal(qtest_get_arch(), "aarch64")) {
>          assert_has_feature(qts, "max", "aarch64");
>          assert_has_feature(qts, "max", "sve");
> +        assert_has_feature(qts, "max", "sve128");
>          assert_has_feature(qts, "cortex-a57", "pmu");
>          assert_has_feature(qts, "cortex-a57", "aarch64");
>  
> +        sve_tests_default(qts, "max");
> +
>          /* Test that features that depend on KVM generate errors without. */
>          assert_error(qts, "max",
>                       "'aarch64' feature cannot be disabled "
> @@ -234,6 +416,13 @@ int main(int argc, char **argv)
>      qtest_add_data_func("/arm/query-cpu-model-expansion",
>                          NULL, test_query_cpu_model_expansion);
>  
> +    if (g_str_equal(qtest_get_arch(), "aarch64")) {
> +        qtest_add_data_func("/arm/max/query-cpu-model-expansion/sve-max-vq-8",
> +                            NULL, sve_tests_sve_max_vq_8);
> +        qtest_add_data_func("/arm/max/query-cpu-model-expansion/sve-off",
> +                            NULL, sve_tests_sve_off);
> +    }
> +
>      if (kvm_available) {
>          qtest_add_data_func("/arm/kvm/query-cpu-model-expansion",
>                              NULL, test_query_cpu_model_expansion_kvm);
> 
Thanks

Eric

