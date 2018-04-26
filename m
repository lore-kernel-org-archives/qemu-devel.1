Received: from eggs.gnu.org ([2001:4830:134:3::10]:48213)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1fBn0G-0000ch-96
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1fBn0B-0003fg-CO
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:56:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:55579)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1fBn0B-0003f2-1E
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:56:23 -0400
References: <AFF77CBF-01EC-494F-AA9C-9820F368EA32@gmail.com>
	<CAFEAcA9ycYWLJfog5ieugos2DzQGQHU5iyEAutPWCA7Pfr5HpQ@mail.gmail.com>
	<28c598cc-40e4-8191-a48c-5edf8eeb9cf0@gmx.com>
	<CANCZdfpWBLRbdY3rf8LwuxNPxMbB_HCZP6oBPJ4Kone6AeL5cQ@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <ac090e9e-3fa9-94bd-379d-ea19479a3071@gmx.com>
Date: Thu, 26 Apr 2018 21:58:26 +0200
MIME-Version: 1.0
In-Reply-To: <CANCZdfpWBLRbdY3rf8LwuxNPxMbB_HCZP6oBPJ4Kone6AeL5cQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2TXtXfAlXvLA3gcmR6f0JWxsyHOJw0XgI"
Subject: Re: [Qemu-devel] Large patch set advice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Warner Losh <imp@bsdimp.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2TXtXfAlXvLA3gcmR6f0JWxsyHOJw0XgI
From: Kamil Rytarowski <n54@gmx.com>
To: Warner Losh <imp@bsdimp.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <ac090e9e-3fa9-94bd-379d-ea19479a3071@gmx.com>
Subject: Re: [Qemu-devel] Large patch set advice
References: <AFF77CBF-01EC-494F-AA9C-9820F368EA32@gmail.com>
 <CAFEAcA9ycYWLJfog5ieugos2DzQGQHU5iyEAutPWCA7Pfr5HpQ@mail.gmail.com>
 <28c598cc-40e4-8191-a48c-5edf8eeb9cf0@gmx.com>
 <CANCZdfpWBLRbdY3rf8LwuxNPxMbB_HCZP6oBPJ4Kone6AeL5cQ@mail.gmail.com>
In-Reply-To: <CANCZdfpWBLRbdY3rf8LwuxNPxMbB_HCZP6oBPJ4Kone6AeL5cQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.04.2018 21:53, Warner Losh wrote:
> On Thu, Apr 26, 2018 at 5:22 AM, Kamil Rytarowski <n54@gmx.com> wrote:
>=20
>> On 26.04.2018 10:11, Peter Maydell wrote:
>>> On 25 April 2018 at 20:57, Warner Losh <imp@bsdimp.com> wrote:
>>>> I=E2=80=99ve foolishly volunteered to rebase all the changes that th=
e bad-user
>>>> mode folks have done to a recent master rev to get these changes
>> upstreamed.
>>>> A number of people have been working on this for a long time. It=E2=80=
=99s
>> possible
>>>> now to run almost any FreeBSD binary from all the architectures. We =
use
>> it
>>>> to do =E2=80=98native=E2=80=99 builds of tens of thousands of packag=
es in a chroot (so
>>>> building FreeBSD/arm packages on a FreeBSD amd64 box). The diffs are=

>> quite
>>>> large (on the order of 42k lines), so I anticipate some bumps in mov=
ing
>>>> this stuff upstream.
>>>
>>> So, first up, thanks for agreeing to do this. It sounds from your
>>> mail like you're already pretty well aware of the usual pitfalls
>>> with this kind of work, and I don't really have much to add that's
>>> QEMU specific that nobody else has said already.
>>>
>>> One question I do have is about the other BSDs: bsd-user at least
>>> in theory is supposed to support freebsd, netbsd and openbsd.
>>> Your patchsets should fix freebsd, but do you know what the status
>>> is of netbsd and openbsd? Upstream we do compiletest but no runtime
>>> testing; I think last time I tried it they didn't work very well,
>>> but it would be worth checking with the other BSDs downstream to
>>> see if they're using bsd-user and to make sure we don't break anythin=
g
>>> that is currently working for netbsd/openbsd...
>>>
>>
>> I'm looking forward to see it updated for FreeBSD first. We can
>> reschedule NetBSD part for later.
>>
>> Feel free to CC me for code review.
>>
>=20
> Sure. Will do. Do you have NetBSD patches against the git repo as well?=

>=20

At the moment nothing sharable for NetBSD.

> Warner
>=20



--2TXtXfAlXvLA3gcmR6f0JWxsyHOJw0XgI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlriL2IMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsOIoP/2wuzxux2x63asQoxVieYAa23B+eaUj3fK8eCbiX
phiLynpTsf3jv1ufL3kFCi1VrUu+xasmTmQ86ijVE62mGYsK+r0Zppw7mwtf+0ye
0lvWq6IzCgKWe1hTzFLc+hvNeqvXxzLqmeKhFTq+vqtCBqfHEgZwJ5oJOysQNNRC
bT1CWkewH1X6mvzQC5q3UnrKY6Aph2VKAmQuSOv2S2wjkSqghwt9idhiU8iGi9Cu
HJCtiUMj81YwdPnhA2Pxlv1Uu/Q5hn3FREeL5cuE6XqLeRahkAi14fJqc/KMKs0L
FF1u9PFfZFaB9C8T9Ucej0ZZtqHID+BET5YqNsjC9NmyJ6U/yifzQkWODeHUgCAG
oOF/q06PVbXTilJosr7lm98QOd0D4m6DqqqgtwTGBIQ9zOEirF3c9oQv+bzSQdSp
uzulh1C1hGQtBWbkxJhX65NPq8Pk9TQehSPiTp/zBrk+8Y1X9qUqCPYe7j1q4yCO
n+AiHXPfKDwN3D4eL9w2Bh1s51QDJmfAVCy1fel0bX3d0MXsPBAb6chv6JMz2aMM
S7JD6WDe1Cn/UAxnkT2R+IH0wFgxm3nfJuEeDY5UQw1hFv2Mwxbze4vStUQt/5I7
om+j/LaV8FQnKuQ0oCcfwK82WZees8ZiyLvFzpL5CkACEJQVXzD+KyD4mj94S7Ky
SZrn
=yggF
-----END PGP SIGNATURE-----

--2TXtXfAlXvLA3gcmR6f0JWxsyHOJw0XgI--
