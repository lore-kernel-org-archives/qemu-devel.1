Received: from eggs.gnu.org ([2001:4830:134:3::10]:32937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPqeG-0003gb-Cy
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPqeF-00067B-Ea
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:35:20 -0400
Date: Tue, 27 Jun 2017 16:34:22 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170627133422.eyyvurl5pje34lr3@postretch>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-4-el13635@mail.ntua.gr>
	<20170626143055.GC29664@stefanha-x1.localdomain>
	<20170626162641.cavidsn7d67absxb@postretch>
	<20170627124540.GF8555@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rwxzjo6py74qjble"
Content-Disposition: inline
In-Reply-To: <20170627124540.GF8555@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 3/8] block: add
 throttle block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>


--rwxzjo6py74qjble
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 01:45:40PM +0100, Stefan Hajnoczi wrote:
>On Mon, Jun 26, 2017 at 07:26:41PM +0300, Manos Pitsidianakis wrote:
>> On Mon, Jun 26, 2017 at 03:30:55PM +0100, Stefan Hajnoczi wrote:
>> > > +    bs->file =3D bdrv_open_child(NULL, options, "file",
>> > > +                                    bs, &child_file, false, &local_=
err);
>> > > +
>> > > +    if (local_err) {
>> > > +        error_propagate(errp, local_err);
>> > > +        return -EINVAL;
>> > > +    }
>> > > +
>> > > +    qdict_flatten(options);
>> > > +    return throttle_configure_tgm(bs, tgm, options, errp);
>> >
>> > Who destroys bs->file on error?
>>
>> It is reaped by bdrv_open_inherit() on failure, if I'm not mistaken.
>> That's how other drivers handle this as well. Some (eg block/qcow2.c)
>> check if bs->file is NULL instead of the error pointer they pass, so
>> this is not not very consistent.
>
>Maybe I'm missing it but I don't see relevant bs->file cleanup in
>bdrv_open_inherit() or bdrv_open_common().
>
>Please post the exact line where it happens.
>
>Stefan

Relevant commit: de234897b60e034ba94b307fc289e2dc692c9251 block: Do not=20
unref bs->file on error in BD's open

bdrv_open_inherit() does this on failure:

fail:
    blk_unref(file);
    if (bs->file !=3D NULL) {
        bdrv_unref_child(bs, bs->file);
    }

While looking into this I noticed bdrv_new_open_driver() doesn't handle=20
bs->file on failure. It simply unrefs the bs but because its child's ref=20
still remains, it is leaked.

--rwxzjo6py74qjble
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllSXt4ACgkQc2J8L2kN
9xCCFBAAoSQLsm3Ugz662+EElffTbnQd12T0uXVuQlmy3bfhN8y+bnhYLGr2kBqi
BAPRv7/SoqMH9OinflYcyoOREQDktMbGT02IuJbR76W84gioUIzefwSzjgi3xIFu
sq+4NeB49mlMWPHfnGT7u/FcYqE6alixSwn8hLwGnx5MvMrKgve29mtvcjig4Lqj
+EeO/VZ2vgduN20fxuEnSkv8ostgb4vpi41MOih736+id7RDqPtdkUYTskihRh1M
R4LYzUKk2tkQ9qbinGYj74YZgSPtSWpsDHJvW0HoI00iD40n+yAwPt4tn5aYplyF
FzlB7Td2nPIShK2FkvA80sa2wnXhH+IG/AAK5Seahoc5iajJ9npnxsfDB0g3wW58
vRcvIeyDZJVCUlTsBMd2WKHDUqqsvXnXXznw1JXrSevtEJROyN9LIOPsvpAJwrUq
eKAMdze97K6hzoFXL24MbzUGZA3cPYHgasqLZbT30VSVz9PDNLhmXJzmEKweL9Ir
RVYtv7XZE92ZT7WRaXsnb96LP2OtUE8aUiLql05Rq3pzJicTtNysHxeVDCDAxFJD
ZoaNv2DOj87g5s5jsQ+0o6faIQh30uAJlaqLEJO6ZPcwD3ajfdXdNQdTuEwsG5jW
XcMs66PDLAgzMGlrYEU/f6W1+6/jqc2e+ilHiyIkmRq12HwkUzM=
=v8q9
-----END PGP SIGNATURE-----

--rwxzjo6py74qjble--
