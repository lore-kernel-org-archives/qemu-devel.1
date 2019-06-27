Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E653C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C042085A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C042085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgS21-0006qB-IT
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 06:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54315)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hgS0T-000658-SU
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hgS0P-000507-AQ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:51:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hgS0D-0004aV-GV; Thu, 27 Jun 2019 06:51:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 06DC9223873;
 Thu, 27 Jun 2019 10:51:15 +0000 (UTC)
Received: from [10.36.116.89] (ovpn-116-89.ams2.redhat.com [10.36.116.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E4AA5C1B4;
 Thu, 27 Jun 2019 10:51:12 +0000 (UTC)
To: Andrew Jones <drjones@redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-8-drjones@redhat.com>
 <96afb9ed-5cbd-ba7c-c6f9-c3191f4209b0@redhat.com>
 <20190627094036.asw3phwp3ivjafl3@kamzik.brq.redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <dc80cd7b-b331-8fd5-2e28-b8e140ee31a4@redhat.com>
Date: Thu, 27 Jun 2019 12:51:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190627094036.asw3phwp3ivjafl3@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 27 Jun 2019 10:51:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 07/14] target/arm/cpu64: max cpu:
 Introduce sve<vl-bits> properties
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

Hi Drew,
On 6/27/19 11:40 AM, Andrew Jones wrote:
> On Wed, Jun 26, 2019 at 04:58:05PM +0200, Auger Eric wrote:
>> Hi Drew,
>>
>> On 6/21/19 6:34 PM, Andrew Jones wrote:
>>> Introduce cpu properties to give fine control over SVE vector lengths.
>>> We introduce a property for each valid length up to the current
>>> maximum supported, which is 2048-bits. The properties are named, e.g.
>>> sve128, sve256, sve512, ..., where the number is the number of bits.
>> sve384 then in the natural order, otherwise it gives the impression you
>> can only specify * 128bit pow of 2 sizes at this stage of the reading.
> 
> OK
> 
>>
>>>
>>> It's now possible to do something like -cpu max,sve-max-vq=4,sve384=off
>> Document the fact sve512 cannot be turned to off, which sounds fully
>> sensible (by reading the code). By the way, I think an actual
>> documentation should be provided in qemu. Maybe as spec to agree on.
> 
> Actually, maybe I could just allow it to be disabled. It would be
> a strange command line to do '-cpu max,sve-max-vq=4,sve512=off', but if
> that's what the user wants, then there's not really any good reason to
> block it. As I say below, mixing these types of properties on the command
> line isn't really a good idea, but it's not completely blocked because we
> want a user that prefers launching their (most likely TCG) guest with,
> e.g.  '-cpu max,sve-max-vq=4', to also have a functional QMP CPU model
> expansion, but the CPU model expansion for SVE vector lengths depends on
> the sve<vl-bits> properties, thus mixing sve-max-vq with sve<vl-bits>,
> where sve-max-vq comes first. They're just not mixed on the command line.
OK
> 
>>> to provide a guest vector lengths 128, 256, and 512 bits. The resulting
>>> set must conform to the architectural constraint of having all power-of-2
>>> lengths smaller than the maximum length present. It's also possible to
>>> only provide sve<vl-bits> properties, e.g. -cpu max,sve512=on> That example provides the machine with 128, 256, and 512 bit vector
>> lengths.
>>> It doesn't hurt to explicitly ask for all expected vector lengths,
>>> which is what, for example, libvirt should do.>
>>> Note1, it is not possible to use sve<vl-bits> properties before
>>> sve-max-vq, e.g. -cpu max,sve384=off,sve-max-vq=4, as supporting
>>> that overly complicates the user input validation.
>>>
>>> Note2, while one might expect -cpu max,sve-max-vq=4,sve512=on to be the
>>> same as -cpu max,sve512=on, they are not.
>> yep it is a bit weird
>>
>> Didn't you consider -cpu max,sve-max-vq=4,req_only=true removing non
>> power of 2 values and sve<vl-bits> setting a single VLbit?
> 
> Nope. I mostly considered making sure sve-max-vq was supported to the
> level necessary to work with the new properties, and to not change its
> current semantics, but I don't want to extend it in any way, nor to
> require it to be used with the new properties at all. sve-max-vq isn't
> even going to be supported by '-cpu host', so we can't rely on it being
> part of the SVE vector length selection for normal KVM guests.
OK, as long as it is documented somewhere.
> 
> Keep in mind that the current semantics of sve-max-vq are to enable all
> vector lengths up to and including that specified maximum. That's not
> a safe way to select vector lengths on KVM, as it may include vector
> lengths that the KVM host does not support, thus it's not something KVM
> users should use. It's already there for the 'max' cpu type though, so
> we work with it in this series the best we can for 'max', but not at all
> for 'host'.
Do you expect hosts to expose only a few of the permitted values? I
imagined it would generally expose none or all of them actually. If you
discourage people to use sve-max-vq and sve<>=on only sets 2^n values,
userspace will need to set manually all intermediate !2^n values
> 
> Re: documentation for this. I suppose I could write something up that
> clarifies the properties and also suggests best practices regarding
> sve-max-vq.

To me this is really helpful to have a global understanding
> 
>>> The former enables all vector lengths 512 bits and smaller
>> ( required and permitted)
>>> while the latter only sets the 512-bit
>>> length and its smaller power-of-2 lengths. It's probably best not to use
>>> sve-max-vq with sve<vl-bits> properties, but it can't be completely
>>> forbidden as we want qmp_query_cpu_model_expansion to work with guests
>>> launched with e.g. -cpu max,sve-max-vq=8 on their command line.
>> what does happen if you specify -cpu max,sve384=on? (seems to be allowed
>> in the code?)
> 
> That's perfectly valid with tcg, you'll get 128,256,384. It's also valid
> with KVM if you're host supports it.
OK so it exposes the maximum configurable vector length + all the
corresponding required values.
> 
>>
>>>
>>> Signed-off-by: Andrew Jones <drjones@redhat.com>
>>> ---
>>>  target/arm/cpu.c         |   6 +
>>>  target/arm/cpu.h         |  14 ++
>>>  target/arm/cpu64.c       | 360 ++++++++++++++++++++++++++++++++++++++-
>>>  target/arm/helper.c      |  11 +-
>>>  target/arm/monitor.c     |  16 ++
>>>  tests/arm-cpu-features.c | 217 +++++++++++++++++++++++
>>>  6 files changed, 620 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>> index f08e178fc84b..e060a0d9df0e 100644
>>> --- a/target/arm/cpu.c
>>> +++ b/target/arm/cpu.c
>>> @@ -1019,6 +1019,12 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>>>          return;
>>>      }
>>>  
>>> +    arm_cpu_sve_finalize(cpu, &local_err);
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>> +        return;
>>> +    }
>>> +
>>>      if (arm_feature(env, ARM_FEATURE_AARCH64) &&
>>>          cpu->has_vfp != cpu->has_neon) {
>>>          /*
>>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>> index f9da672be575..cbb155cf72a5 100644
>>> --- a/target/arm/cpu.h
>>> +++ b/target/arm/cpu.h
>>> @@ -184,8 +184,13 @@ typedef struct {
>>>  
>>>  #ifdef TARGET_AARCH64
>>>  # define ARM_MAX_VQ    16
>>> +void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
>>> +uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq);
>>>  #else
>>>  # define ARM_MAX_VQ    1
>>> +static inline void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp) { }
>>> +static inline uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
>>> +{ return 0; }
>>>  #endif
>>>  
>>>  typedef struct ARMVectorReg {
>>> @@ -915,6 +920,15 @@ struct ARMCPU {
>>>  
>>>      /* Used to set the maximum vector length the cpu will support.  */
>>>      uint32_t sve_max_vq;
>>> +
>>> +    /*
>>> +     * In sve_vq_map each set bit is a supported vector length of
>>> +     * (bit-number + 1) * 16 bytes, i.e. each bit number + 1 is the vector> +     * length in quadwords. We need a map size twice the maximum
>>> +     * quadword length though because we use two bits for each vector
>>> +     * length in order to track three states: uninitialized, off, and on.
>>> +     */
>>> +    DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ * 2);
>>>  };
>>>  
>>>  void arm_cpu_post_init(Object *obj);
>>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>>> index 02ada65f240c..5def82111dee 100644
>>> --- a/target/arm/cpu64.c
>>> +++ b/target/arm/cpu64.c
>>> @@ -257,6 +257,149 @@ static void aarch64_a72_initfn(Object *obj)
>>>      define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
>>>  }
>>>  
>>> +/*
>>> + * While we eventually use cpu->sve_vq_map as a typical bitmap, where each vq
>>> + * has only two states (off/on), until we've finalized the map at realize time
>>> + * we use an extra bit, at the vq - 1 + ARM_MAX_VQ bit number, to also allow
>>> + * tracking of the uninitialized state. The arm_vq_state typedef and following
>>> + * functions allow us to more easily work with the bitmap. Also, while the map
>>> + * is still initializing, sve-max-vq has an additional three states, bringing
>>> + * the number of its states to five, which are the following:
>>> + *
>>> + * sve-max-vq:
>>> + *   0:    SVE is disabled. The default value for a vq in the map is 'OFF'.
>>> + *  -1:    SVE is enabled, but neither sve-max-vq nor sve<vl-bits> properties
>>> + *         have yet been specified by the user. The default value for a vq in
>>> + *         the map is 'ON'.
>>> + *  -2:    SVE is enabled and one or more sve<vl-bits> properties have been
>>> + *         set to 'OFF' by the user, but no sve<vl-bits> properties have yet
>>> + *         been set to 'ON'. The user is now blocked from setting sve-max-vq
>>> + *         and the default value for a vq in the map is 'ON'.
>>> + *  -3:    SVE is enabled and one or more sve<vl-bits> properties have been
>>> + *         set to 'ON' by the user. The user is blocked from setting sve-max-vq
>>> + *         and the default value for a vq in the map is 'OFF'. sve-max-vq never
>>> + *         transitions back to -2, even if later inputs disable the vector
>>> + *         lengths that initially transitioned sve-max-vq to this state. This
>>> + *         avoids the default values from flip-flopping.
>>> + *  [1-ARM_MAX_VQ]: SVE is enabled and the user has specified a valid
>>> + *                  sve-max-vq. The sve-max-vq specified vq and all smaller
>>> + *                  vq's will be initially enabled. All larger vq's will have
>>> + *                  a default of 'OFF'.
>>> + */
>>> +#define ARM_SVE_INIT          -1
>>> +#define ARM_VQ_DEFAULT_ON     -2
>>> +#define ARM_VQ_DEFAULT_OFF    -3
>>> +
>>> +#define arm_sve_have_max_vq(cpu) ((int32_t)(cpu)->sve_max_vq > 0)
>>> +
>>> +typedef enum arm_vq_state {
>>> +    ARM_VQ_OFF,
>>> +    ARM_VQ_ON,
>>> +    ARM_VQ_UNINITIALIZED,
>>> +} arm_vq_state;
>>> +
>>> +static arm_vq_state arm_cpu_vq_map_get(ARMCPU *cpu, int vq)> +{
>>> +    assert(vq <= ARM_MAX_VQ);
>>> +
>>> +    return test_bit(vq - 1, cpu->sve_vq_map) |
>>> +           test_bit(vq - 1 + ARM_MAX_VQ, cpu->sve_vq_map) << 1;
>>> +}> +
>>> +static void arm_cpu_vq_map_set(ARMCPU *cpu, int vq, arm_vq_state state)
>>> +{
>>> +    assert(state == ARM_VQ_OFF || state == ARM_VQ_ON);
>>> +    assert(vq <= ARM_MAX_VQ);
>>> +
>>> +    clear_bit(vq - 1 + ARM_MAX_VQ, cpu->sve_vq_map);
>>> +
>>> +    if (state == ARM_VQ_ON) {
>>> +        set_bit(vq - 1, cpu->sve_vq_map);
>>> +    } else {
>>> +        clear_bit(vq - 1, cpu->sve_vq_map);
>>> +    }
>>> +}
>>> +
>>> +static void arm_cpu_vq_map_init(ARMCPU *cpu)
>>> +{
>>> +    bitmap_zero(cpu->sve_vq_map, ARM_MAX_VQ * 2);
>> nit: bitmap_clear(map, 0, ARM_MAX_VQ);
> 
> bitmap_clear will only clear the specified bits, leaving the upper bits
> uninitialized, which could cause problems. It's not a problem here
> because we're using a zero initialized cpu state member, but if it was
> a bitmap like below, declared on the stack, then we need the zeroing at
> least once. I'd prefer to use zero here too, to keep it consistent.
Sorry I don't get it. I would have expected the above bitmap_clear would
0 initialize 0 - ARM_MAX_VQ-1 bits and the bitmap_set below would
initialize ARM_MAX_VQ - 2 * ARM_MAX_VQ -1 with 1's?

> 
>> /* all VLs OFF */
>>> +    bitmap_set(cpu->sve_vq_map, ARM_MAX_VQ, ARM_MAX_VQ);
>> /* all VLs uninitialized */
> 
> I can add one comment that says
> 
> "Set all VQ's to ARM_VQ_UNINITIALIZED" above both lines.
> 
>>> +}
>>> +
>>> +static bool arm_cpu_vq_map_is_finalized(ARMCPU *cpu)
>>> +{
>>> +    DECLARE_BITMAP(map, ARM_MAX_VQ * 2);
>>> +
>>> +    bitmap_zero(map, ARM_MAX_VQ * 2);
>> same
> 
> Here me must use bitmap_zero.
> 
>>> +    bitmap_set(map, ARM_MAX_VQ, ARM_MAX_VQ);
>>> +    bitmap_and(map, map, cpu->sve_vq_map, ARM_MAX_VQ * 2);
>>> +
>>> +    return bitmap_empty(map, ARM_MAX_VQ * 2);
>>> +}
>>> +
>>> +static void arm_cpu_vq_map_finalize(ARMCPU *cpu)
>>> +{
>>> +    Error *err = NULL;
>>> +    char name[8];
>>> +    uint32_t vq;
>>> +    bool value;
>>> +
>>> +    /*
>>> +     * We use the property get accessor because it knows what default
>>> +     * values to return for uninitialized vector lengths.
>>> +     */
>>> +    for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
>>> +        sprintf(name, "sve%d", vq * 128);
>>> +        value = object_property_get_bool(OBJECT(cpu), name, &err);
>>> +        assert(!err);
>>> +        if (value) {
>>> +            arm_cpu_vq_map_set(cpu, vq, ARM_VQ_ON);
>>> +        } else {
>>> +            arm_cpu_vq_map_set(cpu, vq, ARM_VQ_OFF);
>>> +        }
>>> +    }
>>> +
>>> +    assert(arm_cpu_vq_map_is_finalized(cpu));
>> this can be removed
> 
> Yes, it can be today, as the code works fine. The idea was that if
> somebody came in here and modified this in someway that broke the
> finalized state, then we'd catch it here before going off and doing
> weird things. This isn't a hot path, so I'd prefer we keep it, but
> if QEMU maintainers prefer to limit defensive code, then I can
> certainly remove it.
Well I understand this was useful was developing and to check some
tricky states but some of the asserts correspond to some checks that
look rather obvious, like this one. But well I let others give their
opinions and it is not a big deal either. Then we can wonder when one
needs a trace mesg before asserting ...
> 
>>> +}
>>> +
>>> +void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>>> +{
>>> +    Error *err = NULL;
>>> +
>>> +    if (!cpu->sve_max_vq) {
>>> +        bitmap_zero(cpu->sve_vq_map, ARM_MAX_VQ * 2);
>>> +        return;
>>> +    }
>>> +
>>> +    if (cpu->sve_max_vq == ARM_SVE_INIT) {
>>> +        object_property_set_uint(OBJECT(cpu), ARM_MAX_VQ, "sve-max-vq", &err);
>>> +        if (err) {
>>> +            error_propagate(errp, err);
>>> +            return;
>>> +        }
>>> +        assert(cpu->sve_max_vq == ARM_MAX_VQ);
>> I guess those asserts can be removed now?
> 
> I'd prefer to keep it. It's critical that we get this right, so if
> somebody changes something somewhere in the property set/get code
> that would break this, then it's best we know right away. Again,
> though, if there's some reason to limit defensive code, even on the
> init path, then I can.
Here I would expect that if the set did not fail, sve-max-vq effectively
if set to the expected value. But maybe I don't remember the cases where
sve_max-vq can be set to some other value without reprting an error.

> 
>>> +        arm_cpu_vq_map_finalize(cpu);
>> move the arm_cpu_vq_map_finalize out of the if, at the end.
> 
> That wouldn't work. In this branch arm_cpu_vq_map_finalize() comes
> after setting cpu->sve_max_vq. In the else branch it must come first.
That's right sorry
> 
>>> +    } else {
>>> +        arm_cpu_vq_map_finalize(cpu);
>>> +        if (!arm_sve_have_max_vq(cpu)) {
>>> +            cpu->sve_max_vq = arm_cpu_vq_map_next_smaller(cpu, ARM_MAX_VQ + 1);
>>> +        }
>>> +    }
>>> +
>>> +    assert(cpu->sve_max_vq == arm_cpu_vq_map_next_smaller(cpu, ARM_MAX_VQ));>
> What happened to my '+ 1' here? I see it's in the patch, but somehow got
> removed in your quote of the patch? For a second there I thought something
> was really wrong, since that assert should have fired for every full map.
Yep sorry for the cut :-(
> 
>> same here
> 
> Anyway my same argument that we don't want to leave arm_cpu_sve_finalize()
> without knowing we got this right applies.

> 
>>> +}
>>> +
>>> +uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
>>> +{
>>> +    uint32_t bitnum;
>>> +
>>> +    assert(vq <= ARM_MAX_VQ + 1);
>>> +    assert(arm_cpu_vq_map_is_finalized(cpu));
>>> +
>>> +    bitnum = find_last_bit(cpu->sve_vq_map, vq - 1);
>> why do you pass ARM_MAX_VQ + 1 and then do vq -1? doesn't
>> find_last_bit() take the size which is ARM_MAX_VQ in this case?
> 
> The size is ARM_MAX_VQ + 1, when you want to also check the bitnum
> corresponding to ARM_MAX_VQ. The bitnum for a VQ is always VQ - 1.
> Recall VQ=1, which is 128-bits. It takes the bit position zero.
> VQ=ARM_MAX_VQ=16 takes the bit position 15. As for the 'vq - 1' here
> in the find_last_bit() call, that's required because that's what the
> function says it does. It finds the next smaller VQ. So if you pass
> in, for example, vq=2, it shouldn't search anything but bit position
> zero:
> 
>  vq=2 => max next smaller is vq=1, bitnum = 0
>       => search the bitmap of size 1 for the last set bit
> 
> Or, if you want to search the whole map, including the maximum
> possibly VQ, as is done above, then you need to pass ARM_MAX_VQ + 1,
> since the max next smaller VQ is ARM_MAX_VQ.
OK I get it now. Maybe renaming the function into something like
arm_cpu_vq_map_last_bit() would have avoided that. the first assert
looks strange typically.
> 
>>> +    return bitnum == vq - 1 ? 0 : bitnum + 1;
>>> +}
>>> +
>>>  static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *name,
>>>                                     void *opaque, Error **errp)
>>>  {
>>> @@ -283,12 +426,203 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
>>>          return;
>>>      }
>>>  
>>> +    /*
>>> +     * It gets complicated trying to support both sve-max-vq and
>>> +     * sve<vl-bits> properties together, so we mostly don't. We
>>> +     * do allow both if sve-max-vq is specified first and only once
>>> +     * though.
>>> +     */
>>> +    if (cpu->sve_max_vq != ARM_SVE_INIT) {
>>> +        error_setg(errp, "sve<vl-bits> in use or sve-max-vq already "
>>> +                   "specified");
>>> +        error_append_hint(errp, "sve-max-vq must come before all "
>>> +                          "sve<vl-bits> properties and it must only "
>>> +                          "be specified once.\n");
>>> +        return;
>>> +    }
>>> +
>>>      cpu->sve_max_vq = value;
>>>  
>>>      if (cpu->sve_max_vq == 0 || cpu->sve_max_vq > ARM_MAX_VQ) {
>>>          error_setg(errp, "unsupported SVE vector length");
>>>          error_append_hint(errp, "Valid sve-max-vq in range [1-%d]\n",
>>>                            ARM_MAX_VQ);
>>> +    } else {
>>> +        uint32_t vq;
>>> +
>>> +        for (vq = 1; vq <= cpu->sve_max_vq; ++vq) {
>>> +            char name[8];
>>> +            sprintf(name, "sve%d", vq * 128);
>>> +            object_property_set_bool(obj, true, name, &err);
>>> +            if (err) {
>>> +                error_propagate(errp, err);
>>> +                return;
>>> +            }
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +static void cpu_arm_get_sve_vq(Object *obj, Visitor *v, const char *name,
>>> +                               void *opaque, Error **errp)
>>> +{
>>> +    ARMCPU *cpu = ARM_CPU(obj);
>>> +    int vq = atoi(&name[3]) / 128;
>>> +    arm_vq_state vq_state;
>>> +    bool value;
>>> +
>>> +    vq_state = arm_cpu_vq_map_get(cpu, vq);
>>> +
>>> +    if (!cpu->sve_max_vq) {
>>> +        /* All vector lengths are disabled when SVE is off. */
>>> +        value = false;
>>> +    } else if (vq_state == ARM_VQ_ON) {
>>> +        value = true;
>>> +    } else if (vq_state == ARM_VQ_OFF) {
>>> +        value = false;
>>> +    } else {
>>> +        /*
>>> +         * vq is uninitialized. We pick a default here based on the
>>> +         * the state of sve-max-vq and other sve<vl-bits> properties.
>>> +         */
>>> +        if (arm_sve_have_max_vq(cpu)) {
>>> +            /*
>>> +             * If we have sve-max-vq, then all remaining uninitialized
>>> +             * vq's are 'OFF'.
>>> +             */
>>> +            value = false;
>>> +        } else {
>>> +            switch (cpu->sve_max_vq) {
>>> +            case ARM_SVE_INIT:
>>> +            case ARM_VQ_DEFAULT_ON:
>>> +                value = true;
>>> +                break;
>>> +            case ARM_VQ_DEFAULT_OFF:
>>> +                value = false;
>>> +                break;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +    visit_type_bool(v, name, &value, errp);
>>> +}
>>> +
>>> +static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name,
>>> +                               void *opaque, Error **errp)
>>> +{
>>> +    ARMCPU *cpu = ARM_CPU(obj);
>>> +    int vq = atoi(&name[3]) / 128;
>>> +    arm_vq_state vq_state;
>>> +    Error *err = NULL;
>>> +    uint32_t max_vq = 0;
>>> +    bool value;
>>> +
>>> +    visit_type_bool(v, name, &value, &err);
>>> +    if (err) {
>>> +        error_propagate(errp, err);
>>> +        return;
>>> +    }
>>> +
>>> +    if (value && !cpu->sve_max_vq) {
>>> +        error_setg(errp, "cannot enable %s", name);
>>> +        error_append_hint(errp, "SVE has been disabled with sve=off\n");
>>> +        return;
>>> +    } else if (!cpu->sve_max_vq) {
>>> +        /*
>>> +         * We don't complain about disabling vector lengths when SVE
>>> +         * is off, but we don't do anything either.
>>> +         */
>>> +        return;
>>> +    }
>>> +
>>> +    if (arm_sve_have_max_vq(cpu)) {
>>> +        max_vq = cpu->sve_max_vq;
>>> +    } else {
>>> +        if (value) {
>>> +            cpu->sve_max_vq = ARM_VQ_DEFAULT_OFF;
>>> +        } else if (cpu->sve_max_vq != ARM_VQ_DEFAULT_OFF) {
>>> +            cpu->sve_max_vq = ARM_VQ_DEFAULT_ON;
>>> +        }
>>> +    }
>>> +
>>> +    /*
>>> +     * We need to know the maximum vector length, which may just currently
>>> +     * be the maximum length, in order to validate the enabling/disabling
>>> +     * of this vector length. We use the property get accessor in order to
>>> +     * get the appropriate default value for any uninitialized lengths.
>>> +     */
>>> +    if (!max_vq) {
>>> +        char tmp[8];
>>> +        bool s;
>>> +
>>> +        for (max_vq = ARM_MAX_VQ; max_vq >= 1; --max_vq) {
>>> +            sprintf(tmp, "sve%d", max_vq * 128);
>>> +            s = object_property_get_bool(OBJECT(cpu), tmp, &err);
>>> +            assert(!err);
>>> +            if (s) {
>>> +                break;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +    if (arm_sve_have_max_vq(cpu) && value && vq > cpu->sve_max_vq) {
>>> +        error_setg(errp, "cannot enable %s", name);
>>> +        error_append_hint(errp, "vq=%d (%d bits) is larger than the "
>>> +                          "maximum vector length, sve-max-vq=%d "
>>> +                          "(%d bits)\n", vq, vq * 128,
>>> +                          cpu->sve_max_vq, cpu->sve_max_vq * 128);
>>> +    } else if (arm_sve_have_max_vq(cpu) && !value && vq == cpu->sve_max_vq) {
>>> +        error_setg(errp, "cannot disable %s", name);
>>> +        error_append_hint(errp, "The maximum vector length must be "
>>> +                          "enabled, sve-max-vq=%d (%d bits)\n",
>>> +                          cpu->sve_max_vq, cpu->sve_max_vq * 128);
>>> +    } else if (arm_sve_have_max_vq(cpu) && !value && vq < cpu->sve_max_vq &&
>>> +               is_power_of_2(vq)) {
>>> +        error_setg(errp, "cannot disable %s", name);
>>> +        error_append_hint(errp, "vq=%d (%d bits) is required as it is a "
>>> +                          "power-of-2 length smaller than the maximum, "
>>> +                          "sve-max-vq=%d (%d bits)\n", vq, vq * 128,
>>> +                          cpu->sve_max_vq, cpu->sve_max_vq * 128);
>>> +    } else if (!value && vq < max_vq && is_power_of_2(vq)) {
>>> +        error_setg(errp, "cannot disable %s", name);
>>> +        error_append_hint(errp, "Vector length %d-bits is required as it "
>>> +                          "is a power-of-2 length smaller than another "
>>> +                          "enabled vector length. Disable all larger vector "
>>> +                          "lengths first.\n", vq * 128);
>>> +    } else {
>> adding return in each if/elsif would allow to avoid this indent.
> 
> Yeah, but I didn't really mind the indent :-)
> 
>>> +        if (value) {
>>> +            bool fail = false;
>>> +            uint32_t s;
>>> +
>>> +            /*
>>> +             * Enabling a vector length automatically enables all
>>> +             * uninitialized power-of-2 lengths smaller than it, as
>>> +             * per the architecture.
>>> +             */
>> Test we are not attempting to enable a !is_power_of_2
> 
> I'm not sure what this means. In this context 'vq' can be a !power-of-2
> if it wants to be, and there's no way for 's' to be a !power-of-2 because
> we filter the vq's with is_power_of_2(s).
Yep got it now
> 
>>> +            for (s = 1; s < vq; ++s) {
>>> +                if (is_power_of_2(s)) {
>>> +                    vq_state = arm_cpu_vq_map_get(cpu, s);
>>> +                    if (vq_state == ARM_VQ_UNINITIALIZED) {
>>> +                        arm_cpu_vq_map_set(cpu, s, ARM_VQ_ON);
>>> +                    } else if (vq_state == ARM_VQ_OFF) {
>>> +                        fail = true;
>>> +                        break;
>>> +                    }
>>> +                }
>>> +            }
>>> +
>>> +            if (fail) {
>>> +                error_setg(errp, "cannot enable %s", name);
>>> +                error_append_hint(errp, "Vector length %d-bits is disabled "
>>> +                                  "and is a power-of-2 length smaller than "
>>> +                                  "%s. All power-of-2 vector lengths smaller "
>>> +                                  "than the maximum length are required.\n",
>>> +                                  s * 128, name);
>>> +            } else {
>>> +                arm_cpu_vq_map_set(cpu, vq, ARM_VQ_ON);
>>> +            }
>>> +        } else {
>>> +            arm_cpu_vq_map_set(cpu, vq, ARM_VQ_OFF);
>>> +        }
>>>      }
>>>  }
>>>  
>>> @@ -318,10 +652,11 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
>>>          /*
>>>           * We handle the -cpu <cpu>,sve=off,sve=on case by reinitializing,
>>>           * but otherwise we don't do anything as an sve=on could come after
>>> -         * a sve-max-vq setting.
>>> +         * a sve-max-vq or sve<vl-bits> setting.
>>>           */
>>>          if (!cpu->sve_max_vq) {
>>> -            cpu->sve_max_vq = ARM_MAX_VQ;
>>> +            cpu->sve_max_vq = ARM_SVE_INIT;
>>> +            arm_cpu_vq_map_init(cpu);
>>>          }
>>>      } else {
>>>          cpu->sve_max_vq = 0;
>>> @@ -336,6 +671,7 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
>>>  static void aarch64_max_initfn(Object *obj)
>>>  {
>>>      ARMCPU *cpu = ARM_CPU(obj);
>>> +    uint32_t vq;
>>>  
>>>      if (kvm_enabled()) {
>>>          kvm_arm_set_cpu_features_from_host(cpu);
>>> @@ -420,11 +756,29 @@ static void aarch64_max_initfn(Object *obj)
>>>          cpu->dcz_blocksize = 7; /*  512 bytes */
>>>  #endif
>>>  
>>> -        cpu->sve_max_vq = ARM_MAX_VQ;
>>> +        /*
>>> +         * sve_max_vq is initially unspecified, but must be initialized to a
>>> +         * non-zero value (ARM_SVE_INIT) to indicate that this cpu type has
>>> +         * SVE. It will be finalized in arm_cpu_realizefn().
>>> +         */
>>> +        cpu->sve_max_vq = ARM_SVE_INIT;
>>>          object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
>>>                              cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
>>>          object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
>>>                              cpu_arm_set_sve, NULL, NULL, &error_fatal);
>>> +
>>> +        /*
>>> +         * sve_vq_map uses a special state while setting properties, so
>>> +         * we initialize it here with its init function and finalize it
>>> +         * in arm_cpu_realizefn().
>>> +         */
>>> +        arm_cpu_vq_map_init(cpu);
>>> +        for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
>>> +            char name[8];
>>> +            sprintf(name, "sve%d", vq * 128);
>>> +            object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
>>> +                                cpu_arm_set_sve_vq, NULL, NULL, &error_fatal);
>>> +        }
>>>      }
>>>  }
>>>  
>>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>>> index f500ccb6d31b..b7b719dba57f 100644
>>> --- a/target/arm/helper.c
>>> +++ b/target/arm/helper.c
>>> @@ -5324,7 +5324,16 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>>  
>>>      /* Bits other than [3:0] are RAZ/WI.  */
>>>      QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
>>> -    raw_write(env, ri, value & 0xf);
>>> +    value &= 0xf;
>>> +
>>> +    if (value) {> +        /* get next vq that is smaller than or equal to value's vq */
>>> +        uint32_t vq = value + 1;
>> ditto
> 
> What does this 'ditto' map to? Oh, probably the discussion about vq's
> getting +1's and -1's. In this context 'value' is the ZCR_ELx
> representation of a VQ, which is VQ - 1, just like in the bitmap. To
> translate that to a VQ we need to do a '+ 1'.

Until here I follow. By the way in which doc did you find the
description of ZCR_ELx?

 As I wrote in the comment
> here, we want to find the next smaller or equal VQ here, because this is
> the input VQ from the guest which may itself be a valid VQ, but if it's
> not, we need to step down to the next valid one. So we ask
> arm_cpu_vq_map_next_smaller() for 'vq + 1' in order to ensure 'vq' will
> be in the searched range. After we get a valid vq from
> arm_cpu_vq_map_next_smaller(), which must be at least '1', since that's
> required by the architecture and thus will always be present, we need to
> translate it back to the ZCR_ELx representation with the subtraction.
> Phew... We programmers do love adding and subtracting by one, right :-)
Got it now. but well I scratched my head
> 
>>> +        vq = arm_cpu_vq_map_next_smaller(cpu, vq + 1);
>>> +        value = vq - 1;
>>> +    }
>>> +
>>> +    raw_write(env, ri, value);
>>>  
>>>      /*
>>>       * Because we arrived here, we know both FP and SVE are enabled;
>>> diff --git a/target/arm/monitor.c b/target/arm/monitor.c
>>> index 157c487a1551..1e213906fd8f 100644
>>> --- a/target/arm/monitor.c
>>> +++ b/target/arm/monitor.c
>>> @@ -89,8 +89,24 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
>>>      return head;
>>>  }
>>>  
>>> +QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
>>> +
>>> +/*
>>> + * These are cpu model features we want to advertise. The order here
>>> + * matters as this is the order in which qmp_query_cpu_model_expansion
>>> + * will attempt to set them. If there are dependencies between features,
>>> + * as there are with the sve<vl-bits> features, then the order that
>>> + * considers those dependencies must be used.
>>> + *
>>> + * The sve<vl-bits> features need to be in reverse order in order to
>>> + * enable/disable the largest vector lengths first, ensuring all
>>> + * power-of-2 vector lengths smaller can also be enabled/disabled.
>>> + */
>>>  static const char *cpu_model_advertised_features[] = {
>>>      "aarch64", "pmu", "sve",
>>> +    "sve2048", "sve1920", "sve1792", "sve1664", "sve1536", "sve1408",
>>> +    "sve1280", "sve1152", "sve1024", "sve896", "sve768", "sve640",
>>> +    "sve512", "sve384", "sve256", "sve128",
>>>      NULL
>>>  };
>>>  
>>> diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
>> Please move all the tests in a separate patch.
> 
> I'd prefer not to. I like keeping the test cases that test the new code in
> the same patch. It self documents what the test cases map to what code and
> allows immediate testing of the patch when bisecting. Also I'm not really
> sure how it makes review worse, as another patch would look the same, just
> in a different email. 
A reviewier might not be familiar with both standard code and test and
feel reluctant to invest reading boths, hence reducing the chances to
collect R-b's. But that's my humble opinion.
> 
>> Each day has enough trouble of its own ;-) sweat...
> 
> I really appreciate the review! I realize it's generating sweat,
> especially with the European heat wave! You don't have to finish
> a patch before sending comments. I'm fine with multiple replies to
> the same patch if you want to break your review up into smaller
> bites.

Thanks. Yes breathing times are needed due to the heat and digestion of
the code ;-)

Thanks

Eric
> 
> Thanks,
> drew
> 
>>
>> Thanks
>>
>> Eric
>>> index 509e458e9c2f..a4bf6aec00df 100644
>>> --- a/tests/arm-cpu-features.c
>>> +++ b/tests/arm-cpu-features.c
>>> @@ -13,6 +13,18 @@
>>>  #include "qapi/qmp/qdict.h"
>>>  #include "qapi/qmp/qjson.h"
>>>  
>>> +#if __SIZEOF_LONG__ == 8
>>> +#define BIT(n) (1UL << (n))
>>> +#else
>>> +#define BIT(n) (1ULL << (n))
>>> +#endif
>>> +
>>> +/*
>>> + * We expect the SVE max-vq to be 16. Also it must be <= 64
>>> + * for our test code, otherwise 'vls' can't just be a uint64_t.
>>> + */
>>> +#define SVE_MAX_VQ 16
>>> +
>>>  #define MACHINE    "-machine virt,gic-version=max "
>>>  #define QUERY_HEAD "{ 'execute': 'query-cpu-model-expansion', " \
>>>                       "'arguments': { 'type': 'full', "
>>> @@ -137,6 +149,201 @@ static void assert_bad_props(QTestState *qts, const char *cpu_type)
>>>      qobject_unref(resp);
>>>  }
>>>  
>>> +static void resp_get_sve_vls(QDict *resp, uint64_t *vls, uint32_t *max_vq)
>>> +{
>>> +    const QDictEntry *e;
>>> +    QDict *qdict;
>>> +    int n = 0;
>>> +
>>> +    *vls = 0;
>>> +
>>> +    qdict = resp_get_props(resp);
>>> +
>>> +    for (e = qdict_first(qdict); e; e = qdict_next(qdict, e)) {
>>> +        if (strlen(e->key) > 3 && !strncmp(e->key, "sve", 3) &&
>>> +            g_ascii_isdigit(e->key[3])) {
>>> +            char *endptr;
>>> +            int bits;
>>> +
>>> +            bits = g_ascii_strtoll(&e->key[3], &endptr, 10);
>>> +            if (!bits || *endptr != '\0') {
>>> +                continue;
>>> +            }
>>> +
>>> +            if (qdict_get_bool(qdict, e->key)) {
>>> +                *vls |= BIT((bits / 128) - 1);
>>> +            }
>>> +            ++n;
>>> +        }
>>> +    }
>>> +
>>> +    g_assert(n == SVE_MAX_VQ);
>>> +
>>> +    *max_vq = !*vls ? 0 : 64 - __builtin_clzll(*vls);
>>> +}
>>> +
>>> +static uint64_t sve_get_vls(QTestState *qts, const char *cpu_type,
>>> +                            const char *fmt, ...)
>>> +{
>>> +    QDict *resp;
>>> +    uint64_t vls;
>>> +    uint32_t max_vq;
>>> +
>>> +    if (fmt) {
>>> +        QDict *args;
>>> +        va_list ap;
>>> +
>>> +        va_start(ap, fmt);
>>> +        args = qdict_from_vjsonf_nofail(fmt, ap);
>>> +        va_end(ap);
>>> +
>>> +        resp = qtest_qmp(qts, QUERY_HEAD "'model': { 'name': %s, "
>>> +                                                    "'props': %p }"
>>> +                              QUERY_TAIL, cpu_type, args);
>>> +    } else {
>>> +        resp = do_query_no_props(qts, cpu_type);
>>> +    }
>>> +
>>> +    g_assert(resp);
>>> +    resp_get_sve_vls(resp, &vls, &max_vq);
>>> +    qobject_unref(resp);
>>> +
>>> +    return vls;
>>> +}
>>> +
>>> +#define assert_sve_vls(qts, cpu_type, expected_vls, fmt, ...) \
>>> +    g_assert(sve_get_vls(qts, cpu_type, fmt, ##__VA_ARGS__) == expected_vls)
>>> +
>>> +static void sve_tests_default(QTestState *qts, const char *cpu_type)
>>> +{
>>> +    /*
>>> +     * With no sve-max-vq or sve<vl-bits> properties on the command line
>>> +     * the default is to have all vector lengths enabled.
>>> +     */
>>> +    assert_sve_vls(qts, cpu_type, BIT(SVE_MAX_VQ) - 1, NULL);
>>> +
>>> +    /*
>>> +     * -------------------------------------------------------------------
>>> +     *               power-of-2(vq)   all-power-            can      can
>>> +     *                                of-2(< vq)          enable   disable
>>> +     * -------------------------------------------------------------------
>>> +     * vq < max_vq      no            MUST*                yes      yes
>>> +     * vq < max_vq      yes           MUST*                yes      no
>>> +     * -------------------------------------------------------------------
>>> +     * vq == max_vq     n/a           MUST*                yes**    yes**
>>> +     * -------------------------------------------------------------------
>>> +     * vq > max_vq      n/a           no                   no       yes
>>> +     * vq > max_vq      n/a           yes                  yes      yes
>>> +     * -------------------------------------------------------------------
>>> +     *
>>> +     * [*] "MUST" means this requirement must already be satisfied,
>>> +     *     otherwise 'max_vq' couldn't itself be enabled.
>>> +     *
>>> +     * [**] Not testable with the QMP interface, only with the command line.
>>> +     */
>>> +
>>> +    /* max_vq := 8 */
>>> +    assert_sve_vls(qts, cpu_type, 0x8b, "{ 'sve1024': true }");
>>> +
>>> +    /* max_vq := 8, vq < max_vq, !power-of-2(vq) */
>>> +    assert_sve_vls(qts, cpu_type, 0x8f,
>>> +                   "{ 'sve1024': true, 'sve384': true }");
>>> +    assert_sve_vls(qts, cpu_type, 0x8b,
>>> +                   "{ 'sve1024': true, 'sve384': false }");
>>> +
>>> +    /* max_vq := 8, vq < max_vq, power-of-2(vq) */
>>> +    assert_sve_vls(qts, cpu_type, 0x8b,
>>> +                   "{ 'sve1024': true, 'sve256': true }");
>>> +    assert_error(qts, cpu_type, "cannot disable sve256",
>>> +                 "{ 'sve1024': true, 'sve256': false }");
>>> +
>>> +    /*
>>> +     * max_vq := 3, vq > max_vq, !all-power-of-2(< vq)
>>> +     *
>>> +     * If given sve384=on,sve512=off,sve640=on the command line error would be
>>> +     * "cannot enable sve640", but QMP visits the vector lengths in reverse
>>> +     * order, so we get "cannot disable sve512" instead. The command line would
>>> +     * also give that error if given sve384=on,sve640=on,sve512=off, so this is
>>> +     * all fine. The important thing is that we get an error.
>>> +     */
>>> +    assert_error(qts, cpu_type, "cannot disable sve512",
>>> +                 "{ 'sve384': true, 'sve512': false, 'sve640': true }");
>>> +
>>> +    /*
>>> +     * We can disable power-of-2 vector lengths when all larger lengths
>>> +     * are also disabled. The shorter, sve384=on,sve512=off,sve640=off
>>> +     * works on the command line, but QMP doesn't know that all the
>>> +     * vector lengths larger than 384-bits will be disabled until it
>>> +     * sees the enabling of sve384, which comes near the end since it
>>> +     * visits the lengths in reverse order. So we just have to explicitly
>>> +     * disable them all.
>>> +     */
>>> +    assert_sve_vls(qts, cpu_type, 0x7,
>>> +                   "{ 'sve384': true, 'sve512': false, 'sve640': false, "
>>> +                   "  'sve768': false, 'sve896': false, 'sve1024': false, "
>>> +                   "  'sve1152': false, 'sve1280': false, 'sve1408': false, "
>>> +                   "  'sve1536': false, 'sve1664': false, 'sve1792': false, "
>>> +                   "  'sve1920': false, 'sve2048': false }");
>>> +
>>> +    /* max_vq := 3, vq > max_vq, all-power-of-2(< vq) */
>>> +    assert_sve_vls(qts, cpu_type, 0x1f,
>>> +                   "{ 'sve384': true, 'sve512': true, 'sve640': true }");
>>> +    assert_sve_vls(qts, cpu_type, 0xf,
>>> +                   "{ 'sve384': true, 'sve512': true, 'sve640': false }");
>>> +}
>>> +
>>> +static void sve_tests_sve_max_vq_8(const void *data)
>>> +{
>>> +    QTestState *qts;
>>> +
>>> +    qts = qtest_init(MACHINE "-cpu max,sve-max-vq=8");
>>> +
>>> +    assert_sve_vls(qts, "max", BIT(8) - 1, NULL);
>>> +
>>> +    /*
>>> +     * Disabling the max-vq set by sve-max-vq is not allowed, but
>>> +     * of course enabling it is OK.
>>> +     */
>>> +    assert_error(qts, "max", "cannot disable sve1024", "{ 'sve1024': false }");
>>> +    assert_sve_vls(qts, "max", 0xff, "{ 'sve1024': true }");
>>> +
>>> +    /*
>>> +     * Enabling anything larger than max-vq set by sve-max-vq is not
>>> +     * allowed, but of course disabling everything larger is OK.
>>> +     */
>>> +    assert_error(qts, "max", "cannot enable sve1152", "{ 'sve1152': true }");
>>> +    assert_sve_vls(qts, "max", 0xff, "{ 'sve1152': false }");
>>> +
>>> +    /*
>>> +     * We can disable non power-of-2 lengths smaller than the max-vq
>>> +     * set by sve-max-vq, but not power-of-2 lengths.
>>> +     */
>>> +    assert_sve_vls(qts, "max", 0xfb, "{ 'sve384': false }");
>>> +    assert_error(qts, "max", "cannot disable sve256", "{ 'sve256': false }");
>>> +
>>> +    qtest_quit(qts);
>>> +}
>>> +
>>> +static void sve_tests_sve_off(const void *data)
>>> +{
>>> +    QTestState *qts;
>>> +
>>> +    qts = qtest_init(MACHINE "-cpu max,sve=off");
>>> +
>>> +    /*
>>> +     * SVE is off, so the map should be empty.
>>> +     */
>>> +    assert_sve_vls(qts, "max", 0, NULL);
>>> +
>>> +    /*
>>> +     * We can't turn anything on, but off is OK.
>>> +     */
>>> +    assert_error(qts, "max", "cannot enable sve128", "{ 'sve128': true }");
>>> +    assert_sve_vls(qts, "max", 0, "{ 'sve128': false }");
>>> +
>>> +    qtest_quit(qts);
>>> +}
>>> +
>>>  static void test_query_cpu_model_expansion(const void *data)
>>>  {
>>>      QTestState *qts;
>>> @@ -159,9 +366,12 @@ static void test_query_cpu_model_expansion(const void *data)
>>>      if (g_str_equal(qtest_get_arch(), "aarch64")) {
>>>          assert_has_feature(qts, "max", "aarch64");
>>>          assert_has_feature(qts, "max", "sve");
>>> +        assert_has_feature(qts, "max", "sve128");
>>>          assert_has_feature(qts, "cortex-a57", "pmu");
>>>          assert_has_feature(qts, "cortex-a57", "aarch64");
>>>  
>>> +        sve_tests_default(qts, "max");
>>> +
>>>          /* Test that features that depend on KVM generate errors without. */
>>>          assert_error(qts, "max",
>>>                       "'aarch64' feature cannot be disabled "
>>> @@ -213,6 +423,13 @@ int main(int argc, char **argv)
>>>      qtest_add_data_func("/arm/query-cpu-model-expansion",
>>>                          NULL, test_query_cpu_model_expansion);
>>>  
>>> +    if (g_str_equal(qtest_get_arch(), "aarch64")) {
>>> +        qtest_add_data_func("/arm/max/query-cpu-model-expansion/sve-max-vq-8",
>>> +                            NULL, sve_tests_sve_max_vq_8);
>>> +        qtest_add_data_func("/arm/max/query-cpu-model-expansion/sve-off",
>>> +                            NULL, sve_tests_sve_off);
>>> +    }
>>> +
>>>      if (kvm_available) {
>>>          qtest_add_data_func("/arm/kvm/query-cpu-model-expansion",
>>>                              NULL, test_query_cpu_model_expansion_kvm);
>>>
>>

