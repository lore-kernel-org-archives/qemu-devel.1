Received: from eggs.gnu.org ([2001:4830:134:3::10]:39491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc17q-0000iJ-5w
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc17h-0007c3-CQ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:49 -0500
Received: from ozlabs.org ([103.22.144.67]:56963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cc17g-0007aU-VN
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:45 -0500
Date: Fri, 10 Feb 2017 13:30:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210023031.GA27610@umbus.fritz.box>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-12-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/qNnUp0NPtZJWkzn"
Content-Disposition: inline
In-Reply-To: <1486456099-7345-12-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 11/17] memory: provide
 IOMMU_NOTIFIER_FOREACH macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com


--/qNnUp0NPtZJWkzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 04:28:13PM +0800, Peter Xu wrote:
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/exec/memory.h | 3 +++
>  memory.c              | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 805a88a..f76e174 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -239,6 +239,9 @@ struct MemoryRegion {
>      IOMMUNotifierFlag iommu_notify_flags;
>  };
> =20
> +#define IOMMU_NOTIFIER_FOREACH(n, mr) \
> +    QLIST_FOREACH((n), &(mr)->iommu_notify, node)
> +
>  /**
>   * MemoryListener: callbacks structure for updates to the physical memor=
y map
>   *
> diff --git a/memory.c b/memory.c
> index 4900bbf..523c43f 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1587,7 +1587,7 @@ static void memory_region_update_iommu_notify_flags=
(MemoryRegion *mr)
>      IOMMUNotifierFlag flags =3D IOMMU_NOTIFIER_NONE;
>      IOMMUNotifier *iommu_notifier;
> =20
> -    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
> +    IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
>          flags |=3D iommu_notifier->notifier_flags;
>      }
> =20
> @@ -1671,7 +1671,7 @@ void memory_region_notify_iommu(MemoryRegion *mr,
>          request_flags =3D IOMMU_NOTIFIER_UNMAP;
>      }
> =20
> -    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
> +    IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
>          /*
>           * Skip the notification if the notification does not overlap
>           * with registered range.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/qNnUp0NPtZJWkzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnSXHAAoJEGw4ysog2bOSLgAQAI2XY3Ic077dgec3mapiTFz1
J0A4pV8Th9k22j362GBbu1VMME8PpZl3TP3eAgO2sCLaymxLFPp47DklbPthOfrD
DUxGQTtfuYlCH6seGEHrefdc5oRXgbOLxgtOF04U187IxrJOdOF8YPeYEMsIILlR
rLHivg8S2VUEXgh6v+A/lfmicX12Ny931R0jIxcSiDMjorVhez3wQPwTAt5GqA1C
bA7CXBt+V4vyvi+nS1e6OYNiEmxX7lZLjmXLqRCsoOuL6ZRXHSO5X27YG++Up1KB
vf0ikMgZyp+A1sc4ezxR9R65zaamYW05/IvBhJ6YidgyzlB2CmWQpZn3o2a8ibep
L4ojzJb6X5BJwV7HRaL3CQ6eo8R4eevVO8SRLPlQbGXLRbkiy594JkMrYbdGdZsV
zTZTo9seBjPyzNgCSiJTOfyVYw9WdGYx41FEqfVteUDQ5dBr2pt0BpTigzF+as4Q
5SALJOIWeO/AoOHPp/xHIg5C4kbSELkmrvyTERLJfjEvxGbNh2w+/AzV+guQtDmD
llPMT2PZsI4LuvYaoObH9ICKeOvdSV68z0NF5ytk+4YYKnJvgkB34KSXNfNnznt3
HV6HF/6vc6J23P/RHr6fIkWJUwX2m8yTrGS49wtDZdlL6Vkfql9/5EWA1/Q/iKdv
sP78MnVN74tgmXNbslPp
=33qw
-----END PGP SIGNATURE-----

--/qNnUp0NPtZJWkzn--
