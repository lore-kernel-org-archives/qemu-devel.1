Received: from eggs.gnu.org ([2001:4830:134:3::10]:50862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db41h-0000wB-2g
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db41e-0008G4-61
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:05:53 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1db41d-0008Cp-W8
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:05:50 -0400
Received: by mail-wm0-x243.google.com with SMTP id y206so4134271wmd.5
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 05:05:48 -0700 (PDT)
Date: Fri, 28 Jul 2017 13:05:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170728120545.GA12364@stefanha-x1.localdomain>
References: <20170728085547.13947-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20170728085547.13947-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] trace-events: print 0x before hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 11:55:47AM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> To make logs more readable prefix all hex values with '0x' mark.
> This is needed for consistency too, as a lot of hex values are already
> prefixed with '0x'. Also, bring all hex outputs to the common form -
> use '%#', not '0x%'.
>=20
> This patch is done by two commands:
> find . -name trace-events | \
>  xargs sed -i 's/%\([-+ *.0-9]*\([hljztL]\|ll\|hh\)\?\(x\|X\|"\s*PRIx\)\)=
/%#\1/g'
> find . -name trace-events | xargs sed -i 's/0x%#/%#/g'
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> Hi all!
>=20
> It is hard to read logs, when there are hex and dec numbers in one line, =
when
> hex number doesn't contain any letters and don't have '0x' prefix. Hope I=
'm
> not alone who is not comfortable with it, so, what about a patch like thi=
s?
> May be regexp's should be improved but, I think, the common idea is clear.

Thanks, this looks useful.  Will review v2.

Stefan

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeyiZAAoJEJykq7OBq3PIdJ4H/Rtypedw72wAMc5VTnqQ1eIW
vK0tn0q515FVJPu1TTasGkf6AfHndGQDu9UXYd7goW7W6hhHrDqu9giSlZF57AkK
iBk/2pQpbrCVhfZ8J1ybDLJFcTjXUYWN5fRVyvVjuolfUsE+HL3+9glXyWaHB+8W
2R6huhQ893WGTWQEss3Rtb+cTsNGvr/riFqklJmNlrXeLTmhhulEi+20CqDAQDtj
fg/fdaJH3h5r18Pz8V7XoLe7aSBz8XafNZysUftYKTPzTcP7bRV86EYLYC3oDOMO
x3qkJwRPX5Zn9xumfBJhh203Wlrr3MGhcyEB8UwFURacYhzty2pkA7vxKUO+3ic=
=8aob
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
