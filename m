Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA14AC49ED6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 00:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC5A20872
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 00:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NAeOsleV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC5A20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Cns-0003Uc-BO
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 20:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i8CmP-000238-5M
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 20:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i8CmN-00069w-Am
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 20:16:08 -0400
Received: from ozlabs.org ([203.11.71.1]:42627)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i8CmM-00069E-6u; Wed, 11 Sep 2019 20:16:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46TK760y9tz9sCJ; Thu, 12 Sep 2019 10:16:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568247362;
 bh=pprueIE2e1wkHfoKZyoDoh/erCEJZn/MfydSlbNgkbM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NAeOsleVZpvSooXohy95KIDxtN3lQ37w9jhP9Dz7mwormEDzF/DuytTzJpyDnqofG
 l+eklxiBs5QNjxpxVJ4EhCtih7n6ejWvDLwWFbmX03tZusTiLKKwKnurcoEi3Pc7ba
 iullYkrHbfrZSU7lMuxY2125sYvFYOuYckcS8IcU=
Date: Thu, 12 Sep 2019 10:15:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Balamuruhan S <bala24@linux.ibm.com>
Message-ID: <20190912001545.GG13785@umbus.fritz.box>
References: <20190911142925.19197-1-bala24@linux.ibm.com>
 <20190911142925.19197-5-bala24@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Content-Disposition: inline
In-Reply-To: <20190911142925.19197-5-bala24@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/ppc/pnv: fix checkpatch.pl
 coding style warnings
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
Cc: maddy@linux.vnet.ibm.com, groug@kaod.org, qemu-devel@nongnu.org,
 anju@linux.vnet.ibm.com, qemu-ppc@nongnu.org, clg@kaod.org,
 hari@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2019 at 07:59:25PM +0530, Balamuruhan S wrote:
> There were few trailing comments after `/*` instead in
> new line and line more than 80 character, these fixes are
> trivial and doesn't change any logic in code.
>=20
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>

This makes sense independent of the rest, so I've applied it now.  The
rest of the patches I'll wait on a respin to address C=E9dric's comments.

> ---
>  hw/ppc/pnv.c | 49 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index f249e72356..77a86c6a23 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -187,7 +187,8 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, v=
oid *fdt)
> =20
>      _FDT((fdt_setprop_cell(fdt, offset, "timebase-frequency", tbfreq)));
>      _FDT((fdt_setprop_cell(fdt, offset, "clock-frequency", cpufreq)));
> -    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size", cpu->hash64_opts=
->slb_size)));
> +    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size",
> +                           cpu->hash64_opts->slb_size)));
>      _FDT((fdt_setprop_string(fdt, offset, "status", "okay")));
>      _FDT((fdt_setprop(fdt, offset, "64-bit", NULL, 0)));
> =20
> @@ -200,19 +201,23 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc,=
 void *fdt)
