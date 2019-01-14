Received: from eggs.gnu.org ([209.51.188.92]:50895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj8FF-0002ii-0S
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj8FC-0007fC-W4
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:50:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gj8FB-0007dn-5T
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:49:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7D8280495
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 19:49:54 +0000 (UTC)
References: <20190114113827.24388-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa15d9b9-11ff-a21e-6ecb-ef73fcc7687a@redhat.com>
Date: Mon, 14 Jan 2019 13:49:53 -0600
MIME-Version: 1.0
In-Reply-To: <20190114113827.24388-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N4LafukvbGtDjOBgMq7raQnXsOxZR3vqU"
Subject: Re: [Qemu-devel] [PATCH] io: ensure UNIX client doesn't unlink
 server socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N4LafukvbGtDjOBgMq7raQnXsOxZR3vqU
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <aa15d9b9-11ff-a21e-6ecb-ef73fcc7687a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] io: ensure UNIX client doesn't unlink server
 socket
References: <20190114113827.24388-1-berrange@redhat.com>
In-Reply-To: <20190114113827.24388-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/14/19 5:38 AM, Daniel P. Berrang=C3=A9 wrote:
> The qio_channel_socket_close method for was mistakenly unlinking the
> UNIX server socket, even if the channel was a client connection. This
> was not noticed with chardevs, since they never call close, but with th=
e
> VNC server, this caused the VNC server socket to be deleted after the
> first client quit.
>=20
> The qio_channel_socket_close method also needlessly reimplemented the
> logic that already exists in socket_listen_cleanup(). Just call that
> method directly, for listen sockets only.
>=20
> This fixes a regression introduced in QEMU 3.0.0 with
>=20
>   commit d66f78e1eaa832f73c771d9df1b606fe75d52a50
>   Author: Pavel Balaev <mail@void.so>
>   Date:   Mon May 21 19:17:35 2018 +0300
>=20
>     Delete AF_UNIX socket after close
>=20
> Fixes launchpad #1795100
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  io/channel-socket.c            | 19 ++------
>  tests/test-io-channel-socket.c | 86 ++++++++++++++++++++++++++++++----=

>  2 files changed, 80 insertions(+), 25 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--N4LafukvbGtDjOBgMq7raQnXsOxZR3vqU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw85+EACgkQp6FrSiUn
Q2oG9Qf/XkQmoc3XHt++OZCzt6oTSi/bdSl654pv5yyBl/RjF6hM5jQeT8ehhyfq
TaG2X3CwCHETQAmTpI0+sgh9YV+V1FS+0qR6VOAmoq4HUwVBQOBZilnmJptSzGdo
uyBEOmm7ncu2Zo/To063VnvAGNEhiTxYKmp40h0hJXQNP5xVmDDmZPOvCmPhl/M/
fF0i7pSYWojy843MN6irkIDUVjUha6wJLmm+MUpNeQnwMRY4PVuPMay7PS6sfRoH
qpxr+X831xe5auOaQHm/eZp3xwWnqGWCOqDB5pFvsVmM7GETSuSOBv3FY+Dlnh1/
nwJuNEZgjGjqegigSfC6277cF0jpJA==
=oORF
-----END PGP SIGNATURE-----

--N4LafukvbGtDjOBgMq7raQnXsOxZR3vqU--
