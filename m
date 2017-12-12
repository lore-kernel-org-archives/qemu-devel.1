Received: from eggs.gnu.org ([2001:4830:134:3::10]:53844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOhaL-0004RG-Gy
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOhaI-0007qc-Af
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:14:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eOhaI-0007q8-0n
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:14:46 -0500
Date: Tue, 12 Dec 2017 10:14:40 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171212101440.GB6985@stefanha-x1.localdomain>
References: <20171207183945-mutt-send-email-mst@kernel.org>
	<CAJSP0QVnukGD3Afu9myv=v5OjqrPDpXu6JL3Tpf+Cdk=em9V3w@mail.gmail.com>
	<20171207193003-mutt-send-email-mst@kernel.org>
	<CAJSP0QX4V64OoU4-Dhb93MUZ9Rz0FPR-La5Xq4_yqGH7SG6PjQ@mail.gmail.com>
	<20171207213420-mutt-send-email-mst@kernel.org>
	<5A2A347B.9070006@intel.com>
	<CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
	<286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
	<20171211111147.GF13593@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
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


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2017 at 01:53:40PM +0000, Wang, Wei W wrote:
> On Monday, December 11, 2017 7:12 PM, Stefan Hajnoczi wrote:
> > On Sat, Dec 09, 2017 at 04:23:17PM +0000, Wang, Wei W wrote:
> > > On Friday, December 8, 2017 4:34 PM, Stefan Hajnoczi wrote:
> > > > On Fri, Dec 8, 2017 at 6:43 AM, Wei Wang <wei.w.wang@intel.com>
> > wrote:
> > > > > On 12/08/2017 07:54 AM, Michael S. Tsirkin wrote:
> > > > >>
> > > > >> On Thu, Dec 07, 2017 at 06:28:19PM +0000, Stefan Hajnoczi wrote:
> > > > >>>
> > > > >>> On Thu, Dec 7, 2017 at 5:38 PM, Michael S. Tsirkin=20
> > > > >>> <mst@redhat.com>
> > > > > Thanks Stefan and Michael for the sharing and discussion. I=20
> > > > > think above 3 and 4 are debatable (e.g. whether it is simpler=20
> > > > > really depends). 1 and 2 are implementations, I think both=20
> > > > > approaches could implement the device that way. We originally=20
> > > > > thought about one device and driver to support all types (called=
=20
> > > > > it transformer sometimes :-) ), that would look interesting from=
=20
> > > > > research point of view, but from real usage point of view, I=20
> > > > > think it would be better to have them separated,
> > > > because:
> > > > > - different device types have different driver logic, mixing=20
> > > > > them together would cause the driver to look messy. Imagine that=
=20
> > > > > a networking driver developer has to go over the block related=20
> > > > > code to debug, that also increases the difficulty.
> > > >
> > > > I'm not sure I understand where things get messy because:
> > > > 1. The vhost-pci device implementation in QEMU relays messages but=
=20
> > > > has no device logic, so device-specific messages like=20
> > > > VHOST_USER_NET_SET_MTU are trivial at this layer.
> > > > 2. vhost-user slaves only handle certain vhost-user protocol messag=
es.
> > > > They handle device-specific messages for their device type only.
> > > > This is like vhost drivers today where the ioctl() function=20
> > > > returns an error if the ioctl is not supported by the device.  It's=
 not messy.
