Received: from eggs.gnu.org ([2001:4830:134:3::10]:54159)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1etV78-0004Nz-25
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 04:11:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1etV72-0006UQ-AK
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 04:11:58 -0500
Received: from mout.gmx.net ([212.227.17.21]:52761)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1etV71-0006Tg-WA
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 04:11:52 -0500
References: <23118.27370.136663.284087@guava.gson.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <143c7064-8a4d-6f78-6d50-ed10096ddd3b@gmx.com>
Date: Wed, 7 Mar 2018 10:13:20 +0100
MIME-Version: 1.0
In-Reply-To: <23118.27370.136663.284087@guava.gson.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HKh8tLpLL9BDHe0ecu7kD88LLe3XeMUId"
Subject: Re: [Qemu-devel] [PATCH] slirp: disable Nagle in outgoing
 connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Gustafsson <gson@gson.org>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HKh8tLpLL9BDHe0ecu7kD88LLe3XeMUId
From: Kamil Rytarowski <n54@gmx.com>
To: Andreas Gustafsson <gson@gson.org>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <143c7064-8a4d-6f78-6d50-ed10096ddd3b@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] slirp: disable Nagle in outgoing connections
References: <23118.27370.136663.284087@guava.gson.org>
In-Reply-To: <23118.27370.136663.284087@guava.gson.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch is correct. LLDB expects 1sec for reply, GDB by default 2.

Debuggers use this option to disable Nagle algorithm in order to quickly
transfer messages between gdb-server and gdb-client. It's also fairy
portable across systems.

On 04.01.2018 18:56, Andreas Gustafsson wrote:
> slirp: disable Nagle in outgoing connections
>=20
> When setting up an outgoing user mode networking TCP connection,
> disable the Nagle algorithm in the host-side connection.  Either the
> guest is already doing Nagle, in which case there is no point in doing
> it twice, or it has chosen to disable it, in which case we should
> respect that choice.
>=20
> This change speeds up GDB remote debugging over TCP over user mode
> networking (with GDB runing on the guest) by multiple orders of
> magnitude, and has been part of the local patches applied by pkgsrc
> since 2012 with no reported ill effects.
>=20
> Signed-off-by: Andreas Gustafsson <gson@gson.org>

Signed-off-by: Kamil Rytarowski <n54@gmx.com>

> ---
>  slirp/tcp_subr.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
> index da0d53743f..8d0f94b75f 100644
> --- a/slirp/tcp_subr.c
> +++ b/slirp/tcp_subr.c
> @@ -416,6 +416,8 @@ int tcp_fconnect(struct socket *so, unsigned short =
af)
>      socket_set_fast_reuse(s);
>      opt =3D 1;
>      qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(opt));
> +    opt =3D 1;
> +    qemu_setsockopt(s, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));
> =20
>      addr =3D so->fhost.ss;
>      DEBUG_CALL(" connect()ing")
>=20



--HKh8tLpLL9BDHe0ecu7kD88LLe3XeMUId
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlqfrT8MHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsD3kP/0xgdsIJfQCYGb3rikEXrTMcPbOYi20c//fTmYUI
+mRYo7VmarPayC6KAW262UT1MJfmcfQjYFD/nLEMiB5PdflFJOSC9ldTPwrQE5c8
imh+ZKaPISIvSep0jXZAohfQq819DIy8vhfWXHOT+XkAxDe9KETFeVKlEzAaoumh
wAxnkwKu6RyBzXZhqH1E3AQQFTAI/Tg8fI9Y9roDuHCFrZtGpUTszWunyIkOXP/P
WwaH5iA38Wr5ziRkizQTobqnlO7RO8XLewDDOh6+IXPD8BasVBAsLsKaXZlO5MIT
rXa1nYlmMy0ACgBn5tppgXAOJWk0wxBUchDLZca5NaTvaUBJRH6A0cvHE3M5VQ9/
M5veqnmbRIv2qTVqRIQAW7hSU+v36Ds1azar83+MV5G8yOJ7HQ5gdYESHkPQF11T
Nva4Z33iRX/Ea6sK/FZs/uC/5p3nj51ps84BRUbv1E+JalTs1Q56ONXt7dew4zVh
CUmM/dgvZYhSFRA2ccBBBAxXvtCcvjVvWGEbLy2cJkmSE2UgWU52pPnoP1mZ2U3c
MlTksnon7mxQkbaQhwUft42Ae9/GIPR2zDxloUlH8mXm6oS/YuIhhoDhDFZjDaXh
dk4vGg3UUocl3m5QS16UlInCprjdqzCyTSTLZZOJCTQJj3gaHW4So1XwwC+v5a6E
8V1z
=aTPm
-----END PGP SIGNATURE-----

--HKh8tLpLL9BDHe0ecu7kD88LLe3XeMUId--
