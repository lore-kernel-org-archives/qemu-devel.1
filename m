Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25B0C352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF96520873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gJ2dKnwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF96520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j24mz-0004bw-Vn
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 22:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j24mC-0003d3-GB
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j24mA-0004aA-Mw
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:02:52 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:42993 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j24mA-0004Rx-0Q; Wed, 12 Feb 2020 22:02:50 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48J1XN0db1z9sPJ; Thu, 13 Feb 2020 14:02:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581562964;
 bh=iBWZECdMc0Kh/WKMUYKchgMqMGJD3k67DDE1L6sgLnc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gJ2dKnwSIiuY+Do5KGpjaJXB4w8ftfAkO6r0IpgBhfwRaBZ+t1c0pMi9m1f2TpUIG
 YBoAplWaEBOhLhV6wj9fB455RkS5okCeeU4p2fPbXPem1zGsf2qDvzwUeEU/aGHmNS
 94xvkvs5aI8fp1LMtDD2qhGloGgzE+ZrLOMuS6h0=
Date: Thu, 13 Feb 2020 13:58:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v6 5/6] spapr: Allow changing offset for -kernel image
Message-ID: <20200213025858.GC124369@umbus.fritz.box>
References: <20200203032943.121178-1-aik@ozlabs.ru>
 <20200203032943.121178-6-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <20200203032943.121178-6-aik@ozlabs.ru>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2020 at 02:29:42PM +1100, Alexey Kardashevskiy wrote:
> This allows moving the kernel in the guest memory. The option is useful
> for step debugging (as Linux is linked at 0x0); it also allows loading
> grub which is normally linked to run at 0x20000.
>=20
> This uses the existing kernel address by default.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to ppc-for-5.0, since I think it makes sense even without the
rest of the series.

