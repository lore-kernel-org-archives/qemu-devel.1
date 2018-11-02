Received: from eggs.gnu.org ([2001:4830:134:3::10]:36919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@posteo.de>) id 1gINOY-0000QR-3n
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@posteo.de>) id 1gINOU-0006S4-35
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:33:02 -0400
Received: from mout01.posteo.de ([185.67.36.65]:37113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <th.huth@posteo.de>) id 1gINOT-0006NS-Mm
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:32:58 -0400
Received: from submission (posteo.de [89.146.220.130])
	by mout01.posteo.de (Postfix) with ESMTPS id 2C62A209B5
	for <qemu-devel@nongnu.org>; Fri,  2 Nov 2018 01:32:53 +0100 (CET)
References: <20181029134000.11157-1-mark.cave-ayland@ilande.co.uk>
	<97900b04-28f0-975f-b3c0-2c0aa7039a4f@linaro.org>
	<5c41b46c-70e3-33a0-76cf-ba2fd8155d33@ilande.co.uk>
	<393eca98-a092-80aa-2016-f14cd2e02d45@vivier.eu>
	<3b1f8942-d8c7-04db-45bc-a7c30de9d769@ilande.co.uk>
	<ad444bbf-0606-2b80-7f7d-389a6df29cfe@vivier.eu>
From: Thomas Huth <th.huth@posteo.de>
Message-ID: <49e0547c-0112-c610-6755-5d6a82b1e105@posteo.de>
Date: Fri, 2 Nov 2018 00:32:52 +0000
MIME-Version: 1.0
In-Reply-To: <ad444bbf-0606-2b80-7f7d-389a6df29cfe@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/11] hw/m68k: add Apple Machintosh
 Quadra 800 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, hpoussin@reactos.org, aurelien@aurel32.net

On 2018-10-30 13:39, Laurent Vivier wrote:
> Le 30/10/2018 =C3=A0 14:12, Mark Cave-Ayland a =C3=A9crit=C2=A0:
>> On 30/10/2018 12:49, Laurent Vivier wrote:
>>
>>> Le 30/10/2018 =C3=A0 12:48, Mark Cave-Ayland a =C3=A9crit=C2=A0:
>>>> On 30/10/2018 08:15, Richard Henderson wrote:
>>>>
>>>>> On 10/29/18 1:39 PM, Mark Cave-Ayland wrote:
>>>>>> You can install your own disk using debian-installer, with:
>>>>>>
>>>>>>     ...
>>>>>>     -M q800 \
>>>>>>     -serial none -serial mon:stdio \
>>>>>>     -m 1000M -drive file=3Dm68k.qcow2,format=3Dqcow2 \
>>>>>>     -net nic,model=3Ddp83932,addr=3D09:00:07:12:34:57 \
>>>>>>     -append "console=3DttyS0 vga=3Doff" \
>>>>>>     -kernel vmlinux-4.15.0-2-m68k \
>>>>>>     -initrd initrd.gz \
>>>>>>     -drive file=3Ddebian-9.0-m68k-NETINST-1.iso \
>>>>>>     -drive file=3Dm68k.qcow2,format=3Dqcow2 \
>>>>>>     -nographic
>>>>>
>>>>> I tried this and got
>>>>>
>>>>> Trace 0: 0x7f2e886c7140 [00000000/0000d404/0xe000]
>>>>> INT      1: Unassigned(0xf4) pc=3D0000d404 sp=3D00393e60 sr=3D2700
>>>>> INT      2: Access Fault(0x8) pc=3D00000000 sp=3D00393e58 sr=3D2700
>>>>>             ssw:  00000506 ea:   00000000 sfc:  5    dfc: 5
>>>>>
>>>>> which lead straight to buserr and panic.  This happens way early in=
 boot --
>>>>> only 1926 TranslationBlocks generated.
>>>>>
>>>>> Is there some device missing from the command-line that the kernel =
is expecting?
>>>>
>>>> Heh that's annoying. The original branch I forked that Laurent was w=
orking on had
>>>> some extra patches at the start of the series: some were required fo=
r q800 whilst
>>>> others were for new development. I thought that all of the patches r=
equired for q800
>>>> had been applied over the past few months, but sadly that isn't the =
case :(
>>>>
>>>> I've pushed an updated branch to https://github.com/mcayland/qemu/tr=
ee/q800-test
>>>> which contains the patchset plus two extra patches that are still ne=
eded to boot to
>>>> the debian installer here:
>>>>
>>>> 9281a5371f "tmp"
>>>> 629754d847 "target/m68k: manage FPU exceptions"
>>>>
>>>> Laurent, are these patches ready for upstream or do they need work i=
n which case we
>>>> should leave q800 until the 3.2 cycle?
>>>
>>> The only needed part is from 9281a5371f.
>>
>> Yeah I think you're right, sorry about that. I'm sure I tried without =
629754d847 and
>> I got a premature exit from QEMU but only in graphic mode, but I've ju=
st tried again
>> and can't seem to recreate it now.
[...]
>>> Because kernel only manages illegal instruction exception not unsuppo=
rted.
>>>
>>> Without the patch, we have:
>>>
>>> IN:
>>> 0x0000d454:  071400
>>>
>>> INT      1: Unassigned(0xf4) pc=3D0000d454 sp=3D00331e60 sr=3D2700
>>>
>>> with the patch:
>>>
>>> IN:
>>> 0x0000d454:  071400
>>>
>>> INT      1: Illegal Instruction(0x10) pc=3D0000d454 sp=3D00331e60 sr=3D=
2700
>>>
>>> We have in linux/arch/m68k/kernel/vectors.c:
>>>
>>> /*
>>>  * this must be called very early as the kernel might
>>>  * use some instruction that are emulated on the 060
>>>  * and so we're prepared for early probe attempts (e.g. nf_init).
>>>  */
>>> void __init base_trap_init(void)
>>> {
>>> ...
>>>
>>>         vectors[VEC_BUSERR] =3D buserr;
>>>         vectors[VEC_ILLEGAL] =3D trap;
>>>         vectors[VEC_SYS] =3D system_call;
>>> }
>>>
>>> So I think the unsupported vector jumps to an invalid address.
>>>
>>> This seems triggered by the aranym native feature:
>>>
>>>     d454:       7300            mvsb %d0,%d1
>>>
>>> from linux/arch/m68k/emu/natfeat.c
>>
>> Interesting. So is this an actual bug in QEMU in terms of implementing=
 the processor
>> specification, or is it relying on undefined behaviour on real hardwar=
e?
>=20
> It's a bug in QEMU.
>=20
> EXCP_UNSUPPORTED is defined to a QEMU specific value (61) that is in th=
e
> Unassigned/Reserved range of the vector table.
>=20
> It is used by QEMU user-mode to trigger illegal instruction, whereas
> illegal is also used to do simcalls (some thing like a syscall with an
> illegal instruction trap). I think this should be deprecated as no one
> is maintaining that and knows how to use that.
>=20
> Perhaps Thomas as an idea as it comes with the coldfire implementation?
> (e6e5906b6e ColdFire target)

No clue, I've never used those simcalls before.

Maybe we could "fix" it simply by changing the #define in cpu.h like this=
:

#if defined(CONFIG_USER_ONLY)
#define EXCP_UNSUPPORTED    61
#else
#define EXCP_UNSUPPORTED    EXCP_ILLEGAL
#endif

?

If that does not work, I'm also fine if we simply deprecate the simcalls
(if possible).

 Thomas
