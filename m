Received: from eggs.gnu.org ([2001:4830:134:3::10]:33407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@sifive.com>) id 1f9Jfg-00057B-Bb
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 20:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@sifive.com>) id 1f9Jfd-0001rd-07
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 20:13:00 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrew@sifive.com>) id 1f9Jfc-0001qi-K1
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 20:12:56 -0400
Received: by mail-wr0-x230.google.com with SMTP id d19-v6so18401063wre.1
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 17:12:56 -0700 (PDT)
Received: from mail-wr0-f173.google.com (mail-wr0-f173.google.com.
	[209.85.128.173]) by smtp.gmail.com with ESMTPSA id
	a16sm2983829edd.28.2018.04.19.17.12.54 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 19 Apr 2018 17:12:54 -0700 (PDT)
Received: by mail-wr0-f173.google.com with SMTP id f14-v6so18382119wre.4
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 17:12:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NtBzUUv4dGjLwxnMi9cOwoS5+7KVnKbrUynXkgX2C477Q@mail.gmail.com>
References: <CA+ZOyaj_4my=u4-MkAbyoee5ORnRq6nyaU+HhX1K6t2+Cn5RHg@mail.gmail.com>
	<3EFD5845-5CE7-45F5-AE4C-0C86CAFAA200@sifive.com>
	<CA+ZOyajL25Gfz_NdcG+MxDAZb9qstjNo2sD_ExzX0fATaDg7HQ@mail.gmail.com>
	<CAHNT7NtJd1ZtYqdVfuiqxe60rOjyc48qyGKrQ99xY0UVH4arHQ@mail.gmail.com>
	<CAHNT7NtBzUUv4dGjLwxnMi9cOwoS5+7KVnKbrUynXkgX2C477Q@mail.gmail.com>
From: Andrew Waterman <andrew@sifive.com>
Date: Thu, 19 Apr 2018 17:12:33 -0700
Message-ID: <CA++6G0CNH5mzZFnsE-d6wS5jGr1YmVRc6VUhhBQYeMXKSQrqjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [sw-dev] The problem of write misa on QEMU and BBL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Zong Li <zongbox@gmail.com>, Zong Li <zong@andestech.com>, Palmer Dabbelt <palmer@sifive.com>, RISC-V SW Dev <sw-dev@groups.riscv.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On Thu, Apr 19, 2018 at 5:11 PM, Michael Clark <mjc@sifive.com> wrote:

