Received: from eggs.gnu.org ([208.118.235.92]:34419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0brp-00016S-4k
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 19:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0bo0-0007nE-IN
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 19:49:33 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:35256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f0bnz-0007lg-Pi
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 19:45:36 -0400
Received: by mail-oi0-x235.google.com with SMTP id x20-v6so17394158oie.2
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 16:45:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NsWALp1eehZ7YNX3eGFemh94YCNKBwxjqUOjEAheBV5iA@mail.gmail.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_4MnAhSyRc2nhaWtrDvLEGP_eEDXu+tzdmOHY_Sp2oqQ@mail.gmail.com>
	<CAHNT7Nt3XZi1aXBe79SrPjOW_4DEBbRweyTRZzhmHRgH5rqJPA@mail.gmail.com>
	<CAHNT7NsWALp1eehZ7YNX3eGFemh94YCNKBwxjqUOjEAheBV5iA@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 26 Mar 2018 16:45:34 -0700
Message-ID: <CAHNT7NuzZY8MgAtDjokbN8MMtHV=oFnrSnXj2xAzDF_uXd=4jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [patches] Re: [PATCH v6 00/26] RISC-V: Fixes and
 cleanups for QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

On Mon, Mar 26, 2018 at 4:14 PM, Michael Clark <mjc@sifive.com> wrote:

>
>
> On Mon, Mar 26, 2018 at 11:07 AM, Michael Clark <mjc@sifive.com> wrote:
>
>>
>>
>> On Sun, Mar 25, 2018 at 8:03 AM, Peter Maydell <peter.maydell@linaro.org=
>
>> wrote:
>>
>>> On 24 March 2018 at 18:13, Michael Clark <mjc@sifive.com> wrote:
>>> > This is a series of bug fixes and code cleanups that we would
>>> > like to get in before the QEMU 2.12 release. We are respinning
>>> > v6 of this series to include two new bug fixes. These changes
>>> > are present in the downstream riscv.org riscv-all branch:
>>> >
>>> > - https://github.com/riscv/riscv-qemu/commits/riscv-all
>>> >
>>> > This series also addresses post-merge feedback such as updating
>>> > the cpu initialization model to conform with other architectures
>>> > as requested by Igor Mammedov.
>>>
>>> Hi. It looks to me like a fair number of these patches
>>> are already reviewed, so we don't need to wait on the
>>> rest being reviewed to get those into master.
>>>
>>> My suggestion is that you send a pullrequest now for the
>>> reviewed patches, and send a patchset for review for the
>>> new ones or the ones that still need review. (If there
>>> are patches that are reviewed but depend on earlier ones
>>> that need to go in set 2 then they go in set 2 as well.)
>>>
>>
>> Unfortunately the reviewed patches are mostly just minor cleanups. It's
>> almost not worth making a PR for them as *none* of the reviewed patches =
are
>> actually bug fixes. They are things like removing unused definitions or
>> replacing hardcoded constants with enums, removing unnesscary braces, et=
c,
>> etc
>>
>
> Apologies. There is one bug fix in the subset of reviewed patches. the
> -cpu model changes.
>
>
>> $ grep Reviewed outgoing/v6-00*
>> outgoing/v6-0001-RISC-V-Make-virt-create_fdt-interface-consistent.patch:=
Reviewed-by:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> outgoing/v6-0002-RISC-V-Replace-hardcoded-constants-with-enum-valu.patch=
:Reviewed-by:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> outgoing/v6-0003-RISC-V-Make-virt-board-description-match-spike.patch:Re=
viewed-by:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> outgoing/v6-0004-RISC-V-Use-ROM-base-address-and-size-from-memmap.patch:=
Reviewed-by:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> outgoing/v6-0005-RISC-V-Remove-identity_translate-from-load_elf.patch:Re=
viewed-by:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> outgoing/v6-0007-RISC-V-Remove-unused-class-definitions.patch:Reviewed-b=
y:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> outgoing/v6-0009-RISC-V-Include-intruction-hex-in-disassembly.patch:Revi=
ewed-by:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> outgoing/v6-0012-RISC-V-Make-some-header-guards-more-specific.patch:Revi=
ewed-by:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> outgoing/v6-0013-RISC-V-Make-virt-header-comment-title-consistent.patch:=
Reviewed-by:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> outgoing/v6-0015-RISC-V-Remove-EM_RISCV-ELF_MACHINE-indirection.patch:Re=
viewed-by:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> outgoing/v6-0017-RISC-V-Remove-braces-from-satp-case-statement.patch:Rev=
iewed-by:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> outgoing/v6-0022-RISC-V-Convert-cpu-definition-towards-future-mode.patch=
:Reviewed-by:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> outgoing/v6-0022-RISC-V-Convert-cpu-definition-towards-future-mode.patch=
:Reviewed-by:
>> Igor Mammedov <imammedo@redhat.com>
>>
>> The unreviewed patches, as I've mentioned many times are the ones that
>> require reading the RISC-V Privileged ISA Specification or are actual bu=
g
>> fixes and hence are harder to review. They are in the maintainer's tree =
and
>> are what folk who are interested in using RISC-V in QEMU are actually
>> running.
>>
>> I can drop the fix to make ROM read-only it is not critical, however it
>> is a bug fix. I went through with a critical eye and reviewed them mysel=
f
>> and picked up a few minor issues, but I believe the patchset as a whole
>> should be fine as long as I can find someone to Ack them. Otherwise we'r=
e
>> sort of in a Catch-22 situation.
>>
>
> Most of the spec compliance bug fixes are innocuous when it comes to
> running Linux, nevertheless, they are bugs and will be exposed by future
> verification and compliance tests. The only really critical bug fix is
> 26/26 mstatus.FS. Igor's fix for the cpu model 22/26 is important as it
> addresses remaining review feedback with the initial port submission. 25/=
26
> is a user-visible bugfix for the disassembler which is important for anyo=
ne
> using -d in_asm. I'm pretty comfortable with the amount of testing this
> series has had despite the lack of review. Testing is also important.
>
> The FDT ROM truncation issue fixed by 8/26 isn't seen in practice but it
> was seen during development as i've been working on patches to separate t=
he
> bbl bootloader from the linux kernel (currently the kernel is embedded as=
 a
> payload in embedded in the monitor firmware). I would like to change the
> ports to use -bios to load firmware and -kernel can then point to a regul=
ar
> linux kernel and we can indicate to the firmware where the kernel is load=
ed
> using a device-tree chosen entry (as some other ports do). That work is n=
ot
> included in this series.
>
> C=3Dcleanup, B=3Dbugfix, I=3Dimportant bugfix, S=3Dspec compliance bugfix=
, X=3Dcritical
> bugfix, R=3Dreviewed
>
> C R [PATCH v6 01/26] RISC-V: Make virt create_fdt interface consistent
> C R [PATCH v6 02/26] RISC-V: Replace hardcoded constants with enum values
> C R [PATCH v6 03/26] RISC-V: Make virt board description match spike
> C R [PATCH v6 04/26] RISC-V: Use ROM base address and size from memmap
> C R [PATCH v6 05/26] RISC-V: Remove identity_translate from load_elf
> B - [PATCH v6 06/26] RISC-V: Mark ROM read-only after copying in code
> C R [PATCH v6 07/26] RISC-V: Remove unused class definitions
> B - [PATCH v6 08/26] RISC-V: Make sure rom has space for fdt
> C R [PATCH v6 09/26] RISC-V: Include instruction hex in disassembly
> S - [PATCH v6 10/26] RISC-V: Improve page table walker spec compliance
> S - [PATCH v6 11/26] RISC-V: Update E order and I extension order
> C R [PATCH v6 12/26] RISC-V: Make some header guards more specific
> C R [PATCH v6 13/26] RISC-V: Make virt header comment title consistent
> B - [PATCH v6 14/26] RISC-V: Use memory_region_is_ram in pte update
> C R [PATCH v6 15/26] RISC-V: Remove EM_RISCV ELF_MACHINE indirection
> S - [PATCH v6 16/26] RISC-V: Hardwire satp to 0 for no-mmu case
> C R [PATCH v6 17/26] RISC-V: Remove braces from satp case statement
> B - [PATCH v6 18/26] RISC-V: riscv-qemu port supports sv39 and sv48
> S - [PATCH v6 19/26] RISC-V: vectored traps are optional
> S - [PATCH v6 20/26] RISC-V: No traps on writes to misa,minstret,mcycle
> C - [PATCH v6 21/26] RISC-V: Remove support for adhoc X_COP interrupt
> I R [PATCH v6 22/26] RISC-V: Convert cpu definition towards future model
> B - [PATCH v6 23/26] RISC-V: Clear mtval/stval on exceptions without info
> C - [PATCH v6 24/26] RISC-V: Remove erroneous comment from translate.c
> I - [PATCH v6 25/26] RISC-V: Fix incorrect disassembly for addiw
> X - [PATCH v6 26/26] RISC-V: Workaround for critical mstatus.FS MTTCG bug
>
>
>
>> 26 patches is a lot to still be carrying around much
>>> beyond rc1, so I would like to see the size of this set
>>> reducing rather than increasing. As the release process
>>> moves forward the bar for "can this still go in" gradually
>>> goes up -- by about rc3 it is at about "is this a
>>> really critical bug or regression from the previous
>>> release".
>>>
>>
I've made a tag for the series including the fixes from my own review
during the weekend (one logic fix and 2 comment of commit log typos, and a
patch hunk in the wrong commit):

- https://github.com/riscv/riscv-qemu/releases/tag/riscv-qemu-2.12-fixes-v7

That said, if you want important or critical fixes only, then i'd suggest
these at least these 3:

I R [PATCH v6 22/26] RISC-V: Convert cpu definition towards future model
I - [PATCH v6 25/26] RISC-V: Fix incorrect disassembly for addiw
X - [PATCH v6 26/26] RISC-V: Workaround for critical mstatus.FS MTTCG bug

The other patches are the 23 patches which were accidentially included in
the initial pull on March 8, now with Signed-off-by, less the one that
Paolo asked me to drop.

Most of the bugs are relatively innocuous except for the mstatus.FS fix.
Linux boots on upstream QEMU but has FPU register file corruption when SMP
is enabled.

I need advice as to which fixes you want to have included in QEMU 2.12. I'm
not sure if the reviewed set is the right set as it excludes 25/26 and more
importantly 26/26.

(Also something seems to have unhelpfully decided to eat
>>> or delay about half of your emails in this patchset :-(
>>> Patchew only sees 14 of the 26. Our mailing list server
>>> does seem to do that occasionally so that would be my
>>> first guess at the culprit, but it's possible it's
>>> something at your end.)
>>>
>>
>> Phil asked that I send out only the patches that don't have review, so
>> that's what I did.
>>
>
>
