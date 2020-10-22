Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4EBC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 04:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1E0223C7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 04:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="G51U+a6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1E0223C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVS8U-0008Nj-8M
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 00:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kVS2v-0003DI-IT; Thu, 22 Oct 2020 00:17:50 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:40571 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kVS2s-0000F8-C0; Thu, 22 Oct 2020 00:17:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CGvGP1x93z9sTs; Thu, 22 Oct 2020 15:17:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603340253;
 bh=vCTqSf8Vc/aoQdJhGpl7Jm5MX/vp+W4+TpUvOYxqTr0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G51U+a6NYtkAiI38bHsJIVV6cmRDbvvQ0TbCWdeIvymyDRE3uP54opjcvMcFWo5t0
 /bQsA3Oj9gwmyILjBneNH88YXimyv2QvVKnkbXpoP930bdF/WZViZ6OOnsUJTGzd+x
 ULxhCuWhwYv45zMnNzzpp5N06gmAgp46MkNLhgvk=
Date: Thu, 22 Oct 2020 15:06:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/5] pc-dimm: Drop @errp argument of pc_dimm_plug()
Message-ID: <20201022040642.GD1821515@yekko.fritz.box>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
 <160309728447.2739814.12831204841251148202.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Content-Disposition: inline
In-Reply-To: <160309728447.2739814.12831204841251148202.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2020 at 10:48:04AM +0200, Greg Kurz wrote:
> pc_dimm_plug() doesn't use it. It only aborts on error.
>=20
> Drop @errp and adapt the callers accordingly.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/arm/virt.c            |    9 +--------
>  hw/i386/pc.c             |    8 +-------
>  hw/mem/pc-dimm.c         |    2 +-
>  hw/ppc/spapr.c           |    5 +----
>  include/hw/mem/pc-dimm.h |    2 +-
>  5 files changed, 5 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index e465a988d683..27dbeb549ef1 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2261,12 +2261,8 @@ static void virt_memory_plug(HotplugHandler *hotpl=
ug_dev,
>      VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
>      MachineState *ms =3D MACHINE(hotplug_dev);
>      bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> -    Error *local_err =3D NULL;
> =20
> -    pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> +    pc_dimm_plug(PC_DIMM(dev), MACHINE(vms));
> =20
>      if (is_nvdimm) {
>          nvdimm_plug(ms->nvdimms_state);
> @@ -2274,9 +2270,6 @@ static void virt_memory_plug(HotplugHandler *hotplu=
g_dev,
> =20
>      hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
>                           dev, &error_abort);
> -
> -out:
> -    error_propagate(errp, local_err);
>  }
> =20
>  static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index e87be5d29a01..38b1be78e707 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1265,24 +1265,18 @@ static void pc_memory_pre_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
>  static void pc_memory_plug(HotplugHandler *hotplug_dev,
>                             DeviceState *dev, Error **errp)
>  {
> -    Error *local_err =3D NULL;
>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
>      X86MachineState *x86ms =3D X86_MACHINE(hotplug_dev);
>      MachineState *ms =3D MACHINE(hotplug_dev);
>      bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> =20
> -    pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms), &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> +    pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms));
> =20
>      if (is_nvdimm) {
>          nvdimm_plug(ms->nvdimms_state);
>      }
> =20
>      hotplug_handler_plug(x86ms->acpi_dev, dev, &error_abort);
> -out:
> -    error_propagate(errp, local_err);
>  }
> =20
>  static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index c30351070bb8..2ffc986734df 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -64,7 +64,7 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState =
*machine,
>                             errp);
>  }
> =20
> -void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **err=
p)
> +void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine)
>  {
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *vmstate_mr =3D ddc->get_vmstate_memory_region(dimm,
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ee716a12af73..4edd31b86915 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3438,10 +3438,7 @@ static void spapr_memory_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
> =20
>      size =3D memory_device_get_region_size(MEMORY_DEVICE(dev), &error_ab=
ort);
> =20
> -    pc_dimm_plug(dimm, MACHINE(ms), &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> +    pc_dimm_plug(dimm, MACHINE(ms));
> =20
>      if (!is_nvdimm) {
>          addr =3D object_property_get_uint(OBJECT(dimm),
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index aec9527fdd96..3d3db82641f8 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -72,6 +72,6 @@ struct PCDIMMDeviceClass {
> =20
>  void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
>                        const uint64_t *legacy_align, Error **errp);
> -void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **err=
p);
> +void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine);
>  void pc_dimm_unplug(PCDIMMDevice *dimm, MachineState *machine);
>  #endif
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+RBVIACgkQbDjKyiDZ
s5J9ARAAxDdyZpXQCoiYkTWtPflaiZzu6HqfbQWMoFfMdKTZS9lAF3GLInFKwZ+K
Gx5IBK7dVD/nf5bafaXKxUPD6gmWP7+eFIhkCWKcMQY7I8X1XfDK5NhsYvt6WkQ2
V4nKPGRoEJfFMCBIfBzuLLrMJTGVaP0Ksv50AyXr98olRfxoz5XrEPQQbyk+qycS
LIXlcgPOiKkX0os6ApPBLu9KKjg/iz6W5wLT0bC6f86z7GjkGRJ2EJsr4QZaKFG+
B8vyXP7gCEB78PUfESL7H6uXgBBBF7XbvhreboYufhW2j4iX4eQEtSm8KE828d0h
3NzxIzmbzpDeRTSqKSaQS/lbozm27LuVQ0FO1Hfdyxyy2RR0eama+v9E0kKQDJgX
qdU0exXRiS9kPkuSXv0OHmkdUjsS2ifAvvtfqeOsJ1bRZmzxZY5f6aUVsJZGGpr8
7M3ZOG+au8M3nx6i92iqsVttVDebtQt+JKBEWmmo+ojgOvfGwZ0Bca7LwM6Cxu4j
EIPh4ly8cyY+qycoSuZ7RNYK+z6dNzDAlGs6589Ju5/4bOMEa9Dm9SzPHft/laro
NEqiEtHN9u1Iu+lLwjNdOGDEhsz531xeAQyljRKJrh6n7Z+llpWMavJRXmMI6+dR
evSTuaqK1K335y8skpyJzrOYC/aMugtH7tKkIxOTcclaA00aORA=
=+7lV
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--

