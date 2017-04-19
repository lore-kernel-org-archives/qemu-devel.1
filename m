Received: from eggs.gnu.org ([2001:4830:134:3::10]:38687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0piW-0007Yn-3p
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0piT-0000yF-1A
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:32:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d0piS-0000xr-O1
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:32:16 -0400
References: <20170418135726.28022-1-stefanha@redhat.com>
	<20170418135726.28022-2-stefanha@redhat.com>
	<09309ca7-dea8-db26-5544-402964224ee1@redhat.com>
	<20170419132737.GF3343@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8c7093c1-8c10-c36c-3628-421664ca02be@redhat.com>
Date: Wed, 19 Apr 2017 08:32:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170419132737.GF3343@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="itOOSVUkjRnD9EaUb6c0frgPP71BgJtEB"
Subject: Re: [Qemu-devel] [PATCH v5 1/9] block: add bdrv_measure() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--itOOSVUkjRnD9EaUb6c0frgPP71BgJtEB
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>
Message-ID: <8c7093c1-8c10-c36c-3628-421664ca02be@redhat.com>
Subject: Re: [PATCH v5 1/9] block: add bdrv_measure() API
References: <20170418135726.28022-1-stefanha@redhat.com>
 <20170418135726.28022-2-stefanha@redhat.com>
 <09309ca7-dea8-db26-5544-402964224ee1@redhat.com>
 <20170419132737.GF3343@stefanha-x1.localdomain>
In-Reply-To: <20170419132737.GF3343@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2017 08:27 AM, Stefan Hajnoczi wrote:

>>
>> I know we haven't done a good job in the past, but should we start
>> trying to do better at documenting callback constraints of new things
>> added in this header?
>=20
> .bdrv_measure() is a 1:1 pass-through of the public bdrv_measure()
> function.  All the public function does is to dereference
> drv->bdrv_measure.
>=20
> I think that's why many of the other callbacks also have no
> documentation - they inherit semantics from the public function.  We
> don't need to duplicate the doc comments.

Sometimes, though, there are slightly different semantics (for example,
we guarantee that the parameters to the driver code have already been
validated against image size, properly sliced-and-diced to match block
limits, and so on), so that the drivers don't have to do as much work.
Documenting these contract guarantees would be useful.

But as I said, it's not something we have to solve in this series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--itOOSVUkjRnD9EaUb6c0frgPP71BgJtEB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY92bWAAoJEKeha0olJ0Nq+2YIAKMn8B2Xk/06nTANVsSeiHBi
9M8kZTkwKd9AJGpP77lyzrsEefcu2LzkmcSbRJi9ZpGDcxm5sd+1/rx7DagBJlPn
tr+thOYKTpnKBvHmXkzPZ+UNtR+ByU88tG5swAe1vKWb5iCTq1O5FVmrWM6dm44h
cYLpvH5QcctRk1cLdWnH69mIDiG4Xhty7P9pojzFpAVkv5s8VOVW6epU5ZXUHzUU
QKxNaANgi83eUPozXKmlTD7Nil2ym28bZgDAVnn+qTe6P0f2Yd0w+b9wgFpgsD70
Ke3vkFkpvRcPRKkQ2+Yc8K+spbqco0u5RCfnerkZ/Fp9R9ofsVHGfL2Mi3cGYsc=
=T6Qy
-----END PGP SIGNATURE-----

--itOOSVUkjRnD9EaUb6c0frgPP71BgJtEB--
