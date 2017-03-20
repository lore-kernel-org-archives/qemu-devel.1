Received: from eggs.gnu.org ([2001:4830:134:3::10]:54289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cpyo0-0000YH-T5
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cpynu-0002wN-UF
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:01:08 -0400
References: <20170317152412.8472-1-pbonzini@redhat.com>
	<64e3466a-58e9-4720-e158-27227bc69d2f@redhat.com>
	<CAFEAcA-NY8izZr3iuJsjomtc42Q0GC-chVr04+ZOguKMUCrVkA@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8ad560d6-37d9-8cb0-53a1-1b35f944783a@redhat.com>
Date: Mon, 20 Mar 2017 16:00:50 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-NY8izZr3iuJsjomtc42Q0GC-chVr04+ZOguKMUCrVkA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ti0WbVpsxrm8R21GKCcgUUJARNagwcLWk"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] curl: fix compilation on
 OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ti0WbVpsxrm8R21GKCcgUUJARNagwcLWk
From: Max Reitz <mreitz@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Message-ID: <8ad560d6-37d9-8cb0-53a1-1b35f944783a@redhat.com>
Subject: Re: [Qemu-block] [PATCH] curl: fix compilation on OpenBSD
References: <20170317152412.8472-1-pbonzini@redhat.com>
 <64e3466a-58e9-4720-e158-27227bc69d2f@redhat.com>
 <CAFEAcA-NY8izZr3iuJsjomtc42Q0GC-chVr04+ZOguKMUCrVkA@mail.gmail.com>
In-Reply-To: <CAFEAcA-NY8izZr3iuJsjomtc42Q0GC-chVr04+ZOguKMUCrVkA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 18.03.2017 18:23, Peter Maydell wrote:
> On 18 March 2017 at 02:27, Max Reitz <mreitz@redhat.com> wrote:
>> On 17.03.2017 16:24, Paolo Bonzini wrote:
>>> EPROTO is not found in OpenBSD.   We usually use EIO when no better
>>> errno is available, do that here too.
>>>
>>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  block/curl.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Thanks, applied to my block branch:
>>
>> https://github.com/XanClic/qemu/commits/block
>=20
> Thanks; I've applied it to master as a build fix, though,
> so you can drop it (or leave it and let the merge
> sort it out if you like).

Got it, thanks!

Max


--Ti0WbVpsxrm8R21GKCcgUUJARNagwcLWk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljP7qISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A5XwIAMERUF0W9Ha1XW98iyc1tREp3jhZVU/J
gmSJEs8Z5HJWteGZ0BtXq4k+3nJWwT7YTetbbU57BYjsqGmzmbw80rb/wYxEna0L
K64rQ6D/6x1OxZ9vM/rAZHlP6YbgHh7bPNwxwDGSf2SUmKowCTyHzzFVfkh6gy5Z
RrgrR1ZouFPJWBlIWCdgMUiST0nSclVISnKlgaczBcIkcUMrRmlKcQMReZrcId10
GFSPEcGBKXBjAUep/HR3dDJ7b1gyGbkKlnzfAx2epBwYBMOk0SGPkHMXpOzkVBbm
JpPKvUgg2GP+F1B1BBoplIlUmM2gxnpzni7bUTLGzK2ApPLTO0u5YDU=
=F7py
-----END PGP SIGNATURE-----

--Ti0WbVpsxrm8R21GKCcgUUJARNagwcLWk--
