Received: from eggs.gnu.org ([2001:4830:134:3::10]:55344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1djrx0-0005QL-Sd
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 15:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1djrwx-0006eP-Nd
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 15:01:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1djrwx-0006TD-F8
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 15:01:23 -0400
References: <20170821161539.11066-1-stefanha@redhat.com>
	<CAJSP0QWVGVn=vZWZy9isTemndDQrnzUAMO=A7T6W6Oe93ST2DQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2217cc17-2638-c7ac-3ac0-6202bb2e4f4f@redhat.com>
Date: Mon, 21 Aug 2017 14:01:10 -0500
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWVGVn=vZWZy9isTemndDQrnzUAMO=A7T6W6Oe93ST2DQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cca6UMCV7O8MrJgnUQO4L9hIoE53Q5x8a"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nbd-client: fix hang after
 server closes connection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cca6UMCV7O8MrJgnUQO4L9hIoE53Q5x8a
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu block <qemu-block@nongnu.org>
Message-ID: <2217cc17-2638-c7ac-3ac0-6202bb2e4f4f@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nbd-client: fix hang after
 server closes connection
References: <20170821161539.11066-1-stefanha@redhat.com>
 <CAJSP0QWVGVn=vZWZy9isTemndDQrnzUAMO=A7T6W6Oe93ST2DQ@mail.gmail.com>
In-Reply-To: <CAJSP0QWVGVn=vZWZy9isTemndDQrnzUAMO=A7T6W6Oe93ST2DQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/21/2017 11:27 AM, Stefan Hajnoczi wrote:
> On Mon, Aug 21, 2017 at 5:15 PM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>>   (qemu) quit
>>   ...hang...
>=20
> By the way, the same issue is present in QEMU 2.9.  This is not a 2.10
> regression.

Most likely, though, it IS a regression introduced in 2.9 and not
present in 2.8.  I'll add this to my list of 2.11 NBD patches.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cca6UMCV7O8MrJgnUQO4L9hIoE53Q5x8a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmbLfcACgkQp6FrSiUn
Q2oppgf9H/phV/VB7bu+4pzW6RY6QtIW7VCg6tJGNxVuEJFIa9xxBcvZav3Z8ATS
/1VVGobuQ0Pb0Y1IVc+2iCJz8FPsNTX/KASgHe+pnVAloHl8Y0aZFSpzybSrDfYZ
O/ZS920Cn5oa4ptRZpTi8fakWwvYjL26/nDTrCDXEUeM3lB+4HUk7fOMXo8SSc8F
gbj3rREkdGF7eYztAeshSvrjusVue1p3+y334/re6sBg32nhsU9NQLCGjLRJyvYo
BkpyKfDhT8Z21HF2ITyrUu4QtfjNf9MIpBVmQqaPYpW4PXj//jGcFg+QSs5DYvJz
wcFuLhhY0zkvyjpEhlhIFwZCntNC4g==
=hplY
-----END PGP SIGNATURE-----

--cca6UMCV7O8MrJgnUQO4L9hIoE53Q5x8a--
