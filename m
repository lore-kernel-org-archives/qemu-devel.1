Received: from eggs.gnu.org ([2001:4830:134:3::10]:51650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cgaGK-0004AB-Mb
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cgaGH-0002NY-Gt
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:59:32 -0500
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:45264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cgaGH-0002NH-Al
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:59:29 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 9DD21B3C8D
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 17:59:26 +0100 (CET)
Date: Wed, 22 Feb 2017 17:59:17 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170222175917.53c27906@bahia.lan>
In-Reply-To: <18735c6a-e21e-6aaf-4283-53f980afae3f@redhat.com>
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
	<20170207001533.3f18e4ea@bahia.lan>
	<20170207113231.44e35be6@bahia.lan>
	<6b702369-7891-4e38-7240-57ad643657bd@redhat.com>
	<20170207172933.05574f60@bahia.lan>
	<20170214132122.GH23310@stefanha-x1.localdomain>
	<20170222144153.131dee9d@bahia.lan>
	<18735c6a-e21e-6aaf-4283-53f980afae3f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/rtz9W_BTaUBadoTOXRGLpSI";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 1/2 v16] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

--Sig_/rtz9W_BTaUBadoTOXRGLpSI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Feb 2017 10:01:09 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 02/22/2017 07:41 AM, Greg Kurz wrote:
> > Eric,
> >=20
> > I fully understand your concern about the missing QMP bits, but given t=
he other
> > comments people made on this series, I'd like to move forward and merge=
 it for
> > 2.9, without the 'x-' prefixed options. Is it okay with you ? =20
>=20
> Yes, I think we'll be okay. Libvirt will just be unable to recognize the
> feature until the QMP bits are in place.
>=20

Ok. I'll work this out with Pradeep for 2.10.

>=20
> >>>> If it cannot be probed via QMP, then libvirt will most likely assume
> >>>> that it does not exist.  I guess we're okay having command line only=
 in
> >>>> 2.9 if you can't get QMP working, because libvirt will just never dr=
ive
> >>>> the feature until 2.10 when QMP is available; but then we risk the
> >>>> command line subtly changing and breaking someone else that was using
> >>>> the command line without QMP.  Maybe the safest approach is to just =
use
> >>>> the 'x-' prefix to the command line portion, until the feature is co=
mplete.
> >>>>    =20
> >>>
> >>> The semantics here are exactly the same as for block devices. The
> >>> command line options added to -fsdev are the very same already used
> >>> by -drive for years.
> >>>
> >>> Patch 2/2 in this series even factors them out to a common header file
> >>> to be used by fsdev and blockdev. I really don't expect any modificat=
ion
> >>> at all on the command line (nor the other people who reviewed that pa=
tch
> >>> obviously)... are you suggesting that we should put 2/2 on hold and
> >>> use the 'x-' prefix anyway ?   =20
> >>
> >> I see these parameter names as stable.  There is little risk that they
> >> would change. =20
>=20
> We just need to be sure that when we do add QMP, that it doesn't use
> names that differ from the command line (blockdev is an example where we
> weren't careful in 2.8, and had to rename things in 2.9 to be
> consistent, and I want to avoid repeating that mistake).
>=20

Can you provide some pointers on what had to be fixed in blockdev ?

Thanks.

--
Greg

--Sig_/rtz9W_BTaUBadoTOXRGLpSI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlitw2UACgkQAvw66wEB28Jf6wCgjtH5jdKymYdTQQlzeIAaYWwN
JEAAoKdAGpmlXDjGk994rI9LFaSjadRK
=xEao
-----END PGP SIGNATURE-----

--Sig_/rtz9W_BTaUBadoTOXRGLpSI--
