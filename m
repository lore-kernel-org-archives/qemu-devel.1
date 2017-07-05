Received: from eggs.gnu.org ([2001:4830:134:3::10]:56749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dSlgj-0004TP-L8
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dSlgi-0000cI-UL
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:53:57 -0400
Date: Wed, 5 Jul 2017 15:53:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170705145347.GE29910@stefanha-x1.localdomain>
References: <20170627163145.GC4792@noname.redhat.com>
	<612358d1-4be0-7118-0e88-d5fce2b19d18@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
In-Reply-To: <612358d1-4be0-7118-0e88-d5fce2b19d18@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] QMP design: Fixing query-block
 and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 02:24:12PM -0400, John Snow wrote:
> On 06/27/2017 12:31 PM, Kevin Wolf wrote:
> > If that's what we're going to do, I think I can figure out something
> > nice for block nodes. That shouldn't be too hard. The only question
> > would be whether we want a command to query one node or whether we would
> > keep returning all of them.
> >=20
>=20
> Personally in favor of allowing filtering, as an option. I don't see why
> we couldn't, or why it would be a problem, or worse in any way.

Yes.  Filtering is important for performance with large numbers of
drives.

Stefan

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXP16AAoJEJykq7OBq3PI5OQIALmJeLLQuQpKZWedQmZnCt6g
E7mH5CieyWhrCmQtlQwAbJlnNPH2Fm4ECUXge+GlncgelX7h6ZqWy1AFRz6Dg0yQ
VCbHUSC388MhWJlp8Psk2GUSIKkDNjNFu8XivwFM3S7b3Gg7MkqassPD6ZuvzQ3i
QXlitj/K3NFSPCTh632ITh8zTdkcpyaHgoSfqpDeCLRObTmaFFJEzsIrHmd9BLLM
g759wybStOXHtbIPMfQtaLJyxFbEqv+w2U2SUrY5QFNuljMHpb1VZaSYd2rnPzRJ
KnYy/dD4qLk8+cgQkVhEgKMeLoCf6jBbB4JecU0PMXoO6e1TGQjhTMM4Mh9Qp7I=
=0+U7
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--
