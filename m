Received: from eggs.gnu.org ([2001:4830:134:3::10]:60518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1flWX2-00030Z-Ep
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1flWX1-000458-La
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:38:00 -0400
Date: Fri, 3 Aug 2018 11:37:48 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180803093748.2s563javprolaqsi@kamzik.brq.redhat.com>
References: <CAKv+Gu-ffZRNmACH6YieNsg=AHxJxYoXHsBGf6C=nOvFfTu7Sg@mail.gmail.com>
	<20180726111109.w24jk6ehklimige7@kamzik.brq.redhat.com>
	<CAKv+Gu80KfwZft4t1HtOXPuijuPLV80K9iW+BsTgs7WcnosMXA@mail.gmail.com>
	<20180726114158.am7kgc3jekxg55i5@kamzik.brq.redhat.com>
	<CAFEAcA8YH4p__zT1o0s3vNZOsyWZn3XPLgkNeT+jSJpmjvFTUw@mail.gmail.com>
	<20180726123509.qyadwbz4skwashcj@kamzik.brq.redhat.com>
	<CAFEAcA-Zv5xV2VwMCfGXUv8oT+gC_dgn8Q3M1v3FBjry7TbXVA@mail.gmail.com>
	<CAHmQWvB1zgaLi++BhGEs1Emb0-5HOrzCcPrHJDoxx-8Be9df1g@mail.gmail.com>
	<CAFEAcA_mVGSicjN=wwJY8OCJ-j=DtdLjDvM9U-dC3dQ=RQQXMQ@mail.gmail.com>
	<CAKv+Gu8sCjfL=uKy4nM6pcRneUzw2YG79CuOVBH3TeNOXf689A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8sCjfL=uKy4nM6pcRneUzw2YG79CuOVBH3TeNOXf689A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Hongbo Zhang <hongbo.zhang@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, lersek@redhat.com

On Fri, Aug 03, 2018 at 11:26:41AM +0200, Ard Biesheuvel wrote:
> On 3 August 2018 at 11:23, Peter Maydell <peter.maydell@linaro.org> wrote:
> > On 3 August 2018 at 10:21, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> >> The 'sbsa' machine won't consume QEMU generated ACPI, so it won't
> >> touch or add new ACPI tables.
> >>
> >> UEFI relies on its ACPI to load OS, but currently it still needs DT
> >> from QEMU to pass some info, one example is CPU number.
> >>
> >> So, the 'sbsa' code implementation should be like this:
> >> A separate file, no ACPI codes, a little necessary DT codes.
> >>
> >> "Necessary DT codes" doesn't include so many peripheral devices nodes,
> >> so the code overlap with virt won't be so much (contrary to sbsa.c
> >> with all the DT codes), then no need to separate the common part to a
> >> third file, and virt.c can be untouched or only a minor change with
> >> few lines.
> >
> > Would the real hardware you are trying to be an example
> > for use DT for this? It seems a bit unlikely to me.
> >
> 
> Yes, as a matter of fact. There is work underway both on the EDK2 and
> the ARM-TF side to rely less on static descriptions, and more on DT to
> instantiate drivers and ACPI tables at runtime rather than at build
> time.

Hi Ard,

(A bit off-topic, but related to your comment above.)

I started poking at teaching ArmVirtQemu how to get the base of RAM
from the DTB, where the DTB is passed to it through x1 (QEMU needed a
few new lines to ensure x1 had it in the firmware=y,-kernel=no case
too). I have the assembler written, but I got hung up on the integration
with edk2, because I don't understand the build files well enough yet to
swap in ArmVirtPkg/PrePi/AArch64/ModuleEntryPoint.S for the ArmVirtQemu
platform. I would also need to clean up the assembler a bit before
posting. I'll be out-of-office for all next week, but if you send me
some edk2 pointers in the meantime, then I should be able to post an
RFC the following week.

Thanks,
drew
