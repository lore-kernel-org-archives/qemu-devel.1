Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD3EC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705D321741
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PvCW0hhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705D321741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8Te-0003pw-JZ
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 20:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kS8RL-00022F-Vv; Mon, 12 Oct 2020 20:45:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40651 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kS8RI-0006nB-PJ; Mon, 12 Oct 2020 20:45:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C9GzQ2BSMz9sTr; Tue, 13 Oct 2020 11:45:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602549906;
 bh=zrJC4/XM7vp0rKB+BrrmR5YCjnp1blrizVpNcbzZTAA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PvCW0hhhPoMTJPhJku7gGwOxe29R1WHbvo87GWhFkIgPb6j2NzhzvTngIjlV1hWb9
 x9EbjdkxDSNcw+TvyD7mkqicHSOvpVSQNNRTMjFrFZuZ3hc5xo9B+STK1EiC85OmJ3
 KAdf+D6u1Dx0AzRjuTUeokOwYD9wpBIJTzpG1uWg=
Date: Tue, 13 Oct 2020 11:40:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr: Move spapr_create_nvdimm_dr_connectors() to core
 machine code
Message-ID: <20201013004014.GF71119@yekko.fritz.box>
References: <160249772183.757627.7396780936543977766.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Content-Disposition: inline
In-Reply-To: <160249772183.757627.7396780936543977766.stgit@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 20:45:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2020 at 12:15:21PM +0200, Greg Kurz wrote:
> The spapr_create_nvdimm_dr_connectors() function doesn't need to access
> any internal details of the sPAPR NVDIMM implementation. Also, pretty
> much like for the LMBs, only spapr_machine_init() is responsible for the
> creation of DR connectors for NVDIMMs.
>=20
> Make this clear by making this function static in hw/ppc/spapr.c.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Hrm, I'm not really seeing the advantage to moving this.  It doesn't
have to be in spapr_nvdimm for data hiding, but it is related, and
spapr.c is kind of huge.

> ---
>  hw/ppc/spapr.c                |   10 ++++++++++
>  hw/ppc/spapr_nvdimm.c         |   11 -----------
>  include/hw/ppc/spapr_nvdimm.h |    1 -
>  3 files changed, 10 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 63315f2d0fa9..ee716a12af73 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2641,6 +2641,16 @@ static hwaddr spapr_rma_size(SpaprMachineState *sp=
apr, Error **errp)
>      return rma_size;
>  }
> =20
> +static void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
> +{
> +    MachineState *machine =3D MACHINE(spapr);
> +    int i;
> +
> +    for (i =3D 0; i < machine->ram_slots; i++) {
> +        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, i);
> +    }
> +}
> +
>  /* pSeries LPAR / sPAPR hardware init */
>  static void spapr_machine_init(MachineState *machine)
>  {
> diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> index b3a489e9fe18..9e3d94071fe1 100644
> --- a/hw/ppc/spapr_nvdimm.c
> +++ b/hw/ppc/spapr_nvdimm.c
> @@ -106,17 +106,6 @@ void spapr_add_nvdimm(DeviceState *dev, uint64_t slo=
t, Error **errp)
>      }
>  }
> =20
> -void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
> -{
> -    MachineState *machine =3D MACHINE(spapr);
> -    int i;
> -
> -    for (i =3D 0; i < machine->ram_slots; i++) {
> -        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, i);
> -    }
> -}
> -
> -
>  static int spapr_dt_nvdimm(SpaprMachineState *spapr, void *fdt,
>                             int parent_offset, NVDIMMDevice *nvdimm)
>  {
> diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
> index b834d82f5545..490b19a009f4 100644
> --- a/include/hw/ppc/spapr_nvdimm.h
> +++ b/include/hw/ppc/spapr_nvdimm.h
> @@ -31,6 +31,5 @@ void spapr_dt_persistent_memory(SpaprMachineState *spap=
r, void *fdt);
>  bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nv=
dimm,
>                             uint64_t size, Error **errp);
>  void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
> -void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr);
> =20
>  #endif
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+E924ACgkQbDjKyiDZ
s5LqRBAA5XnZIAPbLhPSqtqD/+sCZ1bDPvvwoRJkgu6zw1geiOd9h4ccYwOa+dVQ
y7rOAcWE9Sw3ViUlRAlM3pfpGfg8/zgnh7Ii1yE80Y8oVM4sGv0SdmZ/aKRgVWpX
G6p2jvpPVqbZZoKN4RuK2RUGZIZtirUnkjhzW840Hfx9TgAizL4TkGPyoOMAwrzq
k1a4oFYqMsrm+XhJjP6EZ9XkxgM9BJTd69MkcFXUayHMQ7/URGM2S54fHYiWptDO
o3JEtNmo04ywlwEk7FQy6017hYw/TWpmuMbgOjauP0bpna8YwbvtM3scF3Y78WwX
OLqllSsp8GfFHYA8k7T7+RjCd9aefedmX17VgLxlxINHeS3qKhFpIGO4LoLlybMm
Xw5ccINYbMhdisyOUFNfN2bO7SpNqShWusTFn/F7yzErt1Lv8uIMzvYNjGM9oTgk
kJ6DEMlF1FfywP0cIA7xAHZ0/f08mt4PfmeDwjraKDAQ0VUMeCw+fk6v4a04M+91
s9p41U/4UAc47v+2+96GTOZVoyRmkPwsFl4S1JY4uuWl0UFbLh73cI7XABIkvQ5e
BCoFh8qlK9dQGWqh2Jfpyqda+j5PbmQ076AI0GEIab5QTdt9ZMoFuW7YoG2IWJaa
Yvh7BDjsPbYcmnfC/mwZUE1C8iAok8tXjos8e1zTsmbRtBfv5ew=
=AYJy
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--

