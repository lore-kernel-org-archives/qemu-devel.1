Received: from eggs.gnu.org ([2001:4830:134:3::10]:60805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP6G3-0000KL-QW
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 07:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP6Fy-0002Es-Nd
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 07:35:31 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:44345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eP6Fx-0002Ds-Sp
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 07:35:26 -0500
Received: by mail-wm0-x22d.google.com with SMTP id t8so4693308wmc.3
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 04:35:25 -0800 (PST)
Date: Wed, 13 Dec 2017 12:35:21 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171213123521.GL16782@stefanha-x1.localdomain>
References: <20171207193003-mutt-send-email-mst@kernel.org>
	<CAJSP0QX4V64OoU4-Dhb93MUZ9Rz0FPR-La5Xq4_yqGH7SG6PjQ@mail.gmail.com>
	<20171207213420-mutt-send-email-mst@kernel.org>
	<5A2A347B.9070006@intel.com>
	<CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
	<286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
	<20171211111147.GF13593@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
	<20171212101440.GB6985@stefanha-x1.localdomain>
	<5A30E0C1.3070905@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gwtGiOGliFx8mAnm"
Content-Disposition: inline
In-Reply-To: <5A30E0C1.3070905@intel.com>
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
To: Wei Wang <wei.w.wang@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>


--gwtGiOGliFx8mAnm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 04:11:45PM +0800, Wei Wang wrote:
> On 12/12/2017 06:14 PM, Stefan Hajnoczi wrote:
> > On Mon, Dec 11, 2017 at 01:53:40PM +0000, Wang, Wei W wrote:
> > > On Monday, December 11, 2017 7:12 PM, Stefan Hajnoczi wrote:
> > > > On Sat, Dec 09, 2017 at 04:23:17PM +0000, Wang, Wei W wrote:
> > > > > On Friday, December 8, 2017 4:34 PM, Stefan Hajnoczi wrote:
> > > > > > On Fri, Dec 8, 2017 at 6:43 AM, Wei Wang <wei.w.wang@intel.com>
> > > > wrote:
> > > > > > > On 12/08/2017 07:54 AM, Michael S. Tsirkin wrote:
> > > > > > > > On Thu, Dec 07, 2017 at 06:28:19PM +0000, Stefan Hajnoczi w=
rote:
> > > > > > > > > On Thu, Dec 7, 2017 at 5:38 PM, Michael S. Tsirkin
> > > > > > > > > <mst@redhat.com>
> > > > > > > Thanks Stefan and Michael for the sharing and discussion. I
> > > > > > > think above 3 and 4 are debatable (e.g. whether it is simpler
> > > > > > > really depends). 1 and 2 are implementations, I think both
> > > > > > > approaches could implement the device that way. We originally
> > > > > > > thought about one device and driver to support all types (cal=
led
> > > > > > > it transformer sometimes :-) ), that would look interesting f=
rom
> > > > > > > research point of view, but from real usage point of view, I
> > > > > > > think it would be better to have them separated,
> > > > > > because:
> > > > > > > - different device types have different driver logic, mixing
> > > > > > > them together would cause the driver to look messy. Imagine t=
hat
> > > > > > > a networking driver developer has to go over the block related
> > > > > > > code to debug, that also increases the difficulty.
> > > > > > I'm not sure I understand where things get messy because:
> > > > > > 1. The vhost-pci device implementation in QEMU relays messages =
but
> > > > > > has no device logic, so device-specific messages like
> > > > > > VHOST_USER_NET_SET_MTU are trivial at this layer.
> > > > > > 2. vhost-user slaves only handle certain vhost-user protocol me=
ssages.
> > > > > > They handle device-specific messages for their device type only.
> > > > > > This is like vhost drivers today where the ioctl() function
> > > > > > returns an error if the ioctl is not supported by the device.  =
It's not messy.
> > > > > >=20
> > > > > > Where are you worried about messy driver logic?
> > > > > Probably I didn=E2=80=99t explain well, please let me summarize m=
y thought a
> > > > > little
> > > > bit, from the perspective of the control path and data path.
> > > > > Control path: the vhost-user messages - I would prefer just have =
the
> > > > > interaction between QEMUs, instead of relaying to the GuestSlave,
> > > > > because
> > > > > 1) I think the claimed advantage (easier to debug and develop)
> > > > > doesn=E2=80=99t seem very convincing
> > > > You are defining a mapping from the vhost-user protocol to a custom
> > > > virtio device interface.  Every time the vhost-user protocol (featu=
re
> > > > bits, messages,
> > > > etc) is extended it will be necessary to map this new extension to =
the
> > > > virtio device interface.
> > > >=20
> > > > That's non-trivial.  Mistakes are possible when designing the mappi=
ng.
> > > > Using the vhost-user protocol as the device interface minimizes the
> > > > effort and risk of mistakes because most messages are relayed 1:1.
> > > >=20
> > > > > 2) some messages can be directly answered by QemuSlave , and some
> > > > messages are not useful to give to the GuestSlave (inside the VM),
> > > > e.g. fds, VhostUserMemoryRegion from SET_MEM_TABLE msg (the device
> > > > first maps the master memory and gives the offset (in terms of the
> > > > bar, i.e., where does it sit in the bar) of the mapped gpa to the
> > > > guest. if we give the raw VhostUserMemoryRegion to the guest, that =
wouldn=E2=80=99t be usable).
> > > >=20
> > > > I agree that QEMU has to handle some of messages, but it should sti=
ll
> > > > relay all (possibly modified) messages to the guest.
> > > >=20
> > > > The point of using the vhost-user protocol is not just to use a
> > > > familiar binary encoding, it's to match the semantics of vhost-user
> > > > 100%.  That way the vhost-user software stack can work either in ho=
st
> > > > userspace or with vhost-pci without significant changes.
> > > >=20
> > > > Using the vhost-user protocol as the device interface doesn't seem =
any
> > > > harder than defining a completely new virtio device interface.  It =
has
> > > > the advantages that I've pointed out:
> > > >=20
> > > > 1. Simple 1:1 mapping for most that is easy to maintain as the
> > > >     vhost-user protocol grows.
> > > >=20
> > > > 2. Compatible with vhost-user so slaves can run in host userspace
> > > >     or the guest.
> > > >=20
> > > > I don't see why it makes sense to define new device interfaces for
> > > > each device type and create a software stack that is incompatible w=
ith vhost-user.
> > >=20
> > > I think this 1:1 mapping wouldn't be easy:
> > >=20
> > > 1) We will have 2 Qemu side slaves to achieve this bidirectional rela=
ying, that is, the working model will be
> > > - master to slave: Master->QemuSlave1->GuestSlave; and
> > > - slave to master: GuestSlave->QemuSlave2->Master
> > > QemuSlave1 and QemuSlave2 can't be the same piece of code, because Qe=
muSlave1 needs to do some setup with some messages, and QemuSlave2 is more =
likely to be a true "relayer" (receive and directly pass on)
> > I mostly agree with this.  Some messages cannot be passed through.  QEMU
> > needs to process some messages so that makes it both a slave (on the
> > host) and a master (to the guest).
> >=20
> > > 2) poor re-usability of the QemuSlave and GuestSlave
> > > We couldn=E2=80=99t reuse much of the QemuSlave handling code for Gue=
stSlave.
> > > For example, for the VHOST_USER_SET_MEM_TABLE msg, all the QemuSlave =
handling code (please see the vp_slave_set_mem_table function), won't be us=
ed by GuestSlave. On the other hand, GuestSlave needs an implementation to =
reply back to the QEMU device, and this implementation isn't needed by Qemu=
Slave.
> > >   If we want to run the same piece of the slave code in both QEMU and=
 guest, then we may need "if (QemuSlave) else" in each msg handling entry t=