>                             segs, sizeof(segs))));
>      }
> =20
> -    /* Advertise VMX/VSX (vector extensions) if available
> +    /*
> +     * Advertise VMX/VSX (vector extensions) if available
>       *   0 / no property =3D=3D no vector extensions
>       *   1               =3D=3D VMX / Altivec available
> -     *   2               =3D=3D VSX available */
> +     *   2               =3D=3D VSX available
> +     */
>      if (env->insns_flags & PPC_ALTIVEC) {
>          uint32_t vmx =3D (env->insns_flags2 & PPC2_VSX) ? 2 : 1;
> =20
>          _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", vmx)));
>      }
> =20
> -    /* Advertise DFP (Decimal Floating Point) if available
> +    /*
> +     * Advertise DFP (Decimal Floating Point) if available
>       *   0 / no property =3D=3D no DFP
> -     *   1               =3D=3D DFP available */
> +     *   1               =3D=3D DFP available
> +     */
>      if (env->insns_flags2 & PPC2_DFP) {
>          _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
>      }
> @@ -424,7 +429,8 @@ static int pnv_dt_isa_device(DeviceState *dev, void *=
opaque)
>      return 0;
>  }
> =20
> -/* The default LPC bus of a multichip system is on chip 0. It's
> +/*
> + * The default LPC bus of a multichip system is on chip 0. It's
>   * recognized by the firmware (skiboot) using a "primary" property.
>   */
>  static void pnv_dt_isa(PnvMachineState *pnv, void *fdt)
> @@ -442,8 +448,10 @@ static void pnv_dt_isa(PnvMachineState *pnv, void *f=
dt)
>      assert(phandle > 0);
>      _FDT((fdt_setprop_cell(fdt, isa_offset, "phandle", phandle)));
> =20
> -    /* ISA devices are not necessarily parented to the ISA bus so we
> -     * can not use object_child_foreach() */
> +    /*
> +     * ISA devices are not necessarily parented to the ISA bus so we
> +     * can not use object_child_foreach()
> +     */
>      qbus_walk_children(BUS(pnv->isa_bus), pnv_dt_isa_device, NULL, NULL,=
 NULL,
>                         &args);
>  }
> @@ -545,7 +553,8 @@ static void pnv_reset(MachineState *machine)
> =20
>      qemu_devices_reset();
> =20
> -    /* OpenPOWER systems have a BMC, which can be defined on the
> +    /*
> +     * OpenPOWER systems have a BMC, which can be defined on the
>       * command line with:
>       *
>       *   -device ipmi-bmc-sim,id=3Dbmc0
> @@ -705,7 +714,8 @@ static void pnv_init(MachineState *machine)
> =20
>          pnv->chips[i] =3D PNV_CHIP(chip);
> =20
> -        /* TODO: put all the memory in one node on chip 0 until we find a
> +        /*
> +         * TODO: put all the memory in one node on chip 0 until we find a
>           * way to specify different ranges for each chip
>           */
>          if (i =3D=3D 0) {
> @@ -732,8 +742,10 @@ static void pnv_init(MachineState *machine)
>      /* Create an RTC ISA device too */
>      mc146818_rtc_init(pnv->isa_bus, 2000, NULL);
> =20
> -    /* OpenPOWER systems use a IPMI SEL Event message to notify the
> -     * host to powerdown */
> +    /*
> +     * OpenPOWER systems use a IPMI SEL Event message to notify the
> +     * host to powerdown
> +     */
>      pnv->powerdown_notifier.notify =3D pnv_powerdown_notify;
>      qemu_register_powerdown_notifier(&pnv->powerdown_notifier);
>  }
> @@ -803,7 +815,8 @@ static void pnv_chip_power9_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
>      pnv_cpu->intc =3D obj;
>  }
> =20
> -/* Allowed core identifiers on a POWER8 Processor Chip :
> +/*
> + * Allowed core identifiers on a POWER8 Processor Chip :
>   *
>   * <EX0 reserved>
>   *  EX1  - Venice only
> @@ -928,8 +941,10 @@ static void pnv_chip_power8_realize(DeviceState *dev=
, Error **errp)
>                                              (uint64_t) PNV_XSCOM_BASE(ch=
ip),
>                                              PNV_XSCOM_LPC_BASE);
> =20
> -    /* Interrupt Management Area. This is the memory region holding
> -     * all the Interrupt Control Presenter (ICP) registers */
> +    /*
> +     * Interrupt Management Area. This is the memory region holding
> +     * all the Interrupt Control Presenter (ICP) registers
> +     */
>      pnv_chip_icp_realize(chip8, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -1442,8 +1457,8 @@ static void pnv_machine_class_init(ObjectClass *oc,=
 void *data)
>      mc->init =3D pnv_init;
>      mc->reset =3D pnv_reset;
>      mc->max_cpus =3D MAX_CPUS;
> -    mc->block_default_type =3D IF_IDE; /* Pnv provides a AHCI device for
> -                                      * storage */
> +    /* Pnv provides a AHCI device for storage */
> +    mc->block_default_type =3D IF_IDE;
>      mc->no_parallel =3D 1;
>      mc->default_boot_order =3D NULL;
>      /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl15jjAACgkQbDjKyiDZ
s5LoRRAA50cJCUNaDLeWPrcH2tIxKuCwquWnIsIB822ysWnAEiEx1IbF1Zex/Blg
PXfviaNhSkwJ1wNaRLF8GMEjNxu4rXS/dzgO6sTriqZfOnBqUIe+8N9tZVTKImsn
RXhOukOmg2lNaQXkU9INXVg6x81BiSt9dMwVHF3K+ibhBkwoQC0+7DS0iwYDSEOP
m5MYifxEq8mXSKXLL8qawRhE8MLOg/8jywOoFURRQxrLbBzZGH2/h5oOfLzAFILA
JHkd+sSMErOYYNQcL3knsODvS6iXRc8H7I+x3r4T/VqrQ8uBvUREhNDUzQ2UGTtR
yW6IkfDTJBTmcaMCKOeRWVGJYucBvSe4+WRyPyEkfbHRdf9BB0a42S235MoFY7CC
jVUF4wctmdwf10rl578+t1X+IkiFOO0sqbpVryKI3sJPFhxDI+MfmAJdHuG59eaK
j25PHVbgM9o7t6Z3Cwu/itcHENDxcCI+Rp8zNFZN2FoqxTCWuNpIh8WMLQyK1jJ8
UiTPA0VunERL5It2uWQz8XVXpPKMqUVFzWYywasY7813gx7qW8IiGBS+GAq85CZ7
VUt+SF9LxOgc2oY9mChqR0afa4Be19D/X+xw8oTTImfUj5N6oQ1e5Vq3+LWnFsvZ
brv+EkE3VOqDACIWfgHC1wAkjeMy3LG5BZl0lnb1HoruVkDL0Lc=
=pfF3
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--

