Received: from eggs.gnu.org ([2001:4830:134:3::10]:58208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKs9u-0006gZ-Fn
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKs9t-0004zC-MJ
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:43:42 -0500
References: <20171116173810.16457-1-crosa@redhat.com>
	<20171116173810.16457-6-crosa@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <171a26fc-bd4a-79d1-72d6-3165b050f3f5@redhat.com>
Date: Fri, 1 Dec 2017 21:43:32 +0100
MIME-Version: 1.0
In-Reply-To: <20171116173810.16457-6-crosa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FSUEUhdNkbPUijji3Vk0Vj9gOLHVDsd8e"
Subject: Re: [Qemu-devel] [PATCH 05/10] qemu-iotests: define functions used
 in _cleanup() before its use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FSUEUhdNkbPUijji3Vk0Vj9gOLHVDsd8e
From: Max Reitz <mreitz@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <171a26fc-bd4a-79d1-72d6-3165b050f3f5@redhat.com>
Subject: Re: [PATCH 05/10] qemu-iotests: define functions used in _cleanup()
 before its use
References: <20171116173810.16457-1-crosa@redhat.com>
 <20171116173810.16457-6-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-6-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-16 18:38, Cleber Rosa wrote:
> The functions used in _cleanup() come from common.rc, which currently
> gets sourced after _cleanup() is defined and registered as a signal
> handler.  When _cleanup() is executed, it has no valid references to
> those functions, as BASH won't resolve the reference at that time.
>=20
> While at it, also fix some tabs versus spaces indentation in
> _cleanup() in a few tests.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---

No real objection apart from that I can't quite reproduce the issue.
When I test it, _cleanup() seems to be executed either way. And if I put

  #!/bin/bash
  foo() {
      bar
  }
  trap foo 2
  . ./bar.sh
  kill -2 $$

in a file foo.sh and

  #!/bin/bash
  bar() {
      echo 42
  }

in a file bar.sh, and then execute foo.sh, I get the "42" output.

Soo... It does seem to work for me?

(I mean, the patch still makes sense to me in theory, so I guess I might
take it anyway)

Max


--FSUEUhdNkbPUijji3Vk0Vj9gOLHVDsd8e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlohvvQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A33EH/j4sCOtnzV8U6gHpnaDFNh/Z6eLm9fN4
fXRd2K8qvp0l2LXrG0LjBH8K2c+2ifufvGSnvhTNJU2B416Ao+WsB2/iiSDC3dL3
CF9wvEVh66LdjTDLzouYY8uDtl8CtoSbLkpNRVI+X0LLOAt5qEEIAhxbH9Mj+EGc
RWBdWQuw02h+PF10Yr7D0BKuakOUUKP7hXBvY2HNwlVaPTmN2gAfUXI2cNp9N2EX
JTLTkWz5y4fCY9YW/IyMSkjx4lynnj5+b5drqGMif8UxGq1A8FLHRte23LZy1Jmv
WF9FRIoqEbkFufD9oTRXq3jQIc+o+1LpcRJzPAVLwxVQCl7mfjHh97s=
=OwDN
-----END PGP SIGNATURE-----

--FSUEUhdNkbPUijji3Vk0Vj9gOLHVDsd8e--