> ---
>  include/hw/ppc/spapr.h |  1 +
>  hw/ppc/spapr.c         | 38 +++++++++++++++++++++++++++++++-------
>  2 files changed, 32 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 3b50f36c338a..32e831a395ae 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -164,6 +164,7 @@ struct SpaprMachineState {
>      void *fdt_blob;
>      long kernel_size;
>      bool kernel_le;
> +    uint64_t kernel_addr;
>      uint32_t initrd_base;
>      long initrd_size;
>      uint64_t rtc_offset; /* Now used only during incoming migration */
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 60153bf0b771..b59e9dc360fe 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1054,7 +1054,7 @@ static void spapr_dt_chosen(SpaprMachineState *spap=
r, void *fdt)
>      }
> =20
>      if (spapr->kernel_size) {
> -        uint64_t kprop[2] =3D { cpu_to_be64(KERNEL_LOAD_ADDR),
> +        uint64_t kprop[2] =3D { cpu_to_be64(spapr->kernel_addr),
>                                cpu_to_be64(spapr->kernel_size) };
> =20
>          _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel",
> @@ -1242,7 +1242,8 @@ void *spapr_build_fdt(SpaprMachineState *spapr, boo=
l reset, size_t space)
>      /* Build memory reserve map */
>      if (reset) {
>          if (spapr->kernel_size) {
> -            _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kernel_s=
ize)));
> +            _FDT((fdt_add_mem_rsv(fdt, spapr->kernel_addr,
> +                                  spapr->kernel_size)));
>          }
>          if (spapr->initrd_size) {
>              _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base,
> @@ -1270,7 +1271,9 @@ void *spapr_build_fdt(SpaprMachineState *spapr, boo=
l reset, size_t space)
> =20
>  static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
>  {
> -    return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
> +    SpaprMachineState *spapr =3D opaque;
> +
> +    return (addr & 0x0fffffff) + spapr->kernel_addr;
>  }
> =20
>  static void emulate_spapr_hypercall(PPCVirtualHypervisor *vhyp,
> @@ -2947,14 +2950,15 @@ static void spapr_machine_init(MachineState *mach=
ine)
>          uint64_t lowaddr =3D 0;
> =20
>          spapr->kernel_size =3D load_elf(kernel_filename, NULL,
> -                                      translate_kernel_address, NULL,
> +                                      translate_kernel_address, spapr,
>                                        NULL, &lowaddr, NULL, NULL, 1,
>                                        PPC_ELF_MACHINE, 0, 0);
>          if (spapr->kernel_size =3D=3D ELF_LOAD_WRONG_ENDIAN) {
>              spapr->kernel_size =3D load_elf(kernel_filename, NULL,
> -                                          translate_kernel_address, NULL=
, NULL,
> +                                          translate_kernel_address, spap=
r, NULL,
>                                            &lowaddr, NULL, NULL, 0,
> -                                          PPC_ELF_MACHINE, 0, 0);
> +                                          PPC_ELF_MACHINE,
> +                                          0, 0);
>              spapr->kernel_le =3D spapr->kernel_size > 0;
>          }
>          if (spapr->kernel_size < 0) {
> @@ -2968,7 +2972,7 @@ static void spapr_machine_init(MachineState *machin=
e)
>              /* Try to locate the initrd in the gap between the kernel
>               * and the firmware. Add a bit of space just in case
>               */
> -            spapr->initrd_base =3D (KERNEL_LOAD_ADDR + spapr->kernel_size
> +            spapr->initrd_base =3D (spapr->kernel_addr + spapr->kernel_s=
ize
>                                    + 0x1ffff) & ~0xffff;
>              spapr->initrd_size =3D load_image_targphys(initrd_filename,
>                                                       spapr->initrd_base,
> @@ -3214,6 +3218,18 @@ static void spapr_set_vsmt(Object *obj, Visitor *v=
, const char *name,
>      visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>  }
> =20
> +static void spapr_get_kernel_addr(Object *obj, Visitor *v, const char *n=
ame,
> +                                  void *opaque, Error **errp)
> +{
> +    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
> +}
> +
> +static void spapr_set_kernel_addr(Object *obj, Visitor *v, const char *n=
ame,
> +                                  void *opaque, Error **errp)
> +{
> +    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
> +}
> +
>  static char *spapr_get_ic_mode(Object *obj, Error **errp)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> @@ -3319,6 +3335,14 @@ static void spapr_instance_init(Object *obj)
>      object_property_add_bool(obj, "vfio-no-msix-emulation",
>                               spapr_get_msix_emulation, NULL, NULL);
> =20
> +    object_property_add(obj, "kernel-addr", "uint64", spapr_get_kernel_a=
ddr,
> +                        spapr_set_kernel_addr, NULL, &spapr->kernel_addr,
> +                        &error_abort);
> +    object_property_set_description(obj, "kernel-addr",
> +                                    stringify(KERNEL_LOAD_ADDR)
> +                                    " for -kernel is the default",
> +                                    NULL);
> +    spapr->kernel_addr =3D KERNEL_LOAD_ADDR;
>      /* The machine class defines the default interrupt controller mode */
>      spapr->irq =3D smc->irq;
>      object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5Eu3IACgkQbDjKyiDZ
s5J1yBAAziMNYavRFaq7evV/iTWK/4lojmvQRl2andUC3kia+BiQ18GK5CLy7y0S
VZHKzfxk0ab11Cj88oP9mza45N6PYTU16R7cQWHSUqik+wzsGCZdknz25+YVzZ0e
PmOaaK8FV9H7+sU+e4uQhJtwhL8DpSLcXRp5VOceQY+d/x4DOm1GeAAzQ90BOeHw
6lT2f2nG6lvRqjUP5jpuqX37IBiwgwGboo4d2HM5eoneXecL8JVLN9+0eQZorAHn
Wl77Ii7ZJlmK2V729h0tVgGxMVghkjfbpFmdv5qA9fCyZtglsuSeett0f98ugk2x
ExnBCuHz5feXRFIYwOlGGqpOhxEmbeLOy8lNWbmnnIzfRYSJR+EnPMjcg2nu1MEw
8NszeZDazgig7I5KwYMEkY6iBJNIbYXYyDIE3vZbcZvJZZei/l37pozLu/OU6LWo
q8qbqtDs0jMtfwegW5M6n2TtHV1l+yJUIdcox/QIwnSwSYe24ZrnXFnbANE1tP1K
adB0n5JpYxDNTsCycPuhnnQULn3fS10NZIizLgagj/6zLFdYnWLUhy6/8PLpd3iT
ZBzmu+LO16YNmtMngXltTqDAPN/2LHOdaJS/oI+MSAsC8SqS1zBWqJruJCHpwTXM
ujr8wIlKCJIC8S/3B/ctSLrkoY4Nur1greunTQKx84dWOspKoPg=
=HZdn
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--

