Received: from eggs.gnu.org ([2001:4830:134:3::10]:48416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYIiR-0002Nq-AN
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYIiN-0005vB-4F
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:10:35 -0400
References: <1500568341-8389-1-git-send-email-peter.maydell@linaro.org>
	<eec67af4-3f8e-bb85-0854-61f4d450f627@redhat.com>
	<CAFEAcA9M0jeER9Ygg74_kQXv4CeW2_PMns7=t=Jw6sxkYhANpA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <15cdd5e0-48f8-35be-8fa3-c57bc50828f6@redhat.com>
Date: Thu, 20 Jul 2017 16:10:27 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9M0jeER9Ygg74_kQXv4CeW2_PMns7=t=Jw6sxkYhANpA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LgRcC7l64IOhTgbRbMCFtk77O7xK1iSVr"
Subject: Re: [Qemu-devel] [PATCH for-2.10] util/oslib-posix.c: Avoid warning
 on NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, "patches@linaro.org" <patches@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LgRcC7l64IOhTgbRbMCFtk77O7xK1iSVr
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>,
 "patches@linaro.org" <patches@linaro.org>
Message-ID: <15cdd5e0-48f8-35be-8fa3-c57bc50828f6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] util/oslib-posix.c: Avoid warning
 on NetBSD
References: <1500568341-8389-1-git-send-email-peter.maydell@linaro.org>
 <eec67af4-3f8e-bb85-0854-61f4d450f627@redhat.com>
 <CAFEAcA9M0jeER9Ygg74_kQXv4CeW2_PMns7=t=Jw6sxkYhANpA@mail.gmail.com>
In-Reply-To: <CAFEAcA9M0jeER9Ygg74_kQXv4CeW2_PMns7=t=Jw6sxkYhANpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 03:53 PM, Peter Maydell wrote:
> On 20 July 2017 at 19:26, Eric Blake <eblake@redhat.com> wrote:
>> On 07/20/2017 11:32 AM, Peter Maydell wrote:
>>> On NetBSD the compiler warns:
>>> util/oslib-posix.c: In function 'sigaction_invoke':
>>> util/oslib-posix.c:589:5: warning: missing braces around initializer =
[-Wmissing-braces]
>>>      siginfo_t si =3D { 0 };
>>>      ^
>>
>> Uggh. That is a broken compiler.  C99 declares that 'anything =3D {0}'=
 is
>> supposed to be a valid way to zero-initialize anything.
>=20
> Looks like maybe it was https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D=
53119

Would it be better to add a configure check for broken -Wmissing-braces
(where we would then add -Wno-missing-braces to the (outdated) NetBSD
compiler)?

But then again, we already rely on gcc/clang's extension of foo=3D{}
(which is valid for C++, what a shame that the two languages picked
different universal-zero initializers), so it's probably less churn to
just fix the few outliers to also rely on the extension than it is to
bloat configure just to permanently work around the broken compiler.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LgRcC7l64IOhTgbRbMCFtk77O7xK1iSVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllxHEMACgkQp6FrSiUn
Q2rZ6ggAl0IB/bMiZOSu1Mzlc7Oxiqymiv9DEkxUat8MRJXTom0kFeQPnmtJC4/a
dQfcGIaUiSxzdH2P9thAPaDz3ZcTTWq1Ice6usFQ7Cqdt415i/SovYlCwCBrtGvQ
dw54FnJF7YszE1q/SkgOZfO6z3nX9C/onlHuyb7kVYT7JkpsZeaMjZlTO2WBtrDD
Cbpk8yQZdcl4Y+r4WW8n786dwBjOL0F4GbONCA+qbmNH5ok+8P7zgWSTPbBd2jNq
2NIU7X1j6jVrRAr+VsiZnLq/LoyONCHyLp9dOYHtPOfBGfyAyK56dy3MFJpEgsBb
Me1TRI9CvFhqbtWRbqtnnuXwEtys9g==
=WeoD
-----END PGP SIGNATURE-----

--LgRcC7l64IOhTgbRbMCFtk77O7xK1iSVr--
