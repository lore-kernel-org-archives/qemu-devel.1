Received: from eggs.gnu.org ([2001:4830:134:3::10]:60826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBHmg-00027n-Vr
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBHmc-0001x7-8M
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:31:50 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dBHmc-0001x3-1A
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:31:46 -0400
Received: by mail-wr0-x232.google.com with SMTP id l50so29228540wrc.3
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 02:31:45 -0700 (PDT)
Date: Thu, 18 May 2017 10:31:42 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170518093142.GG30862@stefanha-x1.localdomain>
References: <20170517180754.20456-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7lMq7vMTJT4tNk0a"
Content-Disposition: inline
In-Reply-To: <20170517180754.20456-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/3] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com


--7lMq7vMTJT4tNk0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 07:07:51PM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> The following changes since commit cdece0467c00007cf8e3f4b3c3f0b13bf2c4fe=
a9:
>=20
>   block/win32: fix 'ret not initialized' warning (2017-05-16 15:34:18 +01=
00)
>=20
> are available in the git repository at:
>=20
>   git://github.com/dagrh/qemu.git tags/pull-hmp-20170517
>=20
> for you to fetch changes up to be9b23c4a539090da30b482015ee660850e8bb5f:
>=20
>   ramblock: add new hmp command "info ramblock" (2017-05-17 17:31:16 +010=
0)
>=20
> ----------------------------------------------------------------
> HMP pull
>=20
> ----------------------------------------------------------------
> Peter Xu (3):
>       ramblock: add RAMBLOCK_FOREACH()
>       utils: provide size_to_str()
>       ramblock: add new hmp command "info ramblock"
>=20
>  exec.c                       | 44 +++++++++++++++++++++++++++++++++-----=
------
>  hmp-commands-info.hx         | 14 ++++++++++++++
>  hmp.c                        |  6 ++++++
>  hmp.h                        |  1 +
>  include/exec/ramlist.h       |  6 ++++++
>  include/qemu-common.h        |  1 +
>  migration/ram.c              | 13 +++++++------
>  qapi/string-output-visitor.c | 22 ++++++----------------
>  util/cutils.c                | 25 +++++++++++++++++++++++++
>  9 files changed, 99 insertions(+), 33 deletions(-)
>=20

Peter has already merged pull requests from your RH2 PGP key.  I will
merge it even though gpg doesn't trust the key.

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--7lMq7vMTJT4tNk0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHWn+AAoJEJykq7OBq3PI4ccH/AmD6OJlfSK06EFQVxXKZQZz
9Oa8DCzajLW9z6iMV6OL+VHrXM0EGKXVvBcQZw3h0+obDQ0Nx4SeOpuFsTWCMVit
3Nsb1adt2JPIs1FQZcsjSegPSFtrj2ULsGW4iyJWWecuZAxhB/Yt98Qewq+YqWTF
dLbxoeow27y9RP0ILmh0vGWUgrxwOl6TWlrTotDOJTpa8e/3q9yNoOOV++zrTUoG
/iznNm9H/1aNkMihWK8mOuWLutqE5y7ofCSQZK9n33V1z6yuxKteGpce/M/UDt6i
+uwnegC9kQmiow4u0CKO+glNB4VCc97sJ3Zs+QX4Zo1IooRcGNeof8WYiDGBbCE=
=5q1p
-----END PGP SIGNATURE-----

--7lMq7vMTJT4tNk0a--
