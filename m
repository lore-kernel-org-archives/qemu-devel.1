Received: from eggs.gnu.org ([2001:4830:134:3::10]:53021)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dnQpd-0003Hn-ED
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dnQpa-0002VA-B4
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:52:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:52805)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dnQpZ-0002Ui-VG
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:52:30 -0400
References: <20170831064302.14427-1-famz@redhat.com>
	<a0308f02-4716-87ea-5070-b57d567aae07@gmx.com>
	<CAFEAcA9x1kmkhqvGM7y0AJRbr7+5t56sOqQPNQ0cowK8vCvVKA@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <aad2bfc7-83a2-f877-42b8-b0dc2bd74f79@gmx.com>
Date: Thu, 31 Aug 2017 16:42:12 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9x1kmkhqvGM7y0AJRbr7+5t56sOqQPNQ0cowK8vCvVKA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ViFmIkCqSOd08q5N7AcVRPTU3FBXiJgh2"
Subject: Re: [Qemu-devel] [PATCH v5 00/12] tests: Add VM based build tests
 (for non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ViFmIkCqSOd08q5N7AcVRPTU3FBXiJgh2
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Message-ID: <aad2bfc7-83a2-f877-42b8-b0dc2bd74f79@gmx.com>
Subject: Re: [PATCH v5 00/12] tests: Add VM based build tests (for non-x86_64
 and/or non-Linux)
References: <20170831064302.14427-1-famz@redhat.com>
 <a0308f02-4716-87ea-5070-b57d567aae07@gmx.com>
 <CAFEAcA9x1kmkhqvGM7y0AJRbr7+5t56sOqQPNQ0cowK8vCvVKA@mail.gmail.com>
In-Reply-To: <CAFEAcA9x1kmkhqvGM7y0AJRbr7+5t56sOqQPNQ0cowK8vCvVKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.08.2017 16:27, Peter Maydell wrote:
> On 31 August 2017 at 15:04, Kamil Rytarowski <n54@gmx.com> wrote:
>> Could we please add SmartOS image. It's an Illumos distribution,
>> previously known as OpenSolaris.
>>
>> qemu is actively maintained for SmartOS in pkgsrc.
>>
>> The latest build fixes were introduced less than a week ago.
>> https://github.com/NetBSD/pkgsrc/commit/f2608af5433f1491a92567bf570e93=
49dffbda7a
>=20
> Maintaining out of tree patches without posting them upstream
> is rather counterproductive, because if the host OS doesn't
> build or have anybody submitting patches to fix it upstream
> we will conclude that it's unused and delete the support entirely.
> That E1000_SEC define has been around for nearly 10 years
> without anybody saying it was a problem, for instance.
> (Indeed Solaris is probably next after AIX on the "nobody
> came along to tell us they cared enough to help us maintain
> it" list for removal as a result.)
>=20

Fully agreed. I keep slowly unloading pkgsrc from the downstream patches.=


>> I'm going to submit the SmartOS patches to fix the build
>> regardless of the decision.
>=20
> Thank you. Do you also have some instructions on how to
> get it running in a VM or something so we can add it to
> our build tests? (Login on a build machine, or a SmartOS
> host in the gcc compile farm, would work too).
>=20

I use a Joyent machine for pkgsrc developers. I'm right now test
building 2.10.0 (including the dependencies).

I don't have any first-time starter.. This wiki might be useful.
https://wiki.smartos.org/display/DOC/Download+SmartOS

SmartOS is a regular UNIX-like OS (or even certified UNIX-based).

> thanks
> -- PMM
>=20



--ViFmIkCqSOd08q5N7AcVRPTU3FBXiJgh2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZqCBLAAoJEEuzCOmwLnZsS2wQAI3SRhWuQOQhBZEgmnJKy485
edCbwOScYv+iVFgQMAqDVoK825dy4V47xPfSfEjkj8ZQXqWi+CNRjC1zsZWQUiUG
a7w3b1qWKfxxOkd+upNHPMtr2VCmyqU54spqx57TGUpoQD668P9Sxv4Ix0NAfWAi
kmeRPZ8VkhCZ4T5CVKbUP+b8o99dC6suD0Dx3EAXVtRgZra/MWqCXa1Q+CWi541B
C/h4GDuNN5+YoMbXjs8Eq6P/pXYfQVeQb8q7IM9EvABGbnhiZZtEtyGYIn4pLjCG
0kahlLpNaOdu4wgEyJVVsz74vbCwlPR4EZ5y+EROyOs/B7NmncmylbLfSJ/iuTm1
X4BF2LAXgSnNqVJ3CjShdLI7nIkcvwkr6Pi6oNPHl62ms5hY/45fEbsgBVDMc0ge
di0BqYsNrSnVYgpLDxdHk6VTaQeVQYalZjCutZm/ogk+hFvWrtY4jRVL58Rv51wn
CeX8bhvprMwu/pOX12PH5V5DNqVD36NAeSZV5goticcRWB5fmkKf5CDYLLfNo+iv
QLwqcu6hw4CModws3Mr7pasHu1eclq9gB/eHC3W14eEvyPhg8GvDRYJQKxn1gF2c
lxz2z9dsoNCw7aeAg/fhbv+/JQlYz8HwNQJZEo7SVzdxuG7TTFIzsJu+eQNnfQ7e
mKATptTjcjlGWktNzl2g
=sCjX
-----END PGP SIGNATURE-----

--ViFmIkCqSOd08q5N7AcVRPTU3FBXiJgh2--