>
>
> On Fri, Apr 20, 2018 at 12:05 PM, Michael Clark <mjc@sifive.com> wrote:
>
>>
>>
>> On Thu, Apr 19, 2018 at 9:28 PM, Zong Li <zongbox@gmail.com> wrote:
>>
>>> 2018-04-19 12:43 GMT+08:00 Michael Clark <mjc@sifive.com>:
>>> > Hi Zong,
>>> >
>>> >> On 19/04/2018, at 2:40 PM, Zong Li <zongbox@gmail.com> wrote:
>>> >>
>>> >> Hi all,
>>> >>
>>> >> For BBL part, in fp_init at machine/minit.c,
>>> >> it will clear the D and F bits of misa register, and assertion that
>>> >> the bits is cleared.
>>> >> But the misa is WARL register, so there is no effect for writing it,
>>> >> and the assertion not be true.
>>> >> So is there has necessary to do that if toolchain not support D and =
F
>>> extension?
>>> >>
>>> >> For QEMU part, when writing misa, it will trigger the illegal
>>> >> instruction exception, but I think that the WARL allow write behavio=
r?
>>> >
>>> > QEMU in the riscv-all branch should have WARL behavior.
>>> >
>>> > - https://github.com/riscv/riscv-qemu/commits/riscv-all
>>> >
>>> > There is a bug in upstream. We have submitted patches to fix the issu=
e
>>> for review on the qemu-devel mailing list. The patch series will be
>>> submitted for upstream review again shortly. We were holding off on the
>>> series as we didn=E2=80=99t classify it as a =E2=80=9Ccritical bug=E2=
=80=9D as QEMU was in
>>> soft-freeze for 2.12 and we weren=E2=80=99t able to get review in time =
to include
>>> this fix in the 2.12 release.
>>> >
>>> > See =E2=80=9CNo traps on writes to misa,minstret,mcycle"
>>> >
>>> > - https://github.com/riscv/riscv-qemu/commits/qemu-2.13-for-upstream
>>> >
>>> > The history is that there were several unimplemented CSRs that had
>>> printf followed by exit. Richard Henderson said we should fix this. I
>>> changed several CSRs to cause illegal instruction traps instead of call=
ing
>>> exit. That was a mistake as CSRs that don=E2=80=99t support write are W=
ARL (Write
>>> Any Read Legal). It was certainly better than having the simulation exi=
t as
>>> a cpu doesn=E2=80=99t typically have a way to =E2=80=9Dexit=E2=80=9D li=
ke a C program, nevertheless
>>> trapping was wrong. My mistake. See here for the history:
>>> >
>>> > - https://github.com/riscv/riscv-qemu/blob/ff36f2f77ec3e6a6211
>>> c63bfe1707ec057b12f7d/target-riscv/op_helper.c
>>> >
>>> > The implementation in the current tree is quite different. We have
>>> recently made the CSR system more modular so that with minor changes,
>>> custom CPUs will be able to hook their own control and status registers=
.
>>> >
>>> > - https://github.com/riscv/riscv-qemu/blob/qemu-2.13-for-upstr
>>> eam/target/riscv/csr.c#L780-L867
>>> >
>>> > See these changes:
>>> >
>>> > - https://github.com/riscv/riscv-qemu/commit/9d9c1bfef911c520a
>>> 35bd3f8c0ed2e14cc96bbb7
>>> > - https://github.com/riscv/riscv-qemu/commit/b5a4cd79ce6c7fbb6
>>> 5fdcf078fb9a8391da1d6b1
>>> >
>>> > We know have a flexible system that will allow implementations to hoo=
k
>>> per-cpu control and status registers, and we have predicates that make =
CSRs
>>> appear on some processor but not on others. i.e. if misa.S is not prese=
nt,
>>> then S-mode s* CSRs will trap. Sometimes WARL is the correct behaviour,=
 but
>>> sometimes trapping is the correct behaviour i.e. if the processor does =
not
>>> implement S-mode.
>>> >
>>> > misa traps on write should only affect bootloaders as Supervisor=E2=
=80=99s
>>> like Linux don=E2=80=99t yet have access to the isa register. It=E2=80=
=99s not a major
>>> issuse.
>>> >
>>> > Michael.
>>>
>>> Hi Michael,
>>>
>>> Thanks for the information. The new CSR system is helpful for custom
>>> CPU such as ours. Thanks.
>>>
>>> In the future, maybe we can do something like this in BBL for flexible
>>> custom platform which has own device to control the timer, ipi and so
>>> on.
>>>
>>> Back to the misa problem in BBL, at fp_init in BBL initial phrase, the
>>> assertion will has problem because the bits of misa will not be
>>> cleared.
>>>
>>> the code piece like below:
>>>     uintptr_t fd_mask =3D (1 << ('F' - 'A')) | (1 << ('D' - 'A'));
>>>     clear_csr(misa, fd_mask);
>>>     assert(!(read_csr(misa) & fd_mask));
>>>
>>> I think that the assertion is not necessary even the clear misa.
>>>
>>
>> I agree. The specification makes no guarantee that misa writes are not
>> ignored so it is legal for a processor that supports FD to drop misa wri=
tes
>> and the assertion will trigger on legal RISC-V implementations. That cod=
e
>> piece does not support legal RISC-V implementations that can't disable F
>> and D. Disabling F and D should not be asserted because it is harmless i=
f
>> an unused extension is present.
>>
>> This assertion will always trigger in QEMU until we support the
>> 'optional' feature to allow changes to 'misa'.
>>
>> Just noting this is not QEMU specifc so we should drop qemu-devel if we
>> continue to discuss misa on RISC-V in bbl.
>>
>> Nevertheless, we do plan to support 'misa' writes however we need to do
>> some work in translate.c to make sure that cached translations match the
>> current state of misa. We may want to perform a tb_flush when we impleme=
nt
>> writable misa. We also want writable misa to be a CPU feature so we can
>> emulate CPUs that don't support writable misa. eg add this to the CPU mo=
del.
>>
>>     set_feature(env, RISCV_FEATURE_MISA_WRITABLE)
>>
>> Thanks for raising this because the new modular CSR implementation only
>> implemented 'existential' predicates for CSRs. We should add a write fla=
g
>> to the predicate. Or we can just return -1 in the write_misa function. e=
.g.
>>
>>     static int write_misa(CPURISCVState *env, int csrno, target_ulong va=
l)
>>     {
>>         if (!riscv_feature(env, RISCV_FEATURE_MISA_WRITABLE)) {
>>             return -1;
>>         }
>>         /* validate misa - must contain 'I' or 'E' */
>>         env->misa =3D val;
>>         tb_flush(CPU(riscv_env_get_cpu(env)));
>>     }
>>
>> tb_flush is pessimistic but conservative. Currently its not common to
>> write misa so it would be acceptable.
>>
>> There is a similar but somewhat more complex issue for disabling misa.C.
>> The behaviour has been discussed on the isa-dev mailing list. Iirc, we h=
ave
>> to ignore bit 1 in mepc/sepc in MRET/SRET if misa.C has been cleared and=
 a
