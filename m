Received: from eggs.gnu.org ([2001:4830:134:3::10]:51148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6fZJ-0000N0-7h
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6fZG-0002w6-2d
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:54:57 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d6fZF-0002vp-Rd
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:54:53 -0400
Received: by mail-wm0-x242.google.com with SMTP id y10so2184544wmh.0
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 08:54:53 -0700 (PDT)
Date: Fri, 5 May 2017 16:54:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505155450.GI14316@stefanha-x1.localdomain>
References: <20170504094053.2329-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="poJSiGMzRSvrLGLs"
Content-Disposition: inline
In-Reply-To: <20170504094053.2329-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/10] Migration PULL requset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com


--poJSiGMzRSvrLGLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 11:40:43AM +0200, Juan Quintela wrote:
> Hi
>=20
> This pull request includes:
> - Add return path to exec (danp)
> - add traces (dave)
> - move hmp commands to hmp.c (quintela)
> - minor migration cleanups (quintela)
>=20
> Please, apply.
>=20
> The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d=
60:
>=20
>   Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into stag=
ing (2017-05-02 15:16:29 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/juanquintela/qemu.git tags/migration/20170504
>=20
> for you to fetch changes up to 1db9d8e501fc99fa2201f228627952aee6cfc349:
>=20
>   migration: Extra tracing (2017-05-04 10:41:23 +0200)
>=20
> ----------------------------------------------------------------
> migration/next for 20170504
>=20
> ----------------------------------------------------------------
> Daniel P. Berrange (1):
>       migration: setup bi-directional I/O channel for exec: protocol
>=20
> Dr. David Alan Gilbert (1):
>       migration: Extra tracing
>=20
> Juan Quintela (8):
>       ram: Split dirty bitmap by RAMBlock
>       migration: to_dst_file at that point is NULL
>       monitor: Remove monitor parameter from save_vmstate
>       monitor: Move hmp_loadvm from monitor.c to hmp.c
>       monitor: Move hmp_savevm from savevm.c to hmp.c
>       monitor: Move hmp_delvm from savevm.c to hmp.c
>       monitor: Move hmp_info_snapshots from savevm.c to hmp.c
>       migration: Move postcopy-ram.h to migration/
>=20
>  hmp.c                                           | 174 +++++++++++++++
>  hmp.h                                           |   4 +
>  include/exec/ram_addr.h                         |  13 +-
>  include/migration/migration.h                   |   3 +-
>  include/sysemu/sysemu.h                         |   5 +-
>  migration/exec.c                                |   4 +-
>  migration/migration.c                           |   2 +-
>  migration/postcopy-ram.c                        |   7 +-
>  {include/migration =3D> migration}/postcopy-ram.h |   3 -
>  migration/ram.c                                 | 275 ++++++++++--------=
------
>  migration/savevm.c                              | 185 +---------------
>  migration/socket.c                              |   1 -
>  migration/tls.c                                 |   1 -
>  migration/trace-events                          |   2 +
>  monitor.c                                       |  13 --
>  replay/replay-snapshot.c                        |   2 +-
>  16 files changed, 317 insertions(+), 377 deletions(-)
>  rename {include/migration =3D> migration}/postcopy-ram.h (95%)
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--poJSiGMzRSvrLGLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDKBKAAoJEJykq7OBq3PIYEIH/AmwlqV6s7QnG1FJezjnL8Kh
ejEKnn/lSrrC403Y8Vive0oMYFve5eec6Dwb+dGwu9VXVsH7rySLtB7HLexjw8IY
ca9ZUjUJj7heBeu2LzGUuejCQAjL/SMCm8GTYYKe2Lx8CO1b/JbTTgvVp3J67pSe
JfZEtnAtZSY3k0+sTEnAn1OkmGqEfZOLVghdrH7A32QFy95sIouYhbwtR3ZtrN1i
V8V5b1TA9DTpBrTfM0hI73sOdpS4jRTBE9+uXSvsTxm3+zd9VkEIHSjD10FNdh43
jMkv4baqFcEE7yRc2TNfXzpBxjg0V+8nNG/x/GbVb9vN/KOr0ZcRdLmWR8umDkE=
=I1kx
-----END PGP SIGNATURE-----

--poJSiGMzRSvrLGLs--
