Received: from eggs.gnu.org ([209.51.188.92]:38091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hBVpH-0003fd-6H
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 22:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hBVpF-0006ga-Hs
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 22:40:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hBVpF-0006dg-2T
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 22:40:29 -0400
Date: Wed, 3 Apr 2019 10:40:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190403024018.GK11008@xz-x1>
References: <20190327064143.GP9149@xz-x1>
	<060498b58287775ce6bd7dd704f13b6d6e185f91.camel@oracle.com>
	<20190327084255.GR9149@xz-x1>
	<AM6PR05MB6616E9FDE038EA2B0665DD9CBD540@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190401024710.GB8853@xz-x1>
	<AM6PR05MB6616E9F5EE3B3B531266B73DBD550@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190401102515.GD8853@xz-x1>
	<AM6PR05MB6616E41924ADEC1CFC6053BFBD550@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<c89218b50e3b015edc4d7f9490138929a97b8268.camel@oracle.com>
	<AM6PR05MB6616081C90DBA9C552B847BEBD560@AM6PR05MB6616.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR05MB6616081C90DBA9C552B847BEBD560@AM6PR05MB6616.eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU and vIOMMU support for emulated VF
 passthrough to nested (L2) VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Elijah Shakkour <elijahsh@mellanox.com>
Cc: Knut Omang <knut.omang@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, Apr 02, 2019 at 03:41:10PM +0000, Elijah Shakkour wrote:
>=20
>=20
> > -----Original Message-----
> > From: Knut Omang <knut.omang@oracle.com>
> > Sent: Monday, April 1, 2019 5:24 PM
> > To: Elijah Shakkour <elijahsh@mellanox.com>; Peter Xu
> > <peterx@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>; Alex Williamson
> > <alex.williamson@redhat.com>; Marcel Apfelbaum
> > <marcel.apfelbaum@gmail.com>; Stefan Hajnoczi <stefanha@gmail.com>;
> > qemu-devel@nongnu.org
> > Subject: Re: QEMU and vIOMMU support for emulated VF passthrough to
> > nested (L2) VM
> >=20
> > On Mon, 2019-04-01 at 14:01 +0000, Elijah Shakkour wrote:
> > >
> > > > -----Original Message-----
> > > > From: Peter Xu <peterx@redhat.com>
> > > > Sent: Monday, April 1, 2019 1:25 PM
> > > > To: Elijah Shakkour <elijahsh@mellanox.com>
> > > > Cc: Knut Omang <knut.omang@oracle.com>; Michael S. Tsirkin
> > > > <mst@redhat.com>; Alex Williamson <alex.williamson@redhat.com>;
> > > > Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Stefan Hajnoczi
> > > > <stefanha@gmail.com>; qemu-devel@nongnu.org
> > > > Subject: Re: QEMU and vIOMMU support for emulated VF passthrough
> > to
> > > > nested (L2) VM
> > > >
> > > > On Mon, Apr 01, 2019 at 09:12:38AM +0000, Elijah Shakkour wrote:
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Peter Xu <peterx@redhat.com>
> > > > > > Sent: Monday, April 1, 2019 5:47 AM
> > > > > > To: Elijah Shakkour <elijahsh@mellanox.com>
> > > > > > Cc: Knut Omang <knut.omang@oracle.com>; Michael S. Tsirkin
> > > > > > <mst@redhat.com>; Alex Williamson <alex.williamson@redhat.com=
>;
> > > > > > Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Stefan Hajnocz=
i
> > > > > > <stefanha@gmail.com>; qemu-devel@nongnu.org
> > > > > > Subject: Re: QEMU and vIOMMU support for emulated VF
> > passthrough
> > > > to
> > > > > > nested (L2) VM
> > > > > >
> > > > > > On Sun, Mar 31, 2019 at 11:15:00AM +0000, Elijah Shakkour wro=
te:
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > I didn't have DMA nor MMIO read/write working with my old
> > > > > > > command
> > > > > > line.
> > > > > > > But, when I removed all CPU flags and only provided "-cpu
> > > > > > > host", I see that
> > > > > > MMIO works.
> > > > > > > Still, DMA read/write from emulated device doesn't work for=
 VF.
> > > > > > > For
> > > > > > example:
> > > > > > > Driver provides me a buffer pointer through MMIO write, thi=
s
> > > > > > > address
> > > > > > (pointer) is GPA of L2, and when I try to call pci_dma_read()
> > > > > > with this address I get:
> > > > > > > "
> > > > > > > Unassigned mem read 0000000000000000 "
> > > > > >
> > > > > > I don't know where this error log was dumped but if it's duri=
ng
> > > > > > DMA then I agree it can probably be related to vIOMMU.
> > > > > >
> > > > >
> > > > > This log is dumped from:
> > > > > memory.c: unassigned_mem_read()
> > > > >
> > > > > > > As I said, my problem now is in translation of L2 GPA provi=
ded
> > > > > > > by driver,
> > > > > > when I call DMA read/write for this address from VF.
> > > > > > > Any insights?
> > > > > >
> > > > > > I just noticed that you were using QEMU 2.12 [1].  If that's =
the
> > > > > > case, please rebase to the latest QEMU, at least >=3D3.0 beca=
use
> > > > > > there's major refactor of the shadow logic during 3.0 devel c=
ycle
> > AFAICT.
> > > > > >
> > > > >
> > > > > Rebased to QEMU 3.1
> > > > > Now I see the address I'm trying to read from in log but still =
same error:
> > > > > "
> > > > > Unassigned mem read 00000000f0481000 "
> > > > > What do you suggest?
> > > >
> > > > Would you please answer the questions that Knut asked?  Is it
> > > > working for L1 guest?  How about PF?
> > >
> > > Both VF and PF are working for L1 guest.
> > > I don't know how to passthrough PF to nested VM in hyper-v.
> >=20
> > On Linux passing through VFs and PFs are the same.
> > Maybe you can try passthrough with all Linux first? (first PF then VF=
) ?
> >=20
> > > I don't invoke VF manually in hyper-v and pass it through to nested
> > > VM. I use hyper-v manager to configure and provide a VF for nested =
VM
> > > (I can see the VF only in the nested VM).
> > >
> > > Did someone try to run emulated device in linux RH as nested L2 whe=
re
> > > L1 is windows hyper-v? Does DMA read/write work for this emulated
> > device in this case?
> >=20
> > I have never tried that, I have only used Linux as L2, Windows might =
be
> > pickier about what it expects, so starting with Linux to rule that ou=
t is
> > probably a good idea.
>=20
> Will move to this solution after I/we give up =F0=9F=98=8A
>=20
> >=20
> > > >
> > > > You can also try to enable VT-d device log by appending:
> > > >
> > > >   -trace enable=3D"vtd_*"
> > > >
> > > > In case it dumps anything useful for you.
>=20
> Here is the relevant dump (dev 01:00.01 is my VF):
> "
> vtd_inv_desc_cc_device context invalidate device 01:00.01
> vtd_ce_not_present Context entry bus 1 devfn 1 not present
> vtd_switch_address_space Device 01:00.1 switching address space (iommu =
enabled=3D1)
> vtd_ce_not_present Context entry bus 1 devfn 1 not present
> vtd_err Detected invalid context entry when trying to sync shadow page =
table

These lines mean that the guest sent a device invalidation to your VF
but the IOMMU found that the device context entry is missing.

> vtd_iotlb_cc_update IOTLB context update bus 0x1 devfn 0x1 high 0x102 l=
ow 0x2d007003 gen 0 -> gen 2
> vtd_err_dmar_slpte_resv_error iova 0xf08e7000 level 2 slpte 0x2a54008f7

This line should not exist in latest QEMU.  Are you sure you're using
the latest QEMU?

I agree with Knut that I would suggest you to use use Linux in both
host and guests first to triage the issue.

Regards,

--=20
Peter Xu
