Received: from eggs.gnu.org ([2001:4830:134:3::10]:38610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv6Iq-0005AH-BO
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv6Ik-0001Yj-Sd
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:02:08 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cv6Ik-0001Wo-ML
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:02:02 -0400
Received: by mail-wr0-x244.google.com with SMTP id u18so35657390wrc.0
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 11:02:02 -0700 (PDT)
Date: Mon, 3 Apr 2017 19:01:58 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170403180158.GG3539@stefanha-x1.localdomain>
References: <1490963801-27870-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m0vRWufqUC70IDnR"
Content-Disposition: inline
In-Reply-To: <1490963801-27870-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] tests/libqtest.c: Delete possible stale
 unix sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, patches@linaro.org


--m0vRWufqUC70IDnR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2017 at 01:36:41PM +0100, Peter Maydell wrote:
> Occasionally if a test crashes or is interrupted by the user
> at the wrong moment it could leave behind a stale UNIX
> socket in /tmp/. This will then cause a subsequent test
> run to fail spuriously with
>  tests/libqtest.c:70:init_socket: assertion failed (ret !=3D -1): (-1 !=
=3D -1)
> if it happens to reuse the same PID.
>=20
> Defend against this by deleting any stray stale socket before
> trying to open the new ones for this test.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This seems like an easy way to shut up this infrequent but irritating
> error case...
>=20
>  tests/libqtest.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--m0vRWufqUC70IDnR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY4o4WAAoJEJykq7OBq3PIbiAH/i6nEtPHa4ZqfLuBgEK9Y8P/
95hPfnc2rC7utAs9mnz7ey0lE0vBeZzVPMstb2mxwl0Q4g+tUqtCDH+JsZKVuWG3
0SCtVTG3oCWJOxFgibiisMMel8YN+GjPGw1gSiTNTeWYCSI/tlhsIEP9ZiF70oZu
nBQENX4XsyFuSueXrDOh4Te5gdfB/NoYaegWgafJaCJEDjm4ifYR/zeyk8eCPdxj
eSCo561dwBc8liwg0rRSsKo3qdGdIrnGkb45cNk84lHd9cXalN4+dYFB424GsDQZ
GU3wXn3qPeVeVRW28kxFaWZPzwLE3fkko0ZZdvYaXM6U5Y9G3kW6bf7NfiMeOpg=
=yrkc
-----END PGP SIGNATURE-----

--m0vRWufqUC70IDnR--
