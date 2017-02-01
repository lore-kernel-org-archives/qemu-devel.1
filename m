Received: from eggs.gnu.org ([2001:4830:134:3::10]:52331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYtnM-0000FR-Qw
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYtnL-0004cB-Sm
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:13:52 -0500
References: <20170126110435.2777-1-berrange@redhat.com>
	<20170126110435.2777-4-berrange@redhat.com>
	<20170126123530.GB23095@lemon.Home> <20170126132708.GB29127@redhat.com>
	<6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8a13c995-c094-2704-c770-214132b2d6cf@redhat.com>
Date: Wed, 1 Feb 2017 13:13:39 +0100
MIME-Version: 1.0
In-Reply-To: <6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CIFOH35G6ku8kV4xTB6gfoRndecfOUPn6"
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CIFOH35G6ku8kV4xTB6gfoRndecfOUPn6
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <8a13c995-c094-2704-c770-214132b2d6cf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
References: <20170126110435.2777-1-berrange@redhat.com>
 <20170126110435.2777-4-berrange@redhat.com>
 <20170126123530.GB23095@lemon.Home> <20170126132708.GB29127@redhat.com>
 <6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
In-Reply-To: <6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.01.2017 19:37, Eric Blake wrote:
> On 01/26/2017 07:27 AM, Daniel P. Berrange wrote:
>> On Thu, Jan 26, 2017 at 08:35:30PM +0800, Fam Zheng wrote:
>>> On Thu, 01/26 11:04, Daniel P. Berrange wrote:
>>>> The -n arg to the convert command allows use of a pre-existing image=
,
>>>> rather than creating a new image. This adds a -n arg to the dd comma=
nd
>>>> to get feature parity.
>>>
>>> I remember there was a discussion about changing qemu-img dd's defaul=
t to a
>>> "conv=3Dnocreat" semantic, if so, "-n" might not be that useful. But =
that part
>>> hasn't made it into the tree, and I'm not sure which direction we sho=
uld take.
>>> (Personally I think default to nocreat is a good idea).
>>
>> Use nocreat by default would be semantically different from real "dd"
>> binary which feels undesirable if the goal is to make "qemu-img dd"
>> be as consistent with "dd" as possible.
>>
>> It would be trivial to rewrite this patch to add support for the "conv=
"
>> option, allowing the user to explicitly give 'qemu-img dd conv=3Dnocre=
at'
>> instead of my 'qemu-img dd -n' syntax, without changing default semant=
ics.
>=20
> Adding 'conv=3Dnocreat' (and not '-n') feels like the right way to me.

The original idea was to make conv=3Dnocreat a mandatory option, I think.=

qemu-img was supposed error out if the user did not specify it.

Max


--CIFOH35G6ku8kV4xTB6gfoRndecfOUPn6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliR0PMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AUfgH/31e1FCnnpEab6D3+O9zzOxpTwVVOKK0
1Rq6gLPOobsZaSF+8VbRMzqO//YgS0XZmOIG8NLMM9P4AAU2Ve6Cqay0xKr/u7XR
vjHa8/hX7PEY8y2NgOGxlJ7KL9vV4FitgUj2hmR3GfpvS0Fcj/Hx3Fs9Klq4jbiB
qTCe0TQdgCm7nFeBQaZnJG3DESmp0cAvKdp5sIqnzX18MrGkm6LaOgQ4U8rbtKDf
wIki0LhRvszPqfkY3Z3koxBLhmd8o9xfR3ZaMXehWZcyCbsasX8k5Dzyu/vvBlLF
zyotb6ypyR905Erxk+z7K3K3YhrRXL24oqrjhl0CVVZQ3fA7f1Hdd8Q=
=nMu/
-----END PGP SIGNATURE-----

--CIFOH35G6ku8kV4xTB6gfoRndecfOUPn6--
