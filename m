Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7644C3B18F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 02:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7538C217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 02:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Wi98cYTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7538C217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Qkn-0007Mm-OB
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 21:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j2Qjb-0006Qv-RX
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 21:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j2Qja-0002Qp-Dx
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 21:29:39 -0500
Received: from ozlabs.org ([203.11.71.1]:60515)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j2QjZ-0002GP-Fk; Thu, 13 Feb 2020 21:29:38 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48Jclf0rg0z9sRl; Fri, 14 Feb 2020 13:29:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581647374;
 bh=gD9io34RoQhh+1Ad1HH5FMiu6QsG3KLr1tYI7B06P8g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Wi98cYTsEr8V+inbxCs5S3AggNNNtAfqnkSt/DnwKm/KRcEHKLdgpiulb9SWt5sJN
 5KvhWRJzrIlmvoWSugEUVkIMQSVcGtNf/Rs0lLGyBmm7uz4kW6ti+1H1iL/nA75zwc
 7wmboHSdH7K8PBCDfMvKPFWY+wFOdwsmmLtMChdU=
Date: Fri, 14 Feb 2020 13:29:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 3/3] spapr: Migrate SpaprDrc::unplug_requested
Message-ID: <20200214022900.GK124369@umbus.fritz.box>
References: <158076936422.2118610.5626450767672103134.stgit@bahia.lan>
 <158076938222.2118610.14456984179352959929.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Content-Disposition: inline
In-Reply-To: <158076938222.2118610.14456984179352959929.stgit@bahia.lan>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5dNcufZ4prhark0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2020 at 11:36:22PM +0100, Greg Kurz wrote:
> Hot unplugging a device is an asynchronous operation. If the guest is
> migrated after the event was sent but before it could release the
> device with RTAS, the destination QEMU doesn't know about the pending
> unplug operation and doesn't actually remove the device when the guest
> finally releases it. The device
>=20
> Migrate SpaprDrc::unplug_requested to fix the inconsistency. This is
> done with a subsection that is only sent if an unplug request is
> pending. This allows to preserve migration with older guests in the
> case of a pending hotplug request. This will cause migration to fail
> if the destination can't handle the subsection, but this is better
> than ending with an inconsistency.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr_drc.c |   27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index d512ac6e1e7f..6f5cab70fc6b 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -455,6 +455,22 @@ void spapr_drc_reset(SpaprDrc *drc)
>      }
>  }
> =20
> +static bool spapr_drc_unplug_requested_needed(void *opaque)
> +{
> +    return spapr_drc_unplug_requested(opaque);
> +}
> +
> +static const VMStateDescription vmstate_spapr_drc_unplug_requested =3D {
> +    .name =3D "spapr_drc/unplug_requested",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_drc_unplug_requested_needed,
> +    .fields  =3D (VMStateField []) {
> +        VMSTATE_BOOL(unplug_requested, SpaprDrc),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static bool spapr_drc_needed(void *opaque)
>  {
>      SpaprDrc *drc =3D (SpaprDrc *)opaque;
> @@ -467,8 +483,11 @@ static bool spapr_drc_needed(void *opaque)
>      /*
>       * We need to migrate the state if it's not equal to the expected
>       * long-term state, which is the same as the coldplugged initial
> -     * state */
> -    return !spapr_drc_device_ready(drc);
> +     * state, or if an unplug request is pending.
> +     */
> +    return
> +        spapr_drc_unplug_requested_needed(drc) ||
> +        !spapr_drc_device_ready(drc);

Hrm.  You start the series by splitting spapr_drc_device_ready() from
spapr_drc_needed().  But at this point, I'm pretty sure you've now got
all the callers of spapr_drc_device_ready() doing equivalent logic
about them, so they might as well be one function again.  That seems
pretty roundabout.

I don't think the rationale for not using the drc_ready function from
the CAS path really makes sense.  It's not just an accident that those
use the same logic - in both cases what we're testing is "Is the DRC
in a state other than that of a default cold-plugged device?".

Changing the name might be sensible, but I still think we want a
common function for the two cases.

>  }
> =20
>  static const VMStateDescription vmstate_spapr_drc =3D {
> @@ -479,6 +498,10 @@ static const VMStateDescription vmstate_spapr_drc =
=3D {
>      .fields  =3D (VMStateField []) {
>          VMSTATE_UINT32(state, SpaprDrc),
>          VMSTATE_END_OF_LIST()
> +    },
> +    .subsections =3D (const VMStateDescription * []) {
> +        &vmstate_spapr_drc_unplug_requested,
> +        NULL
>      }
>  };
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5GBekACgkQbDjKyiDZ
s5KvbxAAyxmpMOhRypSh4tt3BJnCN/uVdRUjJrzEcnb41mG4u1x0PVoOFtNrNijR
Z3OFjSOnO0lUOM48FrQjXnvkGHYtWWb974PGMYbnO7jrcMkvnoaWn4wj/2wtOKCj
sMwrXzArxL3oUB4CZ2cuqrsRhOJXCTG/D2h1G0O7hUUTSXwUZ3mpawjo2GbsqvEF
hND2MBo7mVEIml3RvAM5ftRjCyfLXjnYY1K/fxm067w6yRiHhke/f821EvVmkFoG
aoLKeeGlsfpMHzCE4vss8akN8e7ajfj1oCfVOPJWTcxduI48XG54COF9pdojiFC3
ZqFGGn6srbBgaVMraPdvJUIv7VWN8gLum9hQcbFZ2usYfhDkQTzxPy8HevQt5W5R
YR72lErK9jDIIF75O6YVLG7BN9ukSlFe1WpGTohR90wFcV9UOSfE7/40yRfmP4nc
pA8A6ktyU30Tlvwfxwo2XTzaMMFNPrYBkJzPtOqPEy8DS1EFtD+zKwxJGjeRSyMy
j4phM1yDCDY+u5pU/Y81JeHBlJGD7nNP9xjkLjL6v6FP/k8ZLyDIrI8yHnGLiIDZ
XNdSCMjA/cvpICqbk2tHyRyFrjr/Uwk+A3UJ8QnoEq2ZSP/RT6kVcXWUiHs5rE8Z
VcfKEwnh3xT7aQJZz64s34UjVX7+TMC1OSQVq7QYC0EI5jOCQVw=
=Tj9N
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--

