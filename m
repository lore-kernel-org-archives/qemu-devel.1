Received: from eggs.gnu.org ([2001:4830:134:3::10]:48974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1llj-0005j7-D4
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 23:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1lli-0004xq-D8
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 23:31:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d1lli-0004wu-3o
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 23:31:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B8D6F806D
	for <qemu-devel@nongnu.org>; Sat, 22 Apr 2017 02:54:14 +0000 (UTC)
References: <20170421122710.15373-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b44af76d-400e-10cb-19a3-fe9e107f602d@redhat.com>
Date: Fri, 21 Apr 2017 09:45:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170421122710.15373-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="trxgx6WJAURCgx2av7raGdS24Xh608x1e"
Subject: Re: [Qemu-devel] [PATCH 00/14] Trivial cleanups around error
 reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--trxgx6WJAURCgx2av7raGdS24Xh608x1e
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <b44af76d-400e-10cb-19a3-fe9e107f602d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/14] Trivial cleanups around error
 reporting
References: <20170421122710.15373-1-famz@redhat.com>
In-Reply-To: <20170421122710.15373-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/21/2017 07:26 AM, Fam Zheng wrote:
> These are patches to:
>=20
> 1) reorder the function parameters so that Error **errp comes
> last.
>=20
> Error pointer in the middle of a function parameter list is very uncomm=
on, and
> does caused mistakes, thus is not a good style. Change to the usual way=
=2E
>=20
> 2) apply the error_propagate_null.cocci semantics patch again.
>=20
> Fam Zheng (14):
>   socket: Make errp the last parameter of socket_connect
>   socket: Make errp the last parameter of inet_connect_saddr
>   socket: Make errp the last parameter of unix_connect_saddr
>   socket: Make errp the last parameter of vsock_connect_saddr
>   block: Make errp the last parameter of bdrv_img_create
>   crypto: Make errp the last parameter of functions
>   mirror: Make errp the last parameter of mirror_start_job
>   block: Make errp the last parameter of commit_active_start
>   nfs: Make errp the last parameter of nfs_client_open
>   fdc: Make errp the last parameter of fdctrl_connect_drives
>   scsi: Make errp the last parameter of virtio_scsi_common_realize
>   migration: Make errp the last parameter of local functions
>   qga: Make errp the last parameter of qga_vss_fsfreeze
>   error: Apply error_propagate_null.cocci again

Series:
Reviewed-by: Eric Blake <eblake@redhat.com>

but you have a typo in the commit message of 6/14

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--trxgx6WJAURCgx2av7raGdS24Xh608x1e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+hsGAAoJEKeha0olJ0NqPHwH/0HTKfIyrWMPDaTDuLkbCmLU
EDyQxWD1C1Rh7ELtBR6W4kvAAMIdn9ZWuQbSaDIEuwsSkI+jdBl/s+kAiwcfSlKQ
HIvHzBZKd+AbsK1MKCKiAqNv40+XfHQP4rBKR54P4L+9i7IzfDiGhBWzsQP5xO89
hD53EbJGASlX9uZX/7OCUx8rhVuoOel4aHKMw/+0zdGXVTxECC/PkDbTsFsJ/cqZ
GhhP6tmMTCMELowtw4izDAf4RCR4OXOHVQQDVsngLA/YfbHgJc2XTMXh+yZYtjc3
Olmg0KabSh7EcLXZG2f6PD+djn0jlAX2UgnLtLc91xLX28VzhPvci9eX5lkX9Gs=
=HorO
-----END PGP SIGNATURE-----

--trxgx6WJAURCgx2av7raGdS24Xh608x1e--
