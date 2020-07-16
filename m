Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734F9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 05:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE53F2071B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 05:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QMVZFlnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE53F2071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvwJv-0007Kk-4q
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 01:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jvwIx-0006P4-Fi; Thu, 16 Jul 2020 01:19:35 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jvwIu-00037H-Iv; Thu, 16 Jul 2020 01:19:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B6jH15PHkz9sRK; Thu, 16 Jul 2020 15:19:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594876765;
 bh=eSVibqFfwX0wnKEcH9EVCefqRsKR8civRCJcYFKTTj0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QMVZFlnw5UDLf+V3EDbTmAyHcfSZpqjGJHgUKnAFL4iXUOq4omPIiL0aLeBV9Pzfa
 OpcfQBrsBSVUeV/ya0lhsyLYybpfeq8KAb97RRFE5JEGhayZLrjZn21KuSeWT/rD9Q
 TTqSSNEt61AnkiCaC+J5R4FuTJC/9gryPwBWbA5E=
Date: Thu, 16 Jul 2020 14:45:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr_pci: Robustify support of PCI bridges
Message-ID: <20200716044540.GL93134@umbus.fritz.box>
References: <159431476748.407044.16711294833569014964.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OGW1Z2JKiS9bXo17"
Content-Disposition: inline
In-Reply-To: <159431476748.407044.16711294833569014964.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--OGW1Z2JKiS9bXo17
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2020 at 07:12:47PM +0200, Greg Kurz wrote:
> Some recent error handling cleanups unveiled issues with our support of
> PCI bridges:
>=20
> 1) QEMU aborts when using non-standard PCI bridge types,
>    unveiled by commit 7ef1553dac "spapr_pci: Drop some dead error handlin=
g"
>=20
> $ qemu-system-ppc64 -M pseries -device pcie-pci-bridge
> Unexpected error in object_property_find() at qom/object.c:1240:
> qemu-system-ppc64: -device pcie-pci-bridge: Property '.chassis_nr' not fo=
und
> Aborted (core dumped)

Oops, I thought we had a check that we actually had a "pci-bridge"
device before continuing with the hotplug, but I guess not.

> This happens because we assume all PCI bridge types to have a "chassis_nr"
> property. This property only exists with the standard PCI bridge type
> "pci-bridge" actually. We could possibly revert 7ef1553dac but it seems
> much simpler to check the presence of "chassis_nr" earlier.

Hrm, right, 7ef1553dac was not really correct since add_drcs() really
can fail.

> 2) QEMU abort if same "chassis_nr" value is used several times,
>    unveiled by commit d2623129a7de "qom: Drop parameter @errp of
>    object_property_add() & friends"
>=20
> $ qemu-system-ppc64 -M pseries -device pci-bridge,chassis_nr=3D1 \
>                         -device pci-bridge,chassis_nr=3D1
> Unexpected error in object_property_try_add() at qom/object.c:1167:
> qemu-system-ppc64: -device pci-bridge,chassis_nr=3D1: attempt to add dupl=
icate property '40000100' to object (type 'container')
> Aborted (core dumped)
>=20
> This happens because we assume that "chassis_nr" values are unique, but
> nobody enforces that and we end up generating duplicate DRC ids. The PCI
> code doesn't really care for duplicate "chassis_nr" properties since it
> is only used to initialize the "Chassis Number Register" of the bridge,
> with no functional impact on QEMU. So, even if passing the same value
> several times might look weird, it never broke anything before, so
> I guess we don't necessarily want to enforce strict checking in the PCI
> code now.

Yeah, I guess.  I'm pretty sure that the chassis number of bridges is
supposed to be system-unique (well, unique within the PCI domain at
least, I guess) as part of the hardware spec.  So specifying multiple
chassis ids the same is a user error, but we need a better failure
mode.

> Workaround both issues in the PAPR code: check that the bridge has a
> unique and non null "chassis_nr" when plugging it into its parent bus.
>
> Fixes: 05929a6c5dfe ("spapr: Don't use bus number for building DRC ids")

Arguably, it's really fixing 7ef1553dac.

> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

I had a few misgivings about the details of this, but I think I've
convinced myself they're fine.  There's a couple of things I'd like to
polish, but I'll do that as a follow up.

