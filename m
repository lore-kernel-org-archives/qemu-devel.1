Received: from eggs.gnu.org ([2001:4830:134:3::10]:57515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1gWkZl-00041p-56
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1gWkZj-0002Kr-74
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:08:01 -0500
Received: from mo6-p02-ob.smtp.rzone.de ([2a01:238:20a:202:5302::9]:32747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1gWkZh-0002HZ-2l
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:07:59 -0500
Date: Tue, 11 Dec 2018 17:07:52 +0100
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20181211160752.GD18447@aepfle.de>
References: <20181211153047.GB18447@aepfle.de>
	<74c1c30c147444cea915ee1befa56cf6@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Content-Disposition: inline
In-Reply-To: <74c1c30c147444cea915ee1befa56cf6@AMSPEX02CL03.citrite.net>
Subject: Re: [Qemu-devel] [Xen-devel] memory leak in block/xen_disk in
 qemu-3.x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, Paul Durrant wrote:

> > -----Original Message-----
> > From: Xen-devel [mailto:xen-devel-bounces@lists.xenproject.org] On Beha=
lf
> > Of Olaf Hering
> > Sent: 11 December 2018 15:31
> > To: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org
> > Subject: [Xen-devel] memory leak in block/xen_disk in qemu-3.x
> >=20
> > What are the live time rules of ioreq->buf?
> > In my testing the memory usage of qemu is constantly growing from about
> > 250MB to several GB after a few days.
> Are you perhaps running into the problem addressed by this patch?
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg00244.html

This looks like a fix, rather than an improvement.
More than a month passed already, why is it not yet in qemu.git#master?

Olaf

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXA/g1QAKCRBdQqD6ppg2
fhfgAJ9RbUUcFAEtEsrsGiJTIS7yNgRGfACg8QiXSJxRrueSFhGycacns2r8BUg=
=cLnZ
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--
