Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A157FC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78BA52173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BA52173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hng9B-0005IU-Mv
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 05:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33892)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hng90-0004u2-HI
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hng8z-0007Cz-7D
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:22:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52456)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hng8y-0007CT-RU
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:22:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C32EB307CDE7;
 Wed, 17 Jul 2019 09:22:35 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-5.ams2.redhat.com
 [10.36.117.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A0F65D9D5;
 Wed, 17 Jul 2019 09:22:31 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20181102171638.24069-1-peter.maydell@linaro.org>
 <20181102171638.24069-9-peter.maydell@linaro.org>
 <3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
 <CAFEAcA_FtoHOUv_cPgfO7GrZ8Ug9cKCvmY2z75i9DaAQ8Qx+gQ@mail.gmail.com>
 <417cd887-aec4-d8ba-1dd2-810bc4c04977@redhat.com>
 <CAFEAcA_JntiaOOWisqLVqAV6jc=wk4nR548KbbUcG0XLabcNpA@mail.gmail.com>
 <8d06b8f2-7ee8-a77a-81d7-3219d5e43c45@redhat.com>
 <dfeab9fd-7ee1-01f2-dd38-cba449b1de63@redhat.com>
 <f625f1f1-ad97-1c75-e44d-3b0c015312b3@redhat.com>
Message-ID: <cf9156f6-c3fa-ec7e-c51a-8b8d2fd1e6d6@redhat.com>
Date: Wed, 17 Jul 2019 11:22:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f625f1f1-ad97-1c75-e44d-3b0c015312b3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 17 Jul 2019 09:22:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 08/10] target/arm: Conditionalize some
 asserts on aarch32 support
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/17/19 10:36, Laszlo Ersek wrote:
> On 07/16/19 22:10, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 7/16/19 8:42 PM, Laszlo Ersek wrote:
>>> On 07/16/19 18:59, Peter Maydell wrote:
>>>> On Tue, 16 Jul 2019 at 17:51, Laszlo Ersek <lersek@redhat.com>
>>>> wrote:
>>>>> The issue still reproduces, so it makes sense for me to look at
>>>>> the host kernel version... Well, I'm afraid it won't help much,
>>>>> for an upstream investigation:
>>>>>
>>>>>   4.14.0-115.8.2.el7a.aarch64
>>>>>
>>>>> This is the latest released kernel from "Red Hat Enterprise Linux
>>>>> for ARM 64 7".
>>>>
>>>> OK. (I'm using 4.15.0-51-generic from ubuntu).
>>>>
>>>> Could you run with QEMU under gdb, and when it hits the
>>>> assertion go back up a stack frame to the arm_cpu_realizefn()
>>>> frame, and then "print /x cpu->isar" ? That should show us
>>>> what we think we've got as ID registers from the kernel.
>>>> (You might need to build QEMU with --enable-debug to get
>>>> useful enough debug info to do that, not sure.)
>>>
>>> (My qemu build script always builds QEMU in two configs, the
>>> difference being --prefix and --enable-debug.)
>>>
>>> This is what I got:
>>>
>>> (gdb) frame 4
>>> #4  0x00000000006a063c in arm_cpu_realizefn (dev=3D0x1761140,
>>>     errp=3D0xffffffffe540)
>>>     at .../qemu/target/arm/cpu.c:1159
>>> 1159            assert(no_aa32 || cpu_isar_feature(arm_div, cpu));
>>> (gdb) print /x cpu->isar
>>> $1 =3D {id_isar0 =3D 0x0, id_isar1 =3D 0x0, id_isar2 =3D 0x0, id_isar=
3 =3D 0x0,
>>>   id_isar4 =3D 0x0, id_isar5 =3D 0x0, id_isar6 =3D 0x0, mvfr0 =3D 0x0=
,
>>>   mvfr1 =3D 0x0, mvfr2 =3D 0x0, id_aa64isar0 =3D 0x0, id_aa64isar1 =3D=
 0x0,
>>>   id_aa64pfr0 =3D 0x11, id_aa64pfr1 =3D 0x0, id_aa64mmfr0 =3D 0x0,
>>>   id_aa64mmfr1 =3D 0x0}
>>
>> For ISAR0, DIVIDE=3D0
>>
>> so cpu_isar_feature(arm_div, cpu)=3Dfalse
>>
>> For AA64PFR0, EL0=3D1, EL1=3D1.
>>
>> EL0 =3D 1: EL0 can be executed in AArch64 state only.
>> EL1 =3D 1: EL1 can be executed in AArch64 state only.
>>
>> so cpu_isar_feature(aa64_aa32, cpu)=3Dfalse
>> then no_aa32=3Dtrue
>>
>> The commit description is "on a host that doesn't support aarch32
>> mode at all, neither arm_div nor jazelle will be supported either."
>>
>> Shouldn't we use a slighly different logic? Such:
>>
>> -    assert(no_aa32 || cpu_isar_feature(arm_div, cpu));
>> +    assert(no_aa32 && !cpu_isar_feature(arm_div, cpu));
>>
>
> I'm unsure. The current formula seems to match the commit description.
> Implication -- that is, "A implies B", (A-->B) -- is equivalent to (!A
> || B).
>
> We have "no_aa32 || arm_div", which corresponds to "aa32 implies
> arm_div" (aa32-->arm_div). And that seems to match exactly what Peter
> said.
>
> The assert you suggest would fire on a host that supports at least one
> of aa32 and arm_div (=3D the assertion would fail if (aa32 || arm_div))=
.
> That would break on my host (hw+kernel) just the same, in the end. To
> substitute the boolean values:
>
> -    assert(false || false)
> +    assert(false && true)