o choose the code path for QemuSlave and GuestSlave separately.
> > > So, ideally we wish to run (reuse) one slave implementation in both Q=
EMU and guest. In practice, we will still need to handle them each case by =
case, which is no different than maintaining two separate slaves for QEMU a=
nd guest, and I'm afraid this would be much more complex.
> > Are you saying QEMU's vhost-pci code cannot be reused by guest slaves?
> > If so, I agree and it was not my intention to run the same slave code in
> > QEMU and the guest.
>=20
> Yes, it is too difficult to reuse in practice.
>=20
> >=20
> > When I referred to reusing the vhost-user software stack I meant
> > something else:
> >=20
> > 1. contrib/libvhost-user/ is a vhost-user slave library.  QEMU itself
> > does not use it but external programs may use it to avoid reimplementing
> > vhost-user and vrings.  Currently this code handles the vhost-user
> > protocol over UNIX domain sockets, but it's possible to add vfio
> > vhost-pci support.  Programs using libvhost-user would be able to take
> > advantage of vhost-pci easily (no big changes required).
> >=20
> > 2. DPDK and other codebases that implement custom vhost-user slaves are
> > also easy to update for vhost-pci since the same protocol is used.  Only
> > the lowest layer of vhost-user slave code needs to be touched.
>=20
> I'm not sure if libvhost-user would be limited to be used by QEMU only in
> practice. For example, DPDK currently implements its own vhost-user slave,
> and changing to use libvhost-user may require dpdk to be bound with QEMU,
> that is, applications like OVS-DPDK will have a dependency on QEMU. Proba=
bly
> people wouldn't want it this way.

