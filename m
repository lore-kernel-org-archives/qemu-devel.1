Received: from eggs.gnu.org ([2001:4830:134:3::10]:46047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fpxLo-0000u3-Aa
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 11:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fpxLW-0004pO-Fc
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 11:04:41 -0400
Date: Wed, 15 Aug 2018 17:04:10 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180815150410.GH2158@andariel.pipo.sk>
References: <20180807043349.27196-1-jsnow@redhat.com>
	<20180815144418.GG2158@andariel.pipo.sk>
	<20180815150029.GG4411@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1EKig6ypoSyM7jaD"
Content-Disposition: inline
In-Reply-To: <20180815150029.GG4411@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 00/21] jobs: defer graph
 changes until finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jtc@redhat.com, Max Reitz <mreitz@redhat.com>


--1EKig6ypoSyM7jaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 15, 2018 at 17:00:29 +0200, Kevin Wolf wrote:
> Am 15.08.2018 um 16:44 hat Peter Krempa geschrieben:
> > On Tue, Aug 07, 2018 at 00:33:28 -0400, John Snow wrote:
> > > This series forces all jobs to use the "finalize" semantics that were
> > > introduced previously, but only exposed via the backup jobs.
> > > This series looks huge, but it's mostly mechanical changes broken out
> > > into a series of much smaller commits so that the changes are easier
> > > to follow at each step.
> >=20
> > Please note that due to the semantics of the commands 'block-job-cancel'
> > and 'block-job-complete' at least in case of the drive/blockdev-mirror
> > job are technically blockjobs of it's own since they may fail or finish
> > in an unbounded amount of time and the actual return value on the
> > monitor does not reflect the result of the operation itself.
> >=20
> > It would be very helpful if qemu treas them as such.
>=20
> 'block-job-cancel' and 'block-job-complete' return immediately. They
> just move the given job into the next phase and return. That job may
> then still take some time until it finally completes (successfully or
> with an error), but that's not part of 'block-job-cancel/complete' any
> more.

Ah I see. That means that we just need to modify the semantics/language
used in libvirt for this.

Thanks for the clarification.

--1EKig6ypoSyM7jaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlt0QOcACgkQHGwCByjY
1GrLyA/+JIfsUQmCXERfUEz6ueg1TIOcVj8wgzBkxUCswhBVFpNho6g6Od3RAaua
2Y92AP8QZFmYLMuhAPp6P6ruAJYu5YPO4mO2BjyNWQzNQrem4MT3rrUg8w3/puvz
pbO29i8kQRIMre251H1eN3/8J/VwqLayXv0tZSfuPNMO7xN/X57c9td+y5VDVbQ/
Hlj2Ex2U3fMRUIHZGvZtfcdzaYRb1PkFYteDR/eezy4G2VKsY4tULpF8UUsG7/TS
NytkIYQecxXkfJ5Kp0aon/nLvODSfqRIFj46gmHpqcU2pCYHrsz1RNABZABMLiMz
NL2gpbSI6CPZVETEsfCvHWVs0JY9wVRNH2aWOpLUWYODqf/Xi4e6qHrPMDFZ7JFT
5NKKGkAd6xeqgLcfvBDZvL+Ja2Rl8JtsKq2ReZJ8dL+Xebd2070cOhd1ARIvA+1t
+DutpibEs0S450JpiNi5gAOeQYa55NvkCBVhRXF/84ttauiVateHX6AzXmZm2A27
xqVRLiqfX54wihfygPIbCo5w6yLDgeda+PcGB/bA4acfa8b3jSWgREjxcdX79A+k
2qXjyi9U8h1EcVxb/qM3MLiKQcrHi3y0a6ytRyYT0gjkNGeXkjp80PKtK5CazvVW
tvQhqTeHrVkXa7qEZpAc7gHeQznxlHgs1TvU/XeG3OTWpeuP3t4=
=r2Ob
-----END PGP SIGNATURE-----

--1EKig6ypoSyM7jaD--
