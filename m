Received: from eggs.gnu.org ([2001:4830:134:3::10]:34552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn83s-0006Bj-B9
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn83r-0007V6-CI
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:50:00 -0400
References: <cover.1504111803.git.jcody@redhat.com>
	<e99a5e3feefe5fdb54d64fb80b09089618a0ff49.1504111803.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ccb4009d-6522-f1df-57aa-c0778eec551b@redhat.com>
Date: Wed, 30 Aug 2017 13:49:39 -0500
MIME-Version: 1.0
In-Reply-To: <e99a5e3feefe5fdb54d64fb80b09089618a0ff49.1504111803.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CHchxNXHR9XVOaNg0WgjegUM4guPfJoNs"
Subject: Re: [Qemu-devel] [PATCH v3 5/5] qemu-iotests: add option to save
 temp files on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CHchxNXHR9XVOaNg0WgjegUM4guPfJoNs
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, kwolf@redhat.com
Message-ID: <ccb4009d-6522-f1df-57aa-c0778eec551b@redhat.com>
Subject: Re: [PATCH v3 5/5] qemu-iotests: add option to save temp files on
 error
References: <cover.1504111803.git.jcody@redhat.com>
 <e99a5e3feefe5fdb54d64fb80b09089618a0ff49.1504111803.git.jcody@redhat.com>
In-Reply-To: <e99a5e3feefe5fdb54d64fb80b09089618a0ff49.1504111803.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 11:52 AM, Jeff Cody wrote:
> Now that ./check takes care of cleaning up after each tests, it
> can also selectively not clean up.  Add option to leave all output from=

> tests intact if that test encountered an error.
>=20
> Note: this currently only works for bash tests, as the python tests
> still clean up after themselves manually.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  tests/qemu-iotests/check  | 10 +++++++++-
>  tests/qemu-iotests/common |  6 ++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index f6ca85d..8a5fc0d 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -370,7 +370,15 @@ do
>              fi
>          fi
> =20
> -        rm -rf "$TEST_DIR_SEQ"
> +        #TODO: There is some intial work to save intermediate files

s/intial/initial/

> +        #      in python tests, but it is imperfect.  Having each
> +        #      test record its test name, and the tearDown function
> +        #      just move intermediate images to a subdirectory with
> +        #      the test name may prove more useful.

Comment works for me, and I'm fine with the idea you present here being
in a followup patch.  So with the typo fixed,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CHchxNXHR9XVOaNg0WgjegUM4guPfJoNs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmnCMMACgkQp6FrSiUn
Q2qD0Af+KWeWscBI9Rc87EWMF8vZZyFd6aFcFFrYgbLsHVY1IAwfFs48oPn0D7Nf
zE1/JBHocXeXC/WsEe99fptiq23u91sjGK3irs9iBO9edgKbNpxmVKhxRLmS/z6B
MSWOQZ9f7rhaN8Q/kLjNTtU7uOv83wJSkYAvqjON4CA7uId0cx9lWVVyxZqcb3jy
yq5b7htVyEdgg/G7wngLD9vuLHrKsjb93352VbpBN/3jWKCtIPNS2clKR/UKUjLT
K/81dikts42UR0oHyZee7HIyxGXhlY36wUwkpM4Cf4ngogsmruWGO5xdiG1btATV
Yvrp2HsXwoe2UJG6ZpjINBOOuPS+eQ==
=Bsft
-----END PGP SIGNATURE-----

--CHchxNXHR9XVOaNg0WgjegUM4guPfJoNs--
