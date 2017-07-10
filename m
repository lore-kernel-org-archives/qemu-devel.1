Received: from eggs.gnu.org ([2001:4830:134:3::10]:40495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUZyD-00011V-D5
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUZy9-0007Qb-Mn
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:47:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dUZy9-0007Q8-DP
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:47:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C2C44E4CB
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 14:47:24 +0000 (UTC)
Received: from [10.10.121.60] (ovpn-121-60.rdu2.redhat.com [10.10.121.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 14A9C5DD71
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 14:47:23 +0000 (UTC)
References: <20170710121434.5047-1-eblake@redhat.com>
	<20170710121434.5047-2-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bee304bf-a054-e009-2671-e84bd6d01d62@redhat.com>
Date: Mon, 10 Jul 2017 09:47:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170710121434.5047-2-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eBRqIXl95QFAqxq33OijLNOc2io6DDqLr"
Subject: Re: [Qemu-devel] [PULL 01/11] MAINTAINERS: Promote NBD to supported,
 with new maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eBRqIXl95QFAqxq33OijLNOc2io6DDqLr
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <bee304bf-a054-e009-2671-e84bd6d01d62@redhat.com>
Subject: Re: [Qemu-devel] [PULL 01/11] MAINTAINERS: Promote NBD to supported,
 with new maintainer
References: <20170710121434.5047-1-eblake@redhat.com>
 <20170710121434.5047-2-eblake@redhat.com>
In-Reply-To: <20170710121434.5047-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/10/2017 07:14 AM, Eric Blake wrote:
> We are promising more than just odd fixes, and Paolo is hoping
> to offload the pull requests to me.  Also, enough of NBD is related
> to the block layer that it is worth including qemu-block on patches.
>=20
> While at it, include blockdev-nbd.c and qemu-nbd.texi in the set
> of maintained files.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Message-Id: <20170707182151.29872-1-eblake@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>=20

> +Network Block Device (NBD)
> +M: Eric Blake <eblake@redhat.com>
> +M: Paolo Bonzini <pbonzini@redhat.com>
> +L: qemu-block@nongnu.org
> +S: Maintained
> +F: block/nbd*
> +F: nbd/
> +F: include/block/nbd*
> +F: qemu-nbd.*
> +F: blockdev-nbd.c
> +T: git git://repo.or.cz/qemu/ericb.git nbd
> +T: git git://github.com/bonzini/qemu.git nbd-next

As it is, Paolo's reply crossed mail with my pull request, so on my v2
pull request, I'll drop the second T:

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eBRqIXl95QFAqxq33OijLNOc2io6DDqLr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZY5N2AAoJEKeha0olJ0NqnekH/1vjq/WuNNyFzBYIh09x4z9l
Nla8/ZpQTO2Xf4U1fVTlQRv9K999umvdceCCGmmBVpOlq11r1jmtv7ylqwMMoHd7
/rM4lsIARBHZGhScDeoKDW+k/J4fxI7x1g7IVtFZQKms59e1Pf4BPAadJWI2W0m4
ogOtwlG69Yg/TgselUEVh6TZDAahCRJEzNtVVO/o51Ou+QoNkmI7877W0KuqPMH1
JKY34hT6iL7hBvhFvWb/t8WEQ89rko7AGrYru96Rpi6A7muny69HytEWIXZcfYYi
Ku8OZ1U+MIc050Qq6/5RsVrRKBS/POu8ESDdMg2TXXaBUf4BRSlxxXoF2Et76i8=
=UpjU
-----END PGP SIGNATURE-----

--eBRqIXl95QFAqxq33OijLNOc2io6DDqLr--
