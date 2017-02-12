Received: from eggs.gnu.org ([2001:4830:134:3::10]:43301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd3y3-0002Ac-8w
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 18:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd3y2-0004Qo-4D
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 18:54:07 -0500
Date: Mon, 13 Feb 2017 09:31:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170212223135.GJ25381@umbus>
References: <20170210092724.6470-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xssso5lpTBgMxDfe"
Content-Disposition: inline
In-Reply-To: <20170210092724.6470-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] ppc: replace debug printf with trace
 points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--Xssso5lpTBgMxDfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 10:27:21AM +0100, Laurent Vivier wrote:
> This series replaces the remaining DPRINTF()
> found under hw/ppc and replace them with trace
> points.
>=20
> Laurent Vivier (3):
>   mac99: replace debug printf with trace points
>   ppc4xx: replace debug printf with trace points
>   spapr: replace debug printf with trace points
>=20
>  hw/ppc/mac_newworld.c | 15 +++------------
>  hw/ppc/ppc4xx_pci.c   | 13 +++----------
>  hw/ppc/spapr_ovec.c   | 17 +++--------------
>  hw/ppc/trace-events   | 12 ++++++++++++
>  4 files changed, 21 insertions(+), 36 deletions(-)

Applied to ppc-for-2.9, thanks.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Xssso5lpTBgMxDfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoOJCAAoJEGw4ysog2bOS9g4P/3iienxzSJQidFj/SZ8J+QPd
tWM+ic1t+Vb9d4ZIldTT955EBP1Gb8fVukZYtr0bKej4e2Lj2Zh/Vt8wFOtZQPAE
cRWLmS3rASg3Eg15GvvbEgiHTQKYVZVZFY/tdpb+54ZGvr5wwDTz31jtrPk+VYI4
jWp4iKOLuCmxfjo19ZxlzxqmSM8LJo4SdAIla3UcQ1nocBpwXq4RDL44Fp9MhPDe
dZI7mmBHkOdQOMHzQnoF+YiCg94AP06zklobTU9XN8PRGp6MW6lOuYWeUOji2l3Q
IPe7PZzxeDmQGo9RZ+qu31QxMYLlquGqbpG9U+kPKxj8eu6XjAhPePutUDF9tCz8
lsy0C1meSPtVbeAIafnAlbnkDcVn0MKY4wsb4Z2/lD7k8tbS+b6Raj7dOsZVO2z5
40kmQmPXUrHxOXWHPH2kq1rXb9dJuTmx7J4ROr43TL8OyrNOTjUhZiC1B9puI7jC
WnYoSmdrvwNDoztjr/Rvqct3rJse3Tano2jfkCs4znr0T9CJvQIIM4fV1vhmi659
0FZkkopcTMEtABWMKHaMWjifF7lN/AI+BHadayFi/aeAj9mAbRGrsydW0tMvgeIJ
wIDpqGZjPGAK8RD8rViBNVGOqgVvNOoCPhV3vYk8DicWPhN1b0pMlF1qlfMa/mRf
k/y49vBM9gtBCfg6qdMl
=WPHI
-----END PGP SIGNATURE-----

--Xssso5lpTBgMxDfe--
