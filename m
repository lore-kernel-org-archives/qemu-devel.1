Received: from eggs.gnu.org ([2001:4830:134:3::10]:43777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKPxW-0003nG-EB
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKPxR-0004dZ-FN
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:04:46 -0400
Received: from mail-lf0-x232.google.com ([2a00:1450:4010:c07::232]:34000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dKPxR-0004dH-71
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:04:41 -0400
Received: by mail-lf0-x232.google.com with SMTP id v20so51541326lfa.1
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 07:04:41 -0700 (PDT)
Date: Mon, 12 Jun 2017 15:04:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170612140425.GD17075@stefanha-x1.localdomain>
References: <20170608182113.nmxnvus26vplg5du@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Content-Disposition: inline
In-Reply-To: <20170608182113.nmxnvus26vplg5du@postretch>
Subject: Re: [Qemu-devel] [Proposal] I/O throttling through new -object
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 08, 2017 at 09:21:13PM +0300, Manos Pitsidianakis wrote:
> Users can hotplug ThrottleGroups with object-add in QMP/HMP, then
> attach drives to a throttle group (ie adding a filter node in the drive path
> that points to that throttle group) with an 'attach-throttle' and detach
> with 'detach-throttle', each taking the drive and throttle group name as
> arguments.

BDS nodes are added/removed with blockdev-add/blockdev-del.  Why are new
attach-throttle/detach-throttle commands necessary?

Stefan

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZPp9pAAoJEJykq7OBq3PIZ1AH/1zBpsZTUQqzfQUJnAy+EgHx
9Kf0rOO0JfZWRn/tmJztBRj00cE6b5MVO7fKrpubqnQeT7szy9Pcc/h+TXOmopXX
CvxPK/e+DfDQdQP9/GZ60b5UH3HMcYVsShQ8hK2QeGXLzwRmCL4fEcjGuHCTsX+x
VfEe9XYoAfnu79EUV1cfrmYs7vscH33iQPoXUjEmUpBmMHwzAG894uaXTdEW43bW
zGLnw9xVdB9ewkWn0T+S5l1pa9g6M8j+EgJeQbwsA/p4yideobUWuRjHw85sZciP
w3ll9Oq6lbUuHaHxTHPm1Z/EB8wgfO7wmtQlp6L9WhnGijizYdDu59zmR7X0Jqw=
=saLV
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
