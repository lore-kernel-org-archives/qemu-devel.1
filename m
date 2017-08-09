Received: from eggs.gnu.org ([2001:4830:134:3::10]:36012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dfNQE-0007zK-0d
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dfNQD-0006e3-0s
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:37:02 -0400
Date: Wed, 9 Aug 2017 12:36:12 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170809093612.oee2u5kdgyojheqm@postretch>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-6-el13635@mail.ntua.gr>
	<w51valyjj7j.fsf@maestria.local.igalia.com>
	<20170808134544.paekftiounmirhbo@postretch>
	<w51poc6jeln.fsf@maestria.local.igalia.com>
	<20170808145620.wlb5rdutuseutclx@postretch>
	<w51mv7aje27.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ncf2wtrp2delb3w4"
Content-Disposition: inline
In-Reply-To: <w51mv7aje27.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--ncf2wtrp2delb3w4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 05:04:48PM +0200, Alberto Garcia wrote:
>On Tue 08 Aug 2017 04:56:20 PM CEST, Manos Pitsidianakis wrote:
>>>> So basically if we have anonymous groups, we accept limits in the
>>>> driver options but only without a group-name.
>>>
>>>In the commit message you do however have limits and a group name, is
>>>that a mistake?
>>>
>>>    -drive driver=3Dthrottle,file.filename=3Dfoo.qcow2, \
>>>           limits.iops-total=3D...,throttle-group=3Dbar
>>
>> Sorry this wasn't clear, I'm actually proposing to remove limits from
>> the throttle driver options and only create/config throttle groups via
>> -object/object-add.
>
>Sorry I think it was me who misunderstood :-) Anyway in the new
>command-line API I would be more inclined to have limits defined using
>"-object throttle-group" and -drive would only reference the group id.
>
>I understand that this implies that it wouldn't be possible to create
>anonymous groups (at least not from the command line), is that a
>problem?
>

We can accept anonymous groups if a user specifies limits but not a=20
group name in the throttle driver. (The only case where limits would be=20
acccepted)

Not creating eponymous throttle groups via the throttle driver means we=20
don't need throttle_groups anymore, since even anonymous ones don't need=20
to be accounted for in a list. I will send a new revision for this=20
series but I can make this change in a later patch if everyone agrees.

--ncf2wtrp2delb3w4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmK14wACgkQc2J8L2kN
9xBNpA/8C/uZio9/G46nZf338fykaIXUP7XYJoCe16PRM/EWVK/Nrnc2BdDvRquF
bX4RCznAXbg21bQFJ6HYqZNLrBuUlEQ8bgUKfe49C7ZJ8YWc7VTmRkX3FN9Aht7E
kkHbSEapLB7/4R6YooaxvkC0/r2I4e2PrM59diw/U1Ki0ke+Y1IpAqRkJnKBXoK0
GtsWxIwg+YXCHkYqDHESuBio42g5OpKLDtDvzMMqlfg3bPwiT3daJzqLmgatuEx4
jwhnjdKJfcAVpahoLjnsmU5PjH0/mA/PAXqcbYsy480YQaRNpQfG33+yYDDcTgeR
KxYJqxNexnw0sDJa1mAr8CcHL4oyBOdVShvU+5o3CewjL7FE8CTtzWmsZJdJekUd
EeITvLkNgNegMdtFLJyHr4rRqZxUgdSHNFHOmsh66Jj7vQFD3eH7rS3nsQf6XP/G
TDuOPZLNeYOs1BdTHcnjv6HmWoNwRFoYNxSAwMONrLvd9yTzuxENqr8S+wRK1eVC
AuDb9u8RZprIuDIwh/MdlojF7Z567WRBQ7SOs7ICukU9Yfeo2LG+yE4DK9RKFH1K
oB6SaKBUddRnVer8Xt5Cvp/89sMOOLe0luESxB/XbC9ClBXDa0tSbPeTOHY7ma5K
1/eqOf2swUGVcmQlxfOkhEIXimzl6LZZH5TuPpWEFFsng6cun0s=
=5Hmy
-----END PGP SIGNATURE-----

--ncf2wtrp2delb3w4--
