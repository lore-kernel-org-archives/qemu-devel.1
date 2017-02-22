Received: from eggs.gnu.org ([2001:4830:134:3::10]:57959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgZ1r-0001o5-JI
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgZ1m-0004Zo-OS
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:40:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgZ1m-0004ZT-GP
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:40:26 -0500
References: <20170222121527.7009-1-cornelia.huck@de.ibm.com>
	<20170222121527.7009-2-cornelia.huck@de.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5a3c1652-f5eb-85a5-44f4-35c7c12d3f4b@redhat.com>
Date: Wed, 22 Feb 2017 09:40:23 -0600
MIME-Version: 1.0
In-Reply-To: <20170222121527.7009-2-cornelia.huck@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cWHM3cmpi7usVLiPhHemppafvsfFvbKFd"
Subject: Re: [Qemu-devel] [PATCH 1/8] chardev: Basic support for TN3270
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org
Cc: Jing Liu <liujbjl@linux.vnet.ibm.com>, agraf@suse.de, borntraeger@de.ibm.com, jfrei@linux.vnet.ibm.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, Yang Chen <bjcyang@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cWHM3cmpi7usVLiPhHemppafvsfFvbKFd
From: Eric Blake <eblake@redhat.com>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org
Cc: Jing Liu <liujbjl@linux.vnet.ibm.com>, agraf@suse.de,
 borntraeger@de.ibm.com, jfrei@linux.vnet.ibm.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, Yang Chen <bjcyang@linux.vnet.ibm.com>
Message-ID: <5a3c1652-f5eb-85a5-44f4-35c7c12d3f4b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] chardev: Basic support for TN3270
References: <20170222121527.7009-1-cornelia.huck@de.ibm.com>
 <20170222121527.7009-2-cornelia.huck@de.ibm.com>
In-Reply-To: <20170222121527.7009-2-cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/22/2017 06:15 AM, Cornelia Huck wrote:
> From: Jing Liu <liujbjl@linux.vnet.ibm.com>
>=20
> This introduces basic support for TN3270, which needs to negotiate
> three Telnet options during handshake:
>   - End of Record
>   - Binary Transmission
>   - Terminal-Type
>=20
> As a basic implementation, this simply ignores NOP and Interrupt
> Process(IP) commands. More work should be done for them later.
>=20
> For more details, please refer to RFC 854 and 1576.
>=20
> Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> Signed-off-by: Yang Chen <bjcyang@linux.vnet.ibm.com>
> Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> Acked-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---

> +++ b/qapi-schema.json
> @@ -4774,6 +4774,8 @@
>  # @nodelay: #optional set TCP_NODELAY socket option (default: false)
>  # @telnet: #optional enable telnet protocol on server
>  #          sockets (default: false)
> +# @tn3270: #optional enable tn3270 protocol on server
> +#          sockets (default: false)

Missing a '(since 2.9)' designation

>  # @reconnect: #optional For a client socket, if a socket is disconnect=
ed,
>  #          then attempt a reconnect after the given number of seconds.=

>  #          Setting this to zero disables this function. (default: 0)
> @@ -4787,6 +4789,7 @@
>                                       '*wait'      : 'bool',
>                                       '*nodelay'   : 'bool',
>                                       '*telnet'    : 'bool',
> +                                     '*tn3270'    : 'bool',
>                                       '*reconnect' : 'int' },
>    'base': 'ChardevCommon' }
> =20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--cWHM3cmpi7usVLiPhHemppafvsfFvbKFd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrbDnAAoJEKeha0olJ0Nq3eYH/RSC9zykL3qf787Uo3YWRrgN
7fKw+e44scbM4D7J8oK2AR2bvzKygGFJ2ftEFdBE8wxbNgE0HbL/9Lg3qNHqqLNx
e2hgEeo99+ABlm4oG/Jr5twHCACtHm0C8qgr4WIEyUlCpGGG+P9Quru+KhBN94A+
11nyQhVPK0PDOummsKUPaQ4nicuHCXzMqwyfR7zvu8OYTZuwE7cepf3gjyL0drqg
GCrJA4YFOY5XZHYdX5/PaCyXqAyMQuVNzxs1SM+A6/I/mG/CB4EneczsyXXA0673
VSEbCZ5VcdYgjAMtYtBI/zw2DijHNyY/d1o7h0U4TvmzNUpaOOowi2+tDGsZG70=
=NSQA
-----END PGP SIGNATURE-----

--cWHM3cmpi7usVLiPhHemppafvsfFvbKFd--
