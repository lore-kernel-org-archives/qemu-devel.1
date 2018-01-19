Received: from eggs.gnu.org ([2001:4830:134:3::10]:34351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ecaLZ-0004ix-J4
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ecaLV-0003HO-Ia
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:20:57 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:39729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ecaLV-0003GS-7q
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:20:53 -0500
Received: by mail-wm0-x22d.google.com with SMTP id b21so4999726wme.4
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 09:20:53 -0800 (PST)
Date: Fri, 19 Jan 2018 17:20:49 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180119172049.GA29973@stefanha-x1.localdomain>
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<dcb849d4-82fb-de8a-5e81-23d47026c9eb@redhat.com>
	<20180111152345.GA7353@stefanha-x1.localdomain>
	<86106573-422b-fe4c-ec15-dad0edf05880@redhat.com>
	<20180112101807.GE7356@stefanha-x1.localdomain>
	<a45c1da8-03e8-140f-725c-af0f31e3da62@redhat.com>
	<20180115135620.GG13238@stefanha-x1.localdomain>
	<9fad276a-d17b-6a45-6cd6-50899934b7a1@redhat.com>
	<20180118105103.GC19831@stefanha-x1.localdomain>
	<78448708-8d53-70ca-d079-424caabc3a35@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <78448708-8d53-70ca-d079-424caabc3a35@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, wei.w.wang@intel.com, qemu-devel@nongnu.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 07:51:49PM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B401=E6=9C=8818=E6=97=A5 18:51, Stefan Hajnoczi wrote:
> > On Tue, Jan 16, 2018 at 01:41:37PM +0800, Jason Wang wrote:
> > >=20
> > > On 2018=E5=B9=B401=E6=9C=8815=E6=97=A5 21:56, Stefan Hajnoczi wrote:
> > > > On Mon, Jan 15, 2018 at 02:56:31PM +0800, Jason Wang wrote:
> > > > > On 2018=E5=B9=B401=E6=9C=8812=E6=97=A5 18:18, Stefan Hajnoczi wro=
te:
> > > > > > > And what's more important, according to the kvm 2016 slides o=
f vhost-pci,
> > > > > > > the motivation of vhost-pci is not building SDN but a chain o=
f VNFs. So
> > > > > > > bypassing the central vswitch through a private VM2VM path do=
es make sense.
> > > > > > > (Though whether or not vhost-pci is the best choice is still =
questionable).
> > > > > > This is probably my fault.  Maybe my networking terminology is =
wrong.  I
> > > > > > consider "virtual network functions" to be part of "software-de=
fined
> > > > > > networking" use cases.  I'm not implying there must be a centra=
l virtual
> > > > > > switch.
> > > > > >=20
> > > > > > To rephrase: vhost-pci enables exitless VM2VM communication.
> > > > > The problem is, exitless is not what vhost-pci invents, it could =
be achieved
> > > > > now when both sides are doing busypolling.
> > > > The only way I'm aware of is ivshmem.  But ivshmem lacks a family of
> > > > standard device types that allows different implementations to
> > > > interoperate.  We already have the virtio family of device types, s=
o it
> > > > makes sense to work on a virtio-based solution.
> > > >=20
> > > > Perhaps I've missed a different approach for exitless VM2VM
> > > > communication.  Please explain how VM1 and VM2 can do exitless netw=
ork
> > > > communication today?
> > > I'm not sure we're talking the same thing. For VM2VM, do you mean onl=
y for
> > > shared memory? I thought we can treat any backends that can transfer =
data
> > > directly between two VMs for a VM2VM solution. In this case, if virtq=
ueue
> > > notifications were disabled by all sides (e.g busy polling), there wi=
ll be
> > > no exits at all.
> > >=20
> > > And if you want a virtio version of shared memory, it's another kind =
of
> > > motivation at least from my point of view.
> > I'm confused, we're probably not talking about the same thing.
> >=20
> > You said that exitless "could be achieved now when both sides are doing
> > busypolling".  Can you post a QEMU command-line that does this?
>=20
> If exitless means no virtqueue kick and interrupt. It does not require any
> special command line, just start a testpmd in both guest and host.
>=20
> >=20
> > In other words, what exactly are you proposing as an alternative to
> > vhost-pci?
>=20
> I don't propose any new idea. I just want to know what's the advantage of
> vhost-pci over zerocopy. Both needs one time of copy, the difference is t=
he
> vhost-pci did it inside a guest but zerocopy did in on host.

Exitless VM2VM communication is desirable if you cannot run software on
the host or if both endpoints are already in VMs.  In that case running
one thing in a VM and another on the host doesn't make sense.

The obvious environment where this applies is in the cloud where
everything is a VM.

Stefan

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaYijxAAoJEJykq7OBq3PIfOYIALhUiErNyD/+2ppspWNVZP0F
CCB6hjKN09MiTa69TV68UU/Nj+7GQgoT4xNcKufgHW2Y74+JYjJpeirfQGwn4vbv
nwUaGqgzZnNnWUHjp/X/tGSW1f+IK1ksJa1xH96yTn3EaHDI9dTlrvxiTxkCUfmS
TBTfbE+LvFGjdsUDPQY7k6Xlh3jWQXMXdFrd51TZWR6C6HfzHbiJ0fZNR35tP8Xt
LaJL+peG9gT05+k+xol4juiKgB4tP1IMa56fvGcrHnVvJi9Vvm6ml2N1zPMf1tmp
jxS5O/m2j0U+jbPSnx4/jiw/VqXGf2rp/Vs+rpiaKPB9FrQHe0fK7Zz1P8ip9Ig=
=3T7d
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
