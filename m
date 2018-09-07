Received: from eggs.gnu.org ([2001:4830:134:3::10]:55768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyQCS-0004DQ-BT
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyQCR-0002Hi-GX
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:30:04 -0400
References: <20180906130225.5118-1-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <88bd9772-0119-bc1b-cf5b-7315dd471776@redhat.com>
Date: Sat, 8 Sep 2018 01:29:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180906130225.5118-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EcSWhrh1ZN4LQbEcUOAm3E32IClwMBVEj"
Subject: Re: [Qemu-devel] [PATCH v5 00/16] jobs: Job Exit Refactoring Pt 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EcSWhrh1ZN4LQbEcUOAm3E32IClwMBVEj
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <88bd9772-0119-bc1b-cf5b-7315dd471776@redhat.com>
Subject: Re: [PATCH v5 00/16] jobs: Job Exit Refactoring Pt 2
References: <20180906130225.5118-1-jsnow@redhat.com>
In-Reply-To: <20180906130225.5118-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-06 15:02, John Snow wrote:
> This is part two of a two part series that refactors the exit logic
> of jobs.
>=20
> This series forces all jobs to use the "finalize" semantics that were
> introduced previously, but only exposed via the backup jobs.
>=20
> Patches 1-3 add plumbing for the auto-dismiss and auto-finalize flags
> but do not expose these via QAPI/QMP.
>=20
> Patches 4-7 refactor the .exit() callbacks into the component pieces
> of .prepare(), .commit(), .abort() and .clean(). Except mirror, which
> I cheat with.
>=20
> Patches 8-10 remove the last usages of .exit in a test.
> Patche 11 removes the .exit callback and the machinery to invoke it.
>=20
> Patches 12-14 expose the new QMP options to all of the jobs.
> Patch 15 is a doc fixup.

Thanks, fixed the capitalization in patch 4's commit message, added the
mirror_exit() comment you proposed in patch 6, and applied to my block
branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--EcSWhrh1ZN4LQbEcUOAm3E32IClwMBVEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluTCe4ACgkQ9AfbAGHV
z0CnqAf+LEZKaAg6T2yNu+JsgVyX6PpgGeWxx2SWWoEOQ2r84nqqYR9//A19bU/s
sV7mPmJjoNsvhv30FzwRLB5+p4Si6nAz2JC3DYF/k7RZHc+g/J93mMAzkiQB95A1
+rXV7NZjxyvI/Bley2axgWsw1DJdnB33PrQ9sOZlIMdlyICdKfFPYHOEGDKB5y8/
xcB3yuzEoNRU5HrTxBNDRPnUPkMrdl9gvkX1OCLsCtICqHQ2mhe8vk41arsYvr6J
acoU3tGQqiOx/dMxlHDaCHqwRRepoTQb+7g9D6YbqE+C/M/YniZh7xbNkZ0FPqsv
GiXLiU4bgNfqYLSBGOPxxc9a55gfQA==
=In/S
-----END PGP SIGNATURE-----

--EcSWhrh1ZN4LQbEcUOAm3E32IClwMBVEj--
