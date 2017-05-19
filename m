Received: from eggs.gnu.org ([2001:4830:134:3::10]:36322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBXFr-0006Ta-IV
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBXFo-00084S-GG
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:02:59 -0400
Date: Fri, 19 May 2017 11:21:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170519012117.GA12284@umbus.fritz.box>
References: <149511591185.8828.11947901967942107196.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <149511591185.8828.11947901967942107196.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: ensure core_slot isn't NULL in
 spapr_core_unplug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2017 at 03:58:31PM +0200, Greg Kurz wrote:
> If we go that far on the path of hot-removing a core and we find out that
> the core-id is invalid, then we have a serious bug.
>=20
> Let's make it explicit with an assert() instead of dereferencing a NULL
> pointer.
>=20
> This fixes Coverity issue CID 1375404.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Merged to ppc-for-2.10.

> ---
>  hw/ppc/spapr.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0980d733cd7a..1c5b814fc0bf 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2715,6 +2715,7 @@ static void spapr_core_unplug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
>      CPUCore *cc =3D CPU_CORE(dev);
>      CPUArchId *core_slot =3D spapr_find_cpu_slot(ms, cc->core_id, NULL);
> =20
> +    assert(core_slot);
>      core_slot->cpu =3D NULL;
>      object_unparent(OBJECT(dev));
>  }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZHkiLAAoJEGw4ysog2bOSFv8P/i0dOdFAu8jrT2lX/oHbGODb
7FgdX9k8eUkASDoZskwbLiVwo9Ub3notwRnAWktQl1GBo7o0fCR/nXvj78dHNSKP
9HzaRv6ANQBuWHg+OCAn9D8ELHahhiK8IgbRcfW+AmYGBesy6+DQbp0XaxGX183m
rHmPINlWaga+19S9ARHn/8zR0pRXEkaLUwxRAPpks+1Weq0GpLynTsKV6megN77i
BU4xC6iFV36VoKtt8D/23Upjs7YSHB59n1trRejqPGlqPedOzKy3t3mF6lN+4+XZ
+N4VBFWFZnBm6V3M1ks6RFSStsQL7/tKGlMDvytsR+D0OnOxkVtx6WzdBW3qB84y
+t4tsOGyPeFDtei8OMsovtirCBlXemIuSC93jCl0vaBGJRHeCxZGjG/zpy0QI25C
kCz+qTvu9O3sfw2N5jg36yk1aKjPzUf0xVo6novgvWBQEcIKu+o5ETfVT3OWyNtb
84iWJYKcIIyYOGDJVAgQ5oxGIPfvXDFjhCMVC2SpcIp4XmbS6Tdx7FNTCVztfcpG
G4kcvA7ppwsdYaZ+uImXa/U4zeBAizkdHv94WiGQrmJo3s6okDdB5FAp2OvDE43a
Pwc3a1Xro7CkbZlNco8zS9UpOEW4BP/98U6Om0EYa8VuBaRNZmRvLLBWYN0H7PjK
yYMbE10hOyEenvh3YwBY
=+Wa5
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
