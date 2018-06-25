Received: from eggs.gnu.org ([2001:4830:134:3::10]:37400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fXLjs-0006Yz-3B
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 03:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fXLjr-0007b1-2C
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 03:16:40 -0400
Date: Mon, 25 Jun 2018 09:16:10 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180625071610.GH16514@angien.pipo.sk>
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AXxEqdD4tcVTjWte"
Content-Disposition: inline
In-Reply-To: <20180622125502.GF4366@localhost.localdomain>
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org


--AXxEqdD4tcVTjWte
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 22, 2018 at 14:55:02 +0200, Kevin Wolf wrote:
> Am 22.06.2018 um 13:38 hat Christian Borntraeger geschrieben:
> >=20
> > On 06/15/2018 04:21 PM, Kevin Wolf wrote:
> > > The -drive option serial was deprecated in QEMU 2.10. It's time to
> > > remove it.
> > >=20
> > > Tests need to be updated to set the serial number with -global instead
> > > of using the -drive option.
> >=20
> > libvirt 4.5 still creates those (at least on s390x)
> >=20
> >     <disk type=3D'file' device=3D'disk'>
> >       <driver name=3D'qemu' type=3D'qcow2' cache=3D'none' io=3D'native'=
 iothread=3D'1'/>
> >       <source file=3D'/var/lib/libvirt/qemu/image.zhyp137'/>
> >       <target dev=3D'hda' bus=3D'virtio'/>
> >       <serial>skel</serial>
> >       <boot order=3D'1'/>
> >       <address type=3D'ccw' cssid=3D'0xfe' ssid=3D'0x0' devno=3D'0x0000=
'/>
> >     </disk>
> >=20
> >=20
> > ->=20
> > [...]
> > -drive file=3D/var/lib/libvirt/qemu/image.zhyp137,format=3Dqcow2,if=3Dn=
one,id=3Ddrive-virtio-disk0,serial=3Dskel,cache=3Dnone,aio=3Dnative -device=
 virtio-blk-ccw,iothread=3Diothread1,scsi=3Doff,devno=3Dfe.0.0000,drive=3Dd=
rive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1,write-cache=3Don=20
> > [...]
> >=20
> > 2018-06-22T11:25:20.946024Z qemu-system-s390x: -drive file=3D/var/lib/l=
ibvirt/qemu/image.zhyp137,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0,=
serial=3Dskel,cache=3Dnone,aio=3Dnative: Block format 'qcow2' does not supp=
ort the option 'serial'
> > 2018-06-22 11:25:21.098+0000: shutting down, reason=3Dfailed
> >=20
> > So it seems that this breaks s390x.
>=20
> Thanks for bringing this up. libvirt should fix this before QEMU 3.0 is
> released.

So, I already extracted the code that formats the attributes which
should be actually done for the frontend few months ago, but did not
swithc to it since I did not want to check when everything was added.

The fix will be rather simple if we are certain that the disk serial,
geometry and error policies were supported in qemu 1.5. In that case we
can switch unconditionally to the new format.

--AXxEqdD4tcVTjWte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlswlrgACgkQHGwCByjY
1GpfSw//fLoYzDiwYxDvSY+3PrGK/NV5bJ3YFxClqeiyo3EpSmQcrnkBOltfxVsM
pdAsT87fsFgzDRdxDD9XZEnaRbAdUc07z34J6qUbex8ARkJ6aMryUpl2dDklFaAi
UqS5MXu1ewEa2F382/UMAlJhORT4RSuYJDq25GBdyw4V57+0vPkC7DepkC6P2tQc
y28FX5dv1Wo0+qYXNqU4uO/uaf3pXnLKBXiLkfxrCwI1vlP9I9S7llphiGla0ITL
txIVHzUT0nVhxGwg6jOp6CV2hgmnzd6UILE9ExWOpP6DzckD8+rdtuiZU1hvoaF2
Qrbhzv8obfvee5RwCKx+gbbiWoIpL43kSLKOA3666TXjvz9zE5Ae7whrsI0qvEMM
3sR9pyg04Y+F25DIlDvZRIdf+mCzzYKAqRQmGB+1+bl9aigHcws0kyoRCVleiwZS
ZuCYaMeKu6jRJdIrIbndptLWgOy+4/xUijmKOj2C2dpUX4h4fGvyeTGLmGS/vnl7
GcfVeFW0B87OxFplFopgMZ8RiHV6PRf1+Shvy3nMHblU2hMctTUB3SaZwMPvnRrd
AZ2jshBRZkvH3EabtjnEb9e2fuJoLz3tz7aTfa8JJP328dBy1eZnN1RCjte8ytds
6x8o7h271DOFgu2edrlNhBKBsQxNwh5zDz36rOd92RHO37fHL94=
=rEng
-----END PGP SIGNATURE-----

--AXxEqdD4tcVTjWte--
