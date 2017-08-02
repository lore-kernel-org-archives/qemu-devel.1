Received: from eggs.gnu.org ([2001:4830:134:3::10]:51071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcwnr-0005zh-3d
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcwnq-0001OP-8r
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:47:23 -0400
Date: Wed, 2 Aug 2017 19:46:31 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170802164631.h3zwxwogba6ng7ae@postretch>
References: <20170801134907.31253-1-el13635@mail.ntua.gr>
	<20170801134907.31253-4-el13635@mail.ntua.gr>
	<20170802100724.GD5531@stefanha-x1.localdomain>
	<20170802103319.GB3649@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gjq2kujpqgweaudz"
Content-Disposition: inline
In-Reply-To: <20170802103319.GB3649@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 3/3] block: remove legacy I/O throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--gjq2kujpqgweaudz
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2017 at 12:33:19PM +0200, Kevin Wolf wrote:
>Am 02.08.2017 um 12:07 hat Stefan Hajnoczi geschrieben:
>> On Tue, Aug 01, 2017 at 04:49:07PM +0300, Manos Pitsidianakis wrote:
>> > diff --git a/block.c b/block.c
>> > index 9ebdba28b0..c6aad25286 100644
>> > --- a/block.c
>> > +++ b/block.c
>> > @@ -1975,6 +1975,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverSta=
te *child_bs,
>> >      child =3D g_new(BdrvChild, 1);
>> >      *child =3D (BdrvChild) {
>> >          .bs             =3D NULL,
>> > +        .parent_bs      =3D NULL,
>> >          .name           =3D g_strdup(child_name),
>> >          .role           =3D child_role,
>> >          .perm           =3D perm,
>> > @@ -2009,6 +2010,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *p=
arent_bs,
>> >      if (child =3D=3D NULL) {
>> >          return NULL;
>> >      }
>> > +    child->parent_bs =3D parent_bs;
>> >
>> >      QLIST_INSERT_HEAD(&parent_bs->children, child, next);
>> >      return child;
>> > @@ -3729,6 +3731,12 @@ const char *bdrv_get_parent_name(const BlockDri=
verState *bs)
>> >                  return name;
>> >              }
>> >          }
>> > +        if (c->parent_bs && c->parent_bs->implicit) {
>> > +            name =3D bdrv_get_parent_name(c->parent_bs);
>> > +            if (name && *name) {
>> > +                return name;
>> > +            }
>> > +        }
>> >      }
>> >
>> >      return NULL;
>>
>> This should be a separate patch.
>>
>> Who updates parent_bs if the parent is changed (e.g.
>> bdrv_replace_node())?
>>
>> We already have bs->parents.  Why is BdrvChild->parent_bs needed?
>
>I haven't look at the whole patch yet, but BdrvChild->parent_bs is a
>thing that intentionally doesn't exist. A node simply has no business
>knowing its parents - which may or may not be BlockDriverStates (the
>obvious example where they aren't BDSes are BlockBackends, but block
>jobs own some BdrvChild objects, too).
>
>Usually the replacement is a BdrvChildRole callback.
>
>Kevin

I think accessing the parent bs is necessary for the reasons I specified=20
in my reply to Stefan. Will a callback that returns BdrvChild->opaque=20
(parent_bs) for child_file and child_backing be okay?


--gjq2kujpqgweaudz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmCAecACgkQc2J8L2kN
9xAndRAA1UoFnmgUyiObl6Yk2B4uzh+oGQdLDrBpxoFE1dB3etM0x6CmtJNgfonQ
e98vWVjsqc7I2efH6peF59ep4W8Ch+94mMGOKKfRztSTC8oyvdj5YifSasPWE8Cq
k3qtIWDfe5bldbOAhPV5j3lMOpksaUj+lETXXAvFqD30HibM5QD3UaTYfZWM6jlN
+GkG+dtr5PwcWqQqWcsmowF6gBeqPBWIawKuY+wALu6YDHSnJ25jO602d2mHOGkj
6HqdPSu7yHYLvc+deR+jsjszoocWYJt0+uK9Jjh0t/zybIrPdy5VcRjO0UoX3rdT
zkoEx/R5kGLKPoiAC3MdrXzW67G7+fzqIFQYxowIyEw1ojg2aoJhaH5+vZqELQBw
SM4MYN5zEwd9l/gZMZZQkvOv3IVtiQcS3/ONd/ncIGqwuF3Ja0zpzrtyBKtaUK7S
nJOT1adj/NDeoxY6ajcQW7JicjuCEAuKz9mhQjMZ+rrnRFF0qhsTaFHb7+SOEZlC
IXK7Xn9QTgizYUo99wkxLGGGFmYUAtus6qxbKaPF25TMWKforDH/zAyVV0RZ3pg+
j/AQCCusXYHp64Pyv25GoKO8E4tGUS/V+FimiWA9HPF0sG2ZeR0ChJ/nopBHErUl
vbjiaM96yDmNvIvRQt2ZJvre+qf3g4EbqpZoMztbkSjLEj5LsHA=
=ystQ
-----END PGP SIGNATURE-----

--gjq2kujpqgweaudz--
