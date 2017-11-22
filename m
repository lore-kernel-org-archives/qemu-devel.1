Received: from eggs.gnu.org ([2001:4830:134:3::10]:49682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHY3U-0001LZ-2Y
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 11:39:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHY3T-0005AF-7A
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 11:39:20 -0500
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
	<20171122101958.17065-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c9e4edd3-6cbe-b8ac-cc56-bb768de8ddc8@redhat.com>
Date: Wed, 22 Nov 2017 10:39:02 -0600
MIME-Version: 1.0
In-Reply-To: <20171122101958.17065-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gnRclvXexuXUMb4etaOd3dbTmwr33u2sc"
Subject: Re: [Qemu-devel] [PATCH 1/5] nbd/server: refactor negotiation
 functions parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gnRclvXexuXUMb4etaOd3dbTmwr33u2sc
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org
Message-ID: <c9e4edd3-6cbe-b8ac-cc56-bb768de8ddc8@redhat.com>
Subject: Re: [PATCH 1/5] nbd/server: refactor negotiation functions parameters
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
 <20171122101958.17065-2-vsementsov@virtuozzo.com>
In-Reply-To: <20171122101958.17065-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/22/2017 04:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> Instead of passing currently negotiating option and its length to
> many of negotiation functions let's just store them on NBDClient
> struct to be state-variables of negotiation phase.
>=20
> This unifies semantics of negotiation functions and this allows to
> track changes of remaining option length in future patches.

"allows to $verb" is not idiomatic English; the options are "allows
$subject to $verb" or "allows ${verb}ing"

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 164 +++++++++++++++++++++++++++++----------------------=
--------
>  1 file changed, 82 insertions(+), 82 deletions(-)

Not really a net win in lines of code; but I'll have to see how the
other patches in the series are made easier by this.  It relies on the
fact that the NBD protocol states that negotiation phase is synchronous
(at one point, it was argued that negotiation, like transmission, could
allow out-of-order replies from the server, but we got that fixed in the
spec to match existing practice, and this patch cements the fact that we
are processing exactly one option at a time).

Mechanically, the conversion looks sane, so:
Reviewed-by: Eric Blake <eblake@redhat.com>

We'll see how I feel at the end of the series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gnRclvXexuXUMb4etaOd3dbTmwr33u2sc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloVqCYACgkQp6FrSiUn
Q2odOwgApgHaeFQSjkwPhtzl9f8aIgdLBibzYRNYv5xnud0xiXpLfdb+zo/Z3EFV
76o9GHkLzPc9ifMqomx43hLs3G7nUsrAkErmcEPDifDstUdwGzGc/Y8aJj4NDJRT
FV9F82KBj7GYPFC8I+V9X54aO3H4ukzAz0H3Gj84ftXjYgWGkZvpSNVf4neCFbhv
w4qLR/vneJuT8CvFn2L21kCREKZnM7vcK1Fqx7p7foJHahC9dkbI71GJ790ngDWd
PIZqIDRDI+U0tYr7BgqlPYhppXgyNPqRRAI6Cqp7CcdIbCjMvk+casRVp9XC/SnI
o+vHqMQ06/u/i+6zrr9Dwr8mpleF/g==
=/5w+
-----END PGP SIGNATURE-----

--gnRclvXexuXUMb4etaOd3dbTmwr33u2sc--
