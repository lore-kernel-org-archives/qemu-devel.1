Received: from eggs.gnu.org ([2001:4830:134:3::10]:42146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHQpD-00027q-BS
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 02:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHQpA-0004M0-9Y
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 02:51:35 -0500
Received: from mail-wj0-f178.google.com ([209.85.210.178]:35422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cHQpA-0004Ll-2t
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 02:51:32 -0500
Received: by mail-wj0-f178.google.com with SMTP id v7so57980297wjy.2
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 23:51:31 -0800 (PST)
Date: Thu, 15 Dec 2016 07:50:29 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161215075028.GD26169@stefanha-x1.localdomain>
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215063226-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline
In-Reply-To: <20161215063226-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] regression in 2.8: unable to exit screen grab in
 SDL mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Cole Robinson <crobinso@redhat.com>


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 15, 2016 at 06:35:39AM +0200, Michael S. Tsirkin wrote:
> The problem always reproduces for me:
> - start qemu with -sdl
> - wait for guest to boot
> - click anywhere within guest screen
> - message "press ctrl+alt to exit capture" appears on screen,
>   but pressing that immediately restarts capture again
>=20
> Note:
> - had to exit to another VT and kill qemu
> - why was I able to do that?
>   should not ctrl-alt-Fn be captured too?

Sounds related to:

commit 56f289f383a871e871f944c7226920b35794efe6
Author: Cole Robinson <crobinso@redhat.com>
Date:   Fri May 6 14:03:06 2016 -0400

    ui: sdl2: Release grab before opening console window

Stefan

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYUktEAAoJEJykq7OBq3PIYQAH/2GzyC4sA2Rqf4nYwihQ0aJE
HelDZ1xNuv6DEj0T7uKAe5nYJTFB19VAFOaO8nB9Obct1uK0tlkEDSaLwjMetT5s
WwBf2qwF+Y9uCaquk09/DNrn9g8hGLKqOnyN99/QbqUXLpL749RVIcbX/qrNcclM
1rWQxovW8s08ERCDmcXgtUFD5XwMSuNHO+tCZZbmKj3nQiJfgFuC25jMwlP6uuf/
s3q6MrjoFll+/yiVBp9oJAeG8Lc1uELcNJtLp4oT/bp8b7P9/ge7LC+TsrXmT0lo
Dzh48wnaAVwwmQ1XSSp8429h/ALH30B1XFYzEYZngwPwRQ4aN62qqUCQQZJFmg8=
=1kJG
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
