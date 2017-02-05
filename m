Received: from eggs.gnu.org ([2001:4830:134:3::10]:57403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1caUoE-0008Ho-2Q
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 16:57:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1caUoD-0001D1-EE
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 16:57:22 -0500
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-6-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9124836c-c8cb-6573-0ade-5025eb4846b3@redhat.com>
Date: Sun, 5 Feb 2017 22:57:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170123123056.30383-6-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0eu6mo3kLjMWh6ugJvawjpqubakMfn241"
Subject: Re: [Qemu-devel] [PATCH v12 05/16] block: Set "share-rw" flag in
 drive-backup when sync=none
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0eu6mo3kLjMWh6ugJvawjpqubakMfn241
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com
Message-ID: <9124836c-c8cb-6573-0ade-5025eb4846b3@redhat.com>
Subject: Re: [PATCH v12 05/16] block: Set "share-rw" flag in drive-backup when
 sync=none
References: <20170123123056.30383-1-famz@redhat.com>
 <20170123123056.30383-6-famz@redhat.com>
In-Reply-To: <20170123123056.30383-6-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:30, Fam Zheng wrote:
> In this case we may open the source's backing image chain multiple
> times. Setting share flag means the new open won't try to acquire or
> check any lock, once we implement image locking.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  blockdev.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--0eu6mo3kLjMWh6ugJvawjpqubakMfn241
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliXn7gSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AiuYH/RcS4vfVh+/9O3Drz5F5u5WMDE7wvFPa
aPbRUv8z2g+n16h6/n4L+1Gj6XEFOWQqIEEf4txK3nGO7jAfoaZnrtJCk+pdxFDG
lq/SbC5pLrNEEEGRWaz8vkBQU5ErRIgHczusQrbSDM6n+ymGykWotM8cx0ihHr1g
1TA2nbUmvm1HutJ2x3uWZOjLgR69jS9M+S7/M5wx2OH2g0ExbEhzPlG68FxLinJf
DMKs0ft6EXZ0BWFmJ1RnnW4vG88Rl6SozQeQrsTn5EVBXbQ1ppfmhrd34vmCIN3T
9VGs60cWLwy6Gavz08cImtUoc5Ejp28gtKQ8sR7KRAwmngSiF63JtJk=
=CRYK
-----END PGP SIGNATURE-----

--0eu6mo3kLjMWh6ugJvawjpqubakMfn241--
