Received: from eggs.gnu.org ([2001:4830:134:3::10]:43022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhc8Q-0004ph-DN
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhc8P-0008NL-Gf
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:43:54 -0400
References: <20170815130502.8736-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a2e272ed-4c69-b692-1775-ffd95bdc4a0f@redhat.com>
Date: Tue, 15 Aug 2017 08:43:39 -0500
MIME-Version: 1.0
In-Reply-To: <20170815130502.8736-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V0xTC3lelvnTT9RVG5wn65b5vJ4FgcrmS"
Subject: Re: [Qemu-devel] [PATCH for-2.10] qemu-iotests: step clock after
 each test iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V0xTC3lelvnTT9RVG5wn65b5vJ4FgcrmS
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>
Message-ID: <a2e272ed-4c69-b692-1775-ffd95bdc4a0f@redhat.com>
Subject: Re: [PATCH for-2.10] qemu-iotests: step clock after each test
 iteration
References: <20170815130502.8736-1-stefanha@redhat.com>
In-Reply-To: <20170815130502.8736-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/15/2017 08:05 AM, Stefan Hajnoczi wrote:
> The 093 throttling test submits twice as many requests as the throttle
> limit in order to ensure that we reach the limit.  The remaining
> requests are left in-flight at the end of each test iteration.
>=20
> Commit 452589b6b47e8dc6353df257fc803dfc1383bed8 ("vl.c/exit: pause cpus=

> before closing block devices") exposed a hang in 093.  This happens
> because requests are still in flight when QEMU terminates but
> QEMU_CLOCK_VIRTUAL time is frozen.  bdrv_drain_all() hangs forever sinc=
e
> throttled requests cannot complete.
>=20
> Step the clock at the end of each test iteration so in-flight requests
> actually finish.  This solves the hang and is cleaner than leaving test=
s
> in-flight.
>=20
> Note that this could also be "fixed" by disabling throttling when drive=
s
> are closed in QEMU.  That approach has two issues:
>=20
> 1. We must drain requests before disabling throttling, so the hang
>    cannot be easily avoided!
>=20
> 2. Any time QEMU disables throttling internally there is a chance that
>    malicious users can abuse the code path to bypass throttling limits.=

>=20
> Therefore it makes more sense to fix the test case than to modify QEMU.=

>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/093 | 4 ++++
>  1 file changed, 4 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

I can take this through the NBD tree (since that's one environment that
trips up on the test), if Peter doesn't apply it directly.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--V0xTC3lelvnTT9RVG5wn65b5vJ4FgcrmS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmS+osACgkQp6FrSiUn
Q2rrOAf+MaKb12yTaRpXfrqI5QBv+LRlL66hlfFjokA75IM2nQHsGa82+tdXcqMt
8y13wmNwYuERuVKFiZvYTAnqVL8BVYhQu0UCNgk2jtStPGnqAzPsS64rx4l9cXE+
wrwQGFoIiNO8nswkwx0LwyacR/x0/dtshir0RZmI9QLGnAKN0VH9cLTql+R9GJHq
+4v5Lh9esLSRRowhe2K4kI9u1IhW7gg4wnTd1C7y0j0TUETWDv4QZXnpcORwdw3I
BR3DTuFa+AHabSy32qexFxGKuKlPlSBuOUAdy8lswQ8ruo+y95fTBlSR8Sdki8QY
h8TZC0bIOoffSoK6wNS7sqizWpZYJg==
=IIPN
-----END PGP SIGNATURE-----

--V0xTC3lelvnTT9RVG5wn65b5vJ4FgcrmS--
