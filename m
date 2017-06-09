Received: from eggs.gnu.org ([2001:4830:134:3::10]:48927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJKkc-0006bo-AV
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJKkb-0008Ab-Gx
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:18:58 -0400
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
	<1497009003-25794-2-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4e6da319-986b-e62a-52ba-188fdec21aea@redhat.com>
Date: Fri, 9 Jun 2017 16:18:46 +0200
MIME-Version: 1.0
In-Reply-To: <1497009003-25794-2-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rv2requ1U1LA7ENOJI7HPUGWFcMFBMQEK"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/3] commit: Fix completion
 with extra reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rv2requ1U1LA7ENOJI7HPUGWFcMFBMQEK
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <4e6da319-986b-e62a-52ba-188fdec21aea@redhat.com>
Subject: Re: [Qemu-block] [PATCH 1/3] commit: Fix completion with extra
 reference
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
 <1497009003-25794-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497009003-25794-2-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-09 13:50, Kevin Wolf wrote:
> commit_complete() can't assume that after its block_job_completed() the=

> job is actually immediately freed; someone else may still be holding
> references. In this case, the op blockers on the intermediate nodes mak=
e
> the graph reconfiguration in the completion code fail.
>=20
> Call block_job_remove_all_bdrv() manually so that we know for sure that=

> any blockers on intermediate nodes are given up.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/commit.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--rv2requ1U1LA7ENOJI7HPUGWFcMFBMQEK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZOq5GEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQN1k
B/99NaINNXNQzodq52GQau5h+zdqSWMIV0btqfVaEm6xhi7w5R97oogG6LSRhIe0
gM4ckAxYyIYQOlx0L9ETLPU1AlkLFfI0MJM0IxKgTguZ/0oJ2rvtu5hL9zlB9b4p
Az4eBVfMljF1zXYfhnHqewmrTkPv35eAVg8kP4NYpRjXbIVEHcrSUr4CTHcT7Itt
6dF2sCWTfxch/2lg/esziYQPbBYlC932KnuCtj7G6Gz+YGpAiB31q8ithVUv/wpQ
Bqd23cVWMIaEGG4P359jna3sg/edlDzoRY3UPA6k9/sTKUAc7kv6C/Yf4kqobELb
Hl89O2gNKsYB1tVeGb140UVe
=xQhZ
-----END PGP SIGNATURE-----

--rv2requ1U1LA7ENOJI7HPUGWFcMFBMQEK--
