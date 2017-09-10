Received: from eggs.gnu.org ([2001:4830:134:3::10]:56508)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dqzRe-00067r-F3
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 06:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dqzRb-0005R5-9M
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 06:26:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:63815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dqzRa-0005Qj-Uo
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 06:26:27 -0400
References: <20170909054613.19148-1-famz@redhat.com>
	<20170909054613.19148-11-famz@redhat.com>
	<CAFEAcA83JDUMAsCAY=YBL+qS8A1n6VMfH1p_DAmouF0W8m-j9g@mail.gmail.com>
	<20170909150710.GA29670@lemon.lan>
	<4377bd37-3309-fe80-666f-f05626efe930@gmx.com>
	<20170910020547.GA32341@lemon.lan>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <07e48f26-b434-942c-4e86-3c52882aaca8@gmx.com>
Date: Sun, 10 Sep 2017 12:15:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170910020547.GA32341@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kcDs7P15uDwsKD6gjmC08Jvfx3Wqg0wLN"
Subject: Re: [Qemu-devel] [PULL v2 10/37] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kcDs7P15uDwsKD6gjmC08Jvfx3Wqg0wLN
From: Kamil Rytarowski <n54@gmx.com>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <07e48f26-b434-942c-4e86-3c52882aaca8@gmx.com>
Subject: Re: [Qemu-devel] [PULL v2 10/37] scripts: Add archive-source.sh
References: <20170909054613.19148-1-famz@redhat.com>
 <20170909054613.19148-11-famz@redhat.com>
 <CAFEAcA83JDUMAsCAY=YBL+qS8A1n6VMfH1p_DAmouF0W8m-j9g@mail.gmail.com>
 <20170909150710.GA29670@lemon.lan>
 <4377bd37-3309-fe80-666f-f05626efe930@gmx.com>
 <20170910020547.GA32341@lemon.lan>
In-Reply-To: <20170910020547.GA32341@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.09.2017 04:05, Fam Zheng wrote:
> On Sat, 09/09 17:08, Kamil Rytarowski wrote:
>>>>> +submodules=3D$(git submodule foreach --recursive --quiet 'echo $na=
me')
>>>>> +
>>>>> +if test -n "$submodules"; then
>>>>> +    {
>>>>> +        git ls-files
>>>>> +        for sm in $submodules; do
>>>>> +            (cd $sm; git ls-files) | sed "s:^:$sm/:"
>>>>> +        done
>>>>> +    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done=
) > $1.list
>>>>
>>>> Supporting '-e something' in a tar -T listfile seems to
>>>> be GNU tar specific. Do we care?
>>>
>>> The "-e $sm" will go to the grep command line, so it isn't GNU specif=
ic, is it?
>>>
>>
>> BSD OSes use GNU grep(1) the latest version GPLv2. There is a work in
>> progress BSD grep(1), but not turned on by default as it's slower.
>>
>> The -e option is supported by SmartOS grep(1).
>=20
> Is there a more portable way to filter out multiple patterns?
>=20
> Fam
>=20


I don't think that there is needed more portability. If so, there is an
option to detect "ggrep" (GNU grep) and if it exists - use it.


--kcDs7P15uDwsKD6gjmC08Jvfx3Wqg0wLN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlm1EOIMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsGeAQALho0LboaeAQO7B87o6VttdoV1YZGUpjh/w9PBuE
QvuS3nHL+Ger1HAmmBku5GwJABIj2tfyVnX1+PGO+YrS5SRAndQCy7CYb7c2Cqkg
5n8ZpXag2AcAzSWIIlVMS2vVaSwZEHKdFGADr74aYShNd+N08Bniu4Tf1GUCuAmR
wE+HK6Uijq4Tv7UNzw6uqxfR/SY/moqeG8/J/E3ex4WiR4nhFgbOR+23lF5Aa4B4
dMIWLcP0bejAbWN9WArfWb2tE3kutTRmvmuCFnRbrYc1jkqTubJhgcR/coL0Y6VC
lMmtQSAYJpSI3IkGoNE+vtuSJe9u/8AJFRTNiPwygm84kCkIHU5Kx5KtYXUq/Nam
MXzKMcCpVuEiEa8utqk43mMjJMxUksyE18nHLxoCfSMoTgY5H4yi+jCA0E7gJ3Nk
dXWXjET88rgAn275yVx3iTCCf+rkBAu3yFTOAAiHifP6TwGHL3gb/lp+QQGz9kBM
Ll8YdjL4ac+z+8SM6tCtQVWJWWa0OC8SkOyyQYHHlXDP1EkbxBVMmfvEgqCMdFRz
605qj+W5IYjarHufYeaGGjP87c/m/MnuQr7ExFzUfAUrAmmtGLSZXRipWcGN13Jv
+IwJB/VivbDmZZ6oZLz5DqIPNW+zIgGi/FugMoCyqWYt6Sr3YwY7MyXllGY8vuZu
+2C5
=+vcZ
-----END PGP SIGNATURE-----

--kcDs7P15uDwsKD6gjmC08Jvfx3Wqg0wLN--
