Received: from eggs.gnu.org ([2001:4830:134:3::10]:39893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drsow-00047m-0I
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drsou-0004o8-TH
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:34:14 -0400
References: <20170912144459.11359-1-pbonzini@redhat.com>
	<20170912144459.11359-11-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <58e61afd-07cd-4a7e-5aaa-d6c80a036066@redhat.com>
Date: Tue, 12 Sep 2017 16:34:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170912144459.11359-11-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="peLkgmkHg4MHuKIIMuBJfAVCdOUBf6LPS"
Subject: Re: [Qemu-devel] [PATCH 10/10] qemu-iotests: merge "check" and
 "common"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--peLkgmkHg4MHuKIIMuBJfAVCdOUBf6LPS
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <58e61afd-07cd-4a7e-5aaa-d6c80a036066@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/10] qemu-iotests: merge "check" and
 "common"
References: <20170912144459.11359-1-pbonzini@redhat.com>
 <20170912144459.11359-11-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 09:44 AM, Paolo Bonzini wrote:
> "check" is full of qemu-iotests--specific details.  Separating it
> from "common" does not make much sense anymore.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/qemu-iotests/check  | 533 ++++++++++++++++++++++++++++++++++++++=
+++++-
>  tests/qemu-iotests/common | 552 --------------------------------------=
--------
>  2 files changed, 531 insertions(+), 554 deletions(-)
>  delete mode 100644 tests/qemu-iotests/common
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--peLkgmkHg4MHuKIIMuBJfAVCdOUBf6LPS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm4UswACgkQp6FrSiUn
Q2pZeAf6AsAykPBPrUao2A+FXgbuTztw0yahp212bTgIDFKrTso6wAPOo2LgtH//
/WnVqUPJBXZ11dLYiXdyerE+9On9EjdzHjr1Rt/VxDtDrOnKu5CGB2xM6Cgmw+/7
YHJ9I9p76OiIGp/pYD1eXy9mlfP8w5myD1c0s/MVLqyWVJHd4agJpiLZAX3jH5oX
uOw7wapC9yxIHFwTv76PlzJEOKVFLvytJ95heNUo0WjatrNF7NCNEfWKuFJPGByd
9hp7hcw3x7VyKIDMQbNzvZHJ6vdPdQGk64RMEWel++ePxtOu+9fkOb4S69JGKkr3
CwhlzvauFmjQ+FcAlkAk7eTdTX70XA==
=ctib
-----END PGP SIGNATURE-----

--peLkgmkHg4MHuKIIMuBJfAVCdOUBf6LPS--
