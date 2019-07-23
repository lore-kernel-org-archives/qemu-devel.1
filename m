Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D53C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFAEC2238E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hQRQK7RN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFAEC2238E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpnEM-0008CH-Ld
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 01:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39763)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpnCh-00013T-Uv
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpnCg-0003qS-0N
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:19:11 -0400
Received: from ozlabs.org ([203.11.71.1]:45851)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hpnCe-0003nD-9I
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:19:09 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45t6G86368z9sNj; Tue, 23 Jul 2019 15:18:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563859136;
 bh=LVElsxlEjj9eAHx9QwFBDQHB2x3EWkcADiMOuLqBkbc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hQRQK7RNhoYojwH1rk+tC54GBEyqOisNgPXPCTLBy00p1UAk5vK26F4a3h/y6kc29
 J+mwuivdT8sAqB+8T6990OVqd3mu01gUUhPlpHXdneUL3TxLxdTMDRG5suBNUzwfIE
 0DeB10jreTXvvT9O8RA1kMOsz2qF3icMMcoq2rmM=
Date: Tue, 23 Jul 2019 13:57:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Message-ID: <20190723035741.GR25073@umbus.fritz.box>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-6-git-send-email-yi.l.liu@intel.com>
 <20190715025519.GE3440@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A00D8BB@SHSMSX104.ccr.corp.intel.com>
 <20190717030640.GG9123@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A0140E0@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YttKMwf6abDJOSyE"
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A0140E0@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [RFC v1 05/18] vfio/pci: add pasid alloc/free
 implementation
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--YttKMwf6abDJOSyE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 07:02:51AM +0000, Liu, Yi L wrote:
> > From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On B=
ehalf
> > Of David Gibson
> > Sent: Wednesday, July 17, 2019 11:07 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [RFC v1 05/18] vfio/pci: add pasid alloc/free implementati=
on
> >=20
> > On Tue, Jul 16, 2019 at 10:25:55AM +0000, Liu, Yi L wrote:
> > > > From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] =
On
> > Behalf
> > > > Of David Gibson
> > > > Sent: Monday, July 15, 2019 10:55 AM
> > > > To: Liu, Yi L <yi.l.liu@intel.com>
> > > > Subject: Re: [RFC v1 05/18] vfio/pci: add pasid alloc/free implemen=
tation
> > > >
> > > > On Fri, Jul 05, 2019 at 07:01:38PM +0800, Liu Yi L wrote:
> > > > > This patch adds vfio implementation PCIPASIDOps.alloc_pasid/free_=
pasid().
> > > > > These two functions are used to propagate guest pasid allocation =
and
> > > > > free requests to host via vfio container ioctl.
> > > >
> > > > As I said in an earlier comment, I think doing this on the device is
> > > > conceptually incorrect.  I think we need an explcit notion of an SVM
> > > > context (i.e. the namespace in which all the PASIDs live) - which w=
ill
> > > > IIUC usually be shared amongst multiple devices.  The create and fr=
ee
> > > > PASID requests should be on that object.
> > >
> > > Actually, the allocation is not doing on this device. System wide, it=
 is
> > > done on a container. So not sure if it is the API interface gives you=
 a
> > > sense that this is done on device.
> >=20
> > Sorry, I should have been clearer.  I can see that at the VFIO level
> > it is done on the container.  However the function here takes a bus
> > and devfn, so this qemu internal interface is per-device, which
> > doesn't really make sense.
>=20
> Got it. The reason here is to pass the bus and devfn info, so that VFIO
> can figure out a container for the operation. So far in QEMU, there is
> no good way to connect the vIOMMU emulator and VFIO regards to
> SVM.

Right, and I think that's an indication that we're not modelling
something in qemu that we should be.

> hw/pci layer is a choice based on some previous discussion. But
> yes, I agree with you that we may need to have an explicit notion for
> SVM. Do you think it is good to introduce a new abstract layer for SVM
> (may name as SVMContext).

