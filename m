Received: from eggs.gnu.org ([209.51.188.92]:60110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gtPA9-00048F-Ip
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 22:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gtPA7-0003CM-O6
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 22:55:13 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gtPA6-00037B-E8
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 22:55:11 -0500
Received: by mail-pl1-x642.google.com with SMTP id bj4so609950plb.7
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 19:55:09 -0800 (PST)
Date: Tue, 12 Feb 2019 11:55:05 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190212035505.GE28401@stefanha-x1.localdomain>
References: <e6c30bdd-6cd0-ee9b-9fdf-cc8eaa54f7cc@yandex-team.ru>
	<20190211095049-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Content-Disposition: inline
In-Reply-To: <20190211095049-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] Is IOThread for virtio-net a good idea?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anton Kuchin <antonkuchin@yandex-team.ru>, jasowang@redhat.com, qemu-devel@nongnu.org


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 09:52:01AM -0500, Michael S. Tsirkin wrote:
> On Mon, Feb 11, 2019 at 04:40:44PM +0300, Anton Kuchin wrote:
> > As far as I can see currently IOThread offloading is used only for block
> > devices and all others are emulated by main thread.
> >=20
> > I expect that network devices can also benefit from processing in separ=
ate
> > thread but I couldn't find any recent work in this direction. I'm going=
 to
> > implement a PoC but I want to ask if you know any previous attempts and=
 do
> > you know why it can be a total waste of time. Are there fundamental
> > obstacles that prevent network emulation handling in IOThread?
>=20
> No but vhost-net is there. Unlike block where you gain lots of
> functionality such as snapshots there seems to be little to
> be gained by doing it in userspace.

Anthony Liguori tried virtio-net in a dedicated thread a long time ago
but it was never completed/merged.

I think the argument for vhost-net in the kernel is that userspace
doesn't offer the same APIs as the kernel.  For example, is zero copy
possible from userspace?

Anton: If you want to do virtio-net in userspace, QEMU has
vhost-user-net support so you can perform emulation in a separate
process.

Stefan

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcYkOZAAoJEJykq7OBq3PIBIsIAMeDgWgeVdjkKv59yMkXS96W
VDCQpjBBZeCyBVpU2N80NknvajC3BSaikyqjcgNtD1gpn9EoYTBmnjnRaYDSZ/U6
k6XI9o3/GYy7jr/k3FotT5O9GIhB6POsqnODIf2sN4cxSDfYynyMYr12xF59y9ni
kFrvd+lSIVLNQrfDcn3ghQLcWgPX7RkujqX7kqodldIkwENow/vciaqGN3U6Qcdj
AQu1d6TNTfob7T+3nJ9hHwwe+BmZqnVpvaPkpFo2DXfc5jewWeuX4Uh0riAmFsPG
e305CBrTVfsm4I3+KGNyKl9JolT124VYMxFT+5vR+MtocLfUmQa3LTs5anOk0cE=
=a6gf
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--
