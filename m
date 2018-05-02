Received: from eggs.gnu.org ([2001:4830:134:3::10]:55758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDkFD-0001J4-0I
	for qemu-devel@nongnu.org; Wed, 02 May 2018 01:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDkF8-0002yY-V1
	for qemu-devel@nongnu.org; Wed, 02 May 2018 01:23:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58728 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fDkF8-0002xp-K9
	for qemu-devel@nongnu.org; Wed, 02 May 2018 01:23:54 -0400
References: <20180430124651.10340-1-stefanha@redhat.com>
	<152509298983.2409.13656791008049355574@71c20359a636>
	<20180501130406.GD14803@stefanha-x1.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e0fe85ba-40c8-ce2e-151a-99b006d150d5@redhat.com>
Date: Wed, 2 May 2018 07:23:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180501130406.GD14803@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="UgHJo5f33YEpnfIPOurYP0KMjqaVG8RpH"
Subject: Re: [Qemu-devel] [PATCH v2 0/5] checkpatch: backport UTF-8 fixes
 and MAINTAINERS check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org, armbru@redhat.com, marcandre.lureau@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UgHJo5f33YEpnfIPOurYP0KMjqaVG8RpH
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org, armbru@redhat.com,
 marcandre.lureau@gmail.com
Message-ID: <e0fe85ba-40c8-ce2e-151a-99b006d150d5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] checkpatch: backport UTF-8 fixes and
 MAINTAINERS check
References: <20180430124651.10340-1-stefanha@redhat.com>
 <152509298983.2409.13656791008049355574@71c20359a636>
 <20180501130406.GD14803@stefanha-x1.localdomain>
In-Reply-To: <20180501130406.GD14803@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.05.2018 15:04, Stefan Hajnoczi wrote:
> On Mon, Apr 30, 2018 at 05:56:30AM -0700, no-reply@patchew.org wrote:
>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>> Checking PATCH 1/5: checkpatch: add a --strict check for utf-8 in comm=
it logs...
>> WARNING: line over 80 characters
>> #101: FILE: scripts/checkpatch.pl:1420:
>> +			WARN("8-bit UTF-8 used in possible commit log\n" . $herecurr);
>>
>> total: 0 errors, 1 warnings, 66 lines checked
>>
>> Your patch has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>> Checking PATCH 2/5: checkpatch: check utf-8 content from a commit log =
when it's missing from charset...
>> Checking PATCH 3/5: checkpatch: ignore email headers better...
>> Checking PATCH 4/5: checkpatch: emit a warning on file add/move/delete=
=2E..
>> WARNING: line over 80 characters
>> #46: FILE: scripts/checkpatch.pl:1397:
>> +		     ($line =3D~ /\{\s*([\w\/\.\-]*)\s*\=3D\>\s*([\w\/\.\-]*)\s*\}/=
 &&
>>
>> ERROR: line over 90 characters
>> #49: FILE: scripts/checkpatch.pl:1400:
>> +			WARN("added, moved or deleted file(s), does MAINTAINERS need updat=
ing?\n" . $herecurr);
>>
>> total: 1 errors, 1 warnings, 24 lines checked
>>
>> Your patch has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>>
>> Checking PATCH 5/5: checkpatch: reduce MAINTAINERS update message freq=
uency...
>> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> If there are no objections I'd like to keep this in sync with upstream,=

> and error messages are exempt from the 80 char limit to aid grepping.

Yes, please keep it as close as possible to upstream. This will also
help to backport future patches from the Linux version to our version
(so we can cherry-pick without conflicts).

 Thomas


--UgHJo5f33YEpnfIPOurYP0KMjqaVG8RpH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJa6UtXAAoJEC7Z13T+cC21QzEP/iN3j763mLyv32ebwtOwwmbs
cI8nJM92+cM7i0jhDzMn36qj6hiAk5RHiJS7UIQHGnERxgRhqv7GcqmZOVd/np2Q
cPPwKntISSBk1Cx4pTow1uQzfV3llyocLKjzj310ZcEIj+dk1ofxvNGexs9piziC
GmVx+Wc0FhCRgB7mVANauAwxskHZVhjMT0ktJpfba0I+5Lf+Vdbhoqgg7WOqgwfv
qAjsvN5OwqaB0l62JqpalXSrlWrYbDBXA15o2BFT5jUOAHNZCI76yfji2UOJ7Da9
SFaxMaEOqGpZ7hydt8P8Ioq3wh1LBhN4DJvRBMk8PS93Yyb5ayBIs27GqBBxC26L
C1eYZvg5UkpvIDn4Uw5VBVv6KyFcf84UQZZg+yXVg7t91JQv4WMlT9VR1lktmcH3
AggsMiu0tFSGkHC1GsvaWw3YhyhV9Q7SNsfXWKJPK18l3Ih1Ja2/a10LYZFlFJ1F
yMTbN/a68FqHV8LLHhauig9TRV61QFvtHJrDinGJ+uqu+NVDqDDIovPsaMpI+Tya
G2zn2biw8yTQQP/lRD7GCy/sk5hO5yochJxOAre0bk7oq+rY0awshSOiVleIZsJD
F8kA2uTBqT+lsJuIR6/fe+sA4VKtV736jGO+DqKQtABQyzKIAdslAnJclBl6EZY1
eor88PZE3QvEkAg6LpyR
=bnsx
-----END PGP SIGNATURE-----

--UgHJo5f33YEpnfIPOurYP0KMjqaVG8RpH--