I think so, yes.

If nothing else, I expect we'll need this concept if we ever want to
be able to implement SVM for emulated devices (which could be useful
for debugging, even if it's not something you'd do in production).

> The idea would be that vIOMMU maintain
> the SVMContext instances and expose explicit interface for VFIO to get
> it. Then VFIO register notifiers on to the SVMContext. When vIOMMU
> emulator wants to do PASID alloc/free, it fires the corresponding
> notifier. After call into VFIO, the notifier function itself figure out t=
he
> container it is bound. In this way, it's the duty of vIOMMU emulator to
> figure out a proper notifier to fire. From interface point of view, it is=
 no
> longer per-device.

Exactly.

> Also, it leaves the PASID management details to
> vIOMMU emulator as it can be vendor specific. Does it make sense?
> Also, I'd like to know if you have any other idea on it. That would
> surely be helpful. :-)
>=20
> > > Also, curious on the SVM context
> > > concept, do you mean it a per-VM context or a per-SVM usage context?
> > > May you elaborate a little more. :-)
> >=20
> > Sorry, I'm struggling to find a good term for this.  By "context" I
> > mean a namespace containing a bunch of PASID address spaces, those
> > PASIDs are then visible to some group of devices.
>=20
> I see. May be the SVMContext instance above can include multiple PASID
> address spaces. And again, I think this relationship should be maintained
> in vIOMMU emulator.
>=20
> Thanks,
> Yi Liu
>=20
> >=20
> > >
> > > Thanks,
> > > Yi Liu
> > >
> > > > >
> > > > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > Cc: Peter Xu <peterx@redhat.com>
> > > > > Cc: Eric Auger <eric.auger@redhat.com>
> > > > > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > > > > Cc: David Gibson <david@gibson.dropbear.id.au>
> > > > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > > > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > > > > ---
> > > > >  hw/vfio/pci.c | 61
> > > > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 61 insertions(+)
> > > > >
> > > > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > > > index ce3fe96..ab184ad 100644
> > > > > --- a/hw/vfio/pci.c
> > > > > +++ b/hw/vfio/pci.c
> > > > > @@ -2690,6 +2690,65 @@ static void
> > vfio_unregister_req_notifier(VFIOPCIDevice
> > > > *vdev)
> > > > >      vdev->req_enabled =3D false;
> > > > >  }
> > > > >
> > > > > +static int vfio_pci_device_request_pasid_alloc(PCIBus *bus,
> > > > > +                                               int32_t devfn,
> > > > > +                                               uint32_t min_pasi=
d,
> > > > > +                                               uint32_t max_pasi=
d)
> > > > > +{
> > > > > +    PCIDevice *pdev =3D bus->devices[devfn];
> > > > > +    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> > > > > +    VFIOContainer *container =3D vdev->vbasedev.group->container;
> > > > > +    struct vfio_iommu_type1_pasid_request req;
> > > > > +    unsigned long argsz;
> > > > > +    int pasid;
> > > > > +
> > > > > +    argsz =3D sizeof(req);
> > > > > +    req.argsz =3D argsz;
> > > > > +    req.flag =3D VFIO_IOMMU_PASID_ALLOC;
> > > > > +    req.min_pasid =3D min_pasid;
> > > > > +    req.max_pasid =3D max_pasid;
> > > > > +
> > > > > +    rcu_read_lock();
> > > > > +    pasid =3D ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &re=
q);
> > > > > +    if (pasid < 0) {
> > > > > +        error_report("vfio_pci_device_request_pasid_alloc:"
> > > > > +                     " request failed, contanier: %p", container=
);
> > > > > +    }
> > > > > +    rcu_read_unlock();
> > > > > +    return pasid;
> > > > > +}
> > > > > +
> > > > > +static int vfio_pci_device_request_pasid_free(PCIBus *bus,
> > > > > +                                              int32_t devfn,
> > > > > +                                              uint32_t pasid)
> > > > > +{
> > > > > +    PCIDevice *pdev =3D bus->devices[devfn];
> > > > > +    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> > > > > +    VFIOContainer *container =3D vdev->vbasedev.group->container;
> > > > > +    struct vfio_iommu_type1_pasid_request req;
> > > > > +    unsigned long argsz;
> > > > > +    int ret =3D 0;
> > > > > +
> > > > > +    argsz =3D sizeof(req);
> > > > > +    req.argsz =3D argsz;
> > > > > +    req.flag =3D VFIO_IOMMU_PASID_FREE;
> > > > > +    req.pasid =3D pasid;
> > > > > +
> > > > > +    rcu_read_lock();
> > > > > +    ret =3D ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
> > > > > +    if (ret !=3D 0) {
> > > > > +        error_report("vfio_pci_device_request_pasid_free:"
> > > > > +                     " request failed, contanier: %p", container=
);
> > > > > +    }
> > > > > +    rcu_read_unlock();
> > > > > +    return ret;
> > > > > +}
> > > > > +
> > > > > +static PCIPASIDOps vfio_pci_pasid_ops =3D {
> > > > > +    .alloc_pasid =3D vfio_pci_device_request_pasid_alloc,
> > > > > +    .free_pasid =3D vfio_pci_device_request_pasid_free,
> > > > > +};
> > > > > +
> > > > >  static void vfio_realize(PCIDevice *pdev, Error **errp)
> > > > >  {
> > > > >      VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
> > > > > @@ -2991,6 +3050,8 @@ static void vfio_realize(PCIDevice *pdev, E=
rror
> > **errp)
> > > > >      vfio_register_req_notifier(vdev);
> > > > >      vfio_setup_resetfn_quirk(vdev);
> > > > >
> > > > > +    pci_setup_pasid_ops(pdev, &vfio_pci_pasid_ops);
> > > > > +
> > > > >      return;
> > > > >
> > > > >  out_teardown:
> > > >
> > >
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YttKMwf6abDJOSyE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl02hbUACgkQbDjKyiDZ
s5LSWBAAwQ5upHdyGvRP2wAh73heUVk9nDRZemvfdJzIt9XKNspTs8U5HQifgTAE
uUeG/0zuykWzmfkdblvD22LCE5+PKFWSA2RQpJm7g/XqmWPt6EkFwViX7QkVKgJu
+RCHRtAbw4LS0x5Rav1ginzsKeeAsO8GDJlOupNILe0/fpcHq+DKCZPcJX7HanYH
12yfQLcP0KfaRO0O962kQZ0yekPokvAVHej78Jr0hLRJSTvLtVVmY68/Vz0fZK/y
EoaCgp7r3uBvCa2EAEYXmGONK8IAC7+fier4/BeM6upYQqsh5Ek8LPJiP3LwC1T5
Gw2KLG6sN0NH0mhsDwIOz6c0e9z9pEi5BRVnEFSDCAdR7Ax9XgdQ00salYTfFTgX
qZm4URcpVOc7JRf/yJoJCOzE/jap7zAx+P/4+SLA3odVlftUUtqCFiA7Uz3JjGRc
YgrrJOOiawp3atgmDGw6ne6+AbKKBAbXTcwbX9/VIEwZFViOzH3OZDohKHBBPgmN
gOD9Zy/0GVJpwf5B8TirLEQj2jh9XVCH/D41ly3X8tP/dcGQT4FO6tEEZWEurwLz
hHqyRiBTBhyvIGH/rKZanKH4YSwI5usnpynoGwS4vtadviMUzMJMfB/ee+hUn8rp
OLQ9b43yGIhqSoknxl5SgkBOp8OBRGZkez36JRmX9Xl7HcK0I7M=
=sNH7
-----END PGP SIGNATURE-----

--YttKMwf6abDJOSyE--

