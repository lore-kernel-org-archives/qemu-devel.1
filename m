Received: from eggs.gnu.org ([2001:4830:134:3::10]:40862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cT7Su-0005tc-Oi
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cT7Sr-0002u3-Hl
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:36:52 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cT7Sr-0002tr-Ae
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:36:49 -0500
Received: by mail-wm0-x242.google.com with SMTP id r126so30906368wmr.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 05:36:49 -0800 (PST)
Date: Mon, 16 Jan 2017 13:36:41 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170116133641.GF14681@stefanha-x1.localdomain>
References: <20170113084022.20152.24498.malonedeb@wampee.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
Content-Disposition: inline
In-Reply-To: <20170113084022.20152.24498.malonedeb@wampee.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1656234] [NEW] Qemu core dumped if using
 virtio-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1656234 <1656234@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 08:40:22AM -0000, Robert Hu wrote:
> Public bug reported:
>=20
> System Environment
> =3D=3D=3D=3D=3D=3D=3D
> Qemu commit/branch: e92fbc75
> Host OS: RHEL7.2 ia32e
> Host Kernel: 4.9.0
> Guest OS: RHEL7.2 ia32e
> Guest Kernel: 4.9.0
>=20
> Bug detailed description
> =3D=3D=3D=3D=3D=3D=3D
> While create a kvm guest using virtio-net, the qemu will core dump with s=
howing "Aborted (core dumped)".
> Reproduce Steps
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> create a guest:
> qemu-system-x86_64 -enable-kvm -m 4096 -smp 4 -device virtio-net-pci,netd=
ev=3Dnic0,mac=3D00:16:3e:49:be:24 -netdev tap,id=3Dnic0,script=3D/etc/kvm/q=
emu-ifup -drive file=3D/ia32e_rhel7u2_kvm.qcow2,if=3Dnone,id=3Dvirtio-disk0=
 -device virtio-blk-pci,drive=3Dvirtio-disk0 -serial file:serial.log
>=20
> Current Result:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> qemu-system-x86_64: /workspace/ia32e/nightly/kvm-next-20170105-ef85b6-e92=
fbc/kvm/qemu/hw/virtio/virtio.c:214: virtio_queue_set_notification: Asserti=
on `vq->notification_disabled > 0' failed.
> Aborted (core dumped)

Thanks for reporting this assertion failure.  A patch is queued and will
be merged soon:
https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg02277.html

Stefan

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYfMxpAAoJEJykq7OBq3PIMiQIAKn0rTpSefnD4rO4CJhMDuzm
HDTdtAjbaVgSc1b7KoRSwyiChmPdG70lPjG62Z4GHtXuh0SAuYBCTYZg2aXmHrEw
okHdSP559HmHF8cLk5jvCyI4KzdWXT9PyZqkot0ofNXDNJeGgH3LCsFR+GMBpaZx
uHRrg49sp/1ugs6NHc1I4obSlWtBrTBkv3Jiv2E+CTNQpNMoPAp0WnwUjcb6b68s
CvgO6G6FeR8sIva5EfVGTlUV0LQ3vbNu4qGD+pgil6s9Z5SJLgywaA12kP5Sf5X8
Lj6YkCb2tS0HGdxe4aOLT4wfrx7uP0JF2IG2AVrOI+iSJWYkcCcd321x8b3iU+c=
=H8R7
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--
