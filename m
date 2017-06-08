Received: from eggs.gnu.org ([2001:4830:134:3::10]:46562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIuGd-0004v7-6S
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIuGa-00009B-2M
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:02:15 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dIuGZ-00008t-Rx
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:02:12 -0400
Received: by mail-wm0-x242.google.com with SMTP id 70so6472871wme.1
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 03:02:11 -0700 (PDT)
Date: Thu, 8 Jun 2017 11:02:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170608100208.GA4145@stefanha-x1.localdomain>
References: <7f44106b-c67e-2581-f59b-36a9796a9a36@upsilon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <7f44106b-c67e-2581-f59b-36a9796a9a36@upsilon.org.uk>
Subject: Re: [Qemu-devel] KVM guests fail to start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Cunningham <ml@upsilon.org.uk>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 08:42:58AM +0100, David Cunningham wrote:
> Apologies if this list is inappropriate, I've failed to come across
> anything pertinent via Google. If anyone can suggest a more appropriate
> forum please do.
>=20
> I'm having a problem starting KVM guests since performing a routine
> apt-get upgrade on a debian jessie system.
>=20
> On starting a guest via virt-manager I'm getting the below error.
>=20
> The same behaviour is seen with existing guests or newly created guests.
>=20
> Could anyone point me towards a solution, or debug course?
>=20
> Thanks...
>=20
>=20
> Error starting domain: internal error: QEMU / QMP failed: Failed to open
> module: /usr/lib/x86_64-linux-gnu/qemu/block-iscsi.so: undefined symbol:
> aio_bh_schedule_oneshot
> Failed to open module: /usr/lib/x86_64-linux-gnu/qemu/block-curl.so:
> undefined symbol: aio_bh_schedule_oneshot
> Failed to open module: /usr/lib/x86_64-linux-gnu/qemu/block-rbd.so:
> undefined symbol: aio_bh_schedule_oneshot
> Failed to open module: /usr/lib/x86_64-linux-gnu/qemu/block-ssh.so:
> undefined symbol: inet_connect_saddr

Please make sure your qemu-block-extra and qemu-system-x86 packages are
up-to-date.  They should both have the same version number.

Are you using a backports package for QEMU?

Stefan

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOSCgAAoJEJykq7OBq3PI514IAJK1Kv9/f6BnwgTDfCqPQ0VP
FqE5rM15Kq/6SBZ4aRZHmF60bYl9x9F0wqznlon0ZQ3P+ttP3SeSSHJ6p5mmPcYM
7IXHfX+nPwJTLKGyhxKSFVJCc2tIH0xaOtkIPMxcymkNsbMURyxXrYwr9537vQX5
VDccsJ1W9r0mYwU3vdIX/w7IzhO1vXTKgb/TOixgJj+YCDJbUThX6E/v3pztt1cY
wmqRIxwO0yTXl9xnh1JaIHntOfxalRaE1n8JFQbSqUFnZ2lYgK2FKi9Lx5+kBQpz
dQlEM7w+vRfUAiltbPqjUZFgCPYPhQ/XlhWWIPSCq7F7IBjXn19a/e+I0UFGjOY=
=yRJx
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
