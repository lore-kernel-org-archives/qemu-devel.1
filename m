Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8B8C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 03:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750922244A
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 03:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="RXT8G0N9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750922244A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXGtM-0007Ci-KG
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 22:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXGsG-00063C-1X
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 22:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXGsE-00020k-J7
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 22:41:47 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:38515)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXGsD-0001vv-RH; Tue, 19 Nov 2019 22:41:46 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47HpQV2ngLz9sPf; Wed, 20 Nov 2019 14:41:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574221298;
 bh=+4M7v6QcHPgr8jDHobnTfot9DkUYJ8C0PIZQx9eEHOQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RXT8G0N9eAFp4rW8umgwY252V+6lXVzWAJoQE3FOjd1dOiNBKf4F7EV+b6EhSD3bs
 6hWyTE9UzFYeKUHHUApEmP4pLwhJbiTUocP6TvneWaY2Kgrug4KxRvoMOn7htPHQBm
 sv4T4HqQmGcGUuzQf8EYgR3e6erWL7nHFourMK5s=
Date: Wed, 20 Nov 2019 14:34:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC 3/5] vfio/pci: Respond to KVM irqchip change notifier
Message-ID: <20191120033412.GC5582@umbus.fritz.box>
References: <20191017054218.8876-1-david@gibson.dropbear.id.au>
 <20191017054218.8876-4-david@gibson.dropbear.id.au>
 <20191017142845.5d4d9121@x1.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YLwdFo+Xu6B7B0Yp"
Content-Disposition: inline
In-Reply-To: <20191017142845.5d4d9121@x1.home>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org,
 groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--YLwdFo+Xu6B7B0Yp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 02:28:45PM -0600, Alex Williamson wrote:
> On Thu, 17 Oct 2019 16:42:16 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > VFIO PCI devices already respond to the pci intx routing notifier, in o=
rder
> > to update kernel irqchip mappings when routing is updated.  However this
> > won't handle the case where the irqchip itself is replaced by a differe=
nt
> > model while retaining the same routing.  This case can happen on
> > the pseries machine type due to PAPR feature negotiation.
> >=20
> > To handle that case, add a handler for the irqchip change notifier, whi=
ch
> > does much the same thing as the routing notifier, but is unconditional,
> > rather than being a no-op when the routing hasn't changed.
> >=20
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/vfio/pci.c | 12 ++++++++++++
> >  hw/vfio/pci.h |  2 ++
> >  2 files changed, 14 insertions(+)
> >=20
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 529ad13908..6aa806baff 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -255,6 +255,14 @@ static void vfio_intx_routing_notifier(PCIDevice *=
pdev)
> >      }
> >  }
> > =20
> > +static void vfio_irqchip_change(Notifier *notify, void *data)
> > +{
> > +    VFIOPCIDevice *vdev =3D container_of(notify, VFIOPCIDevice,
> > +                                       irqchip_change_notifier);
> > +
> > +    vfio_intx_update(vdev, &vdev->intx.route);
> > +}
> > +
> >  static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
> >  {
> >      uint8_t pin =3D vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PI=
N, 1);
> > @@ -2960,6 +2968,8 @@ static void vfio_realize(PCIDevice *pdev, Error *=
*errp)
> >                                                    vfio_intx_mmap_enabl=
e, vdev);
> >          pci_device_set_intx_routing_notifier(&vdev->pdev,
> >                                               vfio_intx_routing_notifie=
r);
> > +        vdev->irqchip_change_notifier.notify =3D vfio_irqchip_change;
> > +        kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier=
);
> >          ret =3D vfio_intx_enable(vdev, errp);
> >          if (ret) {
> >              goto out_teardown;
> > @@ -3009,6 +3019,7 @@ static void vfio_realize(PCIDevice *pdev, Error *=
*errp)
> > =20
> >  out_teardown:
> >      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> > +    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
>=20
> We can get here without having added the irqchip notifier and I don't
> think QLIST_REMOVE is very friendly with gratuitous calls.

Good point, adjusted.


> >      vfio_teardown_msi(vdev);
> >      vfio_bars_exit(vdev);
> >  error:
> > @@ -3042,6 +3053,7 @@ static void vfio_exitfn(PCIDevice *pdev)
> >      vfio_unregister_req_notifier(vdev);
> >      vfio_unregister_err_notifier(vdev);
> >      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> > +    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
>=20
> Same here.  Otherwise the approach looks sane to me.  Thanks,
>=20
> Alex
>=20
> >      vfio_disable_interrupts(vdev);
> >      if (vdev->intx.mmap_timer) {
> >          timer_free(vdev->intx.mmap_timer);
> > diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> > index 834a90d646..11324f28ce 100644
> > --- a/hw/vfio/pci.h
> > +++ b/hw/vfio/pci.h
> > @@ -168,6 +168,8 @@ typedef struct VFIOPCIDevice {
> >      bool no_vfio_ioeventfd;
> >      bool enable_ramfb;
> >      VFIODisplay *dpy;
> > +
> > +    Notifier irqchip_change_notifier;
> >  } VFIOPCIDevice;
> > =20
> >  uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YLwdFo+Xu6B7B0Yp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3UtDQACgkQbDjKyiDZ
s5JSoQ//Y54FHdHeMarLaFRjpgqL5QHDvpHlBpGDPpL2V/JbgJg7afRIOyaFmDc+
pbROcZ01Ey2cIqY1kgW/gADLUvJUMKd2vGXaLxaVcs1m/kWRrzSkp1Ote48OLNVz
ug9VIZz9EoJ5u6J9lJUDUebblLs4VlAu81X00qUUubdBOZeFgZ0/6WofADRj6IPY
iQt5F6i9RrYrPKZfMSou3rahjjtbEcHPW6Nn8OpjZjusP4bAf7WPY7Hr77vvU/ns
Wti3ZeV271I9g2Yjnjj9fnbe489JgrPvUFvrFfpRkx8kuoy1BVbWrsvFkWE/Jew/
iRMMgkuWULZ0UPMFryPON4sDCasbGoU2JS/uU56aC9RanmuNSWPi/Q1u3dSYZSwK
QyPFwQ4M4DlkOLHH+YiJ5dscUm2zJjBvhA3wN0CTq0WYZWCzgi2z3YU1WOZyWxgt
hMcfu1AOdHDddfCoz6l2odG7TQ3UTmFWKknCH5FiurmHPutAL8AherYfb5hu/Cid
9heosyZ6AUSMQMu50inJ+gQFsm/RC8bd63YHNU5j8j4P4a00aD697yCDt+/6Zwb4
bCun3qUWQbTBzRPtITalbLSI7K/7vcREiHHVhO7fxPriPUAuZ9yCqgEG/kuvZCcJ
9fJvMI7fjihRMxH0v+NEm2fxlzRCKSX7/4S8ZmgfLtPlg4kM4VI=
=Wzxg
-----END PGP SIGNATURE-----

--YLwdFo+Xu6B7B0Yp--

