Received: from eggs.gnu.org ([2001:4830:134:3::10]:59742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXqBl-0007W3-W3
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXqBi-00047h-UA
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:42:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXqBi-00047E-Kn
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:42:54 -0400
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
	<20170718170819.28494-4-anton.ivanov@cambridgegreys.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8bbfa5e4-7125-71d3-b640-5a7f82b1c7f9@redhat.com>
Date: Wed, 19 Jul 2017 09:42:51 -0500
MIME-Version: 1.0
In-Reply-To: <20170718170819.28494-4-anton.ivanov@cambridgegreys.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3VbrVgs0U1S45WEbTJGSpCwuIphUxCs7r"
Subject: Re: [Qemu-devel] [PATCH 3/3] Unified Datagram Socket Transport -
 raw support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: anton.ivanov@cambridgegreys.com, qemu-devel@nongnu.org
Cc: jasowang@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3VbrVgs0U1S45WEbTJGSpCwuIphUxCs7r
From: Eric Blake <eblake@redhat.com>
To: anton.ivanov@cambridgegreys.com, qemu-devel@nongnu.org
Cc: jasowang@redhat.com
Message-ID: <8bbfa5e4-7125-71d3-b640-5a7f82b1c7f9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] Unified Datagram Socket Transport - raw
 support
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
 <20170718170819.28494-4-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20170718170819.28494-4-anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 12:08 PM, anton.ivanov@cambridgegreys.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>=20
> This adds raw socket support to the unified socket driver.
>=20
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---

Interface review only.


> +++ b/qapi-schema.json
> @@ -3883,6 +3883,21 @@
>      '*txkey':    'uint32',
>      '*rxkey':    'uint32' } }
>  ##
> +# @NetdevRawOptions:
> +#
> +# Connect the VLAN to an network interface using raw sockets
> +#
> +# @ifname: network interface name
> +#
> +

Missing #

> +# Since 2.9

Same comments as on 2/3 - you've got the wrong version.

> +##
> +{ 'struct': 'NetdevRawOptions',
> +  'data': {
> +    'ifname':          'str'
> +} }
> +
> +##
>  # @NetdevVdeOptions:
>  #
>  # Connect the VLAN to a vde switch running on the host.
> @@ -4000,7 +4015,7 @@
>  ##
>  { 'enum': 'NetClientDriver',
>    'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde', '=
dump',
> -            'bridge', 'hubport', 'netmap', 'vhost-user', 'gre' ] }
> +            'bridge', 'hubport', 'netmap', 'vhost-user', 'gre', 'raw' =
] }

Missing comment on the 2.11 addition

> @@ -4062,7 +4078,7 @@
>  ##
>  { 'enum': 'NetLegacyOptionsType',
>    'data': ['none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> -           'dump', 'bridge', 'netmap', 'vhost-user', 'gre'] }
> +           'dump', 'bridge', 'netmap', 'vhost-user', 'gre', 'raw'] }

Again, this should NOT be added to NetLegacy.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3VbrVgs0U1S45WEbTJGSpCwuIphUxCs7r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllvb+sACgkQp6FrSiUn
Q2pOfAf/awaUOCPiertBOMvnLwFXzZoMa5Ql82cdkzzBEN7qnLJs8UvJk7fQTW4F
VMsfh/Wy8klaa4I7ST0J2NsrhO/UBMDoIKnOW+/TWQb4S0gnAGUHbYUopqffsMIB
kK9aoIeZJnwOnIe4M7lnlr1R1mED++1bQY5IYj4isJFkl0d3FBs0Mx7zp6QB51nR
N+BZ41zj6CX9WOXDYksz22kW5184wwnAvB5gwaR5SxGDscCKwUUa6V4Vl8GZdwA8
72k2U3UJEr2zPszzP1+AmNh8vj2qG+iU4D44kgG6eini3GCvIir/aaUhlcq9B/RO
CCaAziXR/YP6BGW9hd4d4BHYDRk6ng==
=okpI
-----END PGP SIGNATURE-----

--3VbrVgs0U1S45WEbTJGSpCwuIphUxCs7r--
