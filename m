Received: from eggs.gnu.org ([2001:4830:134:3::10]:54036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eddlt-0001RK-Ql
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eddlq-0001U8-Lz
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:12:29 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:44818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eddlq-0001SM-GN
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:12:26 -0500
Received: by mail-wm0-x22a.google.com with SMTP id t74so17065084wme.3
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 07:12:26 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<CAFEAcA-JRFQmgfQ12VRgvUEa2bsFwZvTpeJ6SiAntX0VAehtOQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-JRFQmgfQ12VRgvUEa2bsFwZvTpeJ6SiAntX0VAehtOQ@mail.gmail.com>
Date: Mon, 22 Jan 2018 15:12:23 +0000
Message-ID: <87lggqj5bc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/16] target/arm: Prepatory work for SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 19 January 2018 at 04:54, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> I believe that this addresses all of the comments Peter had with
>> respect to v1.  I did go ahead and add the system registers, so that
>> I could figure out how they're supposed to work.
>>
>> This has been rebased to master so that it has no dependencies.
>>
>>
>> r~
>>
>>
>> Richard Henderson (16):
>> 1  target/arm: Mark disas_set_insn_syndrome inline
>> 2  target/arm: Use pointers in crypto helpers
>> 3  target/arm: Use pointers in neon zip/uzp helpers
>> 4  target/arm: Use pointers in neon tbl helper
>> 5  target/arm: Change the type of vfp.regs
>> 6  target/arm: Add aa{32,64}_vfp_{dreg,qreg} helpers
>> 7  vmstate: Add VMSTATE_UINT64_SUB_ARRAY
>> 8  target/arm: Expand vector registers for SVE
>> 9  target/arm: Add predicate registers for SVE
>> 10 target/arm: Add ARM_FEATURE_SVE
>> 11 target/arm: Add SVE to migration state
>> 12 target/arm: Add ZCR_ELx
>> 13 target/arm: Move cpu_get_tb_cpu_state out of line
>> 14 target/arm: Hoist store to flags output in cpu_get_tb_cpu_state
>> 15 target/arm: Simplify fp_exception_el for user-only
>> 16 target/arm: Add SVE state to TB->FLAGS
>
> In the interests of reducing the size of this patch set, I'm going to
> take patches 1..7, 10, 13..15 into target-arm.next. (Alex, I know
> you had a nit about changing the type of a variable in patch 4 but
> I think I'd rather just take the patchset rather than do another
> round with it for that.)

Sure - it was only a nit ;-)

>
> The target-arm.next branch (which rebases!) with those patches is at:
>
> https://git.linaro.org/people/peter.maydell/qemu-arm.git target-arm.next
>
> I expect I'll make a pullreq either tomorrow or more likely Thursday.
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
