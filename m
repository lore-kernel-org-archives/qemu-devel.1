Received: from eggs.gnu.org ([2001:4830:134:3::10]:36091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQBug-0000pa-M4
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQBub-0000NW-Oy
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:17:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dQBub-0000NI-GF
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:17:37 -0400
Date: Wed, 28 Jun 2017 13:17:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170628121730.GD7538@stefanha-x1.localdomain>
References: <20170615163813.7255-1-stefanha@redhat.com>
	<20170615163813.7255-2-stefanha@redhat.com>
	<20170627084348.GG14166@lemon.lan>
	<20170627110735.GB4792@noname.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline
In-Reply-To: <20170627110735.GB4792@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] virtio-pci: use ioeventfd even when
 KVM is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 01:07:35PM +0200, Kevin Wolf wrote:
> Am 27.06.2017 um 10:43 hat Fam Zheng geschrieben:
> > On Thu, 06/15 17:38, Stefan Hajnoczi wrote:
> > > Old kvm.ko versions only supported a tiny number of ioeventfds so
> > > virtio-pci avoids ioeventfds when kvm_has_many_ioeventfds() returns 0.
> > >=20
> > > Do not check kvm_has_many_ioeventfds() when KVM is disabled since it
> > > always returns 0.  Since commit 8c56c1a592b5092d91da8d8943c17777d6462=
a6f
> > > ("memory: emulate ioeventfd") it has been possible to use ioeventfds =
in
> > > qtest or TCG mode.
> > >=20
> > > This patch makes -device virtio-blk-pci,iothread=3Diothread0 work even
> > > when KVM is disabled.
> > >=20
> > > I have tested that virtio-blk-pci works under TCG both with and witho=
ut
> > > iothread.
> > >=20
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > This one was dropped out from Kevin's pull request but the iotest case
> > update on 068 which depends on it is merged. Now the test fails for
> > me:
>=20
> Whoops, sorry about that. Anyway, I think if we can, the way to fix it
> is to find out why this patch is failing qtest, and merge a fixed v2,
> rather than reverting the test cases.
>=20
> Stefan, can you reproduce the failure?

I will merge this patch via my tree and send a pull request today.

The purpose of this patch is to make -device virtio-blk-pci,iothread=3DID
work under TCG/qtest.  This is necessary because qemu-iotests isn't
allowed to depend on KVM.

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZU55aAAoJEJykq7OBq3PIlNAIAMMNlduoYdArhIo5+lmcNwAZ
5cTClX9Z+FYsYJuEpaGXE8a1qOphlFNMLvf2M4JcXQRlqxQO+Ki5pt2x/CYoh+eX
EXtrf6sS6bWukdC55109seplGTtvYorApcZlGYDIaRegVMhB9fT2TPjseK6V1eft
9gfXjkEoIlwxqhANwWtshOy+H9YM9GLDTXgdbMaQB02m/+Vo7Dz/P3cvkv+ZwyjX
UKlLxl8K4ASDwaD76jcmKywE+gAxiinxcf7OQAIb5UZ/eFti3Pckwpw/m9Vt9LD5
IloWXf0zbFSZ07YrqnDO0nQWQ7ZhWBVBHdgrCpqv3piF+lwqREjxOBK5cKAQwYA=
=qc4n
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--
