Received: from eggs.gnu.org ([2001:4830:134:3::10]:42615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFkRe-00047I-Rq
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFkRa-00048N-Vx
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:56:34 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:49789)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFkRZ-000470-TE
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:56:30 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id BC6D3F7921
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 18:56:26 +0200 (CEST)
Date: Tue, 30 May 2017 18:56:18 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170530185618.2e875ebb@bahia.ttt.fr.ibm.com>
In-Reply-To: <e8fdae1c-9d3c-1059-509a-6b85000e83a9@de.ibm.com>
References: <149615665491.28067.17765793725374594694.stgit@bahia.lan>
	<e8fdae1c-9d3c-1059-509a-6b85000e83a9@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/DELfm1Nhd5zmjInezB448lz";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] pc-bios/s390-ccw: use STRIP variable in
 Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-trivial@nongnu.org, Fam Zheng <famz@redhat.com>, Alexander Graf <agraf@suse.de>

--Sig_/DELfm1Nhd5zmjInezB448lz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 30 May 2017 18:34:46 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 05/30/2017 05:04 PM, Greg Kurz wrote:
> > The docker-run-test-build@debian-s390x-cross target fails with:
> >=20
> > strip --strip-unneeded s390-ccw.elf -o s390-ccw.img
> > strip: Unable to recognise the format of the input file `s390-ccw.elf'
> >=20
> > The configure script defines a STRIP makefile variable whose default
> > value is ${cross_prefix}strip. Let's use it.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  pc-bios/s390-ccw/Makefile |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> > index 79a46b67356f..7af57dad109c 100644
> > --- a/pc-bios/s390-ccw/Makefile
> > +++ b/pc-bios/s390-ccw/Makefile
> > @@ -22,7 +22,7 @@ s390-ccw.elf: $(OBJECTS)
> >  	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $(OBJECTS),"BUILD","$(TAR=
GET_DIR)$@")
> >=20
> >  s390-ccw.img: s390-ccw.elf
> > -	$(call quiet-command,strip --strip-unneeded $< -o $@,"STRIP","$(TARGE=
T_DIR)$@")
> > +	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(TA=
RGET_DIR)$@")
> >=20
> >  $(OBJECTS): Makefile
> >=20
> >  =20
>=20
> I was going to apply this, but it fails with --disable-strip like
>=20
>     /bin/sh: --strip-unneeded: command not found
>     Makefile:25: recipe for target 's390-ccw.img' failed
>     make[1]: *** [s390-ccw.img] Error 127
>     Makefile:354: recipe for target 'romsubdir-s390-ccw' failed
>     make: *** [romsubdir-s390-ccw] Error 2
>=20
> Not yet sure whats going on.
>=20

configure doesn't generate STRIP when --disable-strip or --enable-debug... =
so
I guess we shouldn't use it here, but rather generate a s390_cross_prefix l=
ike
in roms/Makefile ?

--Sig_/DELfm1Nhd5zmjInezB448lz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlktpDMACgkQAvw66wEB28K30ACeOf/P+RdJHUVWKyj3bY7jP2JI
y2IAnisPII1mIFBVffiJF5L7Ym8pfZV/
=gst4
-----END PGP SIGNATURE-----

--Sig_/DELfm1Nhd5zmjInezB448lz--
