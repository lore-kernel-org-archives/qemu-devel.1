Received: from eggs.gnu.org ([2001:4830:134:3::10]:43740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d9Doy-0007Zg-A3
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d9Dox-00078b-Gp
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:53:40 -0400
References: <20170511150337.21470-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c56d8ad8-50e2-778b-6a12-36c84de66f6c@redhat.com>
Date: Fri, 12 May 2017 18:53:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170511150337.21470-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NRoehw9PWea9Ndh8OOK6T2jr3A8RtGlBu"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qcow2: remove extra
 local_error variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NRoehw9PWea9Ndh8OOK6T2jr3A8RtGlBu
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <c56d8ad8-50e2-778b-6a12-36c84de66f6c@redhat.com>
Subject: Re: [Qemu-block] [PATCH] qcow2: remove extra local_error variable
References: <20170511150337.21470-1-berto@igalia.com>
In-Reply-To: <20170511150337.21470-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-11 17:03, Alberto Garcia wrote:
> Commit d7086422b1c1e75e320519cfe26176db6ec97a37 added a local_err
> variable global to the qcow2_amend_options() function, so there's no
> need to have this other one.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--NRoehw9PWea9Ndh8OOK6T2jr3A8RtGlBu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZFeiJEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQCNO
CACe+rbRRykYbLLZ9z/+caS4e7Tn7Na6Kd3UL0P+4fFC+HRNckn0xZuOIvBDJuVj
6DluS3+s/yH9xycbrMfmLnXRBozwgNNAXTDaPTqdpNMuwpzRxbXYBkkKhAXzbpuP
f/GAucb03bVdV9P11p5bu8gawFbdBpiPTXyE+teIX9q5/2eUBLlv6ZCWGOOM7kki
HhXJsw84+PsDXxjHYbVPMLvKqOiI6NH05NjCRTuJj8K25X0YH64m4sK2fzkqZAWw
7iRk/5KnJQ6bWSHCNeffCy3fJFVyFV9arFbif3O0F50W85lPkZq18YG2GGlnpIth
KG95tPl7nGjRZh+XnhMO9nb5
=n7sw
-----END PGP SIGNATURE-----

--NRoehw9PWea9Ndh8OOK6T2jr3A8RtGlBu--
