Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AF2CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 14:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316B720659
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 14:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="V+vWWGka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316B720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPSPP-0007W4-3B
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 10:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iPSOT-0006Lb-KP
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 10:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iPSOS-00053K-2c
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 10:22:45 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60267)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1iPSOQ-0004zI-Vf
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 10:22:44 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 472YhC1X4nz9sRf; Wed, 30 Oct 2019 01:22:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1572358955;
 bh=HzmZZNI1K+5CLWZCzfNyEnSmfjsfV5LboTZr/oWFEz4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V+vWWGkaoMquBtZB1lxNHNqMsntFep3dr/7kzJ9og6/c8h+auK+FGRsAZdG/MWDk5
 /ZWK40HkTV0D1k2ulc355kxYF/6jZ1XXpBUdv+6qtnQ8NaicawCyMwItpjzJjM5ZwR
 pxOI+oK+dNAek2OHCKdRLMLcQUHBuzhm66dez1Hw=
Date: Tue, 29 Oct 2019 12:50:47 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC v2 07/22] hw/pci: introduce pci_device_iommu_context()
Message-ID: <20191029115047.GR3552@umbus.metropole.lan>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-8-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A1VS04HCCjrR2aaM"
Content-Disposition: inline
In-Reply-To: <1571920483-3382-8-git-send-email-yi.l.liu@intel.com>
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com,
 yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--A1VS04HCCjrR2aaM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 08:34:28AM -0400, Liu Yi L wrote:
> This patch adds pci_device_iommu_context() to get an iommu_context
> for a given device. A new callback is added in PCIIOMMUOps. Users
> who wants to listen to events issued by vIOMMU could use this new
> interface to get an iommu_context and register their own notifiers,
> then wait for notifications from vIOMMU. e.g. VFIO is the first user
> of it to listen to the PASID_ALLOC/PASID_BIND/CACHE_INV events and
> propagate the events to host.
>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/pci/pci.c         | 16 ++++++++++++++++
>  include/hw/pci/pci.h |  5 +++++
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index b5ce9ca..4e6af06 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2625,6 +2625,22 @@ AddressSpace *pci_device_iommu_address_space(PCIDe=
vice *dev)
>      return &address_space_memory;
>  }
> =20
> +IOMMUContext *pci_device_iommu_context(PCIDevice *dev)
> +{
> +    PCIBus *bus =3D pci_get_bus(dev);
> +    PCIBus *iommu_bus =3D bus;
> +
> +    while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus->parent_dev) {
> +        iommu_bus =3D pci_get_bus(iommu_bus->parent_dev);
> +    }
> +    if (iommu_bus && iommu_bus->iommu_ops &&
> +        iommu_bus->iommu_ops->get_iommu_context) {
> +        return iommu_bus->iommu_ops->get_iommu_context(bus,
> +                           iommu_bus->iommu_opaque, dev->devfn);
> +    }
> +    return NULL;
> +}
> +
>  void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
>  {
>      bus->iommu_ops =3D ops;
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index d9fed8d..ccada47 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -9,6 +9,8 @@
> =20
>  #include "hw/pci/pcie.h"
> =20
> +#include "hw/iommu/iommu.h"
> +
>  extern bool pci_available;
> =20
>  /* PCI bus */
> @@ -484,9 +486,12 @@ typedef struct PCIIOMMUOps PCIIOMMUOps;
>  struct PCIIOMMUOps {
>      AddressSpace * (*get_address_space)(PCIBus *bus,
>                                  void *opaque, int32_t devfn);
> +    IOMMUContext * (*get_iommu_context)(PCIBus *bus,
> +                                void *opaque, int32_t devfn);
>  };
> =20
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
> +IOMMUContext *pci_device_iommu_context(PCIDevice *dev);
>  void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *iommu_ops, void *op=
aque);
> =20
>  static inline void

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--A1VS04HCCjrR2aaM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl24J5QACgkQbDjKyiDZ
s5JJ3g/+Lur05gbjGYLYlgvjdq2Pn85zjxpG5uoDmWI86UluvDcz4lN/3ZVe5IK/
cG7aTArqvvTbmv4QI7SljHU4/luRHPZbfsgyXwpoxCuJbtc+vB7RjSHQJhOZVocs
oHkQs+Nk/x0AT7WJz9aCfcCUEKr0cyUxci5EwsxHba9predsU7uyatFgrUwqrUV/
E7Lh8bxPrl2tWqC1xDX2BUmL3HzHHAq27kPEgxhBaMlMbtO7t3U0p3+ZFNIBTuIY
R8p/5zo3tsl1cKkLkI9tFSe3BZlIcC6ypXr8I3SV3xac0sJoXjMQFsjhPHfD+D5M
OBxikWjIS0mK9hJEaJl/9hFOELjcOyzLmoKzNUEs60i9XqdU1TD/q+yfGXDe0Krd
4LtqR+hsMwbHc0yKmIaG8162ugJDGkhJ43DK9WLka/EP7TN3B6YRK8M5+MaZCdnJ
IogG+tUJPhPE5UElBdxqNDQ0lif2tpJkIWW0Il5Lzl9iNvaCP4XS48fvah3B1pOI
uHPYcyHMThofGIxKR17yX38BHLHebkCxN3jC1BEJGw/uBd8LlpkurHKeiXL6nmYV
7PwzjpIaoKRBu+jVogotItllNAHjd6HkGoxYl3wySJfFVSPUG/2dow68LrZLDBu6
SiuCMG0dQpGcqNjwhjFDk887x7TbIzrCb1g5i4xKYgcrmmWMCrY=
=hQKS
-----END PGP SIGNATURE-----

--A1VS04HCCjrR2aaM--

