Received: from eggs.gnu.org ([209.51.188.92]:56609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqmDT-00021r-Ay
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqmDP-0002NT-QA
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:55:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqmDP-0002LM-FQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:55:43 -0500
Date: Mon, 4 Feb 2019 16:55:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204165316-mutt-send-email-mst@kernel.org>
References: <20190204160325.4914-1-lersek@redhat.com>
	<20190204160325.4914-5-lersek@redhat.com>
	<20190204124613-mutt-send-email-mst@kernel.org>
	<e9e9ed1d-0675-6a6e-1706-b6a23169719c@redhat.com>
	<20190204142534-mutt-send-email-mst@kernel.org>
	<d4e8a405-cfb5-a302-bc7f-34537f2d7fcf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d4e8a405-cfb5-a302-bc7f-34537f2d7fcf@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/5] tests/uefi-test-tools: add build
 scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On Mon, Feb 04, 2019 at 08:46:33PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi Michael,
>=20
> On 2/4/19 8:32 PM,  Michael S. Tsirkin wrote:
> > On Mon, Feb 04, 2019 at 07:41:38PM +0100, Laszlo Ersek wrote:
> >> On 02/04/19 18:47, Michael S. Tsirkin wrote:
> >>> On Mon, Feb 04, 2019 at 05:03:24PM +0100, Laszlo Ersek wrote:
> >>>> Introduce the following build scripts under "tests/uefi-test-tools=
":
> >>>>
> >>>> * "build.sh" builds a single module (a UEFI application) from
> >>>>   UefiTestToolsPkg, for a single QEMU emulation target.
> >>>>
> >>>>   "build.sh" relies on cross-compilers when the emulation target a=
nd the
> >>>>   build host architecture don't match. The cross-compiler prefix i=
s
> >>>>   computed according to a fixed, Linux-specific pattern. No attemp=
t is
> >>>>   made to copy or reimplement the GNU Make magic from "qemu/roms/M=
akefile"
> >>>>   for cross-compiler prefix determination. The reason is that the =
build
> >>>>   host OSes that are officially supported by edk2, and those that =
are
> >>>>   supported by QEMU, intersect only in Linux. (Note that the UNIXG=
CC
> >>>>   toolchain is being removed from edk2,
> >>>>   <https://bugzilla.tianocore.org/show_bug.cgi?id=3D1377>.)
> >>>>
> >>>> * "Makefile" currently builds the "UefiTestToolsPkg/BiosTablesTest=
"
> >>>>   application, for arm, aarch64, i386, and x86_64, with the help o=
f
> >>>>   "build.sh".
> >>>>
> >>>>   "Makefile" turns each resultant UEFI executable into a UEFI-boot=
able,
> >>>>   qcow2-compressed ISO image. The ISO images are output as
> >>>>   "tests/data/uefi-boot-images/bios-tables-test.<TARGET>.iso.qcow2=
".
> >>>>
> >>>>   Each ISO image should be passed to QEMU as follows:
> >>>>
> >>>>     -drive id=3Dboot-cd,if=3Dnone,readonly,format=3Dqcow2,file=3D$=
ISO \
> >>>>     -device virtio-scsi-pci,id=3Dscsi0 \
> >>>>     -device scsi-cd,drive=3Dboot-cd,bus=3Dscsi0.0,bootindex=3D0 \
> >>>>
> >>>>   "Makefile" assumes that "mkdosfs", "mtools", and "genisoimage" a=
re
> >>>>   present.
> >>>>
> >>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >>>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
> >>>> Cc: Igor Mammedov <imammedo@redhat.com>
> >>>> Cc: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >>>> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> >>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> >>>> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >>>> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >>>> ---
> >>>>
> >>>> Notes:
> >>>>     v3:
> >>>>     - explicitly mark the "./build.sh" recipe as recursive, with t=
he "+"
> >>>>       indicator; document it in a comment [Phil]
> >>>>     - pick up R-b, T-b [Phil]
> >>>>
> >>>>     v2:
> >>>>     - add the .NOTPARALLEL target [Phil, help-make, edk2-devel]
> >>>>
> >>>>  tests/uefi-test-tools/Makefile   | 106 ++++++++++++++
> >>>>  tests/uefi-test-tools/.gitignore |   3 +
> >>>>  tests/uefi-test-tools/build.sh   | 145 ++++++++++++++++++++
> >>>>  3 files changed, 254 insertions(+)
> >>>>
> >>>> diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tool=
s/Makefile
> >>>> new file mode 100644
> >>>> index 000000000000..1d78bc14d51a
> >>>> --- /dev/null
> >>>> +++ b/tests/uefi-test-tools/Makefile
> >>>> @@ -0,0 +1,106 @@
> >>>> +# Makefile for the test helper UEFI applications that run in gues=
ts.
> >>>> +#
> >>>> +# Copyright (C) 2019, Red Hat, Inc.
> >>>> +#
> >>>> +# This program and the accompanying materials are licensed and ma=
de available
> >>>> +# under the terms and conditions of the BSD License that accompan=
ies this
> >>>> +# distribution. The full text of the license may be found at
> >>>> +# <http://opensource.org/licenses/bsd-license.php>.
> >>>> +#
> >>>> +# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" =
BASIS, WITHOUT
> >>>> +# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IM=
PLIED.
> >>>> +
> >>>> +edk2_dir              :=3D ../../roms/edk2
> >>>> +images_dir            :=3D ../data/uefi-boot-images
> >>>> +emulation_targets     :=3D arm aarch64 i386 x86_64
> >>>> +uefi_binaries         :=3D bios-tables-test
> >>>> +intermediate_suffixes :=3D .efi .fat .iso.raw
> >>>> +
> >>>> +images: $(foreach binary,$(uefi_binaries), \
> >>>> +		$(foreach target,$(emulation_targets), \
> >>>> +			$(images_dir)/$(binary).$(target).iso.qcow2))
> >>>> +
> >>>> +# Preserve all intermediate targets if the build succeeds.
> >>>> +# - Intermediate targets help with development & debugging.
> >>>> +# - Preserving intermediate targets also keeps spurious changes o=
ut of the
> >>>> +#   final build products, in case the user re-runs "make" without=
 any changes
> >>>> +#   to the UEFI source code. Normally, the intermediate files wou=
ld have been
> >>>> +#   removed by the last "make" invocation, hence the re-run would=
 rebuild them
> >>>> +#   from the unchanged UEFI sources. Unfortunately, the "mkdosfs"=
 and
> >>>> +#   "genisoimage" utilities embed timestamp-based information in =
their outputs,
> >>>> +#   which causes git to report differences for the tracked qcow2 =
ISO images.
> >>>> +.SECONDARY: $(foreach binary,$(uefi_binaries), \
> >>>> +		$(foreach target,$(emulation_targets), \
> >>>> +			$(foreach suffix,$(intermediate_suffixes), \
> >>>> +				Build/$(binary).$(target)$(suffix))))
> >>>> +
> >>>> +# In the pattern rules below, the stem (%, $*) stands for
> >>>> +# "$(binary).$(target)".
> >>>> +
> >>>> +# Convert the raw ISO image to a qcow2 one, enabling compression,=
 and using a
> >>>> +# small cluster size. This allows for small binary files under gi=
t control,
> >>>> +# hence for small binary patches.
> >>>> +$(images_dir)/%.iso.qcow2: Build/%.iso.raw
> >>>> +	mkdir -p -- $(images_dir)
> >>>> +	$${QTEST_QEMU_IMG:-qemu-img} convert -f raw -O qcow2 -c \
> >>>> +		-o cluster_size=3D512 -- $< $@
> >>>> +
> >>>> +# Embed the "UEFI system partition" into an ISO9660 file system a=
s an ElTorito
> >>>> +# boot image.
> >>>> +Build/%.iso.raw: Build/%.fat
> >>>> +	genisoimage -input-charset ASCII -efi-boot $(notdir $<) -no-emul=
-boot \
> >>>> +		-quiet -o $@ -- $<
> >>>> +
> >>>> +# Define chained macros in order to map QEMU system emulation tar=
gets to
> >>>> +# *short* UEFI architecture identifiers. Periods are allowed in, =
and ultimately
> >>>> +# stripped from, the argument.
> >>>> +map_arm_to_uefi     =3D $(subst arm,ARM,$(1))
> >>>> +map_aarch64_to_uefi =3D $(subst aarch64,AA64,$(call map_arm_to_ue=
fi,$(1)))
> >>>> +map_i386_to_uefi    =3D $(subst i386,IA32,$(call map_aarch64_to_u=
efi,$(1)))
> >>>> +map_x86_64_to_uefi  =3D $(subst x86_64,X64,$(call map_i386_to_uef=
i,$(1)))
> >>>> +map_to_uefi         =3D $(subst .,,$(call map_x86_64_to_uefi,$(1)=
))
> >>>> +
> >>>> +# Format a "UEFI system partition", using the UEFI binary as the =
default boot
> >>>> +# loader. Add 10% size for filesystem metadata, round up to the n=
ext KB, and
> >>>> +# make sure the size is large enough for a FAT filesystem. Name t=
he filesystem
> >>>> +# after the UEFI binary. (Excess characters are automatically dro=
pped from the
> >>>> +# filesystem label.)
> >>>> +Build/%.fat: Build/%.efi
> >>>> +	rm -f -- $@
> >>>> +	uefi_bin_b=3D$$(stat --format=3D%s -- $<) && \
> >>>> +		uefi_fat_kb=3D$$(( (uefi_bin_b * 11 / 10 + 1023) / 1024 )) && \
> >>>> +		uefi_fat_kb=3D$$(( uefi_fat_kb >=3D 64 ? uefi_fat_kb : 64 )) &&=
 \
> >>>> +		mkdosfs -C $@ -n $(basename $(@F)) -- $$uefi_fat_kb
> >>>> +	MTOOLS_SKIP_CHECK=3D1 mmd -i $@ ::EFI
> >>>> +	MTOOLS_SKIP_CHECK=3D1 mmd -i $@ ::EFI/BOOT
> >>>> +	MTOOLS_SKIP_CHECK=3D1 mcopy -i $@ -- $< \
> >>>> +		::EFI/BOOT/BOOT$(call map_to_uefi,$(suffix $*)).EFI
> >>>> +
> >>>> +# In the pattern rules below, the stem (%, $*) stands for "$(targ=
et)" only. The
> >>>> +# association between the UEFI binary (such as "bios-tables-test"=
) and the
> >>>> +# component name from the edk2 platform DSC file (such as "BiosTa=
blesTest") is
> >>>> +# explicit in each rule.
> >>>> +
> >>>> +# "build.sh" invokes the "build" utility of edk2 BaseTools. In an=
y given edk2
> >>>> +# workspace, at most one "build" instance may be operating at a t=
ime. Therefore
> >>>> +# we must serialize the rebuilding of targets in this Makefile.
> >>>> +.NOTPARALLEL:
> >>>> +
> >>>> +# In turn, the "build" utility of edk2 BaseTools invokes another =
"make".
> >>>> +# Although the outer "make" process advertizes its job server to =
all child
> >>>> +# processes via MAKEFLAGS in the environment, the outer "make" cl=
oses the job
> >>>> +# server file descriptors (exposed in MAKEFLAGS) before executing=
 a recipe --
