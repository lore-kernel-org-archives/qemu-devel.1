Received: from eggs.gnu.org ([2001:4830:134:3::10]:43618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQjUz-0008Bo-Mu
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 19:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQjUu-0002AF-TV
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 19:41:41 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
	<cover.1513548172.git.mjt@msgid.tls.msk.ru>
	<CAFEAcA9qOtMtct6hND=uOiP_Nv9vaiuR=0NkSvrQQdz0v3FmfA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <26d87055-4c23-6aa1-e55a-fb6a95ece7fd@amsat.org>
Date: Sun, 17 Dec 2017 21:41:24 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9qOtMtct6hND=uOiP_Nv9vaiuR=0NkSvrQQdz0v3FmfA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="cMXAmX5kw5WGtRURVwINp7W7P7lYhBTw9"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PULL v2 00/61] Trivial patches for
 2017-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cMXAmX5kw5WGtRURVwINp7W7P7lYhBTw9
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev
 <mjt@tls.msk.ru>, Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <26d87055-4c23-6aa1-e55a-fb6a95ece7fd@amsat.org>
Subject: Re: [Qemu-trivial] [Qemu-devel] [PULL v2 00/61] Trivial patches for
 2017-12-18
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
 <cover.1513548172.git.mjt@msgid.tls.msk.ru>
 <CAFEAcA9qOtMtct6hND=uOiP_Nv9vaiuR=0NkSvrQQdz0v3FmfA@mail.gmail.com>
In-Reply-To: <CAFEAcA9qOtMtct6hND=uOiP_Nv9vaiuR=0NkSvrQQdz0v3FmfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 12/17/2017 08:14 PM, Peter Maydell wrote:
> On 17 December 2017 at 22:07, Michael Tokarev <mjt@tls.msk.ru> wrote:
>>> Here's a large pull request for trivial-patches queue.
>>> It's been quite a whie since the last request, and many
>>> changes has been accumulated.
>>>
>>> Also there's a large patchset by Philippe Mathieu-Daud=C3=A9
>>> named "remove i386/pc dependency from non-PC world (part 1)"
>>> consisting of 42 patches which makes good portion of this
>>> pull request.
>>
>> I forgot to add my S-o-b lines to the large series by
>> Philippe Mathieu-Daud=C3=A9. So here's a re-send of just the
>> cover letter (not all the other patches). The only difference
>> is the addition of 42 of my "S-o-b" line.
>=20
> I'm afraid this fails 'make check'. (I only tested the
> first pullreq but if you only changed signoffs then
> it'll still be the same):
>=20
> TEST: tests/qom-test... (pid=3D12208)
>   /alpha/qom/clipper:
> Broken pipe
> FAIL
> GTester: last random seed: R02S26a31a16d967b2664ad714c1c7f8e7f1
> (pid=3D12214)

Oops

>   /alpha/qom/none:                                                     =
OK
> FAIL: tests/qom-test
> TEST: tests/test-hmp... (pid=3D12219)
>   /alpha/hmp/clipper:
> Broken pipe
> FAIL
> GTester: last random seed: R02S0c5a0f7de3fc6e9885b740c77c86eef2
> (pid=3D12225)
>   /alpha/hmp/none:                                                     =
OK
>   /alpha/hmp/none+2MB:                                                 =
OK
> FAIL: tests/test-hmp
>=20
> This is because qemu-system-alpha segfaults on startup:

My bad...

eede06dd70f72da489b8f968abbb7cb5445ef834 is the first bad commit
Author: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

    hw/alpha/typhoon: simplify using the "unimplemented" sysbus device

I'm pretty sure I run the qtests, but this was 2 months ago...
I'll have a look.

[...]
> There was also a minor merge conflict with the tpm pullreq
> (both pulls change the #includes in hw/tpm/tpm_tis.c) which
> you might fix when you respin.

Yes, I rebased the 42 patches on /master yesterday but I see you merged
the TPM tree in your /staging, so I'll rebase there and resend the
offending patches fixed to Michael.

Regards,

Phil.


--cMXAmX5kw5WGtRURVwINp7W7P7lYhBTw9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlo3DrgACgkQ4+MsLN6t
wN4srg/7BQ89mrRlBdY0jNO3f377WQARmSo8FUcCfsGDURVMDbjDF1CpHMrBOjxi
BR/ehKG2fljtKnjcQ5HstUef9XsddH67kQs3K5/PkKvXLdtvXUwy0qRwQRpYxqpB
yt9NXxFgHp9DCjVZLV6ULnsYkBXEzOlTHNx0B+L/E8PMYnvyAt70gVywROTKQBX0
UUELG9/o9lKAMtB9MCIm6y52Tm1GqLTMoJ0r874OMNhaEH7xGdzH9YGotErTBuqw
2lBYOTUN0W9Fd5MD8SKViHibowOWbVEGkFeyCzShN3Ibg6nN+T5OfqSpZYs2xpfh
PHFyTMyc9AqylznKlp4T/gf2w2RduJhFvfEIQrBFqjS6rB+VLksyfzxVyHXzR/tz
9xnH1wN0XGM58SO2x7JEBoKp60b8mR03hzoXRG3HUa4xgZzslhMtjnOf09n4Z/Pa
tJhg1RYZyBQlct+3env3tIwDrtICi68Ebjhp7/EyzsOTeLSLc2IaXEA3w5PskOCb
PwKOzTrXRX9yJpAfX158fmFwzPMZJcSTXQG2XaetHm/fpba1WsHOlkh2GfXL+CQr
i1iH+O06PDXJEo7XndnagpVnAMgacZow1pJtjxuMH9d9BujKpUn5sPEtxGOtQrfT
xSpybjvWTudTanKKt3i22gXijmYEDybGELAOK/zipH1wkFnksPI=
=trym
-----END PGP SIGNATURE-----

--cMXAmX5kw5WGtRURVwINp7W7P7lYhBTw9--
