Received: from eggs.gnu.org ([2001:4830:134:3::10]:52868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds1x9-00078p-QX
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds1x8-0004sc-TV
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:19:19 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-29-eblake@redhat.com>
	<52e5f270-4648-b3ce-bdaf-c4b59700ff01@redhat.com>
	<b777963c-a914-b941-26f2-6492b2fb4f84@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f79db7a3-ab12-2b3e-03ca-8451ea287f88@redhat.com>
Date: Wed, 13 Sep 2017 09:19:00 +0200
MIME-Version: 1.0
In-Reply-To: <b777963c-a914-b941-26f2-6492b2fb4f84@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="cSobBJbtFOOAE4vgk3Ux3vIO9PhIAFeIp"
Subject: Re: [Qemu-devel] [PATCH v7 28/38] libqtest: Add qtest_[v]startf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:IDE" <qemu-block@nongnu.org>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cSobBJbtFOOAE4vgk3Ux3vIO9PhIAFeIp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.09.2017 15:32, Eric Blake wrote:
> On 09/12/2017 05:14 AM, Thomas Huth wrote:
>> On 11.09.2017 19:20, Eric Blake wrote:
>>> We have several callers that were formatting the argument strings
>>> themselves; consolidate this effort by adding new convenience
>>> functions directly in libqtest, and update all call-sites that
>>> can benefit from it.
[...]
>>>  static void test_mon_partial(const void *data)
>>>  {
>>>      char *s;
>>> -    char *cli;
>>> +    const char *args =3D data;
>>>
>>> -    cli =3D make_cli(data, "-smp 8 "
>>> -                   "-numa node,nodeid=3D0,cpus=3D0-1 "
>>> -                   "-numa node,nodeid=3D1,cpus=3D4-5 ");
>>> -    qtest_start(cli);
>>> +    global_qtest =3D qtest_startf("%s -smp 8 "
>>> +                                "-numa node,nodeid=3D0,cpus=3D0-1 "
>>> +                                "-numa node,nodeid=3D1,cpus=3D4-5 ",=
 args);
>>
>> Does GCC emit a warning if you'd used data here directly? Otherwise I
>> think you could simply do this without the local args variable...
>=20
> Passing void* through varargs, with the intent of the receiver parsing
> it as char*, is technically undefined in C.  I don't know if gcc warns,=

> but I'm also worried that clang might warn.  I prefer to err on the sid=
e
> of defined behavior in this case, even though it annoyingly requires a
> temporary variable.

OK, sounds reasonable, so let's keep it!

 Thomas


--cSobBJbtFOOAE4vgk3Ux3vIO9PhIAFeIp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZuNvkAAoJEC7Z13T+cC21v0oP/isGDJK2TQZzgJPMGn3KYF64
fKG/1gnhlP0ldLpPaVy147snY+GpTaUPPQgCG5M6dhYbiX3cd62t+2XBQdNGJUG9
xEkNTE3fzv88nAj852DzMb3KRcPKAAPO/Do4gOjUgvZWG+fhn0vXgZr1Jxo7tSuy
fE4icAmDWtDhaujknwvGfVkTihstUY8349Svq5cCHWqmQUWJAZyXjJkAgMbMnkEL
GPPXNE3YIaWKL9KoWspN9eJAxwEpKN0EFF524ckJXRgSR2jwSYgwp1i4zIECiVzb
012BprQkYMIphg8KQ/QmG0tcamGD5XcZQqRkKXur63H4aaK6nTlgEIvLH3OQUfW4
k+XirM5tepktP3g08ZERJ6oGvl1OrrlxqAk9/D4lJeid4YUAp4INurv16fnQKXi0
R/0d152q6jtlo0rBdkMLraaZVZ/TIQpOwQN3R/MH/742VvaUiyV6oin7jKvje2Kb
5Cx2tKsVEZjxb6d2R8Oq87K3ncSbe7BoPSqcgVcTkEv7y2z5j9y99N1q0x6YbVt0
kexDmrSgU0tmReOOE+VPWo5CsW/tiGiKAdgvhM2QnsQSdSecL/rjJjzyFuHCY2dz
bhsf5nnRYQ4UuQt2+HD3UbiG2ZbSMouMqbpswfSL3dVexXKd8AdVHLun3QEcg8L1
uT9WIxgKWxEK1eMifvTl
=RDU4
-----END PGP SIGNATURE-----

--cSobBJbtFOOAE4vgk3Ux3vIO9PhIAFeIp--
