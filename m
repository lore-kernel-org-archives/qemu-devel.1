Received: from eggs.gnu.org ([2001:4830:134:3::10]:51452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1ciLUJ-00054I-Rl
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1ciLUF-0008BJ-UJ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:37:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:30293)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1ciLUF-0008Av-Lr
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:37:11 -0500
Date: Mon, 27 Feb 2017 14:38:05 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20170227133805.GG3900@andariel.pipo.sk>
References: <20170227094050.ia6nrkvtvzmg7b2q@XZHOUW.usersys.redhat.com>
	<20170227101104.GB28403@stefanha-x1.localdomain>
	<20170227125003.fegyd7gbrfdvrwjv@XZHOUW.usersys.redhat.com>
	<20170227133130.GS28403@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/i8j2F0k9BYX4qLc"
Content-Disposition: inline
In-Reply-To: <20170227133130.GS28403@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [libvirt] Fail to start 2nd guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Xiong Zhou <xzhou@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org


--/i8j2F0k9BYX4qLc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2017 at 13:31:30 +0000, Stefan Hajnoczi wrote:
> On Mon, Feb 27, 2017 at 08:50:03PM +0800, Xiong Zhou wrote:
> > On Mon, Feb 27, 2017 at 10:11:04AM +0000, Stefan Hajnoczi wrote:
> > > On Mon, Feb 27, 2017 at 05:40:50PM +0800, Xiong Zhou wrote:

[...]

> > > > sh-4.2# virsh start 73us
> > > > error: Failed to start domain 73us
> > > > error: internal error: qemu unexpectedly closed the monitor: ((null=
):11497): Spice-Warning **: reds.c:2499:reds_init_socket: listen: Address a=
lready in use
> > > > 2017-02-27T09:33:42.335708Z qemu-kvm: failed to initialize spice se=
rver
> > >=20
> > > The error message says that the spice remote desktop cannot listen on
> > > -spice port=3D5900,addr=3D127.0.0.1.
> > >=20
> > > Did you hardcode port 5900 in the domain XML?  That could explain why
> > No.
> > > the second guest fails to launch - you need to use unique port numbers
> > > or let libvirt automatically assign them.  Check the domain XML:
> > >=20
> > >   <graphics type=3D'spice' port=3D'-1' tlsPort=3D'-1' autoport=3D'yes=
'>
> >=20
> > It looks like:
> >=20
> >     <graphics type=3D'spice' autoport=3D'yes'>
> >       <listen type=3D'address'/>
> >       <image compression=3D'off'/>
> >     </graphics>
> >=20
> >=20
> > >=20
> > > Another possibility is that a process running on the host is already
> > > using port 5900.  Perhaps a guest or VNC server that was launched
> > > outside of libvirt?  You can check this with:
> > >=20
> > >   netstat -alpn | grep 5900
> > # netstat -alpn | grep 5900
> > tcp        0      0 127.0.0.1:5900          0.0.0.0:*               LIS=
TEN      11065/qemu-kvm     =20
>=20
> Please check that 11065/qemu-kvm was launched by the same libvirtd and
> its domain XML also uses autoport=3D'yes'.
>=20
> I have CCed the libvirt mailing list because they may be able to explain
> why there is a collision on TCP port 5900.

There was a bug in the code. There could be a race between startup of
two VMs:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1397440

--/i8j2F0k9BYX4qLc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAli0K7cACgkQHGwCByjY
1GrShQ/+IVU0T60hWOGQ/dCMZDn/rZiGn8dVuvZcwBNC+NG514bjWyGaLb+Y4MXe
w9Io2ThOcjGXUWnOvxAhegwbFCkNh2BraxUii8ZdHZCaVDyZsP0i8EtHYfyAJkMp
Y5US6+zH/JXGsvgENO20cK+atnAHhuwIIVlx3Z5sSth+QTozR1UGT0TgUqvUG/W8
QLx1r4ZAcyPXqgQ0Bss8Fd+GPEcm6IBwLhuQC6s8NSvumW9d3ReCXrocPsaN5G9q
88vsTupVJAGU2UYCJFEu688KjzC/UCfQhKthZo471qYjM/D4tNpS68WUi/00SB9H
9Vds40PZCbDFWCuBH2HHWGBpKUJz0zhu5/aobevigc9V2Dph+JVa0099/E/bIE0e
fSW6rl6vmr7ccWyJk/ye3JQLkY9ZCLjvkBpN2M4rgNn1h6zcITKVveIrMuZh4cfn
3VwFECv6r8VBMsoie0F06pfhyF/UYV78bOosEmN2rrnb67bcn8lYiNvOUT0mV8sS
mg8kkjCssiAt+lH5BZFfkVFzlBg3BulPu7z2LTzGqswD/em6LP2cQOaO2qvIGcvg
ZpCCBsMMf9wNqZrp0EwJNkOMjgSzTRlr3x24Mrq4HFDPPMzQ4DHIJcvR4H5RwiER
vrmTdb199vBh1hBWog3eXFxg5VrNKrp69z+wr3IycL4vQRw6y4s=
=LMCn
-----END PGP SIGNATURE-----

--/i8j2F0k9BYX4qLc--
