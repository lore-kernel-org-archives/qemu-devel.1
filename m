Received: from eggs.gnu.org ([209.51.188.92]:41828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghDKe-0000Y4-64
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghDCH-0004sq-9f
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:43:01 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:36011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ghDCH-0004sJ-1c
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:43:01 -0500
Received: by mail-wr1-x42e.google.com with SMTP id u4so7539302wrp.3
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 04:43:00 -0800 (PST)
Date: Wed, 9 Jan 2019 12:42:58 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190109124258.GD18942@stefanha-x1.localdomain>
References: <ae9873.3d686.1683223a356.Coremail.wuzhouhui14@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline
In-Reply-To: <ae9873.3d686.1683223a356.Coremail.wuzhouhui14@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] Qemu migration with vhost-user-blk on top of local
 storage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Cc: qemu-devel@nongnu.org, xieyongji@baidu.com, lilin24@baidu.com, libvir-list@redhat.com, spdk@lists.01.org


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 06:23:42PM +0800, wuzhouhui wrote:
> Hi everyone,
>=20
> I'm working qemu with vhost target (e.g. spdk), and I attempt to migrate =
VM with
> 2 local storages. One local storage is a regular file, e.g. /tmp/c74.qcow=
2, and
> the other is a malloc bdev that spdk created. This malloc bdev will expor=
ted to
> VM via vhost-user-blk. When I execute following command:
>=20
>   virsh migrate --live --persistent --unsafe --undefinesource --copy-stor=
age-all \
>      --p2p --auto-converge --verbose --desturi qemu+tcp://<uri>/system vm0
>=20
> The libvirt reports:
>=20
>   qemu-2.12.1: error: internal error: unable to execute QEMU command \
>     'nbd-server-add': Cannot find device=3Ddrive-virtio-disk1 nor \
>     node_name=3Ddrive-virtio-disk1

Please post your libvirt domain XML.

> Does it means that qemu with spdk on top of local storage don't support m=
igration?
>=20
> QEMU: 2.12.1
> SPDK: 18.10

vhost-user-blk bypasses the QEMU block layer, so NBD storage migration
at the QEMU level will not work for the vhost-user-blk disk.

Stefan

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcNexSAAoJEJykq7OBq3PIHpAIALme9YVZW2zz2G4s9hTZc3rL
b2y8ug+kCjI12MmCh4UHoEqhCGuWfdPK9wXUCFX3Rk+FALxffWgJLe8aXrJ80VQz
1ywsfT9ZTvv/+YjOg86lMBeXAQ/vSg2o5yHAtD87TIpOEVtFX8TKLh55hovWnI9j
simoug5y0If4wrRzkvYrZDj0PkqJmWRXO0Plnm6JkWsVBNRers7UfnnD3LiceEUs
eALpdeR6Lrd0VdvbRykGBAKILjtqO7RxGpUa9uiEmbsQ++i5mt4ZynBMksVBjgRY
QOgOOLbdaa8cg3tAlQRJcBQhDPALnFlfhS+szXjn9NX5rz+FiHWQGYGdI8VKWJQ=
=650C
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
