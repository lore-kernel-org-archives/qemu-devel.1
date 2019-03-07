Received: from eggs.gnu.org ([209.51.188.92]:44957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1ycl-00007o-7i
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:24:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1yck-0005IN-8p
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:24:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h1ycj-0005H1-TU
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:24:10 -0500
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
	<CAMxuvaxeAdZKk_CQOyqCJdd_1kVZEBPCm0LRoP2u9aijOtbDxg@mail.gmail.com>
	<c0e04289-3373-3a56-b367-0d6033c52789@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <81f2035b-f584-f9b7-e6af-4754707b2f17@redhat.com>
Date: Thu, 7 Mar 2019 13:24:07 -0600
MIME-Version: 1.0
In-Reply-To: <c0e04289-3373-3a56-b367-0d6033c52789@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nr8fmYQY7kRNKqpWyJacbBrhsqQtwSZ58"
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nr8fmYQY7kRNKqpWyJacbBrhsqQtwSZ58
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Message-ID: <81f2035b-f584-f9b7-e6af-4754707b2f17@redhat.com>
Subject: Re: [Qemu-devel] converting build system to Meson?
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
 <87r2bigarf.fsf@zen.linaroharston>
 <a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
 <CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
 <62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
 <CAMxuvaxeAdZKk_CQOyqCJdd_1kVZEBPCm0LRoP2u9aijOtbDxg@mail.gmail.com>
 <c0e04289-3373-3a56-b367-0d6033c52789@redhat.com>
In-Reply-To: <c0e04289-3373-3a56-b367-0d6033c52789@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/7/19 1:04 PM, Eric Blake wrote:

> I don't mind a switch to mandatory out-of-tree builds (I like the
> convenience of in-tree for quick hacks, but VPATH is infinitely more
> flexible when testing multiple build configurations in parallel, and
> I've worked on other projects with mandatory VPATH builds without seein=
g
> too many complaints there).

I will add: The GNU Coding Standards require both in-tree and
out-of-tree builds to work (and you get that with Autotool'd projects).
But since qemu is intentionally not using Autotools, and is not a GNU
project, it is merely an annoyance to me if in-tree builds are broken
(I'm much more annoyed by projects that don't support VPATH builds than
by projects that don't support in-tree builds).

And if switching to out-of-tree-only eases maintenance burdens (less
=2Egitignore patches from me, for starters :), then we can spend develope=
r
time on more important stuff.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--nr8fmYQY7kRNKqpWyJacbBrhsqQtwSZ58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyBb9cACgkQp6FrSiUn
Q2oEUQgAjA4cILvJQix6OrcCXYSrwyzqsVN8sdM2JbQaUJK/Yp+DVZ6xxMEmpvz5
vnHpF8TLoep8DmR47r55G4db2eMGs+w3TFk/SpnhEH4tQ1onuE7PRY0BZb0iEXxR
rEHTLn/9XD5Gerp1dYBp+OgNbmSga8i6au7bgM8oMvTslxuCKFIRonIH+/1T3pKp
khCbxictTZfLEcJ1Ypjur8RX3YS3kcSIDZEUCo7pztxGEXojXS1XiWM1JMaYMa02
Oaj3G9YBWn7pJYEZ4oJz4Yc0HUNBCQh7Bx2bzO65PXTMt5O4sZV6vxfe8fZP86i1
GSsaYeoYHWQAZATZ6DPGt7rr1ZimgQ==
=4xBY
-----END PGP SIGNATURE-----

--nr8fmYQY7kRNKqpWyJacbBrhsqQtwSZ58--
