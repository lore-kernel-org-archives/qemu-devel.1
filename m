Received: from eggs.gnu.org ([2001:4830:134:3::10]:37489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dOOIb-0005gZ-Hk
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dOOIY-0003ZC-Ed
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:06:57 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dOOIY-0003Yt-5q
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:06:54 -0400
Received: by mail-wr0-x231.google.com with SMTP id c11so65115853wrc.3
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 06:06:54 -0700 (PDT)
Date: Fri, 23 Jun 2017 14:06:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170623130650.GD14304@stefanha-x1.localdomain>
References: <20170621122234.12751-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline
In-Reply-To: <20170621122234.12751-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sdl2: add assert to make coverity happy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2017 at 02:22:34PM +0200, Gerd Hoffmann wrote:
> There is a loop a few lines up counting consoles and setting
> sdl2_num_outputs accordingly, so con ptr can't be NULL there.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/sdl2.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZTRJqAAoJEJykq7OBq3PIJ4kIAKhhrCCnJiwhT4VFGOLh/tI1
FnTHDkuAJCLuJcy+oQn7CJLlmsm2FEUDZY35hkfy3+ylvyzNvfwTqeQJHVHHeuXq
jvj5c1aPIaUfGmBiZj4rOjwGde6J/nJpkXYaYL0bZYu0npneU5JP1jj1UbZznVyk
tajazEgb3+2GpybTFlivXq5gs9tUjDNiCHUAcIk01wlbRK7K1KbjTxw0pUlXCmPV
+Cu/rnMa4tF+lkhw+Dz7+0rg3myrAZB//GiJuU5tRoPPMrlbHK9J7FK1i/+d4XW0
jQfADqkDbhvu2JeCntLJrpomCDwCLUSNW6eS/GhSb6UA/p7+PRNyTXAWdY5Th0U=
=Y+e4
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
