Received: from eggs.gnu.org ([2001:4830:134:3::10]:34157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwBo1-00048m-Mt
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwBny-0005WH-GY
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:06:49 -0400
References: <433d922c5ad43020493323c5e065b4c4ef4157ab.1491500481.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d3604dd2-6a9c-7ee3-0b30-d9107bf61287@redhat.com>
Date: Thu, 6 Apr 2017 13:06:43 -0500
MIME-Version: 1.0
In-Reply-To: <433d922c5ad43020493323c5e065b4c4ef4157ab.1491500481.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3bM3pc3iaekTtUTfvokVw3n8L5La2BLua"
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/1] qemu-img: img_create does not
 support image-opts, fix docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3bM3pc3iaekTtUTfvokVw3n8L5La2BLua
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <d3604dd2-6a9c-7ee3-0b30-d9107bf61287@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/1] qemu-img: img_create does not
 support image-opts, fix docs
References: <433d922c5ad43020493323c5e065b4c4ef4157ab.1491500481.git.jcody@redhat.com>
In-Reply-To: <433d922c5ad43020493323c5e065b4c4ef4157ab.1491500481.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 12:45 PM, Jeff Cody wrote:
> The documentation and help for qemu-img claims that 'qemu-img create'
> will take the '--image-opts' argument.  This is not true, so this
> patch removes those claims.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  qemu-img-cmds.hx | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Doc fix, worth having in 2.9 if we still have time.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--3bM3pc3iaekTtUTfvokVw3n8L5La2BLua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5oOzAAoJEKeha0olJ0Nql/EIAKR/9iZ4cvkyvuWUyg6ZsrEV
Wt5iT0XUB9IWNMCuIqpstH7qy3Qd1UApuGDCV1zzrjJP75jSZC47nrPMc+XNzJ+H
RWASacWQDWOtuQo2TfO9meUcpLmWR4EzgSdnZm0ZQu30ikTRLBC3aGdrEdvbtPlA
HHyLb1rCqLa6q0LW/s44PPBU1Bs3BNU4diH6JfAW/3dsfKlW/Qb9AwVSgdV0diHP
apArk/PheBy9U9f1d0c54oG0MjL0NcEQ/VzA+y81KzrfVquBwu/HNGkvMvBSbh/O
yj4yDjCutVl+NhqhP/pT9pZr8wGkNgJNFzsdhZfCFzH+nbxD4+vFwAjVHeO860E=
=BOuk
-----END PGP SIGNATURE-----

--3bM3pc3iaekTtUTfvokVw3n8L5La2BLua--
