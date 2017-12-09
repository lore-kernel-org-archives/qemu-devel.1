Received: from eggs.gnu.org ([2001:4830:134:3::10]:35577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eNhgF-0007eF-6S
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 11:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eNhgB-0007pB-2r
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 11:08:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:30821)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eNhgA-0007oS-LZ
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 11:08:43 -0500
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Sat, 9 Dec 2017 16:08:34 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73937DFC6@shsmsx102.ccr.corp.intel.com>
References: <5A290398.60508@intel.com>
	<CAJSP0QURjdD8BnOmJo83fzJn_zCijSKQh==Pz+Xu4r6Q2i3SkQ@mail.gmail.com>
	<20171207153454-mutt-send-email-mst@kernel.org>
	<CAJSP0QVu4iwAu01Sth84VZshQde97x3FW1E1ua_YXVKs-65vhQ@mail.gmail.com>
	<20171207183945-mutt-send-email-mst@kernel.org>
	<CAJSP0QVnukGD3Afu9myv=v5OjqrPDpXu6JL3Tpf+Cdk=em9V3w@mail.gmail.com>
	<20171207193003-mutt-send-email-mst@kernel.org>
	<CAJSP0QX4V64OoU4-Dhb93MUZ9Rz0FPR-La5Xq4_yqGH7SG6PjQ@mail.gmail.com>
	<20171207213420-mutt-send-email-mst@kernel.org>
	<CAJSP0QXYMVBidUd5-NJb5FDYbc6wSkNYgdadjk8+NXvwosLMPw@mail.gmail.com>
	<20171208161606-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171208161606-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: "'Michael S. Tsirkin'" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>

On Friday, December 8, 2017 10:28 PM, Michael S. Tsirkin wrote:
> On Fri, Dec 08, 2017 at 06:08:05AM +0000, Stefan Hajnoczi wrote:
> > On Thu, Dec 7, 2017 at 11:54 PM, Michael S. Tsirkin <mst@redhat.com>
> wrote:
> > > On Thu, Dec 07, 2017 at 06:28:19PM +0000, Stefan Hajnoczi wrote:
> > >> On Thu, Dec 7, 2017 at 5:38 PM, Michael S. Tsirkin <mst@redhat.com>
> wrote:
> > >> > On Thu, Dec 07, 2017 at 05:29:14PM +0000, Stefan Hajnoczi wrote:
> > >> >> On Thu, Dec 7, 2017 at 4:47 PM, Michael S. Tsirkin <mst@redhat.co=
m>
> wrote:
> > >> >> > On Thu, Dec 07, 2017 at 04:29:45PM +0000, Stefan Hajnoczi wrote=
:
> > >> >> >> On Thu, Dec 7, 2017 at 2:02 PM, Michael S. Tsirkin
> <mst@redhat.com> wrote:
> > >> >> >> > On Thu, Dec 07, 2017 at 01:08:04PM +0000, Stefan Hajnoczi
> wrote:
> > >> >> >> >> Instead of responding individually to these points, I hope
> > >> >> >> >> this will explain my perspective.  Let me know if you do
> > >> >> >> >> want individual responses, I'm happy to talk more about
> > >> >> >> >> the points above but I think the biggest difference is our
> perspective on this:
> > >> >> >> >>
> > >> >> >> >> Existing vhost-user slave code should be able to run on
> > >> >> >> >> top of vhost-pci.  For example, QEMU's
> > >> >> >> >> contrib/vhost-user-scsi/vhost-user-scsi.c should work
> > >> >> >> >> inside the guest with only minimal changes to the source
> > >> >> >> >> file (i.e. today it explicitly opens a UNIX domain socket
> > >> >> >> >> and that should be done by libvhost-user instead).  It
> > >> >> >> >> shouldn't be hard to add vhost-pci vfio support to
> contrib/libvhost-user/ alongside the existing UNIX domain socket code.
> > >> >> >> >>
> > >> >> >> >> This seems pretty easy to achieve with the vhost-pci PCI
> > >> >> >> >> adapter that I've described but I'm not sure how to
> > >> >> >> >> implement libvhost-user on top of vhost-pci vfio if the
> > >> >> >> >> device doesn't expose the vhost-user protocol.
> > >> >> >> >>
> > >> >> >> >> I think this is a really important goal.  Let's use a
> > >> >> >> >> single vhost-user software stack instead of creating a
> > >> >> >> >> separate one for guest code only.
> > >> >> >> >>
> > >> >> >> >> Do you agree that the vhost-user software stack should be
> > >> >> >> >> shared between host userspace and guest code as much as
> possible?
> > >> >> >> >
> > >> >> >> >
> > >> >> >> >
> > >> >> >> > The sharing you propose is not necessarily practical
> > >> >> >> > because the security goals of the two are different.
> > >> >> >> >
> > >> >> >> > It seems that the best motivation presentation is still the
> > >> >> >> > original rfc
> > >> >> >> >
> > >> >> >> > http://virtualization.linux-foundation.narkive.com/A7FkzAgp
> > >> >> >> > /rfc-vhost-user-enhancements-for-vm2vm-communication
> > >> >> >> >
> > >> >> >> > So comparing with vhost-user iotlb handling is different:
> > >> >> >> >
> > >> >> >> > With vhost-user guest trusts the vhost-user backend on the h=
ost.
> > >> >> >> >
> > >> >> >> > With vhost-pci we can strive to limit the trust to qemu only=
.
> > >> >> >> > The switch running within a VM does not have to be trusted.
> > >> >> >>
> > >> >> >> Can you give a concrete example?
> > >> >> >>
> > >> >> >> I have an idea about what you're saying but it may be wrong:
> > >> >> >>
> > >> >> >> Today the iotlb mechanism in vhost-user does not actually
> > >> >> >> enforce memory permissions.  The vhost-user slave has full
> > >> >> >> access to mmapped memory regions even when iotlb is enabled.
> > >> >> >> Currently the iotlb just adds an indirection layer but no
> > >> >> >> real security.  (Is this correct?)
> > >> >> >
> > >> >> > Not exactly. iotlb protects against malicious drivers within gu=
est.
> > >> >> > But yes, not against a vhost-user driver on the host.
> > >> >> >
> > >> >> >> Are you saying the vhost-pci device code in QEMU should
> > >> >> >> enforce iotlb permissions so the vhost-user slave guest only
> > >> >> >> has access to memory regions that are allowed by the iotlb?
> > >> >> >
> > >> >> > Yes.
> > >> >>
> > >> >> Okay, thanks for confirming.
> > >> >>
> > >> >> This can be supported by the approach I've described.  The
> > >> >> vhost-pci QEMU code has control over the BAR memory so it can
> > >> >> prevent the guest from accessing regions that are not allowed by =
the
> iotlb.
> > >> >>
> > >> >> Inside the guest the vhost-user slave still has the memory
> > >> >> region descriptions and sends iotlb messages.  This is
> > >> >> completely compatible with the libvirt-user APIs and existing
> > >> >> vhost-user slave code can run fine.  The only unique thing is
> > >> >> that guest accesses to memory regions not allowed by the iotlb do
> not work because QEMU has prevented it.
> > >> >
> > >> > I don't think this can work since suddenly you need to map full
> > >> > IOMMU address space into BAR.
> > >>
> > >> The BAR covers all guest RAM
> > >> but QEMU can set up MemoryRegions that hide parts from the guest
> > >> (e.g. reads produce 0xff).  I'm not sure how expensive that is but
> > >> implementing a strict IOMMU is hard to do without performance
> > >> overhead.
> > >
> > > I'm worried about leaking PAs.
> > > fundamentally if you want proper protection you need your device
> > > driver to use VA for addressing,
> > >
> > > On the one hand BAR only needs to be as large as guest PA then.
> > > On the other hand it must cover all of guest PA, not just what is
> > > accessible to the device.
> >
> > A more heavyweight iotlb implementation in QEMU's vhost-pci device
> > could present only VAs to the vhost-pci driver.  It would use
> > MemoryRegions to map pieces of shared guest memory dynamically.  The
> > only information leak would be the overall guest RAM size because we
> > still need to set the correct BAR size.
>=20
> I'm not sure this will work. KVM simply
> isn't designed with a huge number of fragmented regions in mind.
>=20
> Wei, just what is the plan for the IOMMU? How will all virtual addresses =
fit
> in a BAR?
>=20
> Maybe we really do want a non-translating IOMMU (leaking PA to userspace
> but oh well)?


