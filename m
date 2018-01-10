Received: from eggs.gnu.org ([2001:4830:134:3::10]:34088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZJca-0006P2-J5
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:53:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZJcZ-0002vo-Or
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:53:00 -0500
Date: Wed, 10 Jan 2018 16:52:48 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180110165248.GD24212@stefanha-x1.localdomain>
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline
In-Reply-To: <20180110091846.10699-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/9] stubs: Add stubs for ram block API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Karl Rister <krister@redhat.com>


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2018 at 05:18:38PM +0800, Fam Zheng wrote:
> These functions will be wanted by block-obj-y but the actual definition
> is in obj-y, so stub them to keep the linker happy.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  stubs/Makefile.objs |  1 +
>  stubs/ram-block.c   | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
>  create mode 100644 stubs/ram-block.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVkTgAAoJEJykq7OBq3PI2PsIALk7AIBY/02AJGX1rdrgm+nQ
zXPGUpBcEMZOomzZIQm3Y2anrashy/O7BU39O2l8F0KOg3RI/hG8Z8Rod72BwqEV
4wJbGhNjZdRcgnk5B34Ya4Zug1ViwNlpNEb5UjjU71V4Hq6PnPvXSK9Wjq2ZRiSR
iTZ3p2s2Me4F9yE2yhMTSaCpc4LUxcieOomjc4SJ1tsczEMws2iyJT01AdT6Mvaa
HTVivBXi3qKmvVD/3CjI1+XKobBfsY+snImGWmgDNhpcjtakyk/bwdeS4BxKSWvF
stEqvw+4GOdDKPuBlsF7XzSPG/oBWitMIaD4eg2FxDHFIKaXsW1JX8s/FK9HAA8=
=yrFZ
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
