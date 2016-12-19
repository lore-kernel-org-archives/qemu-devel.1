Received: from eggs.gnu.org ([2001:4830:134:3::10]:56007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cIvjW-0001Uw-EB
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cIvjR-0008BU-Ek
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:03:54 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cIvjR-0008BI-88
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:03:49 -0500
Received: by mail-wm0-x242.google.com with SMTP id a20so17970787wme.2
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 03:03:49 -0800 (PST)
Date: Mon, 19 Dec 2016 11:03:46 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161219110346.GC17374@stefanha-x1.localdomain>
References: <1a3a7aef-55f1-11b6-b33f-621979cbb59f@profihost.ag>
	<1383290552.4515122.1481729638569.JavaMail.zimbra@oxygem.tv>
	<32c0e94e-8beb-03f3-2605-46225500e6ad@profihost.ag>
	<464605215.4528644.1481784392571.JavaMail.zimbra@oxygem.tv>
	<ba2e2786-a7ba-5ad9-86ef-aae1c4def034@profihost.ag>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
In-Reply-To: <ba2e2786-a7ba-5ad9-86ef-aae1c4def034@profihost.ag>
Subject: Re: [Qemu-devel] any known virtio-net regressions in Qemu 2.7?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, qemu-devel <qemu-devel@nongnu.org>, power-management@lists.fedoraproject.org, jskarvad@redhat.com


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2016 at 10:00:36PM +0100, Stefan Priebe - Profihost AG wrot=
e:
>=20
> Am 15.12.2016 um 07:46 schrieb Alexandre DERUMIER:
> > does rollbacking the kernel to previous version fix the problem ?
>=20
> The culprit is the used tuned agent from Redhat
> (https://github.com/redhat-performance/tuned). The used profile
> virtual-host results in these problems. Stopping tuned or using another
> profile like throughput-performance everything is fine again.

Interesting discovery.  Have you filed a bug report about it?

> after upgrading a cluster OS, Qemu, ... i'm experiencing slow and
> volatile network speeds inside my VMs.
>
> Currently I've no idea what causes this but it's related to the host
> upgrades. Before i was running Qemu 2.6.2.
>
> I'm using virtio for the network cards.

Stefan

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYV76SAAoJEJykq7OBq3PIQWgH/1UXqzj9958yGas+bqxiK1y9
UAJqx5t5JApLs8jXALmkgEW8MvHcxBmOyKpYsps9pa93akZPF1d9Rx5FPAvYN25x
MVn+AG5/CTmdIliodwJK9mn+DZVdlB/CEF9+YFDqbMnCVbVzWrTUZ042tshTTBZz
5sWhkOcRW3dhjNeY8tBL/9fzlpmqmf9IwBSiEEyf5AYMFWCio//ZiKzISZDqdkaj
aoQNvHhWgl1PWcB9jYtj1MpbuH8ueUZ2xBKtRd2/HDii30n/Y91uZP4BSoOgSm/w
Zh0gRo8H4vU2zOYAI3rC0yqkMxBkXnI+rKiFzxmws/Rx+Q5d+sCnp4EdjoZrR7Y=
=ziXf
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
