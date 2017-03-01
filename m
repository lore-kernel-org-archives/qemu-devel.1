Received: from eggs.gnu.org ([2001:4830:134:3::10]:56641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciu9e-0004yd-Pz
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 21:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciu9e-0001aj-0B
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 21:38:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciu9d-0001aM-Iw
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 21:38:13 -0500
References: <20170228122901.24520-1-berrange@redhat.com>
	<20170228122901.24520-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ee01c83-d50f-6e23-be73-871b0c0ef939@redhat.com>
Date: Tue, 28 Feb 2017 20:04:38 -0600
MIME-Version: 1.0
In-Reply-To: <20170228122901.24520-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OhrNgofH3VnrVcR7SqSsvG2fVjgvON60A"
Subject: Re: [Qemu-devel] [PATCH 1/2] makefile: merge GENERATED_HEADERS &
 GENERATED_SOURCES variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OhrNgofH3VnrVcR7SqSsvG2fVjgvON60A
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <2ee01c83-d50f-6e23-be73-871b0c0ef939@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] makefile: merge GENERATED_HEADERS &
 GENERATED_SOURCES variables
References: <20170228122901.24520-1-berrange@redhat.com>
 <20170228122901.24520-2-berrange@redhat.com>
In-Reply-To: <20170228122901.24520-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2017 06:29 AM, Daniel P. Berrange wrote:
> The only functional difference between the GENERATED_HEADERS
> and GENERATED_SOURCES variables is that 'Makefile' has a
> dependancy on GENERATED_HEADERS, causing generated header files

s/dependancy/dependency/

> to be created immediatey at the start of the build process.

s/immediatey/immediately/

> There is no reason why this early creation should be restricted
> to the .h files, and not include .c files too. Merge both of
> the variables into a single GENERATED_FILES variable to make
> it clear it is for any type of generated file.
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--OhrNgofH3VnrVcR7SqSsvG2fVjgvON60A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtiw3AAoJEKeha0olJ0NqDF0IAIPligJCGsm6yLjSPMQVKvfq
48Q+vZ3u2zdBiPbwjT8PnBJYayGlCfbyicugnHbT0cC59v0NukcAaXD7vVmEf/Dg
K18gbHITm+XjSN0ZcqgGKWjcM0G9Xo1QdbZ1Zrk1jCdRt1VBg3MsjDcxd88APgaF
mXBP6ksAGpcJPtPtrHQM2Xeck/aQcva1KfZFAFtOvhbQ4llrLTwqjxPIUzHIWTI5
gelkDjlq/DS1ua8RupK+OGXXZRIX9UYbPbu88QtzFQDbVPZcxJ6ovDaJ4ofVtppv
r7kthv0Kxn/sbznMPzhPmhlnQX6ghHHxp5ogeIovVDudbBbfeqgu124yMu6y/Dc=
=VyIr
-----END PGP SIGNATURE-----

--OhrNgofH3VnrVcR7SqSsvG2fVjgvON60A--
