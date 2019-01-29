Received: from eggs.gnu.org ([209.51.188.92]:41787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1goKAQ-0004Tq-Ph
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 22:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1goKAQ-0000qV-3l
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 22:34:30 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:39254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1goKAP-0000oY-TN
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 22:34:30 -0500
Received: by mail-pg1-x52e.google.com with SMTP id w6so8147068pgl.6
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 19:34:29 -0800 (PST)
Date: Tue, 29 Jan 2019 11:34:25 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190129033425.GE3264@stefanha-x1.localdomain>
References: <20190125172229.23025-1-cfergeau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Oiv9uiLrevHtW1RS"
Content-Disposition: inline
In-Reply-To: <20190125172229.23025-1-cfergeau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/2] qemu-io: Use error_[gs]et_progname()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Fergeau <cfergeau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 06:22:28PM +0100, Christophe Fergeau wrote:
> qemu-io reimplements itself what
> error_get_progname()/error_set_progname() already does.
> This commit switches it to use this API from qemu-error.h
>=20
> Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
> ---
>  qemu-io.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcT8nBAAoJEJykq7OBq3PIgu8IAItkhbsesRrxe9HvG8PghM9F
0WHU4Q1XBjyFgowYkF2RYXyB4RkcnyXcJxQ8wGAb1BLO1Nyh8gcIhLB4TrjGuSEB
B1opa2/Tv8f8qpfQX/0eU7lrNqd33WZoNbEN1ZG2LFGgJVN8mbOVL0UllZCyPmxZ
Xj6g2TGAAcKCq+7xSWbQwhE0YmB391PxrpV2PwH9tWENnb0RRE3dZiTZM0DpeXwq
q/YL7ixjrBilgLYiEPtxyYJXkBnbwhRo/YVpX+GlbcmMrhDAfVzLvVJpS/wgmxr+
H7/mWEX4AIYLfntCRuQh01v5XGnY3EoonjZHyO9kwEG3zdWLoNB3c1lNWrw7Wb4=
=/3tv
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--
