Received: from eggs.gnu.org ([2001:4830:134:3::10]:38817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFzpF-0004tM-Mq
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFzpD-0005mE-FH
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:26:29 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:38347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fFzpD-0005m1-94
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:26:27 -0400
Received: by mail-wr0-x243.google.com with SMTP id 94-v6so30429645wrf.5
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 03:26:27 -0700 (PDT)
Date: Tue, 8 May 2018 11:26:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180508102624.GG19710@stefanha-x1.localdomain>
References: <20180502100422.8688-1-peterx@redhat.com>
	<20180502100422.8688-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yZnyZsPjQYjG7xG7"
Content-Disposition: inline
In-Reply-To: <20180502100422.8688-5-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 4/4] monitor: add lock to protect
 mon_fdsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--yZnyZsPjQYjG7xG7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 06:04:22PM +0800, Peter Xu wrote:
> Similar to previous patch, but introduce a new global big lock for
> mon_fdsets.  Take it where needed.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 53 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yZnyZsPjQYjG7xG7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa8XtQAAoJEJykq7OBq3PITOEH/1G1HxeCJBfCzTCvQwePLJxe
JNa6jyyZ9A2ryyq+ZAMmyvKU3ufZFCoWUCNBmTmI6u0+Xc95GSv/9KOx8GS9nsrJ
tqVGDQ0Mv0hRByHZBee7nzxQNXv0P+34m0JFBA6lIpwSUYDI52KRT7KTgMKxyl2w
v4dlD5+973KWSS6zmz45RGCAkAOvPaCY0caIU2hZDwiflfs8AjqYqZ/UAOCAv443
GyZGkxUAEB8DNzKtaM9vQOLw+DOY+ox2X46+19XG8sfQVwdkKy8UKqk0KvAL3hGU
K0k+rdtw2uzG6eSerEjgtf8VDz1HdDTUzQXWG4Q9Xo8KOx+TJWaVZubq37eKVYI=
=YCiR
-----END PGP SIGNATURE-----

--yZnyZsPjQYjG7xG7--
