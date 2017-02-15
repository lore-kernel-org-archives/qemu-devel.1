Received: from eggs.gnu.org ([2001:4830:134:3::10]:55719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ce8VB-00007E-Tz
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 17:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ce8V7-0005TR-Dj
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 17:56:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ce8V7-0005T6-4i
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 17:56:41 -0500
References: <cover.1487139038.git.ben@skyportsystems.com>
	<96c621a0c1588234e473bf0c0d068af8812f3225.1487139038.git.ben@skyportsystems.com>
	<ebde49dc-fd80-895e-b73f-545ec9a966c8@redhat.com>
	<4757B80F-46A7-4A6F-BB65-1119A07BE52A@skyportsystems.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be899831-3bd1-3ea0-d689-473b86a3a15a@redhat.com>
Date: Wed, 15 Feb 2017 16:56:37 -0600
MIME-Version: 1.0
In-Reply-To: <4757B80F-46A7-4A6F-BB65-1119A07BE52A@skyportsystems.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hc2GNmoUF3QR22hjjbbiioRSTe1EVH5gB"
Subject: Re: [Qemu-devel] [PATCH v6 6/7] tests: Move reusable ACPI macros
 into a new header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>, mst@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hc2GNmoUF3QR22hjjbbiioRSTe1EVH5gB
From: Eric Blake <eblake@redhat.com>
To: Ben Warren <ben@skyportsystems.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, mst@redhat.com
Message-ID: <be899831-3bd1-3ea0-d689-473b86a3a15a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 6/7] tests: Move reusable ACPI macros into
 a new header file
References: <cover.1487139038.git.ben@skyportsystems.com>
 <96c621a0c1588234e473bf0c0d068af8812f3225.1487139038.git.ben@skyportsystems.com>
 <ebde49dc-fd80-895e-b73f-545ec9a966c8@redhat.com>
 <4757B80F-46A7-4A6F-BB65-1119A07BE52A@skyportsystems.com>
In-Reply-To: <4757B80F-46A7-4A6F-BB65-1119A07BE52A@skyportsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/15/2017 03:58 PM, Ben Warren wrote:

>>=20
>> ---
>> tests/acpi-utils.h       | 75 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>> tests/bios-tables-test.c | 72 +---------------------------------------=
------
>> 2 files changed, 76 insertions(+), 71 deletions(-)


>> No copyright blurb? Also, does MAINTAINERS need an update to cover the=

>> new file?
>>
> Sure, I didn=E2=80=99t realize the header files all have copyright head=
ers.  As for MAINTAINERS, do you mean I should add a device entry for vmg=
enid?

In this patch, you're just refactoring to a new tests/acpi-utils.h, so
I'd normally suggest adding it to the blurb that owns
tests/bios-tables-test.c - but as a pre-existing problem, that also has
no listed maintainer.  we're trying to ensure that all new added files
have something listed in MAINTAINERS, even if it is in a misc section
that only emails the list, although it's harder to say what maintainer
to use for existing files that you are merely touching, and failure to
list a maintainer is not (yet) a hard failure (although there have been
patches proposed to scripts/checkpatch.pl to tighten the rules).

A new section for vmgenid might not be a bad idea, especially it if
covers more files than just the one addition I noticed in this patch.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Hc2GNmoUF3QR22hjjbbiioRSTe1EVH5gB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpNylAAoJEKeha0olJ0Nq5BgH/iwnEmEZebmnuXeFr0iE7kFr
J9xdj33pCrl6cvy6KxMYZ//taiwYbnYSqpRUfMiF8V3MB3AA7/uomy6cBw34vrxx
SHwu2kgeHg5CA6I5JADVfM56Iq+JWo+8VjbTy5gemWh8texyIZRCJSs5DKmK+dTI
5Kzox3fyVKsDJuJeYspTcW60VUyZG4dhWOkgAyo5Bxnmr0OzAD461vRtqRR+B7Eg
CLVE3HlhE+VN9sc/gXc5lpGos0M7XmvH/r8RSjCDQTKoDJHfVCG8PPqXUX3KlXKi
vqvMggrT5c3VqHcrrG+Dwx5icXapRxJtWjjowzKgE+qjTs4jXUAOIlMXb/aGVpY=
=nzam
-----END PGP SIGNATURE-----

--Hc2GNmoUF3QR22hjjbbiioRSTe1EVH5gB--
