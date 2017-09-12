Received: from eggs.gnu.org ([2001:4830:134:3::10]:54810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drmXy-0001nR-Dh
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drmXt-0005Xg-JY
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:52:18 -0400
References: <20170912140149.7692-1-lvivier@redhat.com>
	<20170912164644.2a0b6977@bahia.lan>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6198350f-a694-cf1b-ec00-4c42ccce39a6@redhat.com>
Date: Tue, 12 Sep 2017 16:51:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170912164644.2a0b6977@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="eggrjUaxIGESK3G2WJO0XjI50UAhKdCh1"
Subject: Re: [Qemu-devel] [PATCH v3 0/3] hmp: fix "dump-quest-memory"
 segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, ehabkost@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eggrjUaxIGESK3G2WJO0XjI50UAhKdCh1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.09.2017 16:46, Greg Kurz wrote:
> On Tue, 12 Sep 2017 16:01:46 +0200
> Laurent Vivier <lvivier@redhat.com> wrote:
>=20
>> Fix aarch64 and ppc when dump-guest-memory is
>> used with none machine type and no CPU.
>>
>> The other machine types don't have the problem.
>>
>> Update test-hmp, to test none machine type
>> with (2 MB) and without memory, and add a test
>> to test dump-quest-memory without filter parameters
>> (it needs the fix from Cornelia Huck to work)
>>
>> v3:
>>   - remove blank line after a comment
>>   - forbid memory dump when there is no CPU
>>
>=20
> So in the end, we would forbid dump on aarch64 and
> ppc, while it is allowed on i386... I don't really
> care about which behavior is more appropriate but
> I guess they should be consistent at least.

It's kind of consistent: Allow it on architectures with fixed endianess,
but disallow it on architectures without fixed endianess ;-)

Honestly, it should not matter - we're talking here about the "none"
machine without a CPU ... as long as it does not crash, there is no need
for a working "dump-guest-memory" function here.

 Thomas


--eggrjUaxIGESK3G2WJO0XjI50UAhKdCh1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZt/SLAAoJEC7Z13T+cC218JwP/A/xuZHyv6rt41+vANkwgTvc
bxS8lPLh39txq8bZIT64n2QR3IHeQ3I/z2Ou8pinguVmzdmq36pYvjbTevxWWOlf
AMYKYtBTJtO+52z4RqVNrxlJZBEZcxgFCrYm02s1O3DUhHEfUYY+CCYMvxitbQ4S
6uoBcDQqi+SmPKCH4EcwJbdEsLJwJPfmKdUeNuCWZFYJ65ICf2O8Nho7JtkLs2xG
sYeKYRBJw7KhWfdx+wW2BdzcWbznm9n2aXzEbLko1mlXFbRwDMeIU+GgSXtaHmSZ
v3RfjSPC3vdm4BwbmyIjGtI2rRximeDuIco6+f5rFdQQ5HsdhvMCFkMCdeb84Ekm
fp5HIra2FWY8NEH4+N8W5+agHt5VGqkXLphyz5MjbgQszjn7/zwN3l4X0gV5V6YA
AitCSH+/UxOWjoEsaXOObT8TG/0e3Sw8lMz5rzGm3m9DtrJ0h3+C1KxAI4e9ubzi
NimCo6Vhat1H0qUAkttTkjkDI4pyLhWdWM0goCPvD2P5fOSolZ5sF+7DGdV56Fmt
idnQYtqHDLanSfH3avFfX4eEFsIQEjqCuPNeypFU7WYLFA8gdmNq6TzCDHzSBler
RZ1NciilrAt+rcOviI3EaDUgjZ+lt/Bx4WnbiGvHjZzgw4A3CzmUzk62ZeRhVMuq
VgK6AzcLutk08kQBjXtV
=jCqC
-----END PGP SIGNATURE-----

--eggrjUaxIGESK3G2WJO0XjI50UAhKdCh1--
