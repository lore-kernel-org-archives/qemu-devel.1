Received: from eggs.gnu.org ([2001:4830:134:3::10]:33024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnmqy-0007Ot-Ay
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnmqt-0000AW-KG
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:23:24 -0400
References: <20170901105434.3288-1-berrange@redhat.com>
	<20170901105434.3288-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf614cf9-598b-a306-4656-1b6d740e1706@redhat.com>
Date: Fri, 1 Sep 2017 09:22:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170901105434.3288-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6w1w3lAECh70pWvWtdb6ioIrdvki8HHcV"
Subject: Re: [Qemu-devel] [PATCH 1/2] iotests: rewrite 192 to use
 _launch_qemu to fix LUKS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6w1w3lAECh70pWvWtdb6ioIrdvki8HHcV
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <famz@redhat.com>
Message-ID: <cf614cf9-598b-a306-4656-1b6d740e1706@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] iotests: rewrite 192 to use _launch_qemu
 to fix LUKS support
References: <20170901105434.3288-1-berrange@redhat.com>
 <20170901105434.3288-2-berrange@redhat.com>
In-Reply-To: <20170901105434.3288-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/01/2017 05:54 AM, Daniel P. Berrange wrote:
> The LUKS driver requires extra args to QEMU to setup passwords.
> The _launch_qemu function takes care of this, so convert the
> test to use this function and use correct -drive syntax
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/192 | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>=20

> =20
> -{
> -echo "nbd_server_start unix:$TEST_DIR/nbd"
> -echo "nbd_server_add -w drive0"
> -echo "q"
> -} | $QEMU -nodefaults -display none -monitor stdio \
> -    -drive format=3D$IMGFMT,file=3D$TEST_IMG,if=3Dide,id=3Ddrive0 \
> -    -incoming defer 2>&1 | _filter_testdir | _filter_qemu | _filter_hm=
p

Can this test use QMP instead of HMP? But that's an independent question.=


Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6w1w3lAECh70pWvWtdb6ioIrdvki8HHcV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmpbUEACgkQp6FrSiUn
Q2pAsAgAibx8nmcos5M2Nv6NRV/77o/1G/TQO6KmK8sw8SBSBCGpnv6BEAqIfz5R
3npqqB+3W6RqhNLxI8Xz/xkPQWEwIJ/tMeYmma57u21C9zpPA1KIT1Viy2cP8HBV
ZBlCqQjijg9RhzhRDBFIwyLlbdyPHVEUUkrHwDNSZSgACVoVUeRYTjwHXI8Mj70t
T6a7ks5ywl/7I5NbqZT7v+y7zuOL0PRuN+mbQU9wrIpMZe4HGfJHy2TulQxo/VBy
EXanG6Ds75ceYBYsHdBjX1If3tjQdb3Kaf7PwF08AXywZGIdPKmSe9+FCS5JL2y7
7jPd3v6HlHONYFbBOym8WN3Tig5CoA==
=rrFH
-----END PGP SIGNATURE-----

--6w1w3lAECh70pWvWtdb6ioIrdvki8HHcV--
