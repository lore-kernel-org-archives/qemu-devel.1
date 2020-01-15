Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FC7C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DA4214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DA4214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irnMS-00026V-UM
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 13:25:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1irnLL-00018x-8I
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1irnLJ-0007vs-SP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:24:39 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:26906)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1irnLJ-0007uy-Iv; Wed, 15 Jan 2020 13:24:37 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 0D94A748DC6;
 Wed, 15 Jan 2020 19:24:35 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ACA01748DC5; Wed, 15 Jan 2020 19:24:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AB3877482D3;
 Wed, 15 Jan 2020 19:24:34 +0100 (CET)
Date: Wed, 15 Jan 2020 19:24:34 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 64/86] ppc:ppc405_boards: add RAM size checks
In-Reply-To: <1579100861-73692-65-git-send-email-imammedo@redhat.com>
Message-ID: <alpine.BSF.2.21.99999.352.2001151923450.24151@zero.eik.bme.hu>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-65-git-send-email-imammedo@redhat.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-607929231-1579112674=:24151"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-607929231-1579112674=:24151
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jan 2020, Igor Mammedov wrote:
> If user provided non-sense RAM size, board will ignore it
> and continue running with fixed RAM size.
>
> Also RAM is going to be allocated by generic code, so it
> won't be possible for board to fix CLI.
>
> Make it error message and exit to force user fix CLI,
> instead of accepting non-sense CLI values.
>
> PS:
> move fixed RAM size into mc->default_ram_size, so that
> generic code will know how much to allocate.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>  * fix format string causing build failure on 32-bit host
>    (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
>
> CC: david@gibson.dropbear.id.au
> CC: qemu-ppc@nongnu.org
> ---
> hw/ppc/ppc405_boards.c | 36 +++++++++++++++++++++++-------------
> 1 file changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index 1f721fe..a7a432d 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -137,7 +137,7 @@ static void ref405ep_fpga_init(MemoryRegion *sysmem=
, uint32_t base)
>
> static void ref405ep_init(MachineState *machine)
> {
> -    ram_addr_t ram_size =3D machine->ram_size;
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>     const char *kernel_filename =3D machine->kernel_filename;
>     const char *kernel_cmdline =3D machine->kernel_cmdline;
>     const char *initrd_filename =3D machine->initrd_filename;
> @@ -161,15 +161,20 @@ static void ref405ep_init(MachineState *machine)
>     DriveInfo *dinfo;
>     MemoryRegion *sysmem =3D get_system_memory();
>
> +    if (machine->ram_size !=3D mc->default_ram_size) {
> +        error_report("Invalid RAM size, should be " RAM_ADDR_UFMT " By=
tes",
> +                     mc->default_ram_size);
> +        exit(EXIT_FAILURE);
> +    }
> +
>     /* XXX: fix this */
>     memory_region_allocate_system_memory(&ram_memories[0], NULL, "ef405=
ep.ram",
> -                                         0x08000000);
> +                                         machine->ram_size);
>     ram_bases[0] =3D 0;
> -    ram_sizes[0] =3D 0x08000000;
> +    ram_sizes[0] =3D machine->ram_size;
>     memory_region_init(&ram_memories[1], NULL, "ef405ep.ram1", 0);
>     ram_bases[1] =3D 0x00000000;
>     ram_sizes[1] =3D 0x00000000;
> -    ram_size =3D 128 * MiB;
>     env =3D ppc405ep_init(sysmem, ram_memories, ram_bases, ram_sizes,
>                         33333333, &pic, kernel_filename =3D=3D NULL ? 0=
 : 1);
>     /* allocate SRAM */
> @@ -227,7 +232,7 @@ static void ref405ep_init(MachineState *machine)
>     if (linux_boot) {
>         memset(&bd, 0, sizeof(bd));
>         bd.bi_memstart =3D 0x00000000;
> -        bd.bi_memsize =3D ram_size;
> +        bd.bi_memsize =3D machine->ram_size;
>         bd.bi_flashstart =3D -bios_size;
>         bd.bi_flashsize =3D -bios_size;
>         bd.bi_flashoffset =3D 0;
> @@ -255,7 +260,7 @@ static void ref405ep_init(MachineState *machine)
>         kernel_base =3D KERNEL_LOAD_ADDR;
>         /* now we can load the kernel */
>         kernel_size =3D load_image_targphys(kernel_filename, kernel_bas=
e,
> -                                          ram_size - kernel_base);
> +                                          machine->ram_size - kernel_b=
ase);
>         if (kernel_size < 0) {
>             error_report("could not load kernel '%s'", kernel_filename)=
;
>             exit(1);
> @@ -266,7 +271,7 @@ static void ref405ep_init(MachineState *machine)
>         if (initrd_filename) {
>             initrd_base =3D INITRD_LOAD_ADDR;
>             initrd_size =3D load_image_targphys(initrd_filename, initrd=
_base,
> -                                              ram_size - initrd_base);
> +                                              machine->ram_size - init=
rd_base);
>             if (initrd_size < 0) {
>                 error_report("could not load initial ram disk '%s'",
>                              initrd_filename);
> @@ -304,6 +309,7 @@ static void ref405ep_class_init(ObjectClass *oc, vo=
id *data)
>
>     mc->desc =3D "ref405ep";
>     mc->init =3D ref405ep_init;
> +    mc->default_ram_size =3D 0x08000000;
> }
>
> static const TypeInfo ref405ep_type =3D {
> @@ -408,7 +414,7 @@ static void taihu_cpld_init(MemoryRegion *sysmem, u=
int32_t base)
>
> static void taihu_405ep_init(MachineState *machine)
> {
> -    ram_addr_t ram_size =3D machine->ram_size;
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>     const char *kernel_filename =3D machine->kernel_filename;
>     const char *initrd_filename =3D machine->initrd_filename;
>     char *filename;
> @@ -425,10 +431,13 @@ static void taihu_405ep_init(MachineState *machin=
e)
>     int fl_idx;
>     DriveInfo *dinfo;
>
> -    /* RAM is soldered to the board so the size cannot be changed */
> -    ram_size =3D 0x08000000;
> +    if (machine->ram_size !=3D mc->default_ram_size) {
> +        error_report("Invalid RAM size, should be " RAM_ADDR_UFMT " By=
tes",

Likewise, should this rather print valid value in M instead of bytes?

Regards,
BALATON Zoltan

> +                     mc->default_ram_size);
> +        exit(EXIT_FAILURE);
> +    }
>     memory_region_allocate_system_memory(ram, NULL, "taihu_405ep.ram",
> -                                         ram_size);
> +                                         machine->ram_size);
>
>     ram_bases[0] =3D 0;
>     ram_sizes[0] =3D 0x04000000;
> @@ -500,7 +509,7 @@ static void taihu_405ep_init(MachineState *machine)
>         kernel_base =3D KERNEL_LOAD_ADDR;
>         /* now we can load the kernel */
>         kernel_size =3D load_image_targphys(kernel_filename, kernel_bas=
e,
> -                                          ram_size - kernel_base);
> +                                          machine->ram_size - kernel_b=
ase);
>         if (kernel_size < 0) {
>             error_report("could not load kernel '%s'", kernel_filename)=
;
>             exit(1);
> @@ -509,7 +518,7 @@ static void taihu_405ep_init(MachineState *machine)
>         if (initrd_filename) {
>             initrd_base =3D INITRD_LOAD_ADDR;
>             initrd_size =3D load_image_targphys(initrd_filename, initrd=
_base,
> -                                              ram_size - initrd_base);
> +                                              machine->ram_size - init=
rd_base);
>             if (initrd_size < 0) {
>                 error_report("could not load initial ram disk '%s'",
>                              initrd_filename);
> @@ -533,6 +542,7 @@ static void taihu_class_init(ObjectClass *oc, void =
*data)
>
>     mc->desc =3D "taihu";
>     mc->init =3D taihu_405ep_init;
> +    mc->default_ram_size =3D 0x08000000;
> }
>
> static const TypeInfo taihu_type =3D {
>
--3866299591-607929231-1579112674=:24151--

