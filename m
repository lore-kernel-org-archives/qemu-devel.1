Received: from eggs.gnu.org ([2001:4830:134:3::10]:45335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dW30C-00022c-PL
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dW30B-0005mu-Qt
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:59:36 -0400
References: <20170714103105.5781-1-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f508a164-5cd9-7432-3502-117388d8bc41@redhat.com>
Date: Fri, 14 Jul 2017 17:59:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170714103105.5781-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Vfh9rVmg4D48R1QIUt17wQvcbfxOr9OMX"
Subject: Re: [Qemu-devel] [PATCH] qcow: fix memory leaks related to
 encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vfh9rVmg4D48R1QIUt17wQvcbfxOr9OMX
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <f508a164-5cd9-7432-3502-117388d8bc41@redhat.com>
Subject: Re: [PATCH] qcow: fix memory leaks related to encryption
References: <20170714103105.5781-1-berrange@redhat.com>
In-Reply-To: <20170714103105.5781-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-14 12:31, Daniel P. Berrange wrote:
> Fix leak of the 'encryptopts' string, which was mistakenly
> declared const.
>=20
> Fix leak of QemuOpts entry which should not have been deleted
> from the opts array.
>=20
> Reported by: coverity
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow.c  | 5 +++--
>  block/qcow2.c | 7 ++++---
>  2 files changed, 7 insertions(+), 5 deletions(-)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--Vfh9rVmg4D48R1QIUt17wQvcbfxOr9OMX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZaOpcEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQJFR
B/9ncCMLa7Amfd17oNchK2aA1TyBxYTUO7RuSeU3uhEnG84njg6F9ayyhQ4V3bCY
ytl13xabC0sFZtrWl9P3SY4fEujJ0D2E6Us4RswxJNr37uuL6x1QRXQ/1hLfaf5I
F6NWeTwzd21qcaLNwkbmoBe3dyh4k0Hyq4XsvQiy5G4Kpbw9DuhnUwB7pPUMlJKv
hrawQenwPVkX9OcPe17CPovF4n1BUNXXqHlaS/dSkF06tZSHWgOPfMR0EFCRDxVU
sIYIu7uoF/H42Wm+WS38+YVZsylWpQ9iC2w+KBOpP2X27Q2ddPPEm3muAH/q8hld
DsNdqY29W6suMRLbL+B65suw
=aA4b
-----END PGP SIGNATURE-----

--Vfh9rVmg4D48R1QIUt17wQvcbfxOr9OMX--
