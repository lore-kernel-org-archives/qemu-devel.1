Received: from eggs.gnu.org ([2001:4830:134:3::10]:52662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ptoscano@redhat.com>) id 1eye7F-0005ze-A4
	for Qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ptoscano@redhat.com>) id 1eye7C-0006tL-79
	for Qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:49:21 -0400
From: Pino Toscano <ptoscano@redhat.com>
Date: Wed, 21 Mar 2018 14:48:54 +0100
Message-ID: <2075074.dXtERdIzXi@thyrus.usersys.redhat.com>
In-Reply-To: <65a7365f-89d5-a66c-4e7a-ce8ae1bcf595@redhat.com>
References: <20180321124417.29242-1-ptoscano@redhat.com>
	<20180321125105.GJ19514@redhat.com>
	<65a7365f-89d5-a66c-4e7a-ce8ae1bcf595@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2077856.cQrCGbDHyq";
	micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Libguestfs] [PATCH] tests: regressions: make
 test-big-heap use a temporary empty file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: libguestfs@redhat.com
Cc: Eric Blake <eblake@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu block <qemu-block@nongnu.org>, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>

--nextPart2077856.cQrCGbDHyq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 21 March 2018 14:45:38 CET Eric Blake wrote:
> [adding qemu lists]
> 
> On 03/21/2018 07:51 AM, Richard W.M. Jones wrote:
> > On Wed, Mar 21, 2018 at 01:44:17PM +0100, Pino Toscano wrote:
> >> Newer versions of qemu use file locking for the images by default, and
> >> apparently that does not work with /dev/null.  Since this test just
> >> calls qemu-img to get the format of an empty image, create a temporary
> >> one instead.
> > 
> > ACK, but feels like this is a bug in qemu-img to me.
> 
> You're right that file locking on a character device like /dev/null is 
> not going to work as expected, but is it a case where fcntl() actually 
> fails, or is it worse where the fcntl() claiming the locks "succeeds" 
> but doesn't do what we want?  That is, what were the actual error 
> messages you ran into?

$ qemu-img --version
qemu-img version 2.10.1(qemu-2.10.1-2.fc27)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
$ qemu-img info /dev/null 
qemu-img: Could not open '/dev/null': Failed to get "consistent read" lock
Is another process using the image?

-- 
Pino Toscano
--nextPart2077856.cQrCGbDHyq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbjdOQa52nq0tQalew9FMLZhkN80FAlqyYsYACgkQw9FMLZhk
N81v6A/+ItfARU/N5BjeoBm4LZA4BnH02bvFCS1xYKyx21ul1dmx5UMnVfK4wBKf
z1Tbas69ZHbYnGbjkLUuai3vBgKrKOKWcWvgMZXMxTnzCgtxG34hJCTxwQj6EZZ7
PLO/dAGkpuwiU4H9Jok9PJCSw1m3dIABwhbvXzLSakUAVanvf3f64MaLbd+/lWYB
Jp+DhRf31WagPxLuvE3oZrKvUnvTFSuAWNGc6bymn7BTjdIrDoLfFME3NNmDy/bX
1ZnPtOGxhP0O0LHimec7e7bi7nc61ga6Wo1lcDqw6ZB+I/fwPzqziGICT5mWqdv4
fNduDwFEk0xnRvH8wZbHp/3rQx8/s/GPHCMmBZS6OSJm55kM1ltbGmfdcWvGYiDe
ZFnAXbapzPr6QbXHWXGZIkSWsmYny/GmFtXSa7mh/Vqqj9QiPV9HyPa+ESN5YPcE
wxV68XdJ+9Jhich0Wbjjbx+wgKj+iTzHTuABYg0nwAY8na10DDqXefGcKjmZRE23
B7Hh4ZE8wTwd5Fhp5Mrd8LIQ9C7yRpqC7xVPDH63weBambyHT8Jby642By7kSMQ+
0jE1JT0+/xey1BHiwfqQs20sYUtq+q+RTc12IrxJDXCT99/u5qSaJARKKCLKgoGm
GnwCBRKsSylWP/zlVGb/I+5iygBqZ1kUwWL1sJ5043C9W8lDiTQ=
=cnFh
-----END PGP SIGNATURE-----

--nextPart2077856.cQrCGbDHyq--
