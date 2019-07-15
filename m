Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7CAC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 06:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A18720838
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 06:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PL+hSpKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A18720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmuQm-0006am-Cf
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 02:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43171)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hmuQG-0004nu-V6
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 02:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hmuQF-0004mz-Fw
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 02:25:16 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48243 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hmuQD-0004gY-9Y
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 02:25:15 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45nD6B4Bc6z9sP0; Mon, 15 Jul 2019 16:25:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563171906;
 bh=MMDinOD+wXlv4awyV674igDfgFgonl4wftkkwcmlRFU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PL+hSpKR28IrMGvUCzlZKT6tRFajGAuminDj1Jm7BPtEZ/M8Kx61FZXXaiCcnlqWz
 3HV/g9lGIU/EFd0k133XAF0Pp2GzrAUZHdR7lNhlxu/WINieGx1FGK6iW9VVEF+MP1
 cfQgTD1C14v31DIHiDqbDqlxsbPpCvwEfR3vZaWM=
Date: Mon, 15 Jul 2019 12:55:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Liu Yi L <yi.l.liu@intel.com>
Message-ID: <20190715025519.GE3440@umbus.fritz.box>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-6-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Content-Disposition: inline
In-Reply-To: <1562324511-2910-6-git-send-email-yi.l.liu@intel.com>
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2019 at 07:01:38PM +0800, Liu Yi L wrote:
> This patch adds vfio implementation PCIPASIDOps.alloc_pasid/free_pasid().
> These two functions are used to propagate guest pasid allocation and
> free requests to host via vfio container ioctl.

As I said in an earlier comment, I think doing this on the device is
conceptually incorrect.  I think we need an explcit notion of an SVM
context (i.e. the namespace in which all the PASIDs live) - which will
IIUC usually be shared amongst multiple devices.  The create and free
PASID requests should be on that object.

>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
>  hw/vfio/pci.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 61 insertions(+)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ce3fe96..ab184ad 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2690,6 +2690,65 @@ static void vfio_unregister_req_notifier(VFIOPCIDe=
vice *vdev)
>      vdev->req_enabled =3D false;
>  }
> =20
> +static int vfio_pci_device_request_pasid_alloc(PCIBus *bus,
> +                                               int32_t devfn,
> +                                               uint32_t min_pasid,
> +                                               uint32_t max_pasid)
> +{
> +    PCIDevice *pdev =3D bus->devices[devfn];
> +    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> +    VFIOContainer *container =3D vdev->vbasedev.group->container;
> +    struct vfio_iommu_type1_pasid_request req;
> +    unsigned long argsz;
> +    int pasid;
> +
> +    argsz =3D sizeof(req);
> +    req.argsz =3D argsz;
> +    req.flag =3D VFIO_IOMMU_PASID_ALLOC;
> +    req.min_pasid =3D min_pasid;
> +    req.max_pasid =3D max_pasid;
> +
> +    rcu_read_lock();
> +    pasid =3D ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
> +    if (pasid < 0) {
> +        error_report("vfio_pci_device_request_pasid_alloc:"
> +                     " request failed, contanier: %p", container);
> +    }
> +    rcu_read_unlock();
> +    return pasid;
> +}
> +
> +static int vfio_pci_device_request_pasid_free(PCIBus *bus,
> +                                              int32_t devfn,
> +                                              uint32_t pasid)
> +{
> +    PCIDevice *pdev =3D bus->devices[devfn];
> +    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> +    VFIOContainer *container =3D vdev->vbasedev.group->container;
> +    struct vfio_iommu_type1_pasid_request req;
> +    unsigned long argsz;
> +    int ret =3D 0;
> +
> +    argsz =3D sizeof(req);
> +    req.argsz =3D argsz;
> +    req.flag =3D VFIO_IOMMU_PASID_FREE;
> +    req.pasid =3D pasid;
> +
> +    rcu_read_lock();
> +    ret =3D ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
> +    if (ret !=3D 0) {
> +        error_report("vfio_pci_device_request_pasid_free:"
> +                     " request failed, contanier: %p", container);
> +    }
> +    rcu_read_unlock();
> +    return ret;
> +}
> +
> +static PCIPASIDOps vfio_pci_pasid_ops =3D {
> +    .alloc_pasid =3D vfio_pci_device_request_pasid_alloc,
> +    .free_pasid =3D vfio_pci_device_request_pasid_free,
> +};
> +
>  static void vfio_realize(PCIDevice *pdev, Error **errp)
>  {
>      VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
> @@ -2991,6 +3050,8 @@ static void vfio_realize(PCIDevice *pdev, Error **e=
rrp)
>      vfio_register_req_notifier(vdev);
>      vfio_setup_resetfn_quirk(vdev);
> =20
> +    pci_setup_pasid_ops(pdev, &vfio_pci_pasid_ops);
> +
>      return;
> =20
>  out_teardown:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0r6xQACgkQbDjKyiDZ
s5J4Eg//aM7TV3CkLDHJtnRYwSfA06xJ1K3BJ78h1scn8zlw7J0CCcwYYK6FuVvT
SXFXQP9dlyKMaRvieS1SfV+LjQ+lCToDJSllg1Wq0CYSTwnpKjCefPIP8O3sQ+DF
Jda+AC3BAfldLrgyN9I7lUXgrIFrP77uMR2ciobnyb4516ZLy4DQ2GYOeBggDDwW
QRZWgNSuvEBob8MFuIg7sTKTz63+N/hL83Jjy27BERVHaNQqDU0XPnOGBBBOmd16
Dn5DGR6HBBeVgOjyOr+8u/lByufe0j4pmhl8bS0wCmAtS4JfCfqxhNEiOhV5QCBA
UxRtzLxKfAbUnAfQMRc79hAJGM2DiChIlLVycRF9OxsD/dmYe2O8GOR337BIe7fv
oYORbuIomOsU0clA/8nisIQKftkoJcK3AO4CIc1ShQcMKa2j0f9Y2c5WH1BC3TX8
67MDlK7hBgRS/gbydog4ZuyUzMSr9bas2+L9CNXG0j1wN2ckFoK9MYSgsRmMSZDJ
BPBLEiYPnlYgU85wlCHTNWxDv0XQ1bHIq0pl3Rxh0Zubrobj3j/FSA1DVWb0NXLP
/p8qBE2ZOj952LRcYUOLFWMgRZyOf30Zlrs+KwKSdjDrZbso9j60m7wRTspsGY4x
LuIU0Jb0Df/F8T6lsYSdtlZfcGt689JLR2v+hrg2kpXScz9TDWA=
=i1pv
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--

