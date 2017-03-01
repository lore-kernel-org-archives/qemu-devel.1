Received: from eggs.gnu.org ([2001:4830:134:3::10]:33245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cj57a-00043e-Os
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cj57W-0005d5-Qx
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:20:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cj57W-0005cy-Ih
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:20:46 -0500
References: <20170301081951.27363-1-fanc.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6d0db5ad-983b-1eb1-571a-c6d8755bffa8@redhat.com>
Date: Wed, 1 Mar 2017 08:20:36 -0600
MIME-Version: 1.0
In-Reply-To: <20170301081951.27363-1-fanc.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7kKshqI89O3TBIuevbKSmOS2hPjmXMPvn"
Subject: Re: [Qemu-devel] [PATCH] Add inst_dirty_pages_rate in 'info migrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chao Fan <fanc.fnst@cn.fujitsu.com>, dgilbert@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com
Cc: caoj.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, douly.fnst@cn.fujitsu.com, maozy.fnst@cn.fujitsu.com, izumi.taku@jp.fujitsu.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7kKshqI89O3TBIuevbKSmOS2hPjmXMPvn
From: Eric Blake <eblake@redhat.com>
To: Chao Fan <fanc.fnst@cn.fujitsu.com>, dgilbert@redhat.com,
 qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com
Cc: caoj.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com,
 douly.fnst@cn.fujitsu.com, maozy.fnst@cn.fujitsu.com,
 izumi.taku@jp.fujitsu.com
Message-ID: <6d0db5ad-983b-1eb1-571a-c6d8755bffa8@redhat.com>
Subject: Re: [PATCH] Add inst_dirty_pages_rate in 'info migrate'
References: <20170301081951.27363-1-fanc.fnst@cn.fujitsu.com>
In-Reply-To: <20170301081951.27363-1-fanc.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/01/2017 02:19 AM, Chao Fan wrote:
> Auto-converge aims to accelerate migration by slowing down the
> generation of dirty pages. But user doesn't know how to determine the
> throttle value, so, a new item "inst-dirty-pages-rate" in "info migrate=
"
> would be helpful for user's determination.
>=20
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---

> +++ b/qapi-schema.json
> @@ -581,6 +581,7 @@
>    'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
>             'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
>             'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
> +           'inst-dirty-pages-rate' : 'int',

Missing documentation, including a '(since 2.9)' tag (if that's what you
are aiming for).

>             'mbps' : 'number', 'dirty-sync-count' : 'int',
>             'postcopy-requests' : 'int' } }
> =20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7kKshqI89O3TBIuevbKSmOS2hPjmXMPvn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtti0AAoJEKeha0olJ0NqsVIH/0runMCKTUik9d+EigGy+/Ux
15zp74zgk0Ym4iBixrOExs0VTQqzJMV4ht2cR9f67uPQ5QnljdvmicRs2ZfHPLCj
gb4D9IJIrvsy9vLWl37t1agb4eUJsyj0ONbWBd8chQejdTmLt3G3+lXeb5Kj3U9P
1PUOpLW2VznIZ13xU0B9A9qePrcH8ZGDWQIa6vP2jFBW3DKwcizD4RKvS8g8Z5+4
KPZKvcs0NxmaTqbi8m3Mjlq2qnXJ766UpFSw17OBSc48kPWRHnBTu3ANE1/REbgM
v6Nou49KRtxfSblCR77rfRabzA/pCJ1lhMqtKPjVmhEQ1C8c/nX0cBDnjIDlqxM=
=/C/b
-----END PGP SIGNATURE-----

--7kKshqI89O3TBIuevbKSmOS2hPjmXMPvn--