Yes, I have 2 ways of implementation in mind. Basically, I think we will le=
verage the slave side EPT to provide the accessible master memory to the sl=
ave guest. Before getting into that, please let me introduce some backgroun=
d first: here, VM1 is the slave VM, and VM2 is the master VM

The VM2's memory, which is exposed to the vhost-pci driver, does not have t=
o be mapped and added to the bar MemoryRegion when the device is plugged to=
 VM1. They can be added later even after the driver does ioremap of the bar=
.  Here is what this patch series has done:

i. when VM1 boots, the bar MemoryRegion is initialized, and registered via =
pci_register_bar (in the vpnet_pci_realize function), the bar MemoryRegion =
is like a "skeleton" without any real memory added to it, except the 4KB me=
tadata memory which is added to the top of bar MemoryRegion (in vpnet_devic=
e_realize)

ii. when the vhost-pci driver probes, it does ioremap(bar, 64GB), which set=
s up the guest kernel mapping of the 64GB bar, but till now only the top 4K=
B memory has qva->gpa mapping,  which will be referenced to create the EPT =
mapping when accessed.

iii. when VM2 boots, the vhost-user master sends the VM2's memory info to V=
M1, then those memory are mapped by QEMU1 and updated to the vhost-pci bar =
MemoryRegion(in the vp_slave_set_mem_table function). After this, VM2's mem=
ory can appear in VM1's EPT when accessed.



With the above understanding, here are the 2 possible options (which are si=
milar actually) of IOMMU support:
Option1:=20
1) In the above phase iii., when QEMU1 receives the memory info, it does no=
t map and expose the entire memory to the guest, instead, it just stores th=
e memory info there, e.g., info1 (fd1, base1, len1), info2 (fd2, base2, len=
2), info3(fd3, base3, len3) etc.
=20
2) When VM2's virtio-net driver wants to set up dma remapping table entries=
, the dma_map_page function will trap to QEMU2 with iova and gpa (is this c=
orrect? I'll double checked this part)

3) then QEMU2 sends an IOTLB_MSG(iova1, gpa1, size1) to QEMU1 -  iova and u=
addr seem not useful for vhost-pci, so maybe we will need to use gpa instea=
d of uaddr

4) When QEMU1 receives the msg, it compares gpa1 with the memory info, for =
example, it may find base1 < gpa1 < base1+len1, and offset1=3Dgpa1-base1, t=
hen do mmap(.., size1, fd1, offset1), and add the sub MemoryRegion (gpa1, s=
ize1) to the bar memory region, which will finally get the memory added to =
ept.

Option 2:
Similar to Option1, but in 1), QEMU1 can map and exposes the entire memory =
to the guest as non-accessible (instead of not mapping), and changes that p=
ieces of memory (from IOTLB_MSG) to accessible in 4)


Best,
Wei
