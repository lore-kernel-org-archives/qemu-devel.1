Received: from eggs.gnu.org ([209.51.188.92]:53536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkCCI-0000N1-4U
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:15:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkCCH-0006A8-9l
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:15:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gkCCG-00066b-O6
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:15:20 -0500
References: <1547745248-1750-1-git-send-email-thuth@redhat.com>
	<CAFEAcA_TSSCUGXO-ze6QBfZsiddszywBCMgrX=kYjORwJsrdbA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <01f7a34e-878c-8bc4-6fca-ac6d24519784@redhat.com>
Date: Thu, 17 Jan 2019 12:15:17 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_TSSCUGXO-ze6QBfZsiddszywBCMgrX=kYjORwJsrdbA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZwLy61rNHyM3IsgYgyTvSiSgVp02aWMGy"
Subject: Re: [Qemu-devel] [PATCH] configure: Add a proper check for
 openpty() in libutil
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZwLy61rNHyM3IsgYgyTvSiSgVp02aWMGy
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <01f7a34e-878c-8bc4-6fca-ac6d24519784@redhat.com>
Subject: Re: [PATCH] configure: Add a proper check for openpty() in libutil
References: <1547745248-1750-1-git-send-email-thuth@redhat.com>
 <CAFEAcA_TSSCUGXO-ze6QBfZsiddszywBCMgrX=kYjORwJsrdbA@mail.gmail.com>
In-Reply-To: <CAFEAcA_TSSCUGXO-ze6QBfZsiddszywBCMgrX=kYjORwJsrdbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/17/19 12:07 PM, Peter Maydell wrote:
> On Thu, 17 Jan 2019 at 17:14, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On Linux (and maybe some BSDs), we require libutil for the openpty()
>> function. However, this library is not available on some other systems=
, so
>> we currently use a fragile if-statement in the configure script to che=
ck
>> whether we need the library or not. Unfortunately, we also hard-coded =
a
>> "-lutil" in the tests/Makefile.include file, so this breaks the build =
on
>> Solaris, for example (see buglink below). To fix the issue, add the "-=
lutil"
>> to "libs_tools" in the configure script instead, then this gets proper=
ly
>> propagated to the tests, too.
>=20
> It also gets propagated to every tool binary we build even if
> it doesn't use openpty(), but I guess that's not a big deal.

Statically linking against libraries only pulls in symbols that the
library provides but which have not been satisfied earlier in the link
line. For programs which do not use openpty(), and where no other
unsatisfied symbols remain which -lutil would satisfy in a shadowing
effect on symbols normally provided by remaining libraries on the
command line, then yeah, it shouldn't change the compiled size of those
binaries.  Dynamic linking might change the binary slightly because of
tracking that the library was linked, but again the behavior shouldn't
change.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ZwLy61rNHyM3IsgYgyTvSiSgVp02aWMGy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxAxjUACgkQp6FrSiUn
Q2qfvgf/fBzPSQAbzdRgOFTf1x/pueWe5ZwO6uFjGZ0z/ag7g7SGfYBIPdB98J6J
1D/mUOF0bf+xZTdXBUWy3wYT/CVaxeuVx+8aVUKTyMdUFfvmd2ptyRWl5dTW4EzS
msAAEDJDGnCr6RGWiD2cCYyRvo3eLnX6PnTYOPo5b84CYNgvc59C6dWGGTwnm/FZ
iJblMSeF3uBZreEWXKcxW2X3DVkhVWLtVMN02p7FCILt2T6VpQ6PvH15SApi+WdD
QzRixugJjhflSpwDoLCnG7mzDhEgp5JDdwDYRUY2eVitmncz3iNTcS3vPgil3MBe
Th0d/u/emkQcq1xdeW69/ggKzardGA==
=I3h8
-----END PGP SIGNATURE-----

--ZwLy61rNHyM3IsgYgyTvSiSgVp02aWMGy--