>> 2-byte aligned address is present in mepc/sepc, so that MRET/SRET can on=
ly
>> jump to 4-byte aligned code. So we drop bit 1 on writes to mepc/sepc whi=
le
>> misa.C is clear and we ignore bit 1 on reads from mepc/sepc while misa.C=
 is
>> cleared. So the change needs slightly more work than just making 'misa'
>> writable. We also have to enforce that 'I' or 'E' are set, and we curren=
tly
>> don't have support for RVE emulation in RISC-V QEMU. This will require
>> changes to validate registers in translate.c and cause illegal instructi=
ons
>> if regno >=3D 16 is used.
>>
>> I'm also not sure exactly how we add misa to the translation cache index=
,
>> but tb_flush seems like the conservative way to ensure the translation
>> cache matches the currently set bits in misa.
>>
>> We also have to audit translate.c to make sure that misa is checked for
>> all allowable extensions. MAFDC. Currently it only checks 'C' so we will
>> need to add checks for 'M' in mul/mulw/div/divw/divu/divuw/rem/remw/remu=
/remuw
>> and 'A' for amos, 'F' and 'D' in floating point operations, etc. It's a
>> fair amount of work...
>>
>> $ grep -r has_ext target/riscv/
>> target/riscv//csr.c:    return -!riscv_has_ext(env, RVS);
>> target/riscv//csr.c:        (!riscv_has_ext(env, RVS) && mpp =3D=3D PRV_=
S) ||
>> target/riscv//csr.c:        (!riscv_has_ext(env, RVU) && mpp =3D=3D PRV_=
U)) {
>> target/riscv//cpu.h:static inline int riscv_has_ext(CPURISCVState *env,
>> target_ulong ext)
>> target/riscv//op_helper.c:    if (!riscv_has_ext(env, RVC) && (retpc &
>> 0x3)) {
>> target/riscv//op_helper.c:    if (!riscv_has_ext(env, RVC) && (retpc &
>> 0x3)) {
>> target/riscv//translate.c:    if (!riscv_has_ext(env, RVC)) {
>> target/riscv//translate.c:        if (!riscv_has_ext(env, RVC)) {
>> target/riscv//translate.c:    if (!riscv_has_ext(env, RVC) && ((ctx->pc =
+
>> bimm) & 0x3)) {
>> target/riscv//translate.c:            if (riscv_has_ext(env, RVS)) {
>> target/riscv//translate.c:        if (!riscv_has_ext(env, RVC)) {
>>
>> So it seems like writable misa is a fair amount of work
>>
>> - RISCV_FEATURE_MISA_WRITABLE (easy)
>> - ISA extension validation rules in write_misa (easy)
>> - Extension checks in translate.c (time-consuming but easy)
>> - RVC instruction pointer alignment checking rules (needs some care)
>> - Make sure we have CPU models with and without writable 'misa' so we ca=
n
>> test code to handle typical legal processor variants.
>>
>
> - Check regno >=3D 16 && riscv_has_ext(env, RVE) then illegal instruction
> trap (time-consuming - needs care to not miss any register)
>
> Are F & D legal with E? 16 register FPU? I guess not. We may need to mask
> and drop some extension writes in the validate misa logic (WARL).
>

No, the manual forbids this case.  E should preclude FD.
