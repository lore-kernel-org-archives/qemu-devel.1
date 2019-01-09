Received: from eggs.gnu.org ([209.51.188.92]:36425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1ghEjN-0002Rn-Mt
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1ghEjL-0004yC-J8
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:21:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1ghEjK-0004wA-JV
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:21:15 -0500
Date: Wed, 9 Jan 2019 15:13:37 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190109141337.GG3382@angien.pipo.sk>
References: <ae9873.3d686.1683223a356.Coremail.wuzhouhui14@mails.ucas.ac.cn>
	<20190109124258.GD18942@stefanha-x1.localdomain>
	<234daa90.3dc4b.16832c82ae0.Coremail.wuzhouhui14@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline
In-Reply-To: <234daa90.3dc4b.16832c82ae0.Coremail.wuzhouhui14@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [libvirt] Qemu migration with vhost-user-blk on
 top of local storage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Cc: stefan hajnoczi <stefanha@gmail.com>, libvir-list@redhat.com, xieyongji@baidu.com, spdk@lists.01.org, qemu-devel@nongnu.org, lilin24@baidu.com


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 21:23:25 +0800, wuzhouhui wrote:
> > -----Original Messages-----
> > From: "Stefan Hajnoczi" <stefanha@gmail.com>
> > Sent Time: 2019-01-09 20:42:58 (Wednesday)
> > To: wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
> > Cc: qemu-devel@nongnu.org, xieyongji@baidu.com, lilin24@baidu.com, libv=
ir-list@redhat.com, spdk@lists.01.org
> > Subject: Re: [Qemu-devel] Qemu migration with vhost-user-blk on top of =
local storage
> >=20
> > On Wed, Jan 09, 2019 at 06:23:42PM +0800, wuzhouhui wrote:
> > > Hi everyone,
> > >=20
> > > I'm working qemu with vhost target (e.g. spdk), and I attempt to migr=
ate VM with
> > > 2 local storages. One local storage is a regular file, e.g. /tmp/c74.=
qcow2, and
> > > the other is a malloc bdev that spdk created. This malloc bdev will e=
xported to
> > > VM via vhost-user-blk. When I execute following command:
> > >=20
> > >   virsh migrate --live --persistent --unsafe --undefinesource --copy-=
storage-all \
> > >      --p2p --auto-converge --verbose --desturi qemu+tcp://<uri>/syste=
m vm0
> > >=20
> > > The libvirt reports:
> > >=20
> > >   qemu-2.12.1: error: internal error: unable to execute QEMU command \
> > >     'nbd-server-add': Cannot find device=3Ddrive-virtio-disk1 nor \
> > >     node_name=3Ddrive-virtio-disk1
> >=20
> > Please post your libvirt domain XML.
>=20
> My libvirt is based on libvirt-1.1.1-29.el7, and add many patches to sati=
sfy our
> own needs, e.g. add support for vhost-user-blk. Post domain xml may not u=
seful.

So you added support for vhost-user-blk, but did not fix the
NBD migration code. You are on your own, sorry. We can't support
arbitrary downstream changes.

Please either upstream your patches or make sure to skip it for
vhost-user.

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlw2AY0ACgkQHGwCByjY
1GqX/BAAtmbX0vRyxN3iLDhqtF8aDLFz2vIvdbKTV61vCFRKp68pqdtoMppScwYc
yVqbKqGssScVKFvDI3UvMYiQAKA/f25Pns9xobT9JKBaji3nbUGcSL/aDMcm7v4z
tiXr3q8v402TF5zv9Odtg5KLUsjd35Ny3Dcw6DDcGqcckCmoAxSay0ieTrYpkb43
ptoEncd3z0/BdXj/7p1WKtArfDR8whvVhO/5/kB0xXq9zjtgIggFonis+vaqcTqG
chqXIGgM5nx6tI6iN2fbelBZOj89gxwTVfCqZqd0dY6x/s7HAs7L39/Y6QaEx8qo
qsQ/3Iiqrr97ib8E67nIXrl8S7vahvXonlx9V91bbFdf/Uvdq0HqIvILY2/U03GG
xuQI8QGZCLEbwUhg59yVvEQvy2Z6uktPytggUSL+j7G5YPQgLR/3iRvDT3SOShhQ
VPMUmSpulkTKZH0f6z1wmYcSPWfUZKl/Ktba1eZhomuMU/kEUTA31A+W4Y1cboJp
vnZrpg/rGsDbjCgIPin8XDE+JloZrctA/XijIDjxbzJCSTeapSjQqbMZC1gn0tVN
ZBhdal+Mkjg1DCzC6629uqFGTnr6uQrR90Skz+duKqhTcLPTApCv7OBa2gVCsW8l
d/uj3dgfKXw+/B9Xw/lqfBs9lVtuJKmLhqcMu6YjDPMifETsqcc=
=PjtD
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--
