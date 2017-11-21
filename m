Received: from eggs.gnu.org ([2001:4830:134:3::10]:36555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eH7Xn-00020r-FO
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eH7Xm-0005te-DB
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:20:51 -0500
References: <cover.1511230683.git.jcody@redhat.com>
	<1f0fd95c2096688add2c7b3cfcd7016756ef19fb.1511230683.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6343710b-dcad-4f0e-d669-d3b554606062@redhat.com>
Date: Tue, 21 Nov 2017 06:20:34 -0600
MIME-Version: 1.0
In-Reply-To: <1f0fd95c2096688add2c7b3cfcd7016756ef19fb.1511230683.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XUaq8D7XEKOkk2wgF1HoaT3bfdhrEk1R7"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 2/4] coroutine: abort if we try
 to schedule or enter a pending coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XUaq8D7XEKOkk2wgF1HoaT3bfdhrEk1R7
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <6343710b-dcad-4f0e-d669-d3b554606062@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 2/4] coroutine: abort if we try
 to schedule or enter a pending coroutine
References: <cover.1511230683.git.jcody@redhat.com>
 <1f0fd95c2096688add2c7b3cfcd7016756ef19fb.1511230683.git.jcody@redhat.com>
In-Reply-To: <1f0fd95c2096688add2c7b3cfcd7016756ef19fb.1511230683.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/20/2017 08:23 PM, Jeff Cody wrote:
> The previous patch fixed a race condition, in which there were
> coroutines being executing doubly, or after coroutine deletion.
>=20
> We can detect common scenarios when this happens, and print an error
> message and abort before we corrupt memory / data, or segfault.
>=20
> This patch will abort if an attempt to enter a coroutine is made while
> it is currently pending execution, either in a specific AioContext bh,
> or pending execution via a timer.  It will also abort if a coroutine
> is scheduled, before a prior scheduled run has occured.

s/occured/occurred/

>=20
> We cannot rely on the existing co->caller check for recursive re-entry
> to catch this, as the coroutine may run and exit with
> COROUTINE_TERMINATE before the scheduled coroutine executes.
>=20
> (This is the scenario that was occuring and fixed in the previous

s/occuring/occurring/

> patch).
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XUaq8D7XEKOkk2wgF1HoaT3bfdhrEk1R7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloUGhMACgkQp6FrSiUn
Q2rsjgf/VYR8poZYVy2xJIJ5g6blFfEwrOlR/pOFjPr48VHwg2Yyv3Kk8NF6gH34
hSchmID8t7BIakwlUKex0sTdlCAsPJuqA6tANTTx/BY4gys3VM/rx8b2I3nUkSaP
gkM9Qeb5fRLh+KrxuyVwJixfs6eQWiTH2DhKH3DD1pZ6rJ/ciLZOhdw9WXIeEt7N
EDkCEjf0TJgTA/Q8BytZzFGQlOQKwC3YGA7MzUj4IyGJvvi/g81OfX6JT9jzKu8B
Q+/nXG37jG1h/nNJa6vL8VpXa9SSPq5r2eitj2Xdw29BUn5Vrixm34JgythhF3Hi
oU5yOLXu4DhwWVtO/7+SWR1hyryi1Q==
=1kQO
-----END PGP SIGNATURE-----

--XUaq8D7XEKOkk2wgF1HoaT3bfdhrEk1R7--
