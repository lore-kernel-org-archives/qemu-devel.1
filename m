Received: from eggs.gnu.org ([2001:4830:134:3::10]:34386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBqAE-00059E-1Z
	for qemu-devel@nongnu.org; Fri, 19 May 2017 18:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBqAA-0000M0-TZ
	for qemu-devel@nongnu.org; Fri, 19 May 2017 18:14:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dBqAA-0000Lp-Ju
	for qemu-devel@nongnu.org; Fri, 19 May 2017 18:14:22 -0400
References: <1495179026-27872-1-git-send-email-yang.zhong@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <afc2d6a0-cefa-9609-d781-5e69d372a7bd@redhat.com>
Date: Fri, 19 May 2017 17:14:19 -0500
MIME-Version: 1.0
In-Reply-To: <1495179026-27872-1-git-send-email-yang.zhong@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="S3QR35fJlPw2r5AXkHLfRM7BJXMgGhV4A"
Subject: Re: [Qemu-devel] [PATCH v0 0/6] move the tcg files into tcg
 directory.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, pbonzini@redhat.com
Cc: anthony.xu@intel.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S3QR35fJlPw2r5AXkHLfRM7BJXMgGhV4A
From: Eric Blake <eblake@redhat.com>
To: Yang Zhong <yang.zhong@intel.com>, pbonzini@redhat.com
Cc: anthony.xu@intel.com, qemu-devel@nongnu.org
Message-ID: <afc2d6a0-cefa-9609-d781-5e69d372a7bd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v0 0/6] move the tcg files into tcg
 directory.
References: <1495179026-27872-1-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1495179026-27872-1-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2017 02:30 AM, Yang Zhong wrote:
> Move the tcg relative files into tcg directory, which will make
> the code more clean in qemu.

Titling a patch series v0 is a bit unusual (typically, the first version
is untitled, and the second version is titled v2; 'git send-email -v2'
can help).  But since 0 is less than 1 or 2, I don't think it breaks any
tools if you use that as your explicit title for a first submission,
even if you have to respin.

>=20
> Yang Zhong (6):
>   move tcg relative files into tcg directory
>   move tcg relative files into tcg directory
>   move tcg header file
>   move tcg relative files into tcg directory
>   move tcg relative files into tcg directory

None of your patches match the usual "topic: Short description" of other
patches.  Furthermore, having identical titles on 4 out of 6 distinct
patches is a nightmare for downstream backporters (which "move tcg
relative files into tcg directory" do I have to backport to fix the bug,
again?).  I highly suggest that every patch you submit have enough
details in the subject line that the subject is distinct (we don't
always succeed, but it's usually quite easy to avoid duplicates).

So, as an example, I might title a patch:

"tcg: Move tcg-runtime.c to tcg/ subdirectory"

>   change tcg relative file's compile definition
>=20
>  Makefile.objs                                | 1 +
>  Makefile.target                              | 8 ++------
>  tcg/Makefile.objs                            | 2 ++
>  tcg-runtime.c =3D> tcg/tcg-runtime.c           | 0
>  tci.c =3D> tcg/tci.c                           | 0
>  tcg/trace-events                             | 6 ++++++
>  translate-all.c =3D> tcg/translate-all.c       | 2 +-
>  translate-all.h =3D> tcg/translate-all.h       | 0
>  translate-common.c =3D> tcg/translate-common.c | 0
>  trace-events                                 | 3 ---

Thankfully, you've got git rename detection turned on, which makes for
much nicer reviews.

>  10 files changed, 12 insertions(+), 10 deletions(-)
>  create mode 100644 tcg/Makefile.objs
>  rename tcg-runtime.c =3D> tcg/tcg-runtime.c (100%)
>  rename tci.c =3D> tcg/tci.c (100%)
>  create mode 100644 tcg/trace-events
>  rename translate-all.c =3D> tcg/translate-all.c (99%)
>  rename translate-all.h =3D> tcg/translate-all.h (100%)
>  rename translate-common.c =3D> tcg/translate-common.c (100%)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--S3QR35fJlPw2r5AXkHLfRM7BJXMgGhV4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZH247AAoJEKeha0olJ0NqdpAH/1cWwUe6MXFFYvbINVPtJ4LR
ozjAU53LE+EhpbBl7S85GTKEsfWSbAlI90ImU6LJbjToo8S3SMh5KgGhvEmoUly5
GzuSK5AI3HM/CG/yZCWKD9ETRvx8u0e2YlWxP2jcZ78ohY29aHrd2AeCot7Bsilm
+9CgLuRbaviy2Xt+WX5JCRthjczE3l1O9yUNsNiObF1lPw7L3HWUUMahaMrrMVb0
WLXKSTRCFMQyxyfKh3G5txxjujCdiDL1N6Fg/4ULv49PF5ibUuhaeT4VgaEj85w5
xsYA6RTr2m2oqIYC+dOJhNeOJpb1yGyLW6L/g/1v8Bi0Zw44QpGQZyK9SIEqja4=
=Tx+K
-----END PGP SIGNATURE-----

--S3QR35fJlPw2r5AXkHLfRM7BJXMgGhV4A--
