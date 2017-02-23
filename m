Received: from eggs.gnu.org ([2001:4830:134:3::10]:48125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgvEO-0003el-PS
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:22:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgvEL-000805-Go
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:22:56 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:32828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgvEL-0007zB-9w
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:22:53 -0500
Received: by mail-wm0-x241.google.com with SMTP id v77so421151wmv.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 07:22:53 -0800 (PST)
Date: Thu, 23 Feb 2017 15:22:50 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223152250.GC30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760178735.31154.8978137672060558694.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h4FfhoHh9AMwLYAn"
Content-Disposition: inline
In-Reply-To: <148760178735.31154.8978137672060558694.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 29/29] 9pfs: local: drop unused code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>


--h4FfhoHh9AMwLYAn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:43:07PM +0100, Greg Kurz wrote:
> Now that the all callbacks have been converted to use "at" syscalls, we
> can drop this code.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |  198 ----------------------------------------------=
------
>  1 file changed, 198 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--h4FfhoHh9AMwLYAn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrv5KAAoJEJykq7OBq3PIL9YH/1NDCiY9AYdb4EKjU2qFspGE
Bha8Sw/qnsJNYKsS6msyUPjXv63K04SRo9vIq0letIUxSedZnoMfRZQxsd13cHHA
LcOc6w+SokJdkGvDI+25grY0qTSCP6DoL0uoUrFiZIdZJ1F9UwajRhfRUDu8WoHI
SaZIkjtqhsc6J54u13TsMqWVdLTbgECNz6/PhN6QTD1ctEasxn0gojklpAM2yfmp
33QF24zM+qZXE8FtRQekrtcIeuUm4IW4qR/tQP7fVyNiTYNL50W75sap2UJzV9ND
tWxqciqQgj+9y8HaCLEpJUPh9KuUv7gq9KpMpvTiMtC3iR05qOZT4kqlTGiPfDc=
=x7YL
-----END PGP SIGNATURE-----

--h4FfhoHh9AMwLYAn--
