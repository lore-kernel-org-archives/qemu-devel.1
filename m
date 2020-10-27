Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F47C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 02:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDFB20790
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 02:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="f8aoNFYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDFB20790
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXEQU-0002gR-9A
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 22:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXEOq-0001Q1-6z
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 22:07:48 -0400
Received: from ozlabs.org ([203.11.71.1]:45991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXEOo-00026G-1L
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 22:07:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CKw8D5jjHz9sT6; Tue, 27 Oct 2020 13:07:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603764460;
 bh=efmqibXo9PrI3W3He+FnWbYvFpNi1vJXW7JgSOoFfBY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f8aoNFYp+5gWgzXz/m76sftnge1xxQWh/yn7ZSXUhrVoyIyUs8ze6ZkXcMS0DaJJC
 W1qaMsBL4TG9g4YsGUbOw+WXuvLJIi1cgR6HyXNTJZjpp76eDjgjnLqClOIvMGj30O
 0UyOolvY1mdI2NVF9tvCkw31j8eS8K1hTVGVfL9o=
Date: Tue, 27 Oct 2020 13:04:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 10/15] ppc: remove bios_name
Message-ID: <20201027020401.GF4671@yekko.fritz.box>
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Content-Disposition: inline
In-Reply-To: <20201026143028.3034018-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 22:03:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 10:30:23AM -0400, Paolo Bonzini wrote:
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/e500.c          | 4 ++--
>  hw/ppc/mac_newworld.c  | 4 +---
>  hw/ppc/mac_oldworld.c  | 4 +---
>  hw/ppc/pnv.c           | 5 +----
>  hw/ppc/ppc405_boards.c | 6 ++----
>  hw/ppc/prep.c          | 4 +---
>  hw/ppc/spapr.c         | 4 +---
>  7 files changed, 9 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index ae39b9358e..153a74c98c 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -1035,7 +1035,7 @@ void ppce500_init(MachineState *machine)
>       * -kernel to users but allows them to run through u-boot as well.
>       */
>      kernel_as_payload =3D false;
> -    if (bios_name =3D=3D NULL) {
> +    if (machine->firmware =3D=3D NULL) {
>          if (machine->kernel_filename) {
>              payload_name =3D machine->kernel_filename;
>              kernel_as_payload =3D true;
> @@ -1043,7 +1043,7 @@ void ppce500_init(MachineState *machine)
>              payload_name =3D "u-boot.e500";
>          }
>      } else {
> -        payload_name =3D bios_name;
> +        payload_name =3D machine->firmware;
>      }
> =20
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, payload_name);
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index f9a1cc8944..61c63819df 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -109,6 +109,7 @@ static void ppc_core99_reset(void *opaque)
>  static void ppc_core99_init(MachineState *machine)
>  {
>      ram_addr_t ram_size =3D machine->ram_size;
> +    const char *bios_name =3D machine->firmware ?: PROM_FILENAME;
>      const char *kernel_filename =3D machine->kernel_filename;
>      const char *kernel_cmdline =3D machine->kernel_cmdline;
>      const char *initrd_filename =3D machine->initrd_filename;
> @@ -161,9 +162,6 @@ static void ppc_core99_init(MachineState *machine)
>                             &error_fatal);
>      memory_region_add_subregion(get_system_memory(), PROM_BASE, bios);
> =20
> -    if (!bios_name) {
> -        bios_name =3D PROM_FILENAME;
> -    }
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>      if (filename) {
>          /* Load OpenBIOS (ELF) */
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 6c59aa5601..11623e8e67 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -83,6 +83,7 @@ static void ppc_heathrow_reset(void *opaque)
>  static void ppc_heathrow_init(MachineState *machine)
>  {
>      ram_addr_t ram_size =3D machine->ram_size;
> +    const char *bios_name =3D machine->firmware ?: PROM_FILENAME;
>      const char *boot_device =3D machine->boot_order;
>      PowerPCCPU *cpu =3D NULL;
>      CPUPPCState *env =3D NULL;
> @@ -130,9 +131,6 @@ static void ppc_heathrow_init(MachineState *machine)
>                             &error_fatal);
>      memory_region_add_subregion(get_system_memory(), PROM_BASE, bios);
> =20
> -    if (!bios_name) {
> -        bios_name =3D PROM_FILENAME;
> -    }
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>      if (filename) {
>          /* Load OpenBIOS (ELF) */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index d9e52873ea..f2b1ee83d3 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -713,6 +713,7 @@ static void pnv_chip_power10_pic_print_info(PnvChip *=
chip, Monitor *mon)
> =20
>  static void pnv_init(MachineState *machine)
>  {
> +    const char *bios_name =3D machine->firmware ?: FW_FILE_NAME;
>      PnvMachineState *pnv =3D PNV_MACHINE(machine);
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      char *fw_filename;
> @@ -739,10 +740,6 @@ static void pnv_init(MachineState *machine)
>      pnv->pnor =3D PNV_PNOR(dev);
> =20
>      /* load skiboot firmware  */
> -    if (bios_name =3D=3D NULL) {
> -        bios_name =3D FW_FILE_NAME;
> -    }
> -
>      fw_filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>      if (!fw_filename) {
>          error_report("Could not find OPAL firmware '%s'", bios_name);
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index 4687715b15..c867e46330 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -141,6 +141,7 @@ static void ref405ep_fpga_init(MemoryRegion *sysmem, =
uint32_t base)
>  static void ref405ep_init(MachineState *machine)
>  {
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> +    const char *bios_name =3D machine->firmware ?: BIOS_FILENAME;
>      const char *kernel_filename =3D machine->kernel_filename;
>      const char *kernel_cmdline =3D machine->kernel_cmdline;
>      const char *initrd_filename =3D machine->initrd_filename;
> @@ -206,8 +207,6 @@ static void ref405ep_init(MachineState *machine)
>          memory_region_init_rom(bios, NULL, "ef405ep.bios", BIOS_SIZE,
>                                 &error_fatal);
> =20
> -        if (bios_name =3D=3D NULL)
> -            bios_name =3D BIOS_FILENAME;
>          filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>          if (filename) {
>              bios_size =3D load_image_size(filename,
> @@ -425,6 +424,7 @@ static void taihu_cpld_init(MemoryRegion *sysmem, uin=
t32_t base)
>  static void taihu_405ep_init(MachineState *machine)
>  {
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> +    const char *bios_name =3D machine->firmware ?: BIOS_FILENAME;
>      const char *kernel_filename =3D machine->kernel_filename;
>      const char *initrd_filename =3D machine->initrd_filename;
>      char *filename;
> @@ -475,8 +475,6 @@ static void taihu_405ep_init(MachineState *machine)
>      } else
>  #endif
>      {
> -        if (bios_name =3D=3D NULL)
> -            bios_name =3D BIOS_FILENAME;
>          bios =3D g_new(MemoryRegion, 1);
>          memory_region_init_rom(bios, NULL, "taihu_405ep.bios", BIOS_SIZE,
>                                 &error_fatal);
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 4a0cb434a6..c6b9d1ddcb 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -237,6 +237,7 @@ static int prep_set_cmos_checksum(DeviceState *dev, v=
oid *opaque)
> =20
>  static void ibm_40p_init(MachineState *machine)
>  {
> +    const char *bios_name =3D machine->firmware ?: "openbios-ppc";
>      CPUPPCState *env =3D NULL;
>      uint16_t cmos_checksum;
>      PowerPCCPU *cpu;
> @@ -271,9 +272,6 @@ static void ibm_40p_init(MachineState *machine)
> =20
>      /* PCI host */
>      dev =3D qdev_new("raven-pcihost");
> -    if (!bios_name) {
> -        bios_name =3D "openbios-ppc";
> -    }
>      qdev_prop_set_string(dev, "bios-name", bios_name);
>      qdev_prop_set_uint32(dev, "elf-machine", PPC_ELF_MACHINE);
>      pcihost =3D SYS_BUS_DEVICE(dev);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 63315f2d0f..667d59e5ad 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2647,6 +2647,7 @@ static void spapr_machine_init(MachineState *machin=
e)
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(machine);
>      SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> +    const char *bios_name =3D machine->firmware ?: FW_FILE_NAME;
>      const char *kernel_filename =3D machine->kernel_filename;
>      const char *initrd_filename =3D machine->initrd_filename;
>      PCIHostState *phb;
> @@ -2970,9 +2971,6 @@ static void spapr_machine_init(MachineState *machin=
e)
>          }
>      }
> =20
> -    if (bios_name =3D=3D NULL) {
> -        bios_name =3D FW_FILE_NAME;
> -    }
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>      if (!filename) {
>          error_report("Could not find LPAR firmware '%s'", bios_name);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+XgBEACgkQbDjKyiDZ
s5JoCw/7BxMPkFzA1vwxm490iygCAyeh24kyY7TYB0M0SEj28ugXHrAXQq8yWLbj
MDV8a8ZDbcLetlCfUN2tXXD9E5XVSBoXvb/bdqJuX/7Eo/9FMeXfdlzIDmjGfMe3
byIo92yQzclPS8iUWRBQedrvK1SftlIhI19u6+rbL0k1Ppqko8jYZcZ3OfgrDi7x
xWZz9iYHFFTb5jObdwPb963pmpgyNmdOpVtgfDqNqHebsyUmJzz0uaczo9t+EQcF
0cJ5M4XDHBGSLT05wsz9VcXMRxo0Hgqt92J0No6SfA1DELSTnEvNPWtlcuUf0ZHq
NTEQfHbRhl2gnD1g5ttK8UvCA4T3jAa5Aii1z58UhEa7zXFSvCDdCUQGgqXqnl8Z
5LYk9lj4GOn1ROHVEloXpc5w7S7jZZTXyC0Svs9Bpv9M0UKLjvmpWg/GvOByAk13
BNm+pdTwIXg+ut4BDrWWVX7K+3VZOxSkiPKGTB9cYBeZiZTxzvh4p2AOJazS3ktT
2lhqIlfD+x/tSNkUbTjWwnGq/aB2nWIb25I6sUVgCC5cc2QHkovlgkLX1RNLE6HT
ynOEkhOt59v9a+2lKEYzKPO4ivAiFqpUKnWaVJUWAoR7HCwvVDDbKGSDvCMuiXZ9
CMYX2npew4uzyWy07eCcIzu0WAVpiqn3lq7cFtYZ2zEX3b+1Ors=
=D9he
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--

