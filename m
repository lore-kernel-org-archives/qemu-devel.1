Received: from eggs.gnu.org ([2001:4830:134:3::10]:53961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fxX4h-000368-OK
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fxX4g-00042g-Ir
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:38:23 -0400
Date: Wed, 5 Sep 2018 14:38:13 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180905123813.GF3803@andariel.pipo.sk>
References: <20180810162658.6562-1-kwolf@redhat.com>
	<20180810162658.6562-2-kwolf@redhat.com>
	<20180828142626.GM122225@angien.pipo.sk>
	<20180903150311.GC14463@dhcp-200-186.str.redhat.com>
	<w51bm9dl81j.fsf@maestria.local.igalia.com>
	<20180904141730.GC3803@andariel.pipo.sk>
	<w515zzll3xy.fsf@maestria.local.igalia.com>
	<20180904150042.GE3803@andariel.pipo.sk>
	<20180904153436.GC4371@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Content-Disposition: inline
In-Reply-To: <20180904153436.GC4371@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 1/2] commit: Add top-node/base-node options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 17:34:36 +0200, Kevin Wolf wrote:
> Am 04.09.2018 um 17:00 hat Peter Krempa geschrieben:
> > On Tue, Sep 04, 2018 at 16:42:17 +0200, Alberto Garcia wrote:
> > > On Tue 04 Sep 2018 04:17:30 PM CEST, Peter Krempa wrote:

[...]

> > I remember being told some time ago to specify both layers explicitly.
> > Since it's not yet enabled in libvirt we theoretically could change to
> > one -blockdev for format+protocol but in that case we need some kind
> > of guarantee that every (even new) feature will work with it.
> >=20
> > Switching between those approaches once we enable it upstream will not
> > be possible without adding a lot of compatibility code.
>=20
> Yeah, I think specifying both layers explicitly is cleaner. This should
> probably be solved some way inside QEMU.
>=20
> The read-only option for the backend isn't that useful anyway. Maybe we
> should do away with it, at least for its current purpose, and just rely
> on write permissions taken by parents. We could then either silently
> ignore (and deprecate) the read-only backend option or we could change
> its semantics to mean "never allow a writer on this node".

So I tried that approach and it seems to work just fine with files
including sharing part of the read-only backing chain with other VMs
without the image locking mechanism ruining the day.

block-commit is able to reopen the format layers and works as expected.

Unfortunately though the 'read-only' option is actually useful as the
curl-driver does not work without it:

-blockdev {"driver":"http","url":"http://ftp.sjtu.edu.cn:80/ubuntu-cd/12.04=
/ubuntu-12.04.5-alternate-amd64.iso","node-name":"libvirt-2-storage","disca=
rd":"unmap"}: curl block device does not support writes

We obviously can encode that knowledge into libvirt but it will be hard
to undo if qemu eventually supports writes in the curl driver.

Which other protocol drivers don't support writes? in case we have to go
this way.

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAluPzjIACgkQHGwCByjY
1GqIghAAobgCg2DApZWZNWiYyHYBlr3q814JrJQcks2ArL2ppMed6Z6qzJ0l1WC0
DIqb2twe8JxKa8/2pDALmZTuQmdzb1TJJ8IvZgdPhZklKIYLM/1ZerYffHXHEu05
sHdwVaiWx9wHJZOspa2TxNINIrfniD/QZwu69ug1nKbv/PB0Q/XSSFWaXoI1St8e
CSnqYlPuRW17jLJwyk/TDxjD+sQx5XnMxIzrVp6ZvUT4OJmglNxJ+gTMEecE7VKn
vuibeIfPSCYfnJ2WztNIAiS2XX+Bj0yiI8NmtBYHVCB9CYqb3rUuCRIkGIh9ppwH
u64dDC5rPbiBNW/RaGnYNmEuxYENFaZtTPCWW5vbwF9o3xpMBbV7QJR2dX8psOe+
MC8ykfsJlBFhcfyz9T+jTNsr+E3yujrdS9lF5Ea5wyDocPghvCXkgzf6csAHuIoJ
HwFa/NVzMOfp/czPi6qcPafIUp9cvAfZRM088O92CeNOJZCHaD+IbPwNF9IV64fO
Nr8yiUJ9lp7bkiJ4P9t0jOX5qdsUNVzckEtj4rVWTW5o75strRWSEDle03RnZ/Rl
9HWMRxOWRQUA8WeJDrdu0jMCUJfHZb19QLQZOo2wea/EAtWK7LHv1QkHAXl9c4x0
2Aa7J8Bo5q41PNCAVjg0vswgyDgA1+xuItLHCVlZOxly1aWchCU=
=wbBd
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--
