Received: from eggs.gnu.org ([2001:4830:134:3::10]:35978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBkpL-0002Mh-7c
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBkpK-0006AV-9c
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:04:47 -0500
References: <20171106165500.30278-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b5564704-1cc2-cad7-de54-105b4a72d085@redhat.com>
Date: Mon, 6 Nov 2017 11:04:37 -0600
MIME-Version: 1.0
In-Reply-To: <20171106165500.30278-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D1RQJxH5RVB0cOFjhiMOjQHE7NnSbSipk"
Subject: Re: [Qemu-devel] [PATCH] block: Fix error path in
 bdrv_backing_update_filename()
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
--D1RQJxH5RVB0cOFjhiMOjQHE7NnSbSipk
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <b5564704-1cc2-cad7-de54-105b4a72d085@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Fix error path in
 bdrv_backing_update_filename()
References: <20171106165500.30278-1-kwolf@redhat.com>
In-Reply-To: <20171106165500.30278-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/06/2017 10:55 AM, Kevin Wolf wrote:
> error_setg_errno() takes a positive errno code.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Worth mentioning Coverity in the commit message?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--D1RQJxH5RVB0cOFjhiMOjQHE7NnSbSipk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloAliUACgkQp6FrSiUn
Q2phhgf+OW3SeqwAcKOIhxKczdbtteggfx8hVYQJ5qKgEKq9jZ6AisqCfe0PYIt/
fIf1Vlol0C57K9LQHVSN1ndTekqsK2RqOWIvq3L1nhSknE4ZjGfxak20S+7Iq9Mf
IZE8cqZmmvcQgoPvTxs90A8/NeoaWOynV3UlnXJL2GGSbFsUNw0TpkRwPWPYE2eH
reNlklJ4aPmSVYSB2CB7tp6oV32nJPTZ178bmtIH1mAHGyUeo+UyrdbM7ArGAAnU
/qabQ7wQZ8P1ka+T+Qj6CQwXVCY/l94ju0IiKaDkBzq8/HjL13EzwfoMj4TabKkV
4uye5Zk6MQhx19KRG3lgeM+O6JmbuA==
=ATDo
-----END PGP SIGNATURE-----

--D1RQJxH5RVB0cOFjhiMOjQHE7NnSbSipk--
