Received: from eggs.gnu.org ([2001:4830:134:3::10]:58000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daNzO-0000jn-GR
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daNzK-0000Ox-Em
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:12:42 -0400
Date: Wed, 26 Jul 2017 16:12:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170726151221.GA3600@stefanha-x1.localdomain>
References: <20170726141924.qaqclberxsup5cdm@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20170726141924.qaqclberxsup5cdm@postretch>
Subject: Re: [Qemu-devel] [RFC] block-insert-node and block-job-delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 05:19:24PM +0300, Manos Pitsidianakis wrote:
> This proposal follows a discussion we had with Kevin and Stefan on filter
> node management.
>=20
> With block filter drivers arises a need to configure filter nodes on runt=
ime
> with QMP on live graphs. A problem with doing live graph modifications is
> that some block jobs modify the graph when they are done and don't operate
> under any synchronisation, resulting in a race condition if we try to ins=
ert
> a filter node in the place of an existing edge.

Block jobs *do* operate under synchronization.  They only manipulate the
graph from the main loop (under the QEMU global mutex just like a
monitor command).

But maybe you are thinking about higher level race conditions between
QMP commands.  Can you give an example of the race?

CCing John Snow (interested in commands for 'reaping' completed block
jobs) and Jeff Cody (block jobs maintainer).

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeLFVAAoJEJykq7OBq3PIhqsH/1yJMp2I8/GIVyIHMW5vmw08
GtXYz7ashXpS0wUfzLBLckm1OmwLyuh8M4IvtdI4y+uw1oe0MgsuqZX45f3sFqd7
95YGOiOckZxEWGE02dPt3R6EIZvSVRbm//WUd3icP1J27x8U6GvdV3j/xPHFw6sA
sP2MeReefgMxariqrwsY0mswPx142aZ2RMRsm3ir3nW57GidEtPVxwuzUo9oDqC1
Yf9fG19iRX1ln0LCnCPTWVGAYonI/oZ1TsUHq6JNqfVPjcS6RardGdxvucOEJvpV
Kt5EokVnVELj+Jg2nDVC00+3C4eX4QcEWIz2n1++fFLrb1BIIz6PLzpH8bsP1WI=
=nPAz
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
