Received: from eggs.gnu.org ([2001:4830:134:3::10]:42771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dg84P-0005c1-1T
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dg84K-0006n4-7C
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:25:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dg84J-0006la-Ut
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:25:32 -0400
Date: Fri, 11 Aug 2017 13:25:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170811112522.GB4162@localhost.localdomain>
References: <20170809203808.31725-1-eblake@redhat.com>
	<20170810130240.GC3650@localhost.localdomain>
	<daa65e6b-77d5-7779-faf4-8e76a811ba86@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <daa65e6b-77d5-7779-faf4-8e76a811ba86@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2 0/5] More bdrv_getlength() fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jcody@redhat.com


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 10.08.2017 um 17:08 hat Eric Blake geschrieben:
> On 08/10/2017 08:02 AM, Kevin Wolf wrote:
> > Am 09.08.2017 um 22:38 hat Eric Blake geschrieben:
> >> We already have a lot of bdrv_getlength() fixes in -rc2; so I think
> >> this is still okay for -rc3.
> >>
> >> v1 was here (with a typo'd subject line):
> >> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01226.html
> >>
> >> Since v1:
> >> - patch 1: fix error message capitalization (Kevin, R-b kept)
> >> - fix locking bug in original patch 2 (Kevin)
> >> - split original patch 2 into two parts: signature update, and
> >> added error checking (Kevin)
> >> - check for unlikely integer overflow before bdrv_truncate (Jeff)
> >>
> >> 001/5:[0002] [FC] 'vpc: Check failure of bdrv_getlength()'
> >> 002/5:[down] 'qcow: Change signature of get_cluster_offset()'
> >> 003/5:[0048] [FC] 'qcow: Check failure of bdrv_getlength() and bdrv_tr=
uncate()'
> >> 004/5:[----] [--] 'qcow2: Drop debugging dump_refcounts()'
> >> 005/5:[----] [--] 'qcow2: Check failure of bdrv_getlength()'
> >=20
> > Looks good to me, but as the bug is far from being critical, I'd rather
> > apply the more complex qcow1 patches only to block-next. The vpc and
> > qcow2 parts seems a lot less risky, so 2.10 should be okay for them.
> >=20
> > What do you think?
>=20
> The argument for NOT doing the qcow changes (patches 2 and 3): the only
> place where we are not checking for failures is part of
> get_cluster_offset() - but in all likelihood, if we were unable to
> determine or change the length of the backing file, we will have nearby
> problems that will ultimately cause failure soon enough.  Furthermore,
> it's not a regression (we've had several releases with the problem), and
> qcow is not a good format (it's painfully slow, and we strongly
> recommend qcow2 instead) - so no one will be hitting any actual bugs in
> practice.
>=20
> I'll trust your judgment as maintainer, so taking just 1, 4, and 5 in
> 2.10 is fine.

Thanks, applied the patches to block and block-next, respectively.

Kevin

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZjZQiAAoJEH8JsnLIjy/WXJ0QAJRtVuP6diARoy722CGb3jkI
MVRPCk55UK0hFfDMrfd7U94ZP1KW4RQtoPcGOUIAa4KZXmboVoVXHEFs6jnHOnBL
WPCuMoGsPAV+8KSEmlqtcv/K+3CGQJpzqFVbfUiz7ikJK4QhlywBPY/xdGn/Wvtn
jfK8hT5C5F3VRzOx8O4l328MVgE2oegUSVt1o9ySfJV2Xkd3vYwbWVttX/tFENsS
jKgMLd+UfT1K/YMGVqWobx26X0SYqT6F35Wa0/xiPVuwv/6KlexFRUh8ZdGrxvM6
VizIA5hLvC7DHlj7FpKFCX+KN8rGB9vQLaB1/AvLOeBRzxeurT6uqz1meqOSbirP
4N/juPLo9h2JFFBGMe3LLBWTOBD1J4/cL5V5+xcx5ypnjLZBCC6NRuKgV1OxmFtD
86qRWwe6+AGw/DralfvO4rgH+8q2CoSqCKTzyfKuDmDqHpdRniqGyiDYCHi2SZ/h
slWPc8b+6Q8aRN3VOiBT/iBWG1wuO+R8dbdG2rEF8GbSEr3kGOBDn8saNNHSuwOt
snVtyd2AhXCboqWhvw3GZjZWKQBhfVoIkY9AAk/qcs8yjcKNQCgU969lfRpvj977
OBvgw60+IjoEwzIXO4981vpna8CO8P/O2jU+4a7JwPHPfliMJMr1YLMNtGJcYo1G
GyNRnLM5ea8alB7Zmk6F
=DiCG
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
