Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8547C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C882073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHnzmjc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C882073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionAB-0003aX-E0
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iomvc-0000B1-A0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iomvZ-0004lG-NA
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:21:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24707
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iomvZ-0004l2-Hz
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578396096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tzSFSmaxFvjqma+6VwZG6hcSkzLobCSQW2MgHcgeD1w=;
 b=BHnzmjc2ILOyxpFjV4sSQrMrw7EdRjLrVIyF7QBhgB4bgCQZKSYQW9me1K2laOxMcuL7Ay
 XbXNciMmWEi6XiWjaDKL9+hrountZazko9zK1cyS729N6YHzQfFtggLno7EFWdPZBZiFmD
 mwr4J3YOWoP4M9c+KM6W0aTBw/+DmoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-Edl0_xZHNBie7wQbJdjUOA-1; Tue, 07 Jan 2020 06:21:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0477E107ACC4;
 Tue,  7 Jan 2020 11:21:33 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 245285D9CA;
 Tue,  7 Jan 2020 11:21:28 +0000 (UTC)
Date: Tue, 7 Jan 2020 12:21:27 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2] hppa: allow max ram size upto 4Gb
Message-ID: <20200107122127.4c8ac59d@redhat.com>
In-Reply-To: <a54bf2ab-a0ae-5374-300c-77d7bc926330@gmx.de>
References: <27c3e31d-82ae-e62f-caba-a0a3fbd55e7c@redhat.com>
 <1577987162-150529-1-git-send-email-imammedo@redhat.com>
 <2f226aa4-5f61-6e6d-d6b9-a98685a79e8c@gmx.de>
 <20200103105434.050d28ea@redhat.com>
 <6fa7bcd3-ee67-cc84-fd4e-d3677e3ae51a@redhat.com>
 <20200106114828.6bc96b23@redhat.com>
 <8ef57947-dba6-9273-0b1e-7f0c052795da@gmx.de>
 <20200106172411.5a6f2efe@redhat.com>
 <a54bf2ab-a0ae-5374-300c-77d7bc926330@gmx.de>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Edl0_xZHNBie7wQbJdjUOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Sven Schnelle <svens@stackframe.org>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jan 2020 18:03:49 +0100
Helge Deller <deller@gmx.de> wrote:

> On 06.01.20 17:24, Igor Mammedov wrote:
> > On Mon, 6 Jan 2020 12:28:51 +0100
> > Helge Deller <deller@gmx.de> wrote:
> > =20
> >> On 06.01.20 11:48, Igor Mammedov wrote: =20
> >>> On Sat, 4 Jan 2020 16:00:19 +0100
> >>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >>> =20
> >>>> On 1/3/20 10:54 AM, Igor Mammedov wrote: =20
> >>>>> On Thu, 2 Jan 2020 21:22:12 +0100
> >>>>> Helge Deller <deller@gmx.de> wrote:
> >>>>> =20
> >>>>>> On 02.01.20 18:46, Igor Mammedov wrote: =20
> >>>>>>> Previous patch drops silent ram_size fixup and makes
> >>>>>>> QEMU error out with:
> >>>>>>>
> >>>>>>>   "RAM size more than 3840m is not supported"
> >>>>>>>
> >>>>>>> when user specified -m X more than supported value.
> >>>>>>>
> >>>>>>> User shouldn't be bothered with starting QEMU with valid CLI,
> >>>>>>> so for the sake of user convenience allow using -m 4G vs -m 3840M=
.
> >>>>>>>
> >>>>>>> Requested-by: Helge Deller <deller@gmx.de>
> >>>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>>>>>> ---
> >>>>>>> v2:
> >>>>>>>    - make main ram -1 prio, so it wouldn't conflict with other re=
gions
> >>>>>>>      starting from 0xf9000000
> >>>>>>>
> >>>>>>> I dislike it but if you feel it's really necessary feel free to a=
ck it. =20
> >>>>
> >>>> Hard to find the v2 buried in the other series with my email client.
> >>>> =20
> >>>>>>>
> >>>>>>> should be applied on top of:
> >>>>>>>    "hppa: drop RAM size fixup" =20
> >>>>>>
> >>>>>> Hello Igor,
> >>>>>> I appreciate that you are trying to make it more cleaner.
> >>>>>> But, can't you merge both of your patches to one patch?
> >>>>>> Right now you have one patch "hppa: drop RAM size fixup", which is
> >>>>>> what I think is wrong. Then you add another one which somehow
> >>>>>> fixes it up again and adds other stuff. =20
> >>>>> 1st patch bring it in line with other boards adding
> >>>>> proper error check but without changing RAM size.
> >>>>> While 2nd is changing device model (mapped RAM size) and
> >>>>> clearly documents that it's a hack for user convenience,
> >>>>> Hence I'd prefer to keep both separated.
> >>>>> =20
> >>>>>> Having everything in one single patch makes your full change more
> >>>>>> understandable.
> >>>>>>
> >>>>>> Is it necessary to introduce clamped_ram_size and not continue wit=
h
> >>>>>> ram_size (even if you would add it as static local variable)? =20
> >>>>> it's necessary since ram_size is global which should be kept =3D=3D=
 MachineState::ram_size.