> >>>> +# unless the recipe is recognized as a recursive "make" recipe. R=
ecipes that
> >>>> +# call $(MAKE) are classified automatically as recursive; for "bu=
ild.sh" below,
> >>>> +# we must mark the recipe manually as recursive, by using the "+"=
 indicator.
> >>>> +# This way, when the inner "make" starts a parallel build of the =
target edk2
> >>>> +# module, it can communicate with the outer "make"'s job server.
> >>>> +Build/bios-tables-test.%.efi: build-edk2-tools
> >>>> +	+./build.sh $(edk2_dir) BiosTablesTest $* $@
> >>>
> >>> Does this actually work with an out of tree build?
> >>
> >> It's not supposed to.
> >>
> >> Again, it's not something that a normal QEMU build includes. It is o=
nly
> >> for maintainers to rebuild when there is a reason to do so. The outp=
ut
> >> binaries are tracked by git, and will be used as-is (in binary form)=
 by
> >> the ACPI test suite. If there are updates to the UEFI source code, t=
he
> >> binaries will have to be rebuilt by a maintainer (or by me, if I sub=
mit
> >> the UEFI code changes), and the refreshed blobs are to be checked in=
to
> >> git. Think iPXE oproms for an analogy.
> >>
> >>> Shouldn't this be SRC_PATH/tests/uefi-test-tools/ ?
> >>
> >> No; nothing under roms/ is built like that, and the same applies to =
this
> >> patch as well.
> >>
> >> *Conceptually*, this patch is for roms/. However, in earlier discuss=
ion,
> >> it was suggested that roms/ be kept dedicated to external git submod=
ules
> >> only, and that we not add such ROM source to roms/ whose master repo=
 is
