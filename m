Received: from eggs.gnu.org ([2001:4830:134:3::10]:51997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drsL5-0002Hd-NZ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drsL4-0007So-UC
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:03:23 -0400
References: <20170912144459.11359-1-pbonzini@redhat.com>
	<20170912144459.11359-4-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <69426a10-70dc-8685-a8ef-8ed615ac159a@redhat.com>
Date: Tue, 12 Sep 2017 16:03:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170912144459.11359-4-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GU0MHlnWq1xCfdNkckNgn18lq1sIjujCI"
Subject: Re: [Qemu-devel] [PATCH 03/10] qemu-iotests: move "check" code out
 of common.rc
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
--GU0MHlnWq1xCfdNkckNgn18lq1sIjujCI
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <69426a10-70dc-8685-a8ef-8ed615ac159a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/10] qemu-iotests: move "check" code out of
 common.rc
References: <20170912144459.11359-1-pbonzini@redhat.com>
 <20170912144459.11359-4-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 09:44 AM, Paolo Bonzini wrote:
> Some functions in common.rc are never used by the tests.  Move
> them out of that file and into common, which is already included
> only by "check".
>=20
> Code that actually *is* common to "check" and tests can be placed in
> common.config.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/qemu-iotests/common        | 25 ++++++++++++++++++++++++-
>  tests/qemu-iotests/common.config | 12 ++++++++++++
>  tests/qemu-iotests/common.rc     | 40 --------------------------------=
--------
>  3 files changed, 36 insertions(+), 41 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GU0MHlnWq1xCfdNkckNgn18lq1sIjujCI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm4S5AACgkQp6FrSiUn
Q2rXlwgAg6GQtK/pSwCexLH2o+RBGRZuFGQ19tfkDQNoUUpm5ZBgPS8c9An8yb67
5cHeTz2UhMjL0/DtFJC8EIm1uaIucDPsUr2KfpB8V0r2MCZxdWFdrLGyCNV5Lk4W
88n6fs+xybalx+QBjS/CHrYCD4/jqW77bpQEwKE2z9aH3HyACpluslBcK0XpttTi
twRF7qzz6ouwm6lktfwKPtvhywEPOwUxuwLy+dKYgX/w3FbSpOVY1GAEfLkcqjWg
9WA1KIW6OZHte3HskK1iWK9RhkskPEyZNF27Hz4Ttqp/JBATtQ/HH3QXxqRvQnGS
CziRnKkS7bbeoBHqcvkIrJayZrSczQ==
=mNgg
-----END PGP SIGNATURE-----

--GU0MHlnWq1xCfdNkckNgn18lq1sIjujCI--
