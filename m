Received: from eggs.gnu.org ([2001:4830:134:3::10]:51519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOM0C-0004uP-Ks
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:12:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOM06-0005YV-Da
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:12:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eOM06-0005Xs-3b
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:11:58 -0500
Date: Mon, 11 Dec 2017 11:11:47 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171211111147.GF13593@stefanha-x1.localdomain>
References: <20171207153454-mutt-send-email-mst@kernel.org>
	<CAJSP0QVu4iwAu01Sth84VZshQde97x3FW1E1ua_YXVKs-65vhQ@mail.gmail.com>
	<20171207183945-mutt-send-email-mst@kernel.org>
	<CAJSP0QVnukGD3Afu9myv=v5OjqrPDpXu6JL3Tpf+Cdk=em9V3w@mail.gmail.com>
	<20171207193003-mutt-send-email-mst@kernel.org>
	<CAJSP0QX4V64OoU4-Dhb93MUZ9Rz0FPR-La5Xq4_yqGH7SG6PjQ@mail.gmail.com>
	<20171207213420-mutt-send-email-mst@kernel.org>
	<5A2A347B.9070006@intel.com>
	<CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
	<286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2017 at 04:23:17PM +0000, Wang, Wei W wrote:
> On Friday, December 8, 2017 4:34 PM, Stefan Hajnoczi wrote:
> > On Fri, Dec 8, 2017 at 6:43 AM, Wei Wang <wei.w.wang@intel.com> wrote:
> > > On 12/08/2017 07:54 AM, Michael S. Tsirkin wrote:
> > >>
> > >> On Thu, Dec 07, 2017 at 06:28:19PM +0000, Stefan Hajnoczi wrote:
> > >>>
> > >>> On Thu, Dec 7, 2017 at 5:38 PM, Michael S. Tsirkin <mst@redhat.com>
> > > Thanks Stefan and Michael for the sharing and discussion. I think
> > > above 3 and 4 are debatable (e.g. whether it is simpler really
> > > depends). 1 and 2 are implementations, I think both approaches could
> > > implement the device that way. We originally thought about one device
> > > and driver to support all types (called it transformer sometimes :-)
> > > ), that would look interesting from research point of view, but from
> > > real usage point of view, I think it would be better to have them sep=
arated,
> > because:
> > > - different device types have different driver logic, mixing them
> > > together would cause the driver to look messy. Imagine that a
> > > networking driver developer has to go over the block related code to
> > > debug, that also increases the difficulty.
> >=20
> > I'm not sure I understand where things get messy because:
> > 1. The vhost-pci device implementation in QEMU relays messages but has =
no
> > device logic, so device-specific messages like VHOST_USER_NET_SET_MTU a=
re
> > trivial at this layer.
> > 2. vhost-user slaves only handle certain vhost-user protocol messages.
> > They handle device-specific messages for their device type only.  This =
is like
> > vhost drivers today where the ioctl() function returns an error if the =
ioctl is
> > not supported by the device.  It's not messy.
> >=20
> > Where are you worried about messy driver logic?
>=20
> Probably I didn=E2=80=99t explain well, please let me summarize my though=
t a little bit, from the perspective of the control path and data path.
>=20
> Control path: the vhost-user messages - I would prefer just have the inte=
raction between QEMUs, instead of relaying to the GuestSlave, because
> 1) I think the claimed advantage (easier to debug and develop) doesn=E2=
=80=99t seem very convincing

You are defining a mapping from the vhost-user protocol to a custom
virtio device interface.  Every time the vhost-user protocol (feature
bits, messages, etc) is extended it will be necessary to map this new
extension to the virtio device interface.

That's non-trivial.  Mistakes are possible when designing the mapping.
Using the vhost-user protocol as the device interface minimizes the
effort and risk of mistakes because most messages are relayed 1:1.

> 2) some messages can be directly answered by QemuSlave , and some message=
s are not useful to give to the GuestSlave (inside the VM), e.g. fds, Vhost=
UserMemoryRegion from SET_MEM_TABLE msg (the device first maps the master m=
emory and gives the offset (in terms of the bar, i.e., where does it sit in=
 the bar) of the mapped gpa to the guest. if we give the raw VhostUserMemor=
yRegion to the guest, that wouldn=E2=80=99t be usable).

I agree that QEMU has to handle some of messages, but it should still
relay all (possibly modified) messages to the guest.

The point of using the vhost-user protocol is not just to use a familiar
binary encoding, it's to match the semantics of vhost-user 100%.  That
way the vhost-user software stack can work either in host userspace or
with vhost-pci without significant changes.

Using the vhost-user protocol as the device interface doesn't seem any
harder than defining a completely new virtio device interface.  It has
the advantages that I've pointed out:

1. Simple 1:1 mapping for most that is easy to maintain as the
   vhost-user protocol grows.

2. Compatible with vhost-user so slaves can run in host userspace
   or the guest.

I don't see why it makes sense to define new device interfaces for each
device type and create a software stack that is incompatible with
vhost-user.

>=20
>=20
> Data path: that's the discussion we had about one driver or separate driv=
er for different device types, and this is not related to the control path.
> I meant if we have one driver for all the types, that driver would look m=
essy, because each type has its own data sending/receiving logic. For examp=
le, net type deals with a pair of tx and rx, and transmission is skb based =
(e.g. xmit_skb), while block type deals with a request queue. If we have on=
e driver, then the driver will include all the things together.

I don't understand this.  Why would we have to put all devices (net,
scsi, etc) into just one driver?  The device drivers sit on top of the
vhost-pci driver.

For example, imagine a libvhost-user application that handles the net
device.  The vhost-pci vfio driver would be part of libvhost-user and
the application would only emulate the net device (RX and TX queues).

Stefan

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaLmfzAAoJEJykq7OBq3PINZwH/iGjv/Ww8RR8b7QZWWmAeO8a
3FQQ6ea7eyDQyLd4IfGxXOnzAIWlYGekj2dqq8Ifwexyg5sIGrXMMnwZ6kwygsCV
KDeDUbZroC4eEgpHbKFAbkCnTnYaXuCj9gjItUJKh1B+kQ0Wn/qFZCmANEJzqfnw
IqrriytyGNWLP/gEvcmjTRmIaCbO7V9bv9wOJt3LkJ0pAfVjZ8+C1nClTmdHUtdM
8cZPECq8CfGSJp2MVCeef1AYXICTGSas6AIudnPAgLXK9a2h31/Wmp1cHnDWk/fO
D/k8VIb9lFdQCwRsU6vVg3c+GYdqvOuRepohvp8jjkXdcO/8kQG72xUIxGt7ID0=
=3ivy
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
