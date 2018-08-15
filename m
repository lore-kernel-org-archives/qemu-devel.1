Received: from eggs.gnu.org ([2001:4830:134:3::10]:45338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpxIm-0006Qt-8b
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 11:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpxIW-0001Wb-B5
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 11:01:35 -0400
Date: Wed, 15 Aug 2018 17:00:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180815150029.GG4411@localhost.localdomain>
References: <20180807043349.27196-1-jsnow@redhat.com>
	<20180815144418.GG2158@andariel.pipo.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20180815144418.GG2158@andariel.pipo.sk>
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
To: Peter Krempa <pkrempa@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jtc@redhat.com, Max Reitz <mreitz@redhat.com>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.08.2018 um 16:44 hat Peter Krempa geschrieben:
> On Tue, Aug 07, 2018 at 00:33:28 -0400, John Snow wrote:
> > This series forces all jobs to use the "finalize" semantics that were
> > introduced previously, but only exposed via the backup jobs.
> > This series looks huge, but it's mostly mechanical changes broken out
> > into a series of much smaller commits so that the changes are easier
> > to follow at each step.
>=20
> Please note that due to the semantics of the commands 'block-job-cancel'
> and 'block-job-complete' at least in case of the drive/blockdev-mirror
> job are technically blockjobs of it's own since they may fail or finish
> in an unbounded amount of time and the actual return value on the
> monitor does not reflect the result of the operation itself.
>=20
> It would be very helpful if qemu treas them as such.

'block-job-cancel' and 'block-job-complete' return immediately. They
just move the given job into the next phase and return. That job may
then still take some time until it finally completes (successfully or
with an error), but that's not part of 'block-job-cancel/complete' any
more.

Kevin

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbdEANAAoJEH8JsnLIjy/WoyQP/0wmY+N/2TMUu+EiM1j6Q+kL
Ht2GjNSrTydo4ETpvpAcSfN6o0ROadtNTlJ2B0U7SfjMPo4tMV2dWv5inIF0Zxrx
VebYjmnfuFFMNGCeN1pKJomWpuaOItzLVJkzkncllkBpKc+uauoGbUuc/bea6MKX
8+wPjcOuj32M8sYz0pDBYBcn5RlZdbNztHZ8XvLeVeUdpAOUQTmovDJGpaA0oP7Q
S9I0rVYIeLOBCDF5gV4IKD9/ZXkKnj+xQXXQj1AE6b0uz2/LVNO5pRDSCuti4HRD
0elAvUz59u1ixMTj1Tb4ND2/EsFyytM2aMdpkHc0aNSdfBu4TrZVIFgyufCi6Ul8
CGKlg6uTOtpiRDpK5Y25yi32+WBUE/mm4UCRlZOdaT9QaQfSOjWij8i78AizFnSY
8Pje9HIOHvIZ1QovxaXKUxmCv+gKGB2PvHrpWVOyhAaLvBiH5GfaZJIxwU4uCarA
ga4OXUbiwE6v26lmiRD50mvTQuyxhS4+qeJb0AdUnWz7kGBRzYSXY46ZVmW0+hDy
WzZamoKA5HsNDcR1okDc40T1Hk82H5g/trbhNk7pdvLpeMngVW+g1doHDhGKZTN8
0573hsh9NSAiYiDNT5m+7Ydeln7mwAUJSkrcN7De7IrI/CK4ticu1tzuKptfJIux
OBRdxmp6ogZQR6obztm5
=2C8k
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
