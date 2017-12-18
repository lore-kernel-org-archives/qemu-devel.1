Received: from eggs.gnu.org ([2001:4830:134:3::10]:51019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQkd1-0007zs-Dz
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 20:54:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQkcw-0004b2-Fl
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 20:54:03 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
	<cover.1513548172.git.mjt@msgid.tls.msk.ru>
	<CAFEAcA9qOtMtct6hND=uOiP_Nv9vaiuR=0NkSvrQQdz0v3FmfA@mail.gmail.com>
	<26d87055-4c23-6aa1-e55a-fb6a95ece7fd@amsat.org>
Message-ID: <232ba76b-c42c-ddec-2f90-6eb403a8fee8@amsat.org>
Date: Sun, 17 Dec 2017 22:53:50 -0300
MIME-Version: 1.0
In-Reply-To: <26d87055-4c23-6aa1-e55a-fb6a95ece7fd@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="1gl1SoQBId3d3iLWe6mOMr0Bdje47MrXR"
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
To: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1gl1SoQBId3d3iLWe6mOMr0Bdje47MrXR
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev
 <mjt@tls.msk.ru>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <232ba76b-c42c-ddec-2f90-6eb403a8fee8@amsat.org>
Subject: Re: [Qemu-trivial] [Qemu-devel] [PULL v2 00/61] Trivial patches for
 2017-12-18
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
 <cover.1513548172.git.mjt@msgid.tls.msk.ru>
 <CAFEAcA9qOtMtct6hND=uOiP_Nv9vaiuR=0NkSvrQQdz0v3FmfA@mail.gmail.com>
 <26d87055-4c23-6aa1-e55a-fb6a95ece7fd@amsat.org>
In-Reply-To: <26d87055-4c23-6aa1-e55a-fb6a95ece7fd@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>> I'm afraid this fails 'make check'. (I only tested the
>> first pullreq but if you only changed signoffs then
>> it'll still be the same):
>>
>> TEST: tests/qom-test... (pid=3D12208)
>>   /alpha/qom/clipper:
>> Broken pipe
>> FAIL
>> GTester: last random seed: R02S26a31a16d967b2664ad714c1c7f8e7f1
>> (pid=3D12214)
>=20
> Oops
>=20
>>   /alpha/qom/none:                                                    =
 OK
>> FAIL: tests/qom-test
>> TEST: tests/test-hmp... (pid=3D12219)
>>   /alpha/hmp/clipper:
>> Broken pipe
>> FAIL
>> GTester: last random seed: R02S0c5a0f7de3fc6e9885b740c77c86eef2
>> (pid=3D12225)
>>   /alpha/hmp/none:                                                    =
 OK
>>   /alpha/hmp/none+2MB:                                                =
 OK
>> FAIL: tests/test-hmp
>>
>> This is because qemu-system-alpha segfaults on startup:
>=20
> My bad...
>=20
> eede06dd70f72da489b8f968abbb7cb5445ef834 is the first bad commit
> Author: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
>     hw/alpha/typhoon: simplify using the "unimplemented" sysbus device
>=20
> I'm pretty sure I run the qtests, but this was 2 months ago...
> I'll have a look.

This patch is not _trivial_ :| Let's drop it from this tree, I'll have
to rework it.

> [...]
>> There was also a minor merge conflict with the tpm pullreq
>> (both pulls change the #includes in hw/tpm/tpm_tis.c) which
>> you might fix when you respin.
>=20
> Yes, I rebased the 42 patches on /master yesterday but I see you merged=

> the TPM tree in your /staging, so I'll rebase there and resend the
> offending patches fixed to Michael.

Michael, I removed the "hw/alpha/typhoon" patch, and updated the
"hw/tpm: remove old i386 dependency" one: no need to modify
hw/tpm/tpm_tis.c, Marc-Andr=C3=A9 Lureau already cleaned it, I did howeve=
r
clean the newly added hw/tpm/tpm_emulator.c file.

The fixed tree is now available signed in the Git repository at:

  github.com:philmd/qemu.git tags/trivial-patches-2017-12-18

If this is OK to you I'll only resend the "hw/tpm: remove old i386
dependency" on the list, but if you/Peter prefer I can still resend the
whole enchilada (which is unchanged except this unique patch).

Regards,

Phil.


--1gl1SoQBId3d3iLWe6mOMr0Bdje47MrXR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlo3H64ACgkQ4+MsLN6t
wN6j8Q//S2m3jBqPC/Lu9MyDzuce0MJRmYHeX/PUKC8H4nkYl3KqLFmTpJeKiL8/
9zNzii/M4tBk0HLUJ+IuINJCOFx5W4lXFsfil9LXpWli44eiesGHWL1QkiMfPS9V
jraFoJsXMAqim6dtF6HWKinG2sf9E6BKrAXsT9DMaKFp9B6Vxeo98zxu21pwVVSC
kzZ5JFLp6SHw5uv4jzvD55OEF2k88Fc4h03aa0R3gpUYyw4KkPKpl3DzESOnVpaL
JMQoIA9lGytEVqxNKVSd8JxM/E73lJbOk6DVrct2pi1ti52t7s7ZzpDgcblynQzD
Pq/zq7NJZCki9/9KMgr+MM5y33sZdvCeLbsXXiIxqlZnKEjYaGi5F6jeUutzbyzS
K3tO/RNSmap15EwqMQs0VaeCOIFY0N2k3H47vC/aipTcKUHVquMU+oUqhyNtXKnu
s/FRD8JGGlCFjPj5UgZzTBs7seUDq22sfVPXd5rmdrQOCLKduuZVwQFGYoFDhPhc
1/i3B8JGAPonVjBCmCe7qBunrOpXl9dQY0H8rbXFl1+/5XQU1GNs636WtQqexbDB
liff7f3FOdqeX3dHNVwZAg1iIPmkA9V0ZJ8NN5i61+dBozxa3hG7nYaQYbgUXt7g
8C/BTr2ZCCBSWOXa+Tw94k+/FzefaPnNLD70CRYAhIQyFVSKwc4=
=Ewwb
-----END PGP SIGNATURE-----

--1gl1SoQBId3d3iLWe6mOMr0Bdje47MrXR--
