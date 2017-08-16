Received: from eggs.gnu.org ([2001:4830:134:3::10]:33345)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dhvRU-00064m-Ov
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dhvRP-0007id-Rk
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:20:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:61706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dhvRP-0007iS-9l
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 06:20:47 -0400
References: <20170816072104.24420-1-famz@redhat.com>
	<9ad5fa6c-a7c1-e701-12e9-6e6d5372b16c@gmx.com>
	<20170816101314.GB8396@lemon>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <ca27ec5c-5642-2c75-1d64-924350cb372c@gmx.com>
Date: Wed, 16 Aug 2017 12:10:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170816101314.GB8396@lemon>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NqKocBP2aobxNNipx4mT4fJsI1MQiCBAe"
Subject: Re: [Qemu-devel] [PATCH RFC 0/9] tests: Add VM based build tests
 (for non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, stefanha@redhat.com, pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NqKocBP2aobxNNipx4mT4fJsI1MQiCBAe
From: Kamil Rytarowski <n54@gmx.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 stefanha@redhat.com, pbonzini@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <ca27ec5c-5642-2c75-1d64-924350cb372c@gmx.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/9] tests: Add VM based build tests (for
 non-x86_64 and/or non-Linux)
References: <20170816072104.24420-1-famz@redhat.com>
 <9ad5fa6c-a7c1-e701-12e9-6e6d5372b16c@gmx.com> <20170816101314.GB8396@lemon>
In-Reply-To: <20170816101314.GB8396@lemon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.2017 12:13, Fam Zheng wrote:
> On Wed, 08/16 11:24, Kamil Rytarowski wrote:
>> On 16.08.2017 09:20, Fam Zheng wrote:
>>> Build tests in one 32 bit Linux guest and three BSD images are define=
d in this
>>> series. This is a more managable way than the manually maintained vir=
tual
>>> machines in patchew. Also, one big advantage of ephemeral VMs over lo=
ng running
>>> guests is the reduced RAM usage of host, which makes it possible to h=
ave one
>>> host test all these BSD variants and probably more.
>>>
>>
>> Thank you for your work on this!
>>
>>> The BSD guest templates are manually prepared following
>>>
>>> https://wiki.qemu.org/Hosts/BSD
>>>
>>> as it is not easy to automate. (The ideal approach is like the ubuntu=
=2Ei386
>>> script, which configures the guest on top of an official released ima=
ge, fully
>>> automatically.)
>>>
>>
>> For the reference, inside the NetBSD infrastructure we use homegrown A=
nita:
>>
>> http://pkgsrc.se/misc/py-anita
>=20
> Looks cool. Is it suitable for using to implement tests/vm/netbsd? Is t=
here a
> user documentation?
>=20
> Fam
>=20

Documentation:

http://www.gson.org/netbsd/anita/

I'm not sure if it is suitable. It was designed with a different goal -
to verify the process of installation and execution of ATF (regress)
tests. The process of clean installation of NetBSD for every patch is
overkill... however this might be a source of inspiration. (I've not
been digging into the source code).


--NqKocBP2aobxNNipx4mT4fJsI1MQiCBAe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZlBozAAoJEEuzCOmwLnZsP5EQAJ81pBuV5kWmTWn6BoFGkG8y
y+xWJ83mGxmCaENJFb4YxMNaL7rSf/x47qVJlzoyHv/O7GmX93Wp8g582G9CUdKD
kxRwd85IQv57NwHe6473jQ9LgCpLC148zRRpzAG87osd38M9WPBKYnmKGBcz/uqH
dWVUWtJB4i4gVrwwQwdBP1/JFRzw1VXvOz4LELBvngBzh6OvZq62acs89Ex4qq+P
BuzWbBp+z0GtLW+nOKnaS/osn03aJLKKOEqqMTiQxWtWcq6wbyIga5fzY6d3+dZP
Tdg4vkkJ3jLl28l32x+mwn4gkIPnWqwY/ZdD9mHKi2xfvPlGnejoancmOaA912Vo
nGcYfHEpLIM9McQVPv4e1Y+6xiKv0Ql50uY2nMUfp2WoLr41W1qIcgfWKlrKAvs7
gCvwFH68z3gfWwyuilu6REIt/bczcPI0Zecb+QhGAq9JQ6EuC2h2bX9QgrKcrBHj
UU+XImKDA+01kDkvFKDr7jKjVhaD7V9CWZ+/OSKUnJpYa7xYzXjnAmioNYpd7Oyx
XQgb2JNnDu5ewYzhxt01n4JNSy8jAWE3s2jcNi3iCgl6rJDTjzIEFFClA7dHX7AX
PMKBkgWP+yVEsMiud1O23xlIa668AApIl9kseGQOiw8NYf1cQ+GA0uVXH+PMQk4f
Ma6D3tx8IBnN+ciFT7NE
=kar4
-----END PGP SIGNATURE-----

--NqKocBP2aobxNNipx4mT4fJsI1MQiCBAe--
