Received: from eggs.gnu.org ([2001:4830:134:3::10]:37674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8WUN-0004NM-Ga
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8WUM-0003IB-K0
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:37:31 -0400
References: <20170510143205.32013-1-pbonzini@redhat.com>
	<20170510143205.32013-6-pbonzini@redhat.com>
	<aeb8c806-9c6b-fcd8-6c2a-cd4098946ff9@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5fc63e28-901c-6e93-2cbe-d25f9e6f45dc@redhat.com>
Date: Wed, 10 May 2017 13:37:23 -0500
MIME-Version: 1.0
In-Reply-To: <aeb8c806-9c6b-fcd8-6c2a-cd4098946ff9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rVe9c2hAswddLdDJDfm5OL3mopwiJCGg3"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 5/7] curl: convert CURLAIOCB
 to byte values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rVe9c2hAswddLdDJDfm5OL3mopwiJCGg3
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com
Message-ID: <5fc63e28-901c-6e93-2cbe-d25f9e6f45dc@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 5/7] curl: convert CURLAIOCB to
 byte values
References: <20170510143205.32013-1-pbonzini@redhat.com>
 <20170510143205.32013-6-pbonzini@redhat.com>
 <aeb8c806-9c6b-fcd8-6c2a-cd4098946ff9@redhat.com>
In-Reply-To: <aeb8c806-9c6b-fcd8-6c2a-cd4098946ff9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/10/2017 12:36 PM, Max Reitz wrote:

> On a very surprised level: Why does curl return the content length as a=

> double?! I can't think of a reason where that might be a good idea. If
> your integer no longer fits into a uin64_t, the double will be inexact,=

> so it pretty much is useless, too...

Not to mention: NO ONE has off_t larger than 63 bits (there physically
is not that much storage around!), so a signed 64-bit integer should
always be sufficient, rather than artificially limiting exact answers to
53 bits of precision via a double.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rVe9c2hAswddLdDJDfm5OL3mopwiJCGg3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZE13jAAoJEKeha0olJ0NqsoYH/jWNc7ceQh9HzQQnFAsQSg6Y
DVO4SWsIdtBCIuFxWVnO4C6vXkARlqLlCfROeusHYa7F5jEQ9F3HB9ZkKbBBYtKC
AS0RGX9W+BJMU5JRikzO64lPkG1/Be9OViO1qh9tTKa+p8ontPzxmL/q6nwSbpCZ
ytqmYIRMxdxYAA+8mr0uDaHgQx+8Vl9T1KpTaVuqeD9caXU0davfCvuo2YUEj296
kED29RdX5Rb+PCaTmPNOwDZOgSafGOQ4TyAIsQoLMWq67NIYK1zyV1Pv49UtJSOu
cOHRISfIdZ6xis3Rvg3prstBW1xRrK+XwJKktB00C0HCxzP6ME7TRVAomcjVz04=
=TBJF
-----END PGP SIGNATURE-----

--rVe9c2hAswddLdDJDfm5OL3mopwiJCGg3--
