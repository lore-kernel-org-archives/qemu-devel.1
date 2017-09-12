Received: from eggs.gnu.org ([2001:4830:134:3::10]:58977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drsX6-0002mA-Tr
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drsX5-0006dg-Ph
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:15:48 -0400
References: <20170912144459.11359-1-pbonzini@redhat.com>
	<20170912144459.11359-6-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dcb2f6b9-e30c-34f2-5cfd-088dd90fcc84@redhat.com>
Date: Tue, 12 Sep 2017 16:15:39 -0500
MIME-Version: 1.0
In-Reply-To: <20170912144459.11359-6-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NX434OEEWfrgSLD06TLbXwP9Ex0kaUM4M"
Subject: Re: [Qemu-devel] [PATCH 05/10] qemu-iotests: limit
 non-_PROG-suffixed variables to common.rc
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
--NX434OEEWfrgSLD06TLbXwP9Ex0kaUM4M
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <dcb2f6b9-e30c-34f2-5cfd-088dd90fcc84@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/10] qemu-iotests: limit non-_PROG-suffixed
 variables to common.rc
References: <20170912144459.11359-1-pbonzini@redhat.com>
 <20170912144459.11359-6-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 09:44 AM, Paolo Bonzini wrote:
> These are never used by "check", with one exception that does not need
> $QEMU_OPTIONS.  Keep them in common.rc, which will be soon included onl=
y
> by the tests.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/qemu-iotests/039.out       | 10 +++---
>  tests/qemu-iotests/061.out       |  4 +--
>  tests/qemu-iotests/137.out       |  2 +-
>  tests/qemu-iotests/common.config | 69 ++------------------------------=
--------
>  tests/qemu-iotests/common.rc     | 65 ++++++++++++++++++++++++++++++++=
+++++
>  5 files changed, 75 insertions(+), 75 deletions(-)

It may be worth tweaking scripts/git.orderfile to prioritize
tests/qemu-iotests/common* above the rest of tests/qemu-iotests (I have
that tweak locally, at any rate).  But that's a separate issue.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NX434OEEWfrgSLD06TLbXwP9Ex0kaUM4M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm4TnwACgkQp6FrSiUn
Q2qFuwf8CpqSwvQ4ooVqWciv9p2GngvNggUNz2HIHEUjGfB8bQ5VAjjWuj16Cs04
8Wbsowp5RJNQQKe+uK8d6FKCoMrEAN9zwdlUiVoJ+8rqwvhvg96kRmCo6/5rOh1l
b7XQqQTiZFXZNEMp0qCYKULxypvcNG1qv/2sGDJp7VY9Vi/Q9d0tz9IhaB9poC/8
IWd7/b0ppcS/T43xsiLdqcooJSMS6aDfJyRpPM/d9riBJ2AizwN5KHN2GbJC9Hi8
iW2fPHga2hpvfOgS7qb2mU8PF6PmVZTBkRqs+fml3ntI1x98ZHY09kQdtwwkuQ+Z
VM2BXCVT/1qXHciyEOam4wroQCTP3g==
=e/Kq
-----END PGP SIGNATURE-----

--NX434OEEWfrgSLD06TLbXwP9Ex0kaUM4M--