> > > >
> > > > Where are you worried about messy driver logic?
> > >
> > > Probably I didn=E2=80=99t explain well, please let me summarize my th=
ought a=20
> > > little
> > bit, from the perspective of the control path and data path.
> > >
> > > Control path: the vhost-user messages - I would prefer just have the=
=20
> > > interaction between QEMUs, instead of relaying to the GuestSlave,=20
> > > because
> > > 1) I think the claimed advantage (easier to debug and develop)=20
> > > doesn=E2=80=99t seem very convincing
> >=20
> > You are defining a mapping from the vhost-user protocol to a custom=20
> > virtio device interface.  Every time the vhost-user protocol (feature=
=20
> > bits, messages,
> > etc) is extended it will be necessary to map this new extension to the=
=20
> > virtio device interface.
> >=20
> > That's non-trivial.  Mistakes are possible when designing the mapping.
> > Using the vhost-user protocol as the device interface minimizes the=20
> > effort and risk of mistakes because most messages are relayed 1:1.
> >=20
> > > 2) some messages can be directly answered by QemuSlave , and some
> > messages are not useful to give to the GuestSlave (inside the VM),=20
> > e.g. fds, VhostUserMemoryRegion from SET_MEM_TABLE msg (the device=20
> > first maps the master memory and gives the offset (in terms of the=20
> > bar, i.e., where does it sit in the bar) of the mapped gpa to the=20
> > guest. if we give the raw VhostUserMemoryRegion to the guest, that woul=
dn=E2=80=99t be usable).
> >=20
> > I agree that QEMU has to handle some of messages, but it should still=
=20
> > relay all (possibly modified) messages to the guest.
> >=20
> > The point of using the vhost-user protocol is not just to use a=20
> > familiar binary encoding, it's to match the semantics of vhost-user=20
> > 100%.  That way the vhost-user software stack can work either in host=
=20
> > userspace or with vhost-pci without significant changes.
> >=20
> > Using the vhost-user protocol as the device interface doesn't seem any=
=20
> > harder than defining a completely new virtio device interface.  It has=
=20
> > the advantages that I've pointed out:
> >=20
> > 1. Simple 1:1 mapping for most that is easy to maintain as the
> >    vhost-user protocol grows.
> >=20
> > 2. Compatible with vhost-user so slaves can run in host userspace
> >    or the guest.
> >=20
> > I don't see why it makes sense to define new device interfaces for=20
> > each device type and create a software stack that is incompatible with =
vhost-user.
>=20
>=20
> I think this 1:1 mapping wouldn't be easy:
>=20
> 1) We will have 2 Qemu side slaves to achieve this bidirectional relaying=
, that is, the working model will be=20
> - master to slave: Master->QemuSlave1->GuestSlave; and
> - slave to master: GuestSlave->QemuSlave2->Master
> QemuSlave1 and QemuSlave2 can't be the same piece of code, because QemuSl=
ave1 needs to do some setup with some messages, and QemuSlave2 is more like=
ly to be a true "relayer" (receive and directly pass on)

I mostly agree with this.  Some messages cannot be passed through.  QEMU
needs to process some messages so that makes it both a slave (on the
host) and a master (to the guest).

> 2) poor re-usability of the QemuSlave and GuestSlave
> We couldn=E2=80=99t reuse much of the QemuSlave handling code for GuestSl=
ave.
> For example, for the VHOST_USER_SET_MEM_TABLE msg, all the QemuSlave hand=
ling code (please see the vp_slave_set_mem_table function), won't be used b=
y GuestSlave. On the other hand, GuestSlave needs an implementation to repl=
y back to the QEMU device, and this implementation isn't needed by QemuSlav=
e.
>  If we want to run the same piece of the slave code in both QEMU and gues=
t, then we may need "if (QemuSlave) else" in each msg handling entry to cho=
ose the code path for QemuSlave and GuestSlave separately.
> So, ideally we wish to run (reuse) one slave implementation in both QEMU =
and guest. In practice, we will still need to handle them each case by case=
, which is no different than maintaining two separate slaves for QEMU and g=
uest, and I'm afraid this would be much more complex.

Are you saying QEMU's vhost-pci code cannot be reused by guest slaves?
If so, I agree and it was not my intention to run the same slave code in
QEMU and the guest.

When I referred to reusing the vhost-user software stack I meant
something else:

1. contrib/libvhost-user/ is a vhost-user slave library.  QEMU itself
does not use it but external programs may use it to avoid reimplementing
vhost-user and vrings.  Currently this code handles the vhost-user
protocol over UNIX domain sockets, but it's possible to add vfio
vhost-pci support.  Programs using libvhost-user would be able to take
advantage of vhost-pci easily (no big changes required).

2. DPDK and other codebases that implement custom vhost-user slaves are
also easy to update for vhost-pci since the same protocol is used.  Only
the lowest layer of vhost-user slave code needs to be touched.

Stefan

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaL6wQAAoJEJykq7OBq3PIWIUH/33RPqLc6WO6Tl0d8peEORys
UGZN2r9l2FADgZ2EwD4vQnvjTyz6w7iPKNXw59/abRBI+n1w9lDfzrTl3XOJgpG4
RwpS9+evMHdJ0Qt0V6smXL/jweP0ZZQGutMLtXbkYEJTTlwsW+PkKrCqQxDE1PYw
JybYJ2Ukd+BFQmXaSq7yWmP3VbIjCBBd0RD5dCN0NbKejUrpEBOD3MrHMu7SDSfR
w4Oo5lAgu8rzlri5LeEqtE8OxzZGoQMQjrJ96n+JMs0tKeo7MF1z9jqhTdg0PYI7
6jF5z/yEA2LKQqbD5QeMJ3AXU0up81J0TQmDwgW0RRzVj/f9y3ZNQLz4IR0r1Sg=
=Fhd7
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
