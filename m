Received: from eggs.gnu.org ([2001:4830:134:3::10]:35971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0WXA-00073q-B8
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0WX8-0002pX-Dt
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:07:52 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:39935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f0WX8-0002p4-5X
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:07:50 -0400
Received: by mail-oi0-x22b.google.com with SMTP id q71-v6so16868601oic.6
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 11:07:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_4MnAhSyRc2nhaWtrDvLEGP_eEDXu+tzdmOHY_Sp2oqQ@mail.gmail.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_4MnAhSyRc2nhaWtrDvLEGP_eEDXu+tzdmOHY_Sp2oqQ@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 26 Mar 2018 11:07:48 -0700
Message-ID: <CAHNT7Nt3XZi1aXBe79SrPjOW_4DEBbRweyTRZzhmHRgH5rqJPA@mail.gmail.com>
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
To: RISC-V Patches <patches@groups.riscv.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Sun, Mar 25, 2018 at 8:03 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 24 March 2018 at 18:13, Michael Clark <mjc@sifive.com> wrote:
> > This is a series of bug fixes and code cleanups that we would
> > like to get in before the QEMU 2.12 release. We are respinning
> > v6 of this series to include two new bug fixes. These changes
> > are present in the downstream riscv.org riscv-all branch:
> >
> > - https://github.com/riscv/riscv-qemu/commits/riscv-all
> >
> > This series also addresses post-merge feedback such as updating
> > the cpu initialization model to conform with other architectures
> > as requested by Igor Mammedov.
>
> Hi. It looks to me like a fair number of these patches
> are already reviewed, so we don't need to wait on the
> rest being reviewed to get those into master.
>
> My suggestion is that you send a pullrequest now for the
> reviewed patches, and send a patchset for review for the
> new ones or the ones that still need review. (If there
> are patches that are reviewed but depend on earlier ones
> that need to go in set 2 then they go in set 2 as well.)
>

Unfortunately the reviewed patches are mostly just minor cleanups. It's
almost not worth making a PR for them as *none* of the reviewed patches are
actually bug fixes. They are things like removing unused definitions or
replacing hardcoded constants with enums, removing unnesscary braces, etc,
etc

$ grep Reviewed outgoing/v6-00*
outgoing/v6-0001-RISC-V-Make-virt-create_fdt-interface-consistent.patch:Rev=
iewed-by:
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
outgoing/v6-0002-RISC-V-Replace-hardcoded-constants-with-enum-valu.patch:Re=
viewed-by:
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
outgoing/v6-0003-RISC-V-Make-virt-board-description-match-spike.patch:Revie=
wed-by:
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
outgoing/v6-0004-RISC-V-Use-ROM-base-address-and-size-from-memmap.patch:Rev=
iewed-by:
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
outgoing/v6-0005-RISC-V-Remove-identity_translate-from-load_elf.patch:Revie=
wed-by:
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
outgoing/v6-0007-RISC-V-Remove-unused-class-definitions.patch:Reviewed-by:
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
outgoing/v6-0009-RISC-V-Include-intruction-hex-in-disassembly.patch:Reviewe=
d-by:
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
outgoing/v6-0012-RISC-V-Make-some-header-guards-more-specific.patch:Reviewe=
d-by:
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
outgoing/v6-0013-RISC-V-Make-virt-header-comment-title-consistent.patch:Rev=
iewed-by:
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
outgoing/v6-0015-RISC-V-Remove-EM_RISCV-ELF_MACHINE-indirection.patch:Revie=
wed-by:
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
outgoing/v6-0017-RISC-V-Remove-braces-from-satp-case-statement.patch:Review=
ed-by:
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
outgoing/v6-0022-RISC-V-Convert-cpu-definition-towards-future-mode.patch:Re=
viewed-by:
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
outgoing/v6-0022-RISC-V-Convert-cpu-definition-towards-future-mode.patch:Re=
viewed-by:
Igor Mammedov <imammedo@redhat.com>

The unreviewed patches, as I've mentioned many times are the ones that
require reading the RISC-V Privileged ISA Specification or are actual bug
fixes and hence are harder to review. They are in the maintainer's tree and
are what folk who are interested in using RISC-V in QEMU are actually
running.

I can drop the fix to make ROM read-only it is not critical, however it is
a bug fix. I went through with a critical eye and reviewed them myself and
picked up a few minor issues, but I believe the patchset as a whole should
be fine as long as I can find someone to Ack them. Otherwise we're sort of
in a Catch-22 situation.

26 patches is a lot to still be carrying around much
> beyond rc1, so I would like to see the size of this set
> reducing rather than increasing. As the release process
> moves forward the bar for "can this still go in" gradually
> goes up -- by about rc3 it is at about "is this a
> really critical bug or regression from the previous
> release".
>
> (Also something seems to have unhelpfully decided to eat
> or delay about half of your emails in this patchset :-(
> Patchew only sees 14 of the 26. Our mailing list server
> does seem to do that occasionally so that would be my
> first guess at the culprit, but it's possible it's
> something at your end.)
>

Phil asked that I send out only the patches that don't have review, so
that's what I did.
