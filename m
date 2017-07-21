Received: from eggs.gnu.org ([2001:4830:134:3::10]:52459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYWxm-0007lN-WA
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYWxj-0000qe-0e
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:23:22 -0400
References: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
	<1500395194-21455-5-git-send-email-peter.maydell@linaro.org>
	<b27c6322-49f7-3f73-6df3-e8f4ddae9652@redhat.com>
	<CAFEAcA9vTrpRL-cihQ-DtDj2TYAbNtzLf8b-WTAx+4Mz5xoKiA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dabe4865-05a0-eb85-f9db-8948db3e14bf@redhat.com>
Date: Fri, 21 Jul 2017 07:23:15 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9vTrpRL-cihQ-DtDj2TYAbNtzLf8b-WTAx+4Mz5xoKiA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4X6gfLNI5Ubw6XR5RQI7IBswIsFgokxjR"
Subject: Re: [Qemu-devel] [PATCH for-2.10 4/4] bsd-user/main.c: Fix unused
 variable warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4X6gfLNI5Ubw6XR5RQI7IBswIsFgokxjR
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 "patches@linaro.org" <patches@linaro.org>
Message-ID: <dabe4865-05a0-eb85-f9db-8948db3e14bf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 4/4] bsd-user/main.c: Fix unused
 variable warning
References: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
 <1500395194-21455-5-git-send-email-peter.maydell@linaro.org>
 <b27c6322-49f7-3f73-6df3-e8f4ddae9652@redhat.com>
 <CAFEAcA9vTrpRL-cihQ-DtDj2TYAbNtzLf8b-WTAx+4Mz5xoKiA@mail.gmail.com>
In-Reply-To: <CAFEAcA9vTrpRL-cihQ-DtDj2TYAbNtzLf8b-WTAx+4Mz5xoKiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/19/2017 03:19 AM, Peter Maydell wrote:
> On 18 July 2017 at 23:01, Eric Blake <eblake@redhat.com> wrote:
>> On 07/18/2017 11:26 AM, Peter Maydell wrote:
>>> On OpenBSD the compiler warns:
>>> bsd-user/main.c:622:21: warning: variable 'sig' set but not used [-Wu=
nused-but-set-variable]
>>>
>>> This is because a lot of the signal delivery code is #if-0'd
>>> out as unused. Reshuffle #ifdefs a bit to silence the warning.
>>
>> Why not just nuke the #if 0 code instead (we can always 'git revert' i=
t
>> later as a starting point for someone that wants to implement it).
>=20
> I went for the minimal change, especially given we know
> that the freebsd folks have a big patchset on top of
> us fixing a lot of bsd-user code and it didn't seem worth
> giving them a more awkward rebase task.

Perhaps worth mentioning in the commit message that keeping the #if 0 is
intentional, then. At any rate,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4X6gfLNI5Ubw6XR5RQI7IBswIsFgokxjR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllx8jQACgkQp6FrSiUn
Q2pn1gf/eDSlDieGM6x0aZfLbzw/FBk3Dc6pDothmIG+46rKJ2s1bQL1s9agTjyC
a1pxqzX3guJhH1gPoJJS8DHxrQkl13WdbXBucVUIzfN7laH6fRtHZs49Wx/5xB7p
HjBqzKM6S/V5Kz6E98xPK6txYGGfmPwQ9Gq0kaqVYK3T1en8Cx8EFl1/M3qEfuId
24fAjT8ojZSomDlMQhb5YFcWDbzTOsgs7aSQ17Z1qhi6uzVwCsZfKslAe7UtxBVM
Hf76+/FGkZr7ol25yviqwZtCPoixWEqc2LOXigozzDiA4EyCwx8D+ci9XYIZh3Pg
Ho+aJBauctMAiY6vveiSk4pcNBOAUA==
=f0Em
-----END PGP SIGNATURE-----

--4X6gfLNI5Ubw6XR5RQI7IBswIsFgokxjR--
