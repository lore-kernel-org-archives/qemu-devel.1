Received: from eggs.gnu.org ([2001:4830:134:3::10]:40803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6Kpg-0001Xm-UK
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6Kpf-0004A5-VJ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:46:28 -0400
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
	<1493916761-32319-7-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c1e09d38-439b-8e95-3944-76fa2d6d33b3@redhat.com>
Date: Thu, 4 May 2017 12:46:21 -0500
MIME-Version: 1.0
In-Reply-To: <1493916761-32319-7-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aFQd7nG0kco3UDWPRHvhHk8R0GXxTqMEc"
Subject: Re: [Qemu-devel] [PATCH 6/6] file-posix: Remove
 .bdrv_inactivate/invalidate_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aFQd7nG0kco3UDWPRHvhHk8R0GXxTqMEc
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <c1e09d38-439b-8e95-3944-76fa2d6d33b3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/6] file-posix: Remove
 .bdrv_inactivate/invalidate_cache
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
 <1493916761-32319-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493916761-32319-7-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/04/2017 11:52 AM, Kevin Wolf wrote:
> Now that the block layer takes care to request a lot less permissions
> for inactive nodes, the special-casing in file-posix isn't necessary an=
y
> more.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-posix.c | 33 ---------------------------------
>  1 file changed, 33 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--aFQd7nG0kco3UDWPRHvhHk8R0GXxTqMEc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZC2jtAAoJEKeha0olJ0NqfRgH/0L3l1PGZwoa9b/gTcR6mUGx
9jJMgmIx0mmc2Wa+DXqtLrbqpRFGBGBgOqPbhIRWhoRPgLs/JUmpYsd5dfHqlWz8
k/Js7c5202vdhzSOlwRtmJ7oTjiKmYELMvrGFrZCeoHbVfV8RG46plKW/8Bu5QHY
HvVhia3ETHhGbZ3hwcndIZIYBGNgiZcBfTe7hngQW64yrxTUtqkpANi/Mb+Zs232
7dWhH1eihcxTDhFjcDe5ORNYDNehJWnqUYEDMQbEHK0PQ8nF5UX2r8zstDLXOH4V
SIclDwy4nyH7zVYHLzEhtf4joRDpfoH3+gGvuf5p8cK8UcThSxJodtVt+d0+waM=
=N8cX
-----END PGP SIGNATURE-----

--aFQd7nG0kco3UDWPRHvhHk8R0GXxTqMEc--
