Received: from eggs.gnu.org ([2001:4830:134:3::10]:60252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDGKe-0004x7-9D
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDGKd-0007qp-3p
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:55:20 -0500
References: <20171110203111.7666-1-mreitz@redhat.com>
	<20171110203111.7666-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8c5cd095-404a-fbc5-8bbb-1c07d7eeb9e1@redhat.com>
Date: Fri, 10 Nov 2017 14:55:07 -0600
MIME-Version: 1.0
In-Reply-To: <20171110203111.7666-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IN1rc3rqAcbFVJoxobrGpPn7MVmq5VitP"
Subject: Re: [Qemu-devel] [PATCH for-2.11 1/5] qcow2: check_errors are fatal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IN1rc3rqAcbFVJoxobrGpPn7MVmq5VitP
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Message-ID: <8c5cd095-404a-fbc5-8bbb-1c07d7eeb9e1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 1/5] qcow2: check_errors are fatal
References: <20171110203111.7666-1-mreitz@redhat.com>
 <20171110203111.7666-2-mreitz@redhat.com>
In-Reply-To: <20171110203111.7666-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 02:31 PM, Max Reitz wrote:
> When trying to repair a dirty image, qcow2_check() may apparently
> succeed (no really fatal error occurred that would prevent the check
> from continuing), but if check_errors in the result object is non-zero,=

> we cannot trust the image to be usable.
>=20
> Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1728639
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c              |  5 ++++-
>  tests/qemu-iotests/060     | 20 ++++++++++++++++++++
>  tests/qemu-iotests/060.out | 23 +++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 1 deletion(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IN1rc3rqAcbFVJoxobrGpPn7MVmq5VitP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloGEisACgkQp6FrSiUn
Q2qBawf/cOs3V8RjhRsK/bTINxMK5UwSk2pLeu8WY0J+j7z3qfE2O2ASIsrKXPzs
KgVZQRxWqqtROxR6HkgPw2nJ4fUXMMy07zm3OmU2h4a/WOwt38mVajGyINBi20Su
GV27vpy9Fhk9LTgFOPSIUJ7yi9PNv4nvdxwg8KHtS5uH4gGrlK3fbx0xtz5eT9AZ
n/YaZbRqio/zp7qSU3Abc5v1NjTAGbKf0WqtSWMYSJkr2hMQ/m9deBq1zort8lzc
zkM3PwjCjh4ZYfYRh73RGYLKanRJHPriACYGM5Qjwun7Ae2t+ikKXDWuj9mB22q2
qFx6UL8Iht2Cj+UXjVh49PrTIPDj/Q==
=8AE+
-----END PGP SIGNATURE-----

--IN1rc3rqAcbFVJoxobrGpPn7MVmq5VitP--