Hmmm wait a second. The ARMv8 ARM says, about ID_ISAR0_EL1:

> Divide, bits [27:24]
>
>     Indicates the implemented Divide instructions. Permitted values
>     are:
>     0000 None implemented.
>     0001 Adds SDIV and UDIV in the T32 instruction set.
>     0010 As for 0b0001, and adds SDIV and UDIV in the A32 instruction
>          set.
>     All other values are reserved.

So this means that (aa32 && !arm_div) *does* conform to the architecture
manual! And then, I understand where the bug is.

As I wrote above, the current C expression stands for:

  aa32 --> arm_div

which -- we see from the ARMv8 ARM -- is wrong.

Upon re-reading the commit message more carefully:

    on a host that doesn't support aarch32 mode at all, neither arm_div
    nor jazelle will be supported either

it's clear that the intent was *not* the implication encoded in the
source. Instead, the intent was the *reverse* implication, namely:

  !aa32 --> !arm_div    [1]

Or, equivalently (because, (A --> B) =3D=3D=3D (!A --> !B)):

  arm_div --> aa32      [2]

Now, if you encode any one of these (equivalent) formulae in C, with the
logical OR operator, you get:

- Starting from [1]:

  (A     --> B)        =3D=3D=3D (!A   || B)
  (!aa32 --> !arm_div) =3D=3D=3D (aa32 || !arm_div) =3D=3D=3D (!no_aa32 |=
| !arm_div)

- Starting from [2]:

  (A       --> B)    =3D=3D=3D (!A       || B)
  (arm_div --> aa32) =3D=3D=3D (!arm_div || aa32) =3D=3D=3D (!arm_div || =
!no_aa32)

You can see that, regardless of whether we start with [1], or
equivalently, [2], we end up with the exact same predicate, logically
speaking. The final expressions only differ in C with regard to the
order of evaluation / shortcut behavior. We can pick whichever we prefer
(for whatever other reason).

FWIW, the language of the original commit message corresponds to [1].
So, if we want to stick with that, then the patch we need is:

> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index e75a64a25a4b..ea84a3e11abb 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1382,8 +1382,13 @@ static void arm_cpu_realizefn(DeviceState *dev, =
Error **errp)
>           * include the various other features that V7VE implies.
>           * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
>           * Security Extensions is ARM_FEATURE_EL3.
> +         *
> +         * Lack of aa32 support excludes arm_div support:
> +         *   no_aa32 --> !arm_div
> +         * Using the logical OR operator, the same is expressed as:
> +         *   !no_aa32 || !arm_div
>           */
> -        assert(no_aa32 || cpu_isar_feature(arm_div, cpu));
> +        assert(!no_aa32 || !cpu_isar_feature(arm_div, cpu));
>          set_feature(env, ARM_FEATURE_LPAE);
>          set_feature(env, ARM_FEATURE_V7);
>      }

If you guys agree, I can formally submit this patch.

Thanks
Laszlo