I'm not saying that DPDK should use libvhost-user.  I'm saying that it's
easy to add vfio vhost-pci support (for the PCI adapter I described) to
DPDK.  This patch series would require writing a completely new slave
for vhost-pci because the device interface is so different from
vhost-user.

> On the other side, vhost-pci is more coupled with the QEMU implementation,
> because some of the msg handling will need to do some device setup (e.g.
> mmap memory and add sub MemoryRegion to the bar). This device emulation
> related code is specific to QEMU, so I think vhost-pci slave may not be
> reused by applications other than QEMU.

As mentioned previously, I did not propose reusing QEMU vhost-pci code
in vhost-user slaves.  It wouldn't make sense to do that.

> Would it be acceptable to use the vhost-pci slave from this patch series =
as
> the initial solution? It is already implemented, and we can investigate t=
he
> possibility of integrating it into the libvhost-user as the next step.

I think the current approach is fine for a prototype but is not suitable
for wider use by the community because it:
1. Does not scale to multiple device types (net, scsi, blk, etc)
2. Does not scale as the vhost-user protocol changes
3. It is hard to make slaves run in both host userspace and the guest

It would be good to solve these problems so that vhost-pci can become
successful.  It's very hard to fix these things after the code is merged
because guests will depend on the device interface.

Here are the points in detail (in order of importance):

1. Does not scale to multiple device types (net, scsi, blk, etc)

vhost-user is being applied to new device types beyond virtio-net.
There will be demand for supporting other device types besides
virtio-net with vhost-pci.

This patch series requires defining a new virtio device type for each
vhost-user device type.  It is a lot of work to design a new virtio
device.  Additionally, the new virtio device type should become part of
the VIRTIO standard, which can also take some time and requires writing
a standards document.

2. Does not scale as the vhost-user protocol changes

When the vhost-user protocol changes it will be necessary to update the
vhost-pci device interface to reflect those changes.  Each protocol
change requires thinking how the virtio devices need to look in order to
support the new behavior.  Changes to the vhost-user protocol will
result in changes to the VIRTIO specification for the vhost-pci virtio
devices.

3. It is hard to make slaves run in both host userspace and the guest

If a vhost-user slave wishes to support running in host userspace and
the guest then not much code can be shared between these two modes since
the interfaces are so different.

How would you solve these issues?

Stefan

--gwtGiOGliFx8mAnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMR6JAAoJEJykq7OBq3PIJ3QIAKQoXlIqxxox1X6415ySys8C
mYNqmUeQteG+t/vJGAB/slPdnZpjhTD030YSBqrbslNNL4vUIqNdMeNjK/gMj59E
/S4vMkh/IGib54X5k8tT05yZV3XLn1xN6N+jZV6bbtiLcqz3hXz78/sfT4keSJeg
mv1xmEm3BJ7Wt3CEtx/UA/ZvMxI7gbjKgyvxToHStfBqWjxxh1lMo3p0vak9aoCE
wClaoQ9XTQPfezjTBZZUGqM25wtHdi9FFOLnkhghNmEbJRZSxKHJ0G3wo/7ITb/g
iMNZJz8GTl3/ymPEyMdcjdkvg6CLdST7SObyp0zPmKTTu8BVdafXHH14lKg3n+E=
=iedS
-----END PGP SIGNATURE-----

--gwtGiOGliFx8mAnm--
