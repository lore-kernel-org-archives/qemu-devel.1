Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1655EC76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 03:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3177206C2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 03:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oUJy9PWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3177206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnaog-0007bW-1m
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 23:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42579)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnao6-0005Ph-2q
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 23:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnao4-0003il-1h
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 23:40:41 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:39391 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hnao0-0003fp-9u
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 23:40:39 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45pNMJ382Vz9sMr; Wed, 17 Jul 2019 13:40:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563334828;
 bh=Ret0oPXowbQTaOVdrvg5u5rp5U7wsx0cuSJ0v6EuZtc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oUJy9PWaaF09mgy0Vh4rs7naRZOj8bsbVncQa/uLEToD/GOqK+oiaT9XuEFl/vPcE
 zU1M94rl95Ym8iad1SvEKrHwrc5gH3deHT7rAGTHP9TGRNCrryX+7sdEjTgxEalMaU
 2Q/XyTnPaxUQzgl5FyqXh9ejEtcIybCLUzpUkEpY=
Date: Wed, 17 Jul 2019 13:06:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Message-ID: <20190717030640.GG9123@umbus.fritz.box>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-6-git-send-email-yi.l.liu@intel.com>
 <20190715025519.GE3440@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A00D8BB@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5L6AZ1aJH5mDrqCQ"
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A00D8BB@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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


--5L6AZ1aJH5mDrqCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2019 at 10:25:55AM +0000, Liu, Yi L wrote:
> > From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On B=
ehalf
> > Of David Gibson
> > Sent: Monday, July 15, 2019 10:55 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [RFC v1 05/18] vfio/pci: add pasid alloc/free implementati=
on
> >=20
> > On Fri, Jul 05, 2019 at 07:01:38PM +0800, Liu Yi L wrote:
> > > This patch adds vfio implementation PCIPASIDOps.alloc_pasid/free_pasi=
d().
> > > These two functions are used to propagate guest pasid allocation and
> > > free requests to host via vfio container ioctl.
> >=20
> > As I said in an earlier comment, I think doing this on the device is
> > conceptually incorrect.  I think we need an explcit notion of an SVM
> > context (i.e. the namespace in which all the PASIDs live) - which will
> > IIUC usually be shared amongst multiple devices.  The create and free
> > PASID requests should be on that object.
>=20
> Actually, the allocation is not doing on this device. System wide, it is
> done on a container. So not sure if it is the API interface gives you a
> sense that this is done on device.

Sorry, I should have been clearer.  I can see that at the VFIO level
it is done on the container.  However the function here takes a bus
and devfn, so this qemu internal interface is per-device, which
doesn't really make sense.

> Also, curious on the SVM context
> concept, do you mean it a per-VM context or a per-SVM usage context?
> May you elaborate a little more. :-)

Sorry, I'm struggling to find a good term for this.  By "context" I
mean a namespace containing a bunch of PASID address spaces, those
PASIDs are then visible to some group of devices.

