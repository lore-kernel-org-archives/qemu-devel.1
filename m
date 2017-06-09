Received: from eggs.gnu.org ([2001:4830:134:3::10]:42306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJIfG-0006Vm-UT
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJIfF-0008N3-TY
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:05:18 -0400
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
	<1497009003-25794-2-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dae737d8-a62c-3699-807a-39edc98b7c54@redhat.com>
Date: Fri, 9 Jun 2017 07:05:06 -0500
MIME-Version: 1.0
In-Reply-To: <1497009003-25794-2-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HkurwXmPPkEAIjHrUCQOTTEPtf4wp9CML"
Subject: Re: [Qemu-devel] [PATCH 1/3] commit: Fix completion with extra
 reference
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
--HkurwXmPPkEAIjHrUCQOTTEPtf4wp9CML
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <dae737d8-a62c-3699-807a-39edc98b7c54@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] commit: Fix completion with extra
 reference
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
 <1497009003-25794-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497009003-25794-2-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/09/2017 06:50 AM, Kevin Wolf wrote:
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
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HkurwXmPPkEAIjHrUCQOTTEPtf4wp9CML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOo7yAAoJEKeha0olJ0Nqzh0H/2AqIjT6g2bMlIu4nmIfOkXu
rguywhgVkMQd4T0ULZKYuu31cNWiuPIpNfRwYN7jd2zlKNcT9tfYbiQVxsNLk/yO
t437d8RD4rAqvJD1AZEw/pdLttrnWX7IiLTSUm60Bm9DRxEPc1gMDyFRWINYGFmx
D8Z/KWfb8CsR18nZxmMH0Pkb/n12erhtCbyiK6d34bdmdQof7zaRRg0zcW2tM6rH
jK/VwLyKm6SOTJp88oD/fJxCUKxUy2Ukl8cM8EepB2/P78FgL8Y+SCKn2E4H2uwl
zIf7s5zVb8cl3G9YPRsohI6f607U2pTfm+mFOwJcbVwtLPQwS11/cltTZu33+Wk=
=tK6a
-----END PGP SIGNATURE-----

--HkurwXmPPkEAIjHrUCQOTTEPtf4wp9CML--
