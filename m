Received: from eggs.gnu.org ([2001:4830:134:3::10]:38883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYDx3-0003Y5-7h
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:33:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYDwy-00049H-8f
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:33:05 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cYDwy-00048M-0h
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:33:00 -0500
Received: by mail-wm0-x243.google.com with SMTP id u63so9499055wmu.2
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:32:59 -0800 (PST)
Date: Mon, 30 Jan 2017 15:32:56 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170130153256.GN2118@stefanha-x1.localdomain>
References: <20170120164322.21851-1-pbonzini@redhat.com>
	<20170120164322.21851-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jnYfR+Q8IWTs8BNa"
Content-Disposition: inline
In-Reply-To: <20170120164322.21851-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/17] io: add methods to set I/O handlers
 on AioContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanha@redhat.com


--jnYfR+Q8IWTs8BNa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 05:43:10PM +0100, Paolo Bonzini wrote:
> This is in preparation for making qio_channel_yield work on
> AioContexts other than the main one.
>=20
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: removed QIOChannelRestart [Daniel]
>=20
>  include/io/channel.h | 25 +++++++++++++++++++++++++
>  io/channel-command.c | 13 +++++++++++++
>  io/channel-file.c    | 11 +++++++++++
>  io/channel-socket.c  | 16 +++++++++++-----
>  io/channel-tls.c     | 12 ++++++++++++
>  io/channel-watch.c   |  6 ++++++
>  io/channel.c         | 11 +++++++++++
>  7 files changed, 89 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jnYfR+Q8IWTs8BNa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYj1yoAAoJEJykq7OBq3PIvaEIAJO2PBOgAft6pCZRpj+aVfMr
KJTQnqF8wsFbNKZUlx1ehf0rqNqAv0B6FLugDEMJk6c5ECYNZLcG04sU0Wt250vq
zEAnD4dBx0fQhHUfezQH2HF08FccsTzXQhNTa3Y78qQgd2NvV4nzCH8mzn0ibC4e
S/uLaXv/1t+Or/wPUm+KMpgKyyQyJ//eKs98onw2vToKbb++5HDAJ0mQUfNI9p0M
/zBWDV6A2usyRgyOKpJfxUVI+QSv9eevsXUmQxJGlvvnTiwHw4+bcskNkkNz6N0Z
6XsK4nVMBi4uCkilfODOPwfv1zhDmjvnlP7oqU4nOVrxjWwRUTw41/gB1LYrUpc=
=M0ux
-----END PGP SIGNATURE-----

--jnYfR+Q8IWTs8BNa--