> >> genuinely the QEMU repo. Please see the sub-thread at:
> >>
> >>   Re: [PATCH 10/14] tests: acpi: ignore SMBIOS tests when UEFI firmw=
are is used
> >>   http://mid.mail-archive.com/20190116115217.jduhqrwbjhuibmoq@sirius=
.home.kraxel.org
> >>
> >> The last idea was that the UEFI source code should be kept in a dire=
ct
> >> subdirectory of tests/ (rather than in roms/). And the binaries shou=
ld
> >> go under tests/data/uefi-boot-images/ (rather than pc-bios/).
> >>
> >> Thanks
> >> Laszlo
> >=20
> > Hmm I see. You see rebuild-expected-aml.sh does not work
> > like this at all. It works fine with an out of tree build:
> > check it out.
>=20
> But rebuild-expected-aml.sh does not depend of roms/.

It absolutely depends on pc-bios/bios.bin



> >=20
> > So I try to keep it all out of tree.
>=20
> Patch 5/5 add the bios-tables-test blobs under tests/data/ (as other
> submodules in roms/ do, adding blobs in pc-bios/).
>=20
> >=20
> > And question would be what if someone wanted a reproducible
> > build of QEMU, what would be the right way to do it?
>=20
> This question deserves his own thread :)

Sure.

> > Yes right now roms seems to be broken for an out of
> > tree build but is that by design and should we
> > add more examples of this?
>=20
> IMO having these tests build out-of-tree is easier than trying to build
> various of the projects in roms/ out-of-tree.
> This would be a good effort, but I'm not sure it is worth it with this
> series.
> Eventually once we have a qtest using the bios-tables, we could spend
> some time to make this script work out-of-tree.
>=20
> Regards,
>=20
> Phil.

I'm not saying it's a blocker.

--=20
MST
