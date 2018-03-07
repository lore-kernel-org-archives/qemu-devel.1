Received: from eggs.gnu.org ([2001:4830:134:3::10]:39223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etXGv-00060P-7V
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:30:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etXGq-0001vi-Lg
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:30:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37462 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1etXGq-0001u8-Hx
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:30:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AFD91D144C
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 11:30:07 +0000 (UTC)
Date: Wed, 7 Mar 2018 11:30:06 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180307113006.GC16861@stefanha-x1.localdomain>
References: <20180306053320.15401-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
In-Reply-To: <20180306053320.15401-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/9] chardev: qio related non-default
 context support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 01:33:11PM +0800, Peter Xu wrote:
> Based-on: <20180305064324.9238-1-peterx@redhat.com>
>=20
> This series is based on the QIO part:
>   [PATCH v3 0/6] qio: general non-default GMainContext support
>=20
> v2:
> - fix the reported problem by patchew in patch 5
> - added some r-bs from Marc-Andre
>=20
> Please review, thanks.
>=20
> Peter Xu (9):
>   vl: export machine_init_done
>   chardev: fix leak in tcp_chr_telnet_init_io()
>   chardev: update net listener gcontext
>   chardev: allow telnet gsource to switch gcontext
>   chardev: introduce chr_machine_done hook
>   chardev: use chardev's gcontext for async connect
>   chardev: tcp: postpone async connection setup
>   chardev: tcp: let TLS run on chardev context
>   chardev: tcp: postpone TLS work until machine done
>=20
>  chardev/char-mux.c         |  33 ++++++++--
>  chardev/char-socket.c      | 153 ++++++++++++++++++++++++++++++++++-----=
------
>  chardev/char.c             |  43 +++++--------
>  include/chardev/char-mux.h |   2 -
>  include/chardev/char.h     |   2 +
>  include/sysemu/sysemu.h    |   2 +
>  stubs/machine-init-done.c  |   2 +
>  tests/test-char.c          |   1 -
>  vl.c                       |   4 +-
>  9 files changed, 169 insertions(+), 73 deletions(-)

I'm not very familiar with chardev or qio, so I defer this to Daniel
Berrange:

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJan80+AAoJEJykq7OBq3PIwhsH/iOGhr6m6Ymq4Ya9IzD9RXc1
3nsB+sBALPTVKNKVgeas4j2QBmECGlrIItNtoZHGIKCl1EaiiiQXhrwx6tfAMieB
b1XvcEI4JJgyciDwhQeM9LEDncBLh/xUKmteLymYuOVVkiLBQGkf4fF0QSn0AqPK
Z/aEMmBAs0qZcT8yRDnWv8w7MsdaTrI/NKs41tWQHD01HEQz1dTbqoHaRP6Z2qqV
E1bDgy+QQKPhR0rud7cHwDRsohrmzp8jiMWPEMu4qPlnAIHDISRpdwot7Tv8G5os
rPRPUftG/0wC+EfluIIzfX8PV9jh4EcUt2dOFD27rTU9qt4N/izANnTsVD2DAMc=
=0yzU
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