> ---
>  hw/ppc/spapr_pci.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 57 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 329002ac040e..09d52ef7954d 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1480,6 +1480,57 @@ static void spapr_pci_bridge_plug(SpaprPhbState *p=
hb,
>      add_drcs(phb, bus);
>  }
> =20
> +/* Returns non-zero if the value of "chassis_nr" is already in use */
> +static int check_chassis_nr(Object *obj, void *opaque)
> +{
> +    int new_chassis_nr =3D
> +        object_property_get_uint(opaque, "chassis_nr", &error_abort);
> +    int chassis_nr =3D
> +        object_property_get_uint(obj, "chassis_nr", NULL);
> +
> +    if (!object_dynamic_cast(obj, TYPE_PCI_BRIDGE)) {
> +        return 0;
> +    }
> +
> +    /* Skip unsupported bridge types */
> +    if (!chassis_nr) {
> +        return 0;
> +    }
> +
> +    /* Skip self */
> +    if (obj =3D=3D opaque) {
> +        return 0;
> +    }
> +
> +    return chassis_nr =3D=3D new_chassis_nr;
> +}
> +
> +static bool bridge_has_valid_chassis_nr(Object *bridge, Error **errp)
> +{
> +    int chassis_nr =3D
> +        object_property_get_uint(bridge, "chassis_nr", NULL);
> +
> +    /*
> +     * slotid_cap_init() already ensures that "chassis_nr" isn't null for
> +     * standard PCI bridges, so this really tells if "chassis_nr" is pre=
sent
> +     * or not.
> +     */
> +    if (!chassis_nr) {
> +        error_setg(errp, "PCI Bridge lacks a \"chassis_nr\" property");
> +        error_append_hint(errp, "Try -device pci-bridge instead.\n");
> +        return false;
> +    }
> +
> +    /* We want unique values for "chassis_nr" */
> +    if (object_child_foreach_recursive(object_get_root(), check_chassis_=
nr,
> +                                       bridge)) {
> +        error_setg(errp, "Bridge chassis %d already in use", chassis_nr);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  static void spapr_pci_plug(HotplugHandler *plug_handler,
>                             DeviceState *plugged_dev, Error **errp)
>  {
> @@ -1491,6 +1542,12 @@ static void spapr_pci_plug(HotplugHandler *plug_ha=
ndler,
>      PCIBus *bus =3D PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
>      uint32_t slotnr =3D PCI_SLOT(pdev->devfn);
> =20
> +    if (pc->is_bridge) {
> +        if (!bridge_has_valid_chassis_nr(OBJECT(plugged_dev), errp)) {
> +            return;
> +        }
> +    }
> +
>      /* if DR is disabled we don't need to do anything in the case of
>       * hotplug or coldplug callbacks
>       */
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OGW1Z2JKiS9bXo17
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8P23EACgkQbDjKyiDZ
s5Jomg//WSZyAtCFIqaO+EBjrxUR7lgx4ZTbASKJnY34lbNqiRYwvRWEKPitKUe5
yvMExeUHsiDbpPzW3+ObA842bmq+ZPIhghmidwqaOumZ0mEhbaBDzWwzs2I0EXn3
4a0gE6OHpcxmRLoRAjjXlOShnAHicIxgTzbQAXDmDL0NsFTrm9Fn4dMJHN9HIP2L
uWkrwKe9RMVbqlmuwRe2fQmjfu8y5q3Y/pjf5k4oHfd4rO5iqreGkkAthzo/tQ0W
1CNafVH5slq0uND/o44yIlDifWZXoq7v/OfODErbXLb1yh0Il/ehDyCzeWEq3F8n
qxW2NnbRtPPtj4xoOTPDmDa+1m7Er75eFqFZUsq1fEf43D3DTvvhXLvH2250yMnm
nQc7W6cpSEvyf8/QnTJ3JhMgAf4dw6f7npQerA4FIqND7DVFNexOvUZY12nfTWww
+bitBdvLUmCZyT7CIa8rf3YCRyFNO4xWY3B9I4RwRSpwEB5Ps3Mwc1hSami34H9O
ikwe9/6jzihZUm6lEnk8CVWaXYYD+rcR8re8c7CGtHbKb9M0c1ldcZEHfjgCNXIJ
47BI/WvRwoxd7xf40uMnCY3YrYMNpDWn2hf8ZKyMDQRDR0tYETWkXNYK0Vdkw5xR
NCxrOQOROhQBKdAfeWFL+BR/yEcDGNhlqkacG6HPj8zkws0AeRE=
=4tZI
-----END PGP SIGNATURE-----

--OGW1Z2JKiS9bXo17--

