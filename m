Received: from eggs.gnu.org ([2001:4830:134:3::10]:39047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ec7mk-0002vN-No
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ec7mj-0007W8-Sz
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:51:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ec7mj-0007VY-JT
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:51:05 -0500
Date: Thu, 18 Jan 2018 10:51:03 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180118105103.GC19831@stefanha-x1.localdomain>
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<dcb849d4-82fb-de8a-5e81-23d47026c9eb@redhat.com>
	<20180111152345.GA7353@stefanha-x1.localdomain>
	<86106573-422b-fe4c-ec15-dad0edf05880@redhat.com>
	<20180112101807.GE7356@stefanha-x1.localdomain>
	<a45c1da8-03e8-140f-725c-af0f31e3da62@redhat.com>
	<20180115135620.GG13238@stefanha-x1.localdomain>
	<9fad276a-d17b-6a45-6cd6-50899934b7a1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <9fad276a-d17b-6a45-6cd6-50899934b7a1@redhat.com>
Subject: Re: [Qemu-devel] vhost-pci and virtio-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: wei.w.wang@intel.com, qemu-devel@nongnu.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 01:41:37PM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B401=E6=9C=8815=E6=97=A5 21:56, Stefan Hajnoczi wrote:
> > On Mon, Jan 15, 2018 at 02:56:31PM +0800, Jason Wang wrote:
> > > On 2018=E5=B9=B401=E6=9C=8812=E6=97=A5 18:18, Stefan Hajnoczi wrote:
> > > > > And what's more important, according to the kvm 2016 slides of vh=
ost-pci,
> > > > > the motivation of vhost-pci is not building SDN but a chain of VN=
Fs. So
> > > > > bypassing the central vswitch through a private VM2VM path does m=
ake sense.
> > > > > (Though whether or not vhost-pci is the best choice is still ques=
tionable).
> > > > This is probably my fault.  Maybe my networking terminology is wron=
g.  I
> > > > consider "virtual network functions" to be part of "software-defined
> > > > networking" use cases.  I'm not implying there must be a central vi=
rtual
> > > > switch.
> > > >=20
> > > > To rephrase: vhost-pci enables exitless VM2VM communication.
> > > The problem is, exitless is not what vhost-pci invents, it could be a=
chieved
> > > now when both sides are doing busypolling.
> > The only way I'm aware of is ivshmem.  But ivshmem lacks a family of
> > standard device types that allows different implementations to
> > interoperate.  We already have the virtio family of device types, so it
> > makes sense to work on a virtio-based solution.
> >=20
> > Perhaps I've missed a different approach for exitless VM2VM
> > communication.  Please explain how VM1 and VM2 can do exitless network
> > communication today?
>=20
> I'm not sure we're talking the same thing. For VM2VM, do you mean only for
> shared memory? I thought we can treat any backends that can transfer data
> directly between two VMs for a VM2VM solution. In this case, if virtqueue
> notifications were disabled by all sides (e.g busy polling), there will be
> no exits at all.
>=20
> And if you want a virtio version of shared memory, it's another kind of
> motivation at least from my point of view.

I'm confused, we're probably not talking about the same thing.

You said that exitless "could be achieved now when both sides are doing
busypolling".  Can you post a QEMU command-line that does this?

In other words, what exactly are you proposing as an alternative to
vhost-pci?

Stefan

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaYHwXAAoJEJykq7OBq3PIicYH/RxWW8kbNO4ddO9BYwP9ZA3+
68hKNKx/+0jcJeG3I7KIVETpKgfhAK3GJyAUFDJcP6UEVBQ5LMdtme46jwLUBDZc
CXrrRiAo2RB9jrMr3sxSP7iymgDhj1agq7ukTudmaT3wF2E/0pumMHvos2ZuFCvE
SBeHS2JEcNrOEeRbqV+J5IzVX/XTfuOYDvqccGDd2nC4wr2uKN3seh6rdhy6w0bO
s248Opo3n7e0pZ8RXtD8o/6zGCSiXAY9yIEjQPvWCB08gTARQTQog9HWeuWn32Cu
HBTPFdax52RPNni34fsXGudBT6anpCIHsF1vuCnxLO3P00fjcsMg1YcihUJju4U=
=WcxV
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
