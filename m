Received: from eggs.gnu.org ([209.51.188.92]:52667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWiE-0008Dr-OP
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWiA-0005eN-J6
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:08 -0500
Date: Mon, 18 Feb 2019 10:58:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190217235819.GL2765@umbus.fritz.box>
References: <20190215133005.15955-1-david@redhat.com>
	<20190215133005.15955-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iK/wEI4vkfDmI6Zw"
Content-Disposition: inline
In-Reply-To: <20190215133005.15955-2-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] cpus: Properly release the iothread
 lock when killing a dummy VCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


--iK/wEI4vkfDmI6Zw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 02:30:00PM +0100, David Hildenbrand wrote:
> This enables CPU unplug under qtest.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  cpus.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/cpus.c b/cpus.c
> index 154daf57dc..e83f72b48b 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1333,6 +1333,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
>          qemu_wait_io_event(cpu);
>      } while (!cpu->unplug);
> =20
> +    qemu_mutex_unlock_iothread();
>      rcu_unregister_thread();
>      return NULL;
>  #endif

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iK/wEI4vkfDmI6Zw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxp9RsACgkQbDjKyiDZ
s5KVNA/7BHiLbkut6sM24hU6791Y09l2jFDkRMBA93L65IBaWeX1RpmvrlqX9Mzm
fMQqET922BPlCETj7HXLl5ur2N68O7Ci16oOuKQYNEuNENGBUXv2NrLUFuzDTZdH
us6BAU/+CU+rWbVIbmTNa0dccSMIcGF47mrOoWX4NWSsGqYlS2ZEuROZ6lCGw3Ce
ZtrRrrDShRS552Vi8RiqtoRZbbWP/IZfwNGbgBDUN+PU7wa6/VAY1dDKfzw6yaTM
zBeivBmh7UJ/3FKHJANe8zg9JNgcAe0K41Y/yt0QvBNpt44lCsCUUPWDTNu9g60U
dqZGsdQd1oEc2mF/jIJ5iBgjcGZ+SFdImu0e3r52g0CF9X/haINTwRhcOVdNsv1k
+GsBvlre0G3dthwwGKnoCo8QB8QzqZRVF9mv4A0TvGjgNnZulejQdhXWJKXwPIAq
xu9GVrgTlGrgJgUMO0ohbSBdL6S/nX4n0O7i84/Wd8F25xdEkKOR0PcQgMjdOEK8
2Ah7Cg2WwCiW4aAV8zfPrxQ4+4g/TP4BxoCIhCRe3SZtebtYy7tyMkmK4nh42Glu
B7Svp4Lvmh6x4KUbMRs10poTilDYVKMofrtLEOilwaEQiuvVc5wb6nA1FBNl3dX7
Nn/gLttJ5XhmB5eMZEi+oGV6bcgz8MWoWVvfl+bZY2nPXcswWFU=
=20Iv
-----END PGP SIGNATURE-----

--iK/wEI4vkfDmI6Zw--
