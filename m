Received: from eggs.gnu.org ([2001:4830:134:3::10]:32862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX4QF-0007Sz-ED
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX4QC-0003D9-BU
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:42:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dX4QC-0003CE-2C
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:42:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D47EB4E047
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 11:42:38 +0000 (UTC)
References: <20170717101632.23247-1-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <93718068-720c-36b3-a18a-6af1d185039c@redhat.com>
Date: Mon, 17 Jul 2017 06:42:34 -0500
MIME-Version: 1.0
In-Reply-To: <20170717101632.23247-1-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f5QcJwfPDrT7EODWBbOQb1eh1xAhSHuLi"
Subject: Re: [Qemu-devel] [PATCH] add scripts/git.orderfile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f5QcJwfPDrT7EODWBbOQb1eh1xAhSHuLi
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Message-ID: <93718068-720c-36b3-a18a-6af1d185039c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] add scripts/git.orderfile
References: <20170717101632.23247-1-kraxel@redhat.com>
In-Reply-To: <20170717101632.23247-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 05:16 AM, Gerd Hoffmann wrote:
> Based on a old patch by Laszlo.
> Time to get this in ...
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  scripts/git.orderfile | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 scripts/git.orderfile

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/scripts/git.orderfile b/scripts/git.orderfile
> new file mode 100644
> index 0000000000..ac699700b1
> --- /dev/null
> +++ b/scripts/git.orderfile
> @@ -0,0 +1,29 @@
> +#
> +# order file for git, to produce patches which are easier to review
> +# by diffing the important stuff like interface changes first.
> +#
> +# one-off usage:
> +#   git diff -O scripts/git.orderfile ...
> +#
> +# add to git config:
> +#   git config diff.orderFile scripts/git.orderfile
> +#
> +
> +# Documentation
> +docs/*
> +*.texi
> +
> +# build system
> +configure
> +Makefile*
> +*.mak
> +
> +# qapi schema
> +*.json
> +
> +# headers
> +*.h
> +
> +# code
> +*.c
> +
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--f5QcJwfPDrT7EODWBbOQb1eh1xAhSHuLi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZbKKqAAoJEKeha0olJ0NqxokH/36GVLdJgylSpZQp3SrVUc7e
LtHAqNsDxf7oW8GTPnRf0Msl0uV/7ykzYO6TuE3LJLwIuukJVG1thjiehf7yp7cO
jOW1BSgxz431KDZcBLJ3lEPXmv0uR94zJ1Dlqb3qfgcV0PrgorTzsWAODMX3Fvk7
FenmuHYuucP2CBaWsAiBFq8yaSt86jSRNHbdxVuDOU+fG5dULZzyViu6mI2P9Kme
xvrlvugKQP/9etjDcrJW2VwFgVRir1MYfmAD4EOA0ELxG4qpqRAaD4J8AFtwySVO
erODnukw9ydLH5XBb09YPdsVMo+835+0TViV/bpkuBmUy1ivz2XfTAPD1OBP5Qk=
=CX7T
-----END PGP SIGNATURE-----

--f5QcJwfPDrT7EODWBbOQb1eh1xAhSHuLi--
