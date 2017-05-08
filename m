Received: from eggs.gnu.org ([2001:4830:134:3::10]:60815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d7d30-0000Uw-Hl
	for qemu-devel@nongnu.org; Mon, 08 May 2017 03:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d7d2v-0001jQ-K4
	for qemu-devel@nongnu.org; Mon, 08 May 2017 03:25:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d7d2v-0001j7-DE
	for qemu-devel@nongnu.org; Mon, 08 May 2017 03:25:29 -0400
References: <1493977730-20581-1-git-send-email-pbonzini@redhat.com>
	<20170508061359.GH25748@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e1b235c4-14c1-549f-45bf-c5175401f949@redhat.com>
Date: Mon, 8 May 2017 09:25:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170508061359.GH25748@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6bTDbxSiE7pu5rOfHuogJ3h8ttOTiVjQ5"
Subject: Re: [Qemu-devel] [PATCH] ppc: xics: fix compilation with CentOS 6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, dgibson@redhat.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6bTDbxSiE7pu5rOfHuogJ3h8ttOTiVjQ5
From: Paolo Bonzini <pbonzini@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, dgibson@redhat.com, stefanha@redhat.com
Message-ID: <e1b235c4-14c1-549f-45bf-c5175401f949@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ppc: xics: fix compilation with CentOS 6
References: <1493977730-20581-1-git-send-email-pbonzini@redhat.com>
 <20170508061359.GH25748@umbus.fritz.box>
In-Reply-To: <20170508061359.GH25748@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/05/2017 08:13, David Gibson wrote:
>>
>> 	Please start including Docker-based tests in your pre-pull-request te=
sts.
> Um.. is there some doco on how to execute these.  I tried "make
> docker-test" and "make docker-image" and they both just seem to hang
> at:
>=20
> umbus:~/src/qemu (ppc-for-2.10)$ make docker-image
>   BUILD   travis
>=20
> strace shows docker blocked on a futex.

Try "make docker-test-full@centos6 V=3D1".

Paolo


--6bTDbxSiE7pu5rOfHuogJ3h8ttOTiVjQ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlkQHV8ACgkQv/vSX3jH
roN/Ugf8CUpkzGu22S/x6PToE/UvIzMdp9SHIy/QVxEGCTPABCI1aJgYNKhgZ9ws
pxc6LM0gmeQL0Vv9dR3Aa36Bq0uotr2+iU6DuO0FiBpXshzTy7IlZx7d3qBVO8Zf
Zy3UyyDanRQ1qyEJhqKMOWzT2K4SP8NqARgflIi6Qv3U4xvH55uu+IeXx08NfPEZ
WgrCGQWG5x5B7BRa880evlJ+bU+sS3kP/EFlZnNoIoiLfjfFiUkIVDusU/H1SWPy
S/iWK8GTsOw81BQ9fii+75kq3DxD1+TSBfHjJBrd8NXx4jmf8xyaZzp8kNPZqsAq
kvwZH7i5D0ZP/sh4YCVsl/vLfdm7aQ==
=FWuq
-----END PGP SIGNATURE-----

--6bTDbxSiE7pu5rOfHuogJ3h8ttOTiVjQ5--
