Received: from eggs.gnu.org ([2001:4830:134:3::10]:34324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cjcsv-0003eL-19
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 21:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cjcsq-0001tR-3M
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 21:23:57 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cjcsp-0001sg-UL
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 21:23:52 -0500
Received: by mail-pf0-x242.google.com with SMTP id e66so2738261pfe.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 18:23:51 -0800 (PST)
Date: Fri, 3 Mar 2017 10:23:47 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170303022347.GD11833@stefanha-x1.localdomain>
References: <20170302181308.69662-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Content-Disposition: inline
In-Reply-To: <20170302181308.69662-1-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] event_notifier: prevent accidental use
 after close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, "Michael S. Tsirkin" <mst@redhat.com>


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2017 at 07:13:08PM +0100, Halil Pasic wrote:
> Let's set the handles to the underlying facilities to their extremal
> value so no accidental misuse can happen, and to make it obvious that the
> notifier is dysfunctional. E.g. if we just close an fd but do not touch
> the int holding the fd eventually a read/write could succeed again when
> the fd gets reused, and corrupt the file addressed by the fd.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>=20
> No strong feelings about this, but obviously, I do think it's worth a
> try.
>=20
> The one who brought this unfortunate possibility to my attention was
> Michael Tsirkin.
> ---
>  util/event_notifier-posix.c | 2 ++
>  util/event_notifier-win32.c | 1 +
>  2 files changed, 3 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYuNOzAAoJEJykq7OBq3PImtUIALSJCiSpTllw83R5ZZqjp9u3
p3fWM9giUTw2w8mG5oGTgIkG4HH2PxGcOQTC98ykGEimjyr9Zw9Ee3WbEbvhp6Mo
syovWME8PM5K8jkLI4mSMiCViGt8bFOSwCpqh0h431yDKCT00ggEyRBJGFqRE4re
DTFBY3OWxVdVCK/I/yPgTkjAqvW+y7TFRqi4VebS7k2ZltAchLEmLQ4ohgVSZpVS
/f7ouFC03fEWslm360Oub9d91P2/2SWRHUEZ3S0F+3+ChwdKfZ4iL7qkh9aHycQY
vVKKNjuoc/j2Wibym3s6wIGgW2WIOFzqB6Rf/aRqlQ7hoLwWHfeaOgLz9MLQKAo=
=EelD
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
