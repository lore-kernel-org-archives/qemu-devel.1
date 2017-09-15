Received: from eggs.gnu.org ([2001:4830:134:3::10]:57753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsuQb-0006bT-20
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsuQW-0002zD-HG
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:29:21 -0400
References: <20170915054404.19914-1-famz@redhat.com>
	<20170915054404.19914-4-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48f385c6-629e-12c8-d039-737cc74f1345@redhat.com>
Date: Fri, 15 Sep 2017 12:29:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170915054404.19914-4-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JtUd6pP0Q48DVrQH8Cn3qTJWDhvowsrRS"
Subject: Re: [Qemu-devel] [PATCH 3/3] iotests: Add "quit during block
 migration" case 195
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com, Juan Quintela <quintela@redhat.com>, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JtUd6pP0Q48DVrQH8Cn3qTJWDhvowsrRS
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 peterx@redhat.com, Juan Quintela <quintela@redhat.com>,
 Jeff Cody <jcody@redhat.com>
Message-ID: <48f385c6-629e-12c8-d039-737cc74f1345@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] iotests: Add "quit during block
 migration" case 195
References: <20170915054404.19914-1-famz@redhat.com>
 <20170915054404.19914-4-famz@redhat.com>
In-Reply-To: <20170915054404.19914-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/15/2017 12:44 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/195     | 97 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/195.out | 19 +++++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 117 insertions(+)
>  create mode 100755 tests/qemu-iotests/195
>  create mode 100644 tests/qemu-iotests/195.out

> +_cleanup()
> +{
> +    rm -f "${MIG_SOCKET}"
> +    rm -f "${TEST_IMG}.dest"
> +    _cleanup_test_img
> +    _cleanup_qemu
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15

Semantic conflict with Jeff's patch series that adds './check -s' that
preserves files in the per-test temp directory.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JtUd6pP0Q48DVrQH8Cn3qTJWDhvowsrRS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm8DeMACgkQp6FrSiUn
Q2pG1wf6AoJBcw8Bjmm8FWPWreuThD5wpNXWFqHUnrXDOvPlFYKfyRvtkcu+jtnM
v0xsDdXr39ntjrQLZmOjg/zFFB6jIdgUzSAg3EZ/oJi82mqbxp4slSmjGelqF9sG
vUHBDcP8+cYNsyX3e4myWcaIkfiUnHgp2jfVP44QLW6hv/ZvAm1SfVe9uq6SX6KV
fJk888j9j+3YH3fxkiuNdI2Ghat5cEAsY7k3Rwm3eerPx/aiabUO4kn5+j7B+6D4
GZkFmKgx72WKydrfCvTo+KEvs82Vac8nscSPMQUhPalJkxTMbzixsxnj96AzEaUF
RU2bf5KsHK9fLTd/sz+I0ESLwRgSEQ==
=b7sc
-----END PGP SIGNATURE-----

--JtUd6pP0Q48DVrQH8Cn3qTJWDhvowsrRS--
