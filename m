Received: from eggs.gnu.org ([2001:4830:134:3::10]:37833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gMwBY-0006AQ-NM
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:30:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gMwBP-0006rB-GH
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:30:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gMwBP-0006qM-5u
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:30:19 -0500
Date: Wed, 14 Nov 2018 14:30:14 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181114143014.GB3103@stefanha-x1.localdomain>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <20181114123643.24091-6-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.2 05/41] slirp: use a callback
 structure to interface with qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, rjones@redhat.com, renzo@cs.unibo.it


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2018 at 04:36:07PM +0400, Marc-Andr=E9 Lureau wrote:
> -typedef void (*slirp_output)(void *opaque, const uint8_t *pkt, int pkt_l=
en);
> +typedef struct SlirpCb {
> +    void (*output)(void *opaque, const uint8_t *pkt, int pkt_len);
> +} SlirpCb;

Please include doc comments for each SlirpCb callback introduced by this
series.  Otherwise it will be hard for other people to use libslirp.

Stefan

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb7DF2AAoJEJykq7OBq3PIZ/IIAIWUSseuG9xEcV1w91GjIO3M
AAiImzkLfXXIA2da2EfYm053YC1P6SFrU62Fx/+LTHcUM4W7RUg5978rja4PldMV
7sc+RXePqRorS/Jg2u/nRtlJRlkxSvvNTvdNUI+ysa1WFlIqlC8cSlsHmI91kqrj
k0C/ozkDE+2y2xIng9maiNkzU5MpK0ySFs8Qr3tCnYjvONSzFlHXijujMN8G3oZk
e8RqXysWSbaRKfDN3pbnn/5F/+c9+2Rg3qOt4NIFqNd2aS2XsglgiW65IkflV5+Z
QnayNyHThi+VQaGbZ0vUKCNO+hd+/2cKzmZB7eTXEyy4bEEOjgQl5X1/uq9VVy8=
=GJoG
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
