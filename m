Received: from eggs.gnu.org ([2001:4830:134:3::10]:39449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc17i-0000gx-UU
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc17h-0007cb-VN
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:46 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:57609)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cc17h-0007aY-Hh
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:45 -0500
Date: Fri, 10 Feb 2017 13:31:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210023101.GB27610@umbus.fritz.box>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-13-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EH85xkKza2NXtwkF"
Content-Disposition: inline
In-Reply-To: <1486456099-7345-13-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 12/17] memory: provide iommu_replay_all()
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


--EH85xkKza2NXtwkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 04:28:14PM +0800, Peter Xu wrote:
> This is an "global" version of exising memory_region_iommu_replay() - we
> announce the translations to all the registered notifiers, instead of a
> specific one.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/exec/memory.h | 8 ++++++++
>  memory.c              | 9 +++++++++
>  2 files changed, 17 insertions(+)
>=20
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index f76e174..606ce88 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -707,6 +707,14 @@ void memory_region_iommu_replay(MemoryRegion *mr, IO=
MMUNotifier *n,
>                                  bool is_write);
> =20
>  /**
> + * memory_region_iommu_replay_all: replay existing IOMMU translations
> + * to all the notifiers registered.
> + *
> + * @mr: the memory region to observe
> + */
> +void memory_region_iommu_replay_all(MemoryRegion *mr);
> +
> +/**
>   * memory_region_unregister_iommu_notifier: unregister a notifier for
>   * changes to IOMMU translation entries.
>   *
> diff --git a/memory.c b/memory.c
> index 523c43f..9e1bb75 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1646,6 +1646,15 @@ void memory_region_iommu_replay(MemoryRegion *mr, =
IOMMUNotifier *n,
>      }
>  }
> =20
> +void memory_region_iommu_replay_all(MemoryRegion *mr)
> +{
> +    IOMMUNotifier *notifier;
> +
> +    IOMMU_NOTIFIER_FOREACH(notifier, mr) {
> +        memory_region_iommu_replay(mr, notifier, false);
> +    }
> +}
> +
>  void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
>                                               IOMMUNotifier *n)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EH85xkKza2NXtwkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnSXlAAoJEGw4ysog2bOSWfcP/1hKlf74gEEZomNahIG83hUT
Tm67B+0POVihkvVxuNIGGVg8UmLYcfURNnHMWzWEDmcH6c+nDwKz/FV80RracGWF
RqzvO3HVhOudLDtrdwLHc8xuO/jA+XbdXsdHJ5ADls4Wl/PXXf7p945BJWzU4R2t
cKJgGbJa0PqvNKA3piaVwsv0EuQ05fmk/eU2pBQXaYBgi0aw79QbNXUaIz9+4W3V
9P0NmC445p50/qnezcqXHgp9xGXxodVOsK3dRj5MkTRX/eOGNXrUFO+Wt9/bkskx
pkBYKiAJNcnN+WmB5+ROTGHef4JMP7fIjpbYVXJZ2JXsz1Vo8mcQ54VZZlbPfkp5
Hmg3mjCSaebtjcth+GYJIQZgZBx91DzZuqVo2o+knRJEsyoS1ZHYQ9I0AKmM4QAN
ckJs4Ql6YT3OE0fFd0/ikPsyEnAVt2BPEUA37wr8k9vztmwMg+giWQJ+EGg5LzAL
OxnWnTtf7nZhMXLjRY/WCG4I6J4+paIQFz6FA5b6x+r65cAnoNfLOANb/UTgCUlr
ItAuGKhMc3Gfuy7LU5zEGai/mv9aCStgzf9HVJCyCc4Lfd2Xp3iCmjXv4391le4A
yFfHzg3AR/1W0IjQD4XXbpYUogr7E6V4ruRXh7ttBg1bOvFBEAGvM2NQ8N5kitMW
aUs9KYley5VZd2o2109h
=3LQz
-----END PGP SIGNATURE-----

--EH85xkKza2NXtwkF--
