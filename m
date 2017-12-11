Received: from eggs.gnu.org ([2001:4830:134:3::10]:50725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOWAQ-0001Vv-Iq
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:03:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOWAN-0000C3-Gj
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:03:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eOWAN-0000AP-3u
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:03:15 -0500
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<20171208105553.12249-6-pbonzini@redhat.com>
	<20171208151306.GC8998@stefanha-x1.localdomain>
	<9c90d2b3-242e-5ffc-3e48-cf05e6fe85c3@redhat.com>
	<a53f2cc7-9da4-bd8e-4d0b-bb3c32c9d4a9@redhat.com>
	<20171211102304.GC13593@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ed2a5cd-cb82-29e9-a2a8-be4a848fa34b@redhat.com>
Date: Mon, 11 Dec 2017 23:03:02 +0100
MIME-Version: 1.0
In-Reply-To: <20171211102304.GC13593@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AN70E5V7he5q2b5xGfpOBbRJEklpTLVq2"
Subject: Re: [Qemu-devel] [PATCH 5/5] thread-pool: convert to use lock guards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AN70E5V7he5q2b5xGfpOBbRJEklpTLVq2
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <6ed2a5cd-cb82-29e9-a2a8-be4a848fa34b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] thread-pool: convert to use lock guards
References: <20171208105553.12249-1-pbonzini@redhat.com>
 <20171208105553.12249-6-pbonzini@redhat.com>
 <20171208151306.GC8998@stefanha-x1.localdomain>
 <9c90d2b3-242e-5ffc-3e48-cf05e6fe85c3@redhat.com>
 <a53f2cc7-9da4-bd8e-4d0b-bb3c32c9d4a9@redhat.com>
 <20171211102304.GC13593@stefanha-x1.localdomain>
In-Reply-To: <20171211102304.GC13593@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/12/2017 11:23, Stefan Hajnoczi wrote:
>>
>> In other words, I don't see what 'QEMU_WITH_LOCK_GUARD() {}' buys us
>> over '{ QEMU_LOCK_GUARD() }'.
> The QEMU_WITH_LOCK_GUARD() {} syntax is nice because it's similar to
> if/while/for statements.
>=20
> However, { QEMU_LOCK_GUARD() } doesn't hide a for statement in a macro
> so the break statement works inside the scope.  Less chance of bugs.

The same is true of a "switch" statement.  Being able to break out of
QEMU_WITH_LOCK_GUARD could also be a feature...

Paolo


> I'd be okay without QEMU_WITH_LOCK_GUARD().


--AN70E5V7he5q2b5xGfpOBbRJEklpTLVq2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlovAJYACgkQv/vSX3jH
roOQVggAm3lOBcXnBipKHWDgQ8qdShqQrdJ5PUcu5f2Xa+WdjaNtFmjPydJ/irLn
hCIntkQ5eZ6+d7aDAZtde5O5jl8DwT7stHn7hrhh4bhLcmrkURyQF6Kw39BhE5F0
bprxu4MyeXMO6HLg1D7UXdQXDZLCE53AHCKtjpxf0bAKGtTnlb0i7UmZfn1KXYDU
zh8JOd30gGzF84BCO6KUbEm4v0HakJeUkw+KEiTEBcZQJjKz47/kxnuyZHorbdSA
+z1aDEFTDccApNHWwWi/dH+Ctg4fxvoLRsLCQ3BwtLxvMtazpZE7CpBt2SIRlhM6
/vnsCJEtOp0y+JBzBkmB/jwDXBXlRQ==
=z/0Z
-----END PGP SIGNATURE-----

--AN70E5V7he5q2b5xGfpOBbRJEklpTLVq2--
