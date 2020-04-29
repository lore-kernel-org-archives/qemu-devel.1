Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CB3C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 01:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC8320731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 01:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="km/jk9VS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC8320731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTbVq-0003qI-Ph
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 21:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jTbVA-00038C-0j
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 21:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jTbV8-0000yW-Li
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 21:27:03 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:33861 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jTbV6-0000sV-BX; Tue, 28 Apr 2020 21:27:02 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49Bgpc4m39z9sSh; Wed, 29 Apr 2020 11:26:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588123608;
 bh=X1FG2Xrbp/WFG9WCdV74JP9krgjN6dmZOFrvUXoK6ZQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=km/jk9VSrglLjP9maRo4Qhnq3OC2z46XWSEomGJF5f7T5wSHiQXKQ8LDZuTj1VYqV
 GB0gtI3mRpFolA+KmgK0dDXPUV21GYDSx9W6rfCfEat8qQTTHOx9Zt5lzg1mXt6rA/
 TRfnchfaFjrj6xkgAotg8djufzBwjH230r/IXxDU=
Date: Wed, 29 Apr 2020 11:22:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 16/17] spapr_pci: Drop some dead error handling
Message-ID: <20200429012257.GA75028@umbus.fritz.box>
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-17-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20200428163419.4483-17-armbru@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: qemu-ppc@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 06:34:18PM +0200, Markus Armbruster wrote:
> chassis_from_bus() uses object_property_get_uint() to get property
> "chassis_nr" of the bridge device.  Failure would be a programming
> error.  Pass &error_abort, and simplify its callers.
>=20
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr_pci.c | 86 ++++++++++------------------------------------
>  1 file changed, 18 insertions(+), 68 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 1d73d05a0a..b6036be51c 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1203,46 +1203,36 @@ static SpaprDrc *drc_from_devfn(SpaprPhbState *ph=
b,
>                             drc_id_from_devfn(phb, chassis, devfn));
>  }
> =20
> -static uint8_t chassis_from_bus(PCIBus *bus, Error **errp)
> +static uint8_t chassis_from_bus(PCIBus *bus)
>  {
>      if (pci_bus_is_root(bus)) {
>          return 0;
>      } else {
>          PCIDevice *bridge =3D pci_bridge_get_device(bus);
> =20
> -        return object_property_get_uint(OBJECT(bridge), "chassis_nr", er=
rp);
> +        return object_property_get_uint(OBJECT(bridge), "chassis_nr",
> +                                        &error_abort);
>      }
>  }
> =20
>  static SpaprDrc *drc_from_dev(SpaprPhbState *phb, PCIDevice *dev)
>  {
> -    Error *local_err =3D NULL;
> -    uint8_t chassis =3D chassis_from_bus(pci_get_bus(dev), &local_err);
> -
> -    if (local_err) {
> -        error_report_err(local_err);
> -        return NULL;
> -    }
> +    uint8_t chassis =3D chassis_from_bus(pci_get_bus(dev));
> =20
>      return drc_from_devfn(phb, chassis, dev->devfn);
>  }
> =20
> -static void add_drcs(SpaprPhbState *phb, PCIBus *bus, Error **errp)
> +static void add_drcs(SpaprPhbState *phb, PCIBus *bus)
>  {
>      Object *owner;
>      int i;
>      uint8_t chassis;
> -    Error *local_err =3D NULL;
> =20
>      if (!phb->dr_enabled) {
>          return;
>      }
> =20
> -    chassis =3D chassis_from_bus(bus, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    chassis =3D chassis_from_bus(bus);
> =20
>      if (pci_bus_is_root(bus)) {
>          owner =3D OBJECT(phb);
> @@ -1256,21 +1246,16 @@ static void add_drcs(SpaprPhbState *phb, PCIBus *=
bus, Error **errp)
>      }
>  }
> =20
> -static void remove_drcs(SpaprPhbState *phb, PCIBus *bus, Error **errp)
> +static void remove_drcs(SpaprPhbState *phb, PCIBus *bus)
>  {
>      int i;
>      uint8_t chassis;
> -    Error *local_err =3D NULL;
> =20
>      if (!phb->dr_enabled) {
>          return;
>      }
> =20
> -    chassis =3D chassis_from_bus(bus, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    chassis =3D chassis_from_bus(bus);
> =20
>      for (i =3D PCI_SLOT_MAX * PCI_FUNC_MAX - 1; i >=3D 0; i--) {
>          SpaprDrc *drc =3D drc_from_devfn(phb, chassis, i);
> @@ -1488,17 +1473,11 @@ int spapr_pci_dt_populate(SpaprDrc *drc, SpaprMac=
hineState *spapr,
>  }
> =20
>  static void spapr_pci_bridge_plug(SpaprPhbState *phb,
> -                                  PCIBridge *bridge,
> -                                  Error **errp)
> +                                  PCIBridge *bridge)
>  {
> -    Error *local_err =3D NULL;
>      PCIBus *bus =3D pci_bridge_get_sec_bus(bridge);
> =20
> -    add_drcs(phb, bus, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    add_drcs(phb, bus);
>  }
> =20
>  static void spapr_pci_plug(HotplugHandler *plug_handler,
> @@ -1529,11 +1508,7 @@ static void spapr_pci_plug(HotplugHandler *plug_ha=
ndler,
>      g_assert(drc);
> =20
>      if (pc->is_bridge) {
> -        spapr_pci_bridge_plug(phb, PCI_BRIDGE(plugged_dev), &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> +        spapr_pci_bridge_plug(phb, PCI_BRIDGE(plugged_dev));
>      }
> =20
>      /* Following the QEMU convention used for PCIe multifunction
> @@ -1560,12 +1535,7 @@ static void spapr_pci_plug(HotplugHandler *plug_ha=
ndler,
>          spapr_drc_reset(drc);
>      } else if (PCI_FUNC(pdev->devfn) =3D=3D 0) {
>          int i;
> -        uint8_t chassis =3D chassis_from_bus(pci_get_bus(pdev), &local_e=
rr);
> -
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> +        uint8_t chassis =3D chassis_from_bus(pci_get_bus(pdev));
> =20
>          for (i =3D 0; i < 8; i++) {
>              SpaprDrc *func_drc;
> @@ -1587,17 +1557,11 @@ out:
>  }
> =20
>  static void spapr_pci_bridge_unplug(SpaprPhbState *phb,
> -                                    PCIBridge *bridge,
> -                                    Error **errp)
> +                                    PCIBridge *bridge)
>  {
> -    Error *local_err =3D NULL;
>      PCIBus *bus =3D pci_bridge_get_sec_bus(bridge);
> =20
> -    remove_drcs(phb, bus, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    remove_drcs(phb, bus);
>  }
> =20
>  static void spapr_pci_unplug(HotplugHandler *plug_handler,
> @@ -1619,11 +1583,7 @@ static void spapr_pci_unplug(HotplugHandler *plug_=
handler,
>      pci_device_reset(PCI_DEVICE(plugged_dev));
> =20
>      if (pc->is_bridge) {
> -        Error *local_err =3D NULL;
> -        spapr_pci_bridge_unplug(phb, PCI_BRIDGE(plugged_dev), &local_err=
);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -        }
> +        spapr_pci_bridge_unplug(phb, PCI_BRIDGE(plugged_dev));
>          return;
>      }
> =20
> @@ -1654,13 +1614,7 @@ static void spapr_pci_unplug_request(HotplugHandle=
r *plug_handler,
>          SpaprDrcClass *func_drck;
>          SpaprDREntitySense state;
>          int i;
> -        Error *local_err =3D NULL;
> -        uint8_t chassis =3D chassis_from_bus(pci_get_bus(pdev), &local_e=
rr);
> -
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> +        uint8_t chassis =3D chassis_from_bus(pci_get_bus(pdev));
> =20
>          if (pc->is_bridge) {
>              error_setg(errp, "PCI: Hot unplug of PCI bridges not support=
ed");
> @@ -1741,7 +1695,7 @@ static void spapr_phb_unrealize(DeviceState *dev)
>          }
>      }
> =20
> -    remove_drcs(sphb, phb->bus, &error_abort);
> +    remove_drcs(sphb, phb->bus);
> =20
>      for (i =3D PCI_NUM_PINS - 1; i >=3D 0; i--) {
>          if (sphb->lsi_table[i].irq) {
> @@ -1980,11 +1934,7 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
>      }
> =20
>      /* allocate connectors for child PCI devices */
> -    add_drcs(sphb, phb->bus, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        goto unrealize;
> -    }
> +    add_drcs(sphb, phb->bus);
> =20
>      /* DMA setup */
>      for (i =3D 0; i < windows_supported; ++i) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6o1u4ACgkQbDjKyiDZ
s5IQhA//T6QKocV6i/rK80uev5aqMWZNWat8PaEG7SSUQ8c3LOEHJrtHJJ1wHyjb
FHi5nBjRgBXI8ZtnuAWXXkFWR3PLLTp+mgH0+8qRsxiz6b9zGlDyj+5R1TqSBtT8
J8rGyishYCKshMo0pvWFysv0F/qEldG1ernpeP7onFRTZH4tN8r8X632nHAeAXrr
37HFibZ+4EJh34rOU0MP14utGZfmJbMPgP8IhnlffIG4voiGQD2CLqCsnStm4U4X
lxR2o/VrWk4orki8hn78k9lUJtHXDpYbQifVAeZIoOwpV2maS7laGTK5zVfcE+6d
a3xH3HYAZxpxyCKHQ+Lk6KYkTSSSRxK1fOt8niChDm8WJQPS7nAxHS7LSttcKdEu
CXO3A14NWnHBy4OfQcNt6JpWVR/pNEbmmhjGqiud+YySzS+/WBnu6xF3nW9gQ9Sw
+ezhXDDFWSI1NDnEppk+0qosAy6Umv+FamhLxLdnrzJJ4iiJNPkBM9DO7wDD/y2M
gUgEP+h9ZQRNZyyypvqeKg6zaxV9qpGkbIKKrJESj8e9gRAjXaJxGiM7b7faL0Xk
FYbe+nEmuIjHd31H0BdCYRFq04TxlLAHT7cFwpkL/XdHQpeN7GcIb63pGxD8nEn5
dJQAkbupyCkrFasYmlJjHqzR3sHkByiJ8IzLR5WycVx2LskFzxw=
=Gadd
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

