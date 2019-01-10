Received: from eggs.gnu.org ([209.51.188.92]:53386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghXX9-0008T6-9t
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghXX8-0002YV-K5
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:25:55 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:46488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ghXX8-0002Uz-B5
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:25:54 -0500
Received: by mail-wr1-x42b.google.com with SMTP id l9so10679574wrt.13
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 02:25:54 -0800 (PST)
Date: Thu, 10 Jan 2019 10:25:51 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190110102551.GD19025@stefanha-x1.localdomain>
References: <20190109112728.9214-1-xieyongji@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline
In-Reply-To: <20190109112728.9214-1-xieyongji@baidu.com>
Subject: Re: [Qemu-devel] [PATCH v4 for-4.0 0/7] vhost-user-blk: Add support
 for backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: elohimes@gmail.com
Cc: mst@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com, maxime.coquelin@redhat.com, yury-kotov@yandex-team.ru, wrfsh@yandex-team.ru, nixun@baidu.com, qemu-devel@nongnu.org, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, Xie Yongji <xieyongji@baidu.com>


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 07:27:21PM +0800, elohimes@gmail.com wrote:
> From: Xie Yongji <xieyongji@baidu.com>
>=20
> This patchset is aimed at supporting qemu to reconnect
> vhost-user-blk backend after vhost-user-blk backend crash or
> restart.
>=20
> The patch 1 uses exisiting wait/nowait options to make QEMU not
> do a connect on client sockets during initialization of the chardev.
>=20
> The patch 2 introduces two new messages VHOST_USER_GET_INFLIGHT_FD
> and VHOST_USER_SET_INFLIGHT_FD to support providing shared
> memory to backend.

Can you describe the problem that the inflight I/O shared memory region
solves?

Thanks,
Stefan

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcNx2vAAoJEJykq7OBq3PIE3wH/i4/Pwh0x1zWmUcKAapWoSHc
GFAZ1F1Cjzu0FTfnhzSIe0GHM+WjLXT1sg+ls49esJBtxjNFynQxMch9grsvefuy
1zGGFRengO3vnyWL63XuxM+go4yx8MDy+UyFmCrOHGN+Y9F7QaSBC0MglJyTrgym
gLGce4yWl++ic+O6VYh/Lxf4egI6tyBgGmepuCTQxPvyzhYGpRZ6SfzVLIVY8VpT
uhK4+hoQHeKb+MTWIecg04vLP57kfvq9h7xiLXr5Nf4rPXmcq/dOcTS14rF4hzXT
o1Mjl3IRvrs+HShTCbvrRcHa6kSSiMaUsBnDBHi4VQ88mmVFS6uD52++GG45E9w=
=FbBb
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
