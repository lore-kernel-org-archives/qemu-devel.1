Received: from eggs.gnu.org ([2001:4830:134:3::10]:33613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cZZM7-0000RI-73
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:36:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cZZM4-00015E-1F
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:36:31 -0500
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
	<148602129908.33.4236801111127079549@eba24e3a0d7f>
	<20170202224420.GA7754@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <03266a2a-2ff8-458e-b6cc-67c3888a6b39@redhat.com>
Date: Fri, 3 Feb 2017 09:36:18 +0100
MIME-Version: 1.0
In-Reply-To: <20170202224420.GA7754@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="euiiSQNVF0AubqrDuv1MMcdqIccOEMQSI"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 000/107] ppc-for-2.9 queue
 20170202
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, peter.maydell@linaro.org, famz@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--euiiSQNVF0AubqrDuv1MMcdqIccOEMQSI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.02.2017 23:44, David Gibson wrote:
> On Wed, Feb 01, 2017 at 11:41:40PM -0800, no-reply@patchew.org wrote:
>> Hi,
>>
>> Your series seems to have some coding style problems. See output below=
 for
>> more information:
[...]
>> Checking PATCH 103/107: tcg/POWER9: NOOP the cp_abort instruction...
>> ERROR: do not use C99 // comments
>> #28: FILE: target/ppc/translate.c:6025:
>> +    // Do Nothing
>>
>> total: 1 errors, 0 warnings, 17 lines checked
>>
>> Your patch has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>=20
> But this one was me being sloppy.  Do we care enough to re-do the
> pullreq?

We've got lot's of C++ comments in the QEMU sources already, and the
CODING_STYLE document even does not mention this ... maybe this is just
a left-over from the Linux kernel's checkpatch.pl script? So IMHO:
Ignore this error. (and if we really agree that C++ comments are a
no-go, then somebody should send a patch to update the CODING_STYLE).

 Thomas



--euiiSQNVF0AubqrDuv1MMcdqIccOEMQSI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYlEEHAAoJEC7Z13T+cC213H0P/jLhiiuqNtw4On1cE/KLknS/
i8RDFR9anr6BH0FVEur+r8vvJbfBCqOfW1b4Y3LdS5pO+UYe/K+Gnc05NBcYL30b
+Nt2bm2BPiMNjxP/PH1QwL+veS8N8pcKl2o7Md3i6kRQc2QMENiQ76KLAYw4wq9L
Mge0g5hgI0xOXy/h4e2Rba8Z16v76LUn3XD+v/1a4iJselOHv0AUtm9uLerR7+tX
rUAu2VdUpPIHJe+VHMPmn7xU56SgiUYNMvL6/J8mpMxxzrN/iVBocAyXxhoMuwL6
+2ZbFNY4gGlruGMEw/8c0gOfu87/8na6b1M+sjH4OsL3Fj0owbHDAmXZ7Elf4FRN
2BQxT2VHho5RHObKDjV+zGraAeHiza07z7tE2WruznkhRX/blEWhFxJhtGIUqn2w
ByEuEcnjKdZKWMC2GG4umDhCVunE0H2OX87lOF51YpPYphLGCJEdVWhOqj3g6Xl3
oJjKmtoOYyIsBNm96LyrUnfb4ef2mPYjQIIXD2moi7UI1enl3RUC1gx8tcC1NsiC
Nz6H1recfXNYcpw8EQ5f6B62nNxGvx4HoKCvxCHymv8vjhopzrDr3soA/yTotPgb
Fe7YXcP6wxQKwnF7A5up2lXCu2LU/6/xa744El2eT5lEGWqlr/020+qVFvkznVso
sEnIGG32droOf2WimQBC
=8bGh
-----END PGP SIGNATURE-----

--euiiSQNVF0AubqrDuv1MMcdqIccOEMQSI--