>=20
> Thanks,
> Yi Liu
>=20
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Eric Auger <eric.auger@redhat.com>
> > > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > > Cc: David Gibson <david@gibson.dropbear.id.au>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > > ---
> > >  hw/vfio/pci.c | 61
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 61 insertions(+)
> > >
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > index ce3fe96..ab184ad 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -2690,6 +2690,65 @@ static void vfio_unregister_req_notifier(VFIOP=
CIDevice
> > *vdev)
> > >      vdev->req_enabled =3D false;
> > >  }
> > >
> > > +static int vfio_pci_device_request_pasid_alloc(PCIBus *bus,
> > > +                                               int32_t devfn,
> > > +                                               uint32_t min_pasid,
> > > +                                               uint32_t max_pasid)
> > > +{
> > > +    PCIDevice *pdev =3D bus->devices[devfn];
> > > +    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> > > +    VFIOContainer *container =3D vdev->vbasedev.group->container;
> > > +    struct vfio_iommu_type1_pasid_request req;
> > > +    unsigned long argsz;
> > > +    int pasid;
> > > +
> > > +    argsz =3D sizeof(req);
> > > +    req.argsz =3D argsz;
> > > +    req.flag =3D VFIO_IOMMU_PASID_ALLOC;
> > > +    req.min_pasid =3D min_pasid;
> > > +    req.max_pasid =3D max_pasid;
> > > +
> > > +    rcu_read_lock();
> > > +    pasid =3D ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
> > > +    if (pasid < 0) {
> > > +        error_report("vfio_pci_device_request_pasid_alloc:"
> > > +                     " request failed, contanier: %p", container);
> > > +    }
> > > +    rcu_read_unlock();
> > > +    return pasid;
> > > +}
> > > +
> > > +static int vfio_pci_device_request_pasid_free(PCIBus *bus,
> > > +                                              int32_t devfn,
> > > +                                              uint32_t pasid)
> > > +{
> > > +    PCIDevice *pdev =3D bus->devices[devfn];
> > > +    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> > > +    VFIOContainer *container =3D vdev->vbasedev.group->container;
> > > +    struct vfio_iommu_type1_pasid_request req;
> > > +    unsigned long argsz;
> > > +    int ret =3D 0;
> > > +
> > > +    argsz =3D sizeof(req);
> > > +    req.argsz =3D argsz;
> > > +    req.flag =3D VFIO_IOMMU_PASID_FREE;
> > > +    req.pasid =3D pasid;
> > > +
> > > +    rcu_read_lock();
> > > +    ret =3D ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
> > > +    if (ret !=3D 0) {
> > > +        error_report("vfio_pci_device_request_pasid_free:"
> > > +                     " request failed, contanier: %p", container);
> > > +    }
> > > +    rcu_read_unlock();
> > > +    return ret;
> > > +}
> > > +
> > > +static PCIPASIDOps vfio_pci_pasid_ops =3D {
> > > +    .alloc_pasid =3D vfio_pci_device_request_pasid_alloc,
> > > +    .free_pasid =3D vfio_pci_device_request_pasid_free,
> > > +};
> > > +
> > >  static void vfio_realize(PCIDevice *pdev, Error **errp)
> > >  {
> > >      VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
> > > @@ -2991,6 +3050,8 @@ static void vfio_realize(PCIDevice *pdev, Error=
 **errp)
> > >      vfio_register_req_notifier(vdev);
> > >      vfio_setup_resetfn_quirk(vdev);
> > >
> > > +    pci_setup_pasid_ops(pdev, &vfio_pci_pasid_ops);
> > > +
> > >      return;
> > >
> > >  out_teardown:
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5L6AZ1aJH5mDrqCQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0ukMAACgkQbDjKyiDZ
s5K34xAAmqhUewLnsaIj9CxX94TPF0CzL2TySUArJZLx37EtqqlkrjBWWdfZCo0L
hfd0311Ml5s77eWdfWgMyjklgCxddh8HrxMCvKa9LqRC+kw5ApfNsrBFwovec1E8
hQOfGltnU23vpiTnedG5l7/4wHe6clNp3DwJL6wbhOSu7PXdd5FWkBqog2qPxa+8
oGor4s6TCYmJoR2GAE2OiLERZmemB9erNkxuPfguQq0wCSYSK7H6G7tuvretrn1r
6NijxvkVXPKR3xOpPbGU2UKjoEs9gPSy6NXaMlx4LkHJqI/K9f1ak7yXeXVHkNCc
UpVVfskMlJFZfXsP97pd6xaCWr83Gb8ip87dAxkVSfvxsVuqe4WtcD6pexkb9zch
9CvQKtt1LsfAOJHv3LfKLY0Visz6u0rEuVll591XbRzw0nkzrmMKS7pS6SdNhrSP
wBRN0A/I+SkeVNFYToiJ7+MZNzta9HFIc9b4UVgvMU96f9KdAp7YuBS33a1gNUlm
DKfKz6COIgxoJUje0WzzeYx4nMycD3vnQ4wZ6fCpVt/vFwK+Ajber3OnRHnCQ0rK
iT+aen+w2Jo8cZ87pz87tCnsg8QvTgjYcUOG9mhJv7miwVqds+M+4H6gyGs6yF4x
rJQvLiiM/lRKUHR6lKnJp2v2mSTeTwHMnHiLxf8X0qymsHc2dis=
=HZho
-----END PGP SIGNATURE-----

--5L6AZ1aJH5mDrqCQ--

