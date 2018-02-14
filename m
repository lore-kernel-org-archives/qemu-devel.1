Received: from eggs.gnu.org ([2001:4830:134:3::10]:42087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1elxD8-0008Ub-J3
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1elxD3-0005ff-PT
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:34:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1elxD3-0005fP-KE
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:34:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3283540FB650
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 13:34:42 +0000 (UTC)
Date: Wed, 14 Feb 2018 13:34:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180214133434.GB7545@stefanha-x1.localdomain>
References: <20180213173429.19501-1-stefanha@redhat.com>
	<20180213173429.19501-2-stefanha@redhat.com>
	<20180213180918.GY573@redhat.com>
	<20180214010111.GB15103@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <20180214010111.GB15103@lemon.usersys.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2018 at 09:01:11AM +0800, Fam Zheng wrote:
> On Tue, 02/13 18:09, Daniel P. Berrang=E9 wrote:
> > On Tue, Feb 13, 2018 at 05:34:25PM +0000, Stefan Hajnoczi wrote:
> > > +[gitpublishprofile "block"]
> > > +base =3D master
> > > +prefix =3D PATCH
> > > +to =3D qemu-devel@nongnu.org
> > > +cc =3D qemu-block@nongnu.org
> > > +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit =
--nogit-fallback 2>/dev/null
> >=20
> > Why is a custom entry needed for block here (and other things
> > below).   Won't running get_maintainer.pl already correctly
> > report when a patch needs cc'ing to qemu-block@nongnu.org
> > based on MAINTAINER rules ?
>=20
> Yeah, dropping them should be fine. What do you think, Stefan?

scripts/get_maintainer.pl only works when patches touch files associated
with qemu-block@nongnu.org in MAINTAINERS.  It would be
counter-intuitive for --profile block to not include
qemu-block@nongnu.org, so I think these entries do serve a purpose.

On the other hand, I personally just use --cc qemu-block instead of a
profile for this.  I'll probably only use the default profile.

Fam, if you want it dropped, let me know.  Otherwise, we can leave it
in if there is no further discussion.

Stefan

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJahDrqAAoJEJykq7OBq3PIZwoH/18U55geCTV3NSoKxtCQNj2u
FPkgLHEyRHpgA5bm0KGLgfdM5J7Kb+cdiehnSw3vXhAUlwahX/vN8BLhAH3WAgRZ
1htDIWxrb9qhbDKHYPZkKXpI6elPgjBkxYzr7IR3J1D62Qdr/nidlldAQ0z7HcoZ
9enw/R9OvH/hj2t/oSg4BZ7Utke/VFH+YAm15T+riR/EzbKVVHczxiwrTAV4rgJO
COkE5jxjnjYFOxVpOiALWcgEGRot+wLmiGmymaDmk3XiaptCjNp7cOPWttm7qq8G
C6GehqTIAfCaPuEcMvCJ+rNGbUZNgKvkLJLKdwNu/3lB/1ASClg1B62dVoLbhdw=
=E6U8
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
