Received: from eggs.gnu.org ([2001:4830:134:3::10]:37000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHG15-0000XW-UD
	for qemu-devel@nongnu.org; Fri, 11 May 2018 17:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHG15-0002I5-7Z
	for qemu-devel@nongnu.org; Fri, 11 May 2018 17:55:56 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-2-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d1b349d7-9632-2674-4459-2cded7f9f239@redhat.com>
Date: Fri, 11 May 2018 23:55:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8bWbnft363SruIFAF9wOoDg5PU0AUJZsf"
Subject: Re: [Qemu-devel] [PATCH 01/42] blockjob: Fix assertion in
 block_job_finalize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8bWbnft363SruIFAF9wOoDg5PU0AUJZsf
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <d1b349d7-9632-2674-4459-2cded7f9f239@redhat.com>
Subject: Re: [PATCH 01/42] blockjob: Fix assertion in block_job_finalize()
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-2-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:25, Kevin Wolf wrote:
> Every job gets a non-NULL job->txn on creation, but it doesn't
> necessarily keep it until it is decommissioned: Finalising a job remove=
s
> it from its transaction. Therefore, calling 'blockdev-job-finalize' a
> second time on an already concluded job causes an assertion failure.
>=20
> Remove job->txn from the assertion in block_job_finalize() to fix this.=

> block_job_do_finalize() still has the same assertion, but if a job is
> already removed from its transaction, block_job_apply_verb() will
> already error out before we run into that assertion.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  blockjob.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--8bWbnft363SruIFAF9wOoDg5PU0AUJZsf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr2EWAACgkQ9AfbAGHV
z0BbGAf/ebIk+qtTj8vKLxlsJpn4eE1IHop3Jm5Sjc3KFHHjGFLO9WZUI9KVQxt+
dnkQHENDy04VWlOFjGYMGbTZ1pAVF2gButuMPLgMFXNIJ9D3ke77QNfHOGPZ1zuf
CeLfMgOq34+MGUOkpJHpC/QN90zL2GjiVX63F6RqumFrYnnG18V8efZxMvj17E+0
PRJ+c59+FCr72c/8nIbdZ/s1pb6IHUi6AhonOaiZt2sYZclg/LFR4sPVz4jDo9ZQ
Q7e/b5ytoM0o3In4GdQ08PabScKUwu0GhlL2PrMpqmP4R+1AoG4tEWTQ2yrH1mC1
yKRD6zufmL6k6RnckW8XudrhE9Ztug==
=jGjf
-----END PGP SIGNATURE-----

--8bWbnft363SruIFAF9wOoDg5PU0AUJZsf--