> >>>>> Later on I plan to remove the former altogether and maybe
> >>>>> MachineState::ram_size aa well, since it could be read with
> >>>>> memory_region_size(MachineState::ram). =20
> >>>>
> >>>> Why insist on clamping the ram? We recommend to model what the hardw=
are
> >>>> does, and the hardware uses a full DIMM of DRAM, so 4GB, not less. =
=20
> >>> I'm not adding 4Gb support here (it's out of scope of this series),
> >>> all this patch does is making pre-existing global ram_size fixup,
> >>> this board only business and naming it clamped_ram_size to match
> >>> its current usage =20
> >>
> >> Ok.
> >> =20
> >>> (along with explicitly documenting the deviation from
> >>> other boards why it was requested to keep fixup 'for user convenience=
'
> >>> instead of going for correct and simpler error message telling
> >>> how much RAM user could specify on CLI). =20
> >>
> >> No, here you are wrong.
> >> This machine, same as all 32-bit x86 based machines, expect users
> >> to insert memory modules of e.g. 1GB, 2GB and so on.
> >> And ROM memory and other regions overlap the RAM in some regions
> >> if required.
> >> So, it's not "user convenience", but it's correct behaviour of the
> >> code to simply allow 4GB and then don't blend in the memory which can'=
t
> >> be accessed.
> >> Giving a error message that "you can only insert 3841MB" would be WRON=
G.
> >> =20
> >>>> What are the new problem introduced by using 4GB? I only see advanta=
ges
> >>>> doing so. This doesn't break your series. This doesn't break the CLI=
.
> >>>> Am I missing something? =20
> >>>
> >>> Well, board was fixing up global ram_size and then used it to
> >>>  - pass clamped value to guest via register
> >>>  - pass it to load load_image_targphys()
> >>>  - perform various checks
> >>>  - affects reset sequence =20
> >>
> >> ... which is all OK, because it mimics the real hardware.
> >> =20
> >>> This patch keeps all of that in the same state
> >>> (I'd suspect changing above points, would break guest) =20
> >>
> >> Yep (unless I change the SeaBIOS ROM code). =20
>=20
> > Does real HW pass in cpu[0]->env.gr[26] full 4Gb or clamped size? =20
>=20
> No, because of the simple reason that real hardware uses a
> propriatary HP Firmware, and that it's not started from some emulation
> layer like qemu. So it has to find way itself to detect how much RAM
> was plugged into the machine.
>=20
> The functionality of giving the ram size in %r26 was done by me,
> otherwise I don't know how SeaBIOS should detect how much RAM the
> user wanted the machine to have. That's changeable if you have another
> idea. Doesn't on x86 the ram size is given in some emulated RTC register?

In x86 case, there is RTC value and there is memory map provided via
paravirt fwcfg.

Using register is fine for passing total RAM size and
Since it's QEMU invention, we could pass full 4Gb in register as
a starting point to support 4Gb of RAM (which removes fixup) and
let SeaBIOS to deduce memory map from that.

Then this patch cloud be amended to:
"
hpp: support 4G of RAM

Real hardware allows to plug in up to 4Gb of RAM
into memory slots, add support for this.
"

> >> Anyway, I'm tired to discuss this.
> >> Your patch isn't wrong by itself, I just think it's changing unnecessa=
ry
> >> too much code and uses wrong wording for the commit message. =20
>=20
> > Let me prepare v3 which hopefully will make is smaller and
> > with commit message corrected.
> > How about following wording:
> > "
> >     hppa: allow max ram size upto 4Gb
> >
> >     Previous patch drops silent ram_size fixup and makes
> >     QEMU error out with:
> >
> >      "RAM size more than 3840m is not supported"
> >
> >     when user specified -m X more than currently supported
> >     value.
> >
> >     However real hardware allows to plug in up to 4Gb RAM
> >     into memory slots. So allow user specify up to 4Gb and
> >     map all of it into guest address space.
> >
> > PS:
> >     guest will still see 3840m being reported in
> >     cpu[0]->env.gr[26] and loose ~248Mb, as it doesn't
> >     have other means to discover RAM above firmware ROM.
> > " =20
>=20
> Why make it so complicated?

It describes what exactly patch does without masking any
consequences of used approach (since we are not really telling
guest that it has more RAM and guest has other means to discover
it).

If you are asking why I'm making it hard error, see cover letter.
(in short main RAM allocation is total mess and series fixes
that by consolidating, de-duplicating and replacing ad hoc allocation
with a centralized approach that allows user to specify used
RAM backend in generic case).

> I see:
> +    if (machine->ram_size > 4 * GiB) {
> +        error_report("RAM size more than 4Gb is not supported");
>=20
> what type is machine->ram_size?
> If it's a 32bit unsigned integer this check is useless, and if it's a 64b=
it
> integer it would be too big for a 32bit-only platform anyway.

it's ram_addr_t, which is mutable depending on the host
it could be 32-bit or 64-bit.

Currently QEMU doesn't have a generic code to do such
checks and QEMU accumulated a whole zoo where some boards
do checks, some mask incorrect -m values and some do don't
do any checks. But cleaning up that is out of scope of
this already big enough re-factoring.
Hence I'm adding checks/removing fixups where they were
missing/present as it's a minimum effort needed to generalize
main RAM allocation.

> So, I'd suggest to drop your wrong patch #43.
As you noted in your first reply, patch is correct.
All it's doing is validating user input versus RAM size
actually supported by the current code, telling user
current supported limit and enforcing it.

I agree it's inconvenience for the users since they
won't be able to specify non-sense values and still
get board running, but that's clear user error and
should be corrected on user side and not by QEMU
magically masking wrong CLI values.
Since it could be fixed on user side, I care less
about user convenience when it comes to correctness
and unified code.
=20
> If you don't want to drop it, my suggestion for a commit message is:
>=20
> hppa: Revert last wrong patch and give warning if user specified > 4GB RA=
M

I have to disagree on definition of wrong here,
in my opinion covering up user errors is wrong especially
when all users have to do is to adapt their CLI.

Supporting 4Gb is another story, which is extending current
impl. and could be done on top of the ram_size check.

> Helge
>=20
> > =20
> >> But just apply it as long as it doesn't break anything.
> >>
> >> Helge
> >> =20
> >>> If you have an alternative patch that enables to use full 4Gb,
> >>> I'd include on respin as far as it doesn't change user supplied
> >>> global ram_size && ms->ram_size && uses generic ms->ram &&
> >>> preferably on top of
> >>>  "[PATCH 44/86] hppa: use memdev for RAM"
> >>> so it would be easier to drop it if there would opposition to it
> >>> without affecting series.
> >>> =20
> >>>>>>> ---
> >>>>>>>   hw/hppa/machine.c | 21 +++++++++++----------
> >>>>>>>   1 file changed, 11 insertions(+), 10 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> >>>>>>> index ebbf44f..0302983 100644
> >>>>>>> --- a/hw/hppa/machine.c
> >>>>>>> +++ b/hw/hppa/machine.c
> >>>>>>> @@ -54,6 +54,7 @@ static uint64_t cpu_hppa_to_phys(void *opaque, =
uint64_t addr)
> >>>>>>>
> >>>>>>>   static HPPACPU *cpu[HPPA_MAX_CPUS];
> >>>>>>>   static uint64_t firmware_entry;
> >>>>>>> +static ram_addr_t clamped_ram_size;
> >>>>>>>
> >>>>>>>   static void machine_hppa_init(MachineState *machine)
> >>>>>>>   {
> >>>>>>> @@ -74,8 +75,6 @@ static void machine_hppa_init(MachineState *mac=
hine)
> >>>>>>>       long i;
> >>>>>>>       unsigned int smp_cpus =3D machine->smp.cpus;
> >>>>>>>
> >>>>>>> -    ram_size =3D machine->ram_size;
> >>>>>>> -
> >>>>>>>       /* Create CPUs.  */
> >>>>>>>       for (i =3D 0; i < smp_cpus; i++) {
> >>>>>>>           char *name =3D g_strdup_printf("cpu%ld-io-eir", i);
> >>>>>>> @@ -90,12 +89,14 @@ static void machine_hppa_init(MachineState *m=
achine)
> >>>>>>>       }
> >>>>>>>
> >>>>>>>       /* Limit main memory. */
> >>>>>>> -    if (ram_size > FIRMWARE_START) {
> >>>>>>> -        error_report("RAM size more than %d is not supported", F=
IRMWARE_START);
> >>>>>>> +    if (machine->ram_size > 4 * GiB) {
> >>>>>>> +        error_report("RAM size more than 4Gb is not supported");
> >>>>>>>           exit(EXIT_FAILURE);
> >>>>>>>       }
> >>>>>>> +    clamped_ram_size =3D machine->ram_size > FIRMWARE_START ?
> >>>>>>> +        FIRMWARE_START : machine->ram_size;
> >>>>>>>
> >>>>>>> -    memory_region_add_subregion(addr_space, 0, machine->ram);
> >>>>>>> +    memory_region_add_subregion_overlap(addr_space, 0, machine->=
ram, -1);
> >>>>>>>
> >>>>>>>       /* Init Dino (PCI host bus chip).  */
> >>>>>>>       pci_bus =3D dino_init(addr_space, &rtc_irq, &serial_irq);
> >>>>>>> @@ -151,7 +152,7 @@ static void machine_hppa_init(MachineState *m=
achine)
> >>>>>>>       qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%08" PRIx=
64
> >>>>>>>                     "-0x%08" PRIx64 ", entry at 0x%08" PRIx64 ".\=
n",
> >>>>>>>                     firmware_low, firmware_high, firmware_entry);
> >>>>>>> -    if (firmware_low < ram_size || firmware_high >=3D FIRMWARE_E=
ND) {
> >>>>>>> +    if (firmware_low < clamped_ram_size || firmware_high >=3D FI=
RMWARE_END) {
> >>>>>>>           error_report("Firmware overlaps with memory or IO space=
");
> >>>>>>>           exit(1);
> >>>>>>>       }
> >>>>>>> @@ -204,7 +205,7 @@ static void machine_hppa_init(MachineState *m=
achine)
> >>>>>>>                  (1) Due to sign-extension problems and PDC,
> >>>>>>>                  put the initrd no higher than 1G.
> >>>>>>>                  (2) Reserve 64k for stack.  */
> >>>>>>> -            initrd_base =3D MIN(ram_size, 1 * GiB);
> >>>>>>> +            initrd_base =3D MIN(clamped_ram_size, 1 * GiB);
> >>>>>>>               initrd_base =3D initrd_base - 64 * KiB;
> >>>>>>>               initrd_base =3D (initrd_base - initrd_size) & TARGE=
T_PAGE_MASK;
> >>>>>>>
> >>>>>>> @@ -232,7 +233,7 @@ static void machine_hppa_init(MachineState *m=
achine)
> >>>>>>>        * various parameters in registers. After firmware initiali=
zation,
> >>>>>>>        * firmware will start the Linux kernel with ramdisk and cm=
dline.
> >>>>>>>        */
> >>>>>>> -    cpu[0]->env.gr[26] =3D ram_size;
> >>>>>>> +    cpu[0]->env.gr[26] =3D clamped_ram_size; =20
> >>>>
> >>>> Helge, is this the code using this register?
> >>>>
> >>>> https://github.com/hdeller/seabios-hppa/blob/parisc-qemu-5.0/src/par=
isc/head.S#L139
> >>>> =20
> >>>>>>>       cpu[0]->env.gr[25] =3D kernel_entry;
> >>>>>>>
> >>>>>>>       /* tell firmware how many SMP CPUs to present in inventory =
table */
> >>>>>>> @@ -255,11 +256,11 @@ static void hppa_machine_reset(MachineState=
 *ms)
> >>>>>>>       }
> >>>>>>>
> >>>>>>>       /* already initialized by machine_hppa_init()? */
> >>>>>>> -    if (cpu[0]->env.gr[26] =3D=3D ram_size) {
> >>>>>>> +    if (cpu[0]->env.gr[26] =3D=3D clamped_ram_size) {
> >>>>>>>           return;
> >>>>>>>       }
> >>>>>>>
> >>>>>>> -    cpu[0]->env.gr[26] =3D ram_size;
> >>>>>>> +    cpu[0]->env.gr[26] =3D clamped_ram_size;
> >>>>>>>       cpu[0]->env.gr[25] =3D 0; /* no firmware boot menu */
> >>>>>>>       cpu[0]->env.gr[24] =3D 'c';
> >>>>>>>       /* gr22/gr23 unused, no initrd while reboot. */
> >>>>>>> =20
> >>>>>> =20
> >>>>> =20
> >>>> =20
> >>> =20
> >>
> >> =20
> > =20
>=20


