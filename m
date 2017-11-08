Received: from eggs.gnu.org ([2001:4830:134:3::10]:44948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCWCl-000545-7M
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:40:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCWCk-0001b6-Fi
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:40:07 -0500
References: <8a184b91-49ef-bb52-d190-053c4c0861a1@redhat.com>
	<20171107052111.GB16355@lemon>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0dca5e3b-eded-abf0-86dd-36073710e792@redhat.com>
Date: Wed, 8 Nov 2017 20:39:52 +0100
MIME-Version: 1.0
In-Reply-To: <20171107052111.GB16355@lemon>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5gKBhJPnu5oJgwRJWGXDn0LMkRNvbBUGt"
Subject: Re: [Qemu-devel] Drainage in bdrv_replace_child_noperm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5gKBhJPnu5oJgwRJWGXDn0LMkRNvbBUGt
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Qemu-devel <qemu-devel@nongnu.org>
Message-ID: <0dca5e3b-eded-abf0-86dd-36073710e792@redhat.com>
Subject: Re: [Qemu-devel] Drainage in bdrv_replace_child_noperm()
References: <8a184b91-49ef-bb52-d190-053c4c0861a1@redhat.com>
 <20171107052111.GB16355@lemon>
In-Reply-To: <20171107052111.GB16355@lemon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-07 06:21, Fam Zheng wrote:
> On Mon, 11/06 19:49, Max Reitz wrote:

[...]

>> I have two ideas:
>>
>> One is to assume that (un-)draining a parent will always (un-)drain al=
l
>> children, including the one the (un-)drain comes from.  This assumptio=
n
>> seems wrong, see [1], but maybe it isn't.  Anyway, if so, we could jus=
t
>> explicitly drain the new child in bdrv_replace_child_noperm() after
>> having drained the parent and thus get a consistent state again.
>>
>> The other is to declare (A) wrong.  Maybe when
>> BdrvChildRole.drained_{begin,end}() is invoked, we should not drain th=
at
>> child because we can declare it the caller's responsibility to make su=
re
>> it's drained.  This seems logical to me because usually those methods
>> are invoked when the child is drained anyway.  But maybe I'm wrong. :-=
)
>=20
> I'm in favor of asking the caller to make sure all nodes involved in th=
e graph
> manupulation are drained, it feels comparably easier to do, than fixing=
 the
> problem in bdrv_append().

I guess my main question was whether any of the two approaches is
evidently wrong in some way, but if you don't say that (and Kevin says
the first is wrong), I'm going to assume doing the second is OK. :-)

Max


--5gKBhJPnu5oJgwRJWGXDn0LMkRNvbBUGt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloDXYgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A/nUH/Rl55LFQDFUHSWC5OfSwHw3sIZoa7nmn
LBmh+3UpcyaRVsO7g5q1V/34VHL28Y/idGzjhA5G2SoQUWmiRKcIwX97TfZXpy6R
9VXb0O1Vfzlf528mzQNAqoOeOlzEhmPlAvvyBVd2yyiqrdIWoPBXYIYoReWSazHN
ZqOP3rJk9faEW0DHFL9bUxXaXyYujjPAk7BRE9vcpbDXhnSd/KWLZ3RmUfziVQRl
uAjIOglLljPpslav5hIP7NhrSC4T/p3Va23W5NKzkd+q/jSZlxZ9MrQNnd9ekVEp
moTYPV9XrbZmXKauCLzuTICNXLHOU+m8MfUN4qqmNy2asMn0+Ph2MWc=
=G7/Z
-----END PGP SIGNATURE-----

--5gKBhJPnu5oJgwRJWGXDn0LMkRNvbBUGt--
