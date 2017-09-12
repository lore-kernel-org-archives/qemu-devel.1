Received: from eggs.gnu.org ([2001:4830:134:3::10]:38396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drslM-00016o-MW
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drslL-0002oI-QN
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:30:32 -0400
References: <20170912144459.11359-1-pbonzini@redhat.com>
	<20170912144459.11359-9-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0df82bae-77a8-816c-b157-32655005d368@redhat.com>
Date: Tue, 12 Sep 2017 16:30:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170912144459.11359-9-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JbtRPQU6doq9nOSD9u6vBmPCglcn6SOp0"
Subject: Re: [Qemu-devel] [PATCH 08/10] qemu-iotests: fix uninitialized
 variable
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
--JbtRPQU6doq9nOSD9u6vBmPCglcn6SOp0
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <0df82bae-77a8-816c-b157-32655005d368@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/10] qemu-iotests: fix uninitialized
 variable
References: <20170912144459.11359-1-pbonzini@redhat.com>
 <20170912144459.11359-9-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 09:44 AM, Paolo Bonzini wrote:
> The variable is used in "common" but defined only after the file
> is sourced.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/qemu-iotests/check  | 2 --
>  tests/qemu-iotests/common | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> +tmp=3D"${TEST_DIR}"/$$

Pre-existing to your code motion, but would we be any safer if $tmp also
included a use of $RANDOM?  (The $$ already protects us from collisions
with a parallel run, but it is easy to guess, so if $tmp is used to
create any file that an attacker can access, running the testsuite may
expose a machine to a symlink or other attack - but we probably have
lots of those things to audit for before we can recommend running the
testsuite in an untrusted environment).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JbtRPQU6doq9nOSD9u6vBmPCglcn6SOp0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm4Ue0ACgkQp6FrSiUn
Q2qpeAf/QPY6fr/cr6VqGv/cKOtcVEV0y1zsIeMEEzI7RpRpwbFK+B08a8Boq6Xf
+na+sbhV0gPX6MD4JZqRXMDvv/uToe0Zd+dQ/wom97Zq3HiCvHSuIg8yradh9mAS
Iny5w2hnjQTsGzZQXsBKFQEPH7snoKfeRLCa74zGCsxTIsOKZqGt75EAn9zzKsVi
VXQiPAD3GGrTKq6a2FhQHnwqDiJWtlBUimotr0zfxu0lpAd2Y5SbSl5qh5C2ACN4
hkMfmvPAzTnVBLq8nK7GvHBwcCOI3NrWkkQpzyK591rPk/2IOxgbmqwq1M/GPuTa
XSRZsI6A7YMqxHdXlgaOc6YU97cf5g==
=AYuY
-----END PGP SIGNATURE-----

--JbtRPQU6doq9nOSD9u6vBmPCglcn6SOp0--
