Received: from eggs.gnu.org ([2001:4830:134:3::10]:59599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gFh5S-00033X-PH
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gFgus-0007tD-LN
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:21 -0400
Received: from ozlabs.org ([203.11.71.1]:46101)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gFgur-0007he-EQ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:18 -0400
Date: Thu, 25 Oct 2018 15:41:58 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181025144158.GC2697@umbus.hotspot.internet-for-guests.com>
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <20181023152306.3123-4-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/7] range: pass const pointer where
 possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2018 at 05:23:02PM +0200, David Hildenbrand wrote:
> If there are no changes, let's use a const pointer.
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/qemu/range.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/qemu/range.h b/include/qemu/range.h
> index f28f0c1825..7e75f4e655 100644
> --- a/include/qemu/range.h
> +++ b/include/qemu/range.h
> @@ -39,7 +39,7 @@ struct Range {
>      uint64_t upb;        /* inclusive upper bound */
>  };
> =20
> -static inline void range_invariant(Range *range)
> +static inline void range_invariant(const Range *range)
>  {
>      assert(range->lob <=3D range->upb || range->lob =3D=3D range->upb + =
1);
>  }
> @@ -48,14 +48,14 @@ static inline void range_invariant(Range *range)
>  #define range_empty ((Range){ .lob =3D 1, .upb =3D 0 })
> =20
>  /* Is @range empty? */
> -static inline bool range_is_empty(Range *range)
> +static inline bool range_is_empty(const Range *range)
>  {
>      range_invariant(range);
>      return range->lob > range->upb;
>  }
> =20
>  /* Does @range contain @val? */
> -static inline bool range_contains(Range *range, uint64_t val)
> +static inline bool range_contains(const Range *range, uint64_t val)
>  {
>      return val >=3D range->lob && val <=3D range->upb;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvR1jYACgkQbDjKyiDZ
s5KexxAAwifABy6edhcXQKGAkq09co6KBOeHBg7DC9t+HJOyIn91E7/5PfUTJ4dZ
c2CufsRoPe2nP0hRqJOa7/hOvl1t5yBpRg6iUldPJAuWLDgmYtwyLDZikDcN8CpG
7IVE4a+TMbLBnJF3usYOLF6LV9N4GQVBCEM7StyZFCFOkri+DRHCPV4qzQcj+3b3
YpilxlVPNMLtd0K+GYSCBxL2jdy/F3B1JDcj2+fsLU5J+iNUhroEDbcgNv5axtxW
q3tn40Ir+KPVs9AhIKT2uNQ8fXeP3XxYUOCaApPwM1gM4Dv58KmZ8IMqbMBmmHTk
+xibkdhr5xgu1WZs46810mMC/oOW5kQ80HFLR170BlsPACFJ9WD+GPylkLOILHx3
kg57jfVn4k34XqBA6INaPa3usHabihvsjTUZMdfars3dJaJSnH/B4RN0K3mlJLmk
aGYWiy/DRC4J7HHA6bHYOs+PEiTKNdRn+h4ES1YkFWIL45qESWsYROyWeO6U1Awy
huDHT/z6lkAnTeysOx0qAnIbxbBEjnJu8ZdChpFVA1lLe2f0JW6c4A23/Q0AWd+W
skPjeAeWQvdTrrvkjKm4pXMvDcEul1n2/fBW8//DF/edyR0Y/2dLdU5ZK2RJ7Xba
50iXzKttgv2lpjFAw5AtCkx+wuy94fei3TIuEs0iLAK/1NaY74s=
=6vIf
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
