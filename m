Received: from eggs.gnu.org ([2001:4830:134:3::10]:33896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jacob.jun.pan@intel.com>) id 1dXwpL-0000nT-NI
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 17:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jacob.jun.pan@intel.com>) id 1dXwpH-0002yn-R1
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 17:48:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:36289)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jacob.jun.pan@intel.com>)
	id 1dXwpH-0002xC-ER
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 17:48:11 -0400
Date: Wed, 19 Jul 2017 14:50:00 -0700
From: Jacob Pan <jacob.jun.pan@intel.com>
Message-ID: <20170719145000.672e8995@jacob-builder>
In-Reply-To: <20170719104543.GA3194@sky-dev>
References: <20170702100659.GA22053@gmail.com>
	<0e4f2dd4-d553-b1b7-7bec-fe0ff5242c54@arm.com>
	<20170703103115.GB22053@gmail.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D25919@SHSMSX101.ccr.corp.intel.com>
	<1d63c1ae-ca10-0f9d-91de-0d9c9823c104@arm.com>
	<20170705112816.56554f65@w520.home>
	<A2975661238FB949B60364EF0F2C2574390A7C4F@shsmsx102.ccr.corp.intel.com>
	<20170714121555.7e64d849@w520.home>
	<A2975661238FB949B60364EF0F2C2574390A906A@shsmsx102.ccr.corp.intel.com>
	<20170717164515.2491b3bf@w520.home> <20170719104543.GA3194@sky-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 7/8] VFIO: Add new IOCTL for IOMMU TLB
 invalidate propagation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Will Deacon <Will.Deacon@arm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peterx@redhat.com" <peterx@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, jacob.jun.pan@intel.com

On Wed, 19 Jul 2017 18:45:43 +0800
"Liu, Yi L" <yi.l.liu@linux.intel.com> wrote:

> On Mon, Jul 17, 2017 at 04:45:15PM -0600, Alex Williamson wrote:
> > On Mon, 17 Jul 2017 10:58:41 +0000
> > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> >   
> > > Hi Alex,
> > > 
> > > Pls refer to the response inline.
> > >   
> > > > -----Original Message-----
> > > > From: kvm-owner@vger.kernel.org
> > > > [mailto:kvm-owner@vger.kernel.org] On Behalf Of Alex Williamson
> > > > Sent: Saturday, July 15, 2017 2:16 AM
> > > > To: Liu, Yi L <yi.l.liu@intel.com>
> > > > Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>;
> > > > Tian, Kevin <kevin.tian@intel.com>; Liu, Yi L
> > > > <yi.l.liu@linux.intel.com>; Lan, Tianyu <tianyu.lan@intel.com>;
> > > > Raj, Ashok <ashok.raj@intel.com>; kvm@vger.kernel.org;
> > > > jasowang@redhat.com; Will Deacon <Will.Deacon@arm.com>;
> > > > peterx@redhat.com; qemu-devel@nongnu.org;
> > > > iommu@lists.linux-foundation.org; Pan, Jacob jun
> > > > <jacob.jun.pan@intel.com>; Joerg Roedel <joro@8bytes.org>
> > > > Subject: Re: [Qemu-devel] [RFC PATCH 7/8] VFIO: Add new IOCTL
> > > > for IOMMU TLB invalidate propagation
> > > > 
> > > > On Fri, 14 Jul 2017 08:58:02 +0000
> > > > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> > > >     
> > > > > Hi Alex,
> > > > >
> > > > > Against to the opaque open, I'd like to propose the following
> > > > > definition based on the existing comments. Pls note that I've
> > > > > merged the pasid table binding and iommu tlb invalidation
> > > > > into a single IOCTL and make different flags to indicate the
> > > > > iommu operations. Per Kevin's comments, there may be iommu
> > > > > invalidation for guest IOVA tlb, so I renamed the IOCTL and
> > > > > data structure to be non-svm specific. Pls kindly have a
> > > > > review, so that we can make the opaque open closed and move
> > > > > forward. Surely, comments and ideas are welcomed. And for the
> > > > > scope and flags definition in struct iommu_tlb_invalidate,
> > > > > it's also welcomed to    
> > > > give your ideas on it.    
> > > > >
> > > > > 1. Add a VFIO IOCTL for iommu operations from user-space
> > > > >
> > > > > #define VFIO_IOMMU_OP_IOCTL _IO(VFIO_TYPE, VFIO_BASE + 24)
> > > > >
> > > > > Corresponding data structure:
> > > > > struct vfio_iommu_operation_info {
> > > > > 	__u32	argsz;
> > > > > #define VFIO_IOMMU_BIND_PASIDTBL	(1 << 0) /* Bind
> > > > > PASID Table */ #define VFIO_IOMMU_BIND_PASID	(1 <<
> > > > > 1) /* Bind PASID from userspace    
> > > > driver*/    
> > > > > #define VFIO_IOMMU_BIND_PGTABLE	(1 << 2) /* Bind guest
> > > > > mmu page table */ #define VFIO_IOMMU_INVAL_IOTLB	(1 <<
> > > > > 3) /* Invalidate iommu tlb */ __u32	flag;
> > > > > 	__u32	length; // length of the data[] part in
> > > > > byte __u8	data[]; // stores the data for iommu op
> > > > > indicated by flag field };    
> > > > 
> > > > If we're doing a generic "Ops" ioctl, then we should have an
> > > > "op" field which is defined by an enum.  It doesn't make sense
> > > > to use flags for this, for example can we set multiple flag
> > > > bits?  If not then it's not a good use for a bit field.  I'm
> > > > also not sure I understand the value of the "length" field,
> > > > can't it always be calculated from argsz?    
> > > 
> > > Agreed, enum would be better. "length" field could be calculated
> > > from argsz. I used it just to avoid offset calculations. May
> > > remove it. 
> > > > > For iommu tlb invalidation from userspace, the "__u8 data[]"
> > > > > stores data which would be parsed by the "struct
> > > > > iommu_tlb_invalidate" defined below.
> > > > >
> > > > > 2. Definitions in include/uapi/linux/iommu.h(newly added
> > > > > header file)
> > > > >
> > > > > /* IOMMU model definition for iommu operations from userspace
> > > > > */ enum iommu_model {
> > > > > 	INTLE_IOMMU,
> > > > > 	ARM_SMMU,
> > > > > 	AMD_IOMMU,
> > > > > 	SPAPR_IOMMU,
> > > > > 	S390_IOMMU,
> > > > > };
> > > > >
> > > > > struct iommu_tlb_invalidate {
> > > > > 	__u32	scope;
> > > > > /* pasid-selective invalidation described by @pasid */
> > > > > #define IOMMU_INVALIDATE_PASID	(1 << 0)
> > > > > /* address-selevtive invalidation described by (@vaddr,
> > > > > @size) */ #define IOMMU_INVALIDATE_VADDR	(1 << 1)    
> > > > 
> > > > Again, is a bit field appropriate here, can a user set both
> > > > bits?    
> > > 
> > > yes, user may set both bits. It would be invalidate address range
> > > which is tagged with a PASID value.
> > >   
> > > >     
> > > > > 	__u32	flags;
> > > > > /*  targets non-pasid mappings, @pasid is not valid */
> > > > > #define IOMMU_INVALIDATE_NO_PASID	(1 << 0)
> > > > > /* indicating that the pIOMMU doesn't need to invalidate
> > > > > 	all intermediate tables cached as part of the PTE for
> > > > > 	vaddr, only the last-level entry (pte). This is a
> > > > > hint. */ #define IOMMU_INVALIDATE_VADDR_LEAF	(1 <<
> > > > > 1)    
> > > > 
> > > > Are we venturing into vendor specific attributes here?    
> > > 
> > > These two attributes are still in discussion. Jean and me synced
> > > several rounds. But lack of comments from other vendors.
> > > 
> > > Personally, I think both should be generic.
> > > IOMMU_INVALIDATE_NO_PASID is to indicate no PASID used
> > > for the invalidation. IOMMU_INVALIDATE_VADDR_LEAF indicates
> > > only invalidate leaf mappings. 
> > > I would see if other vendor is object on it. If yes, I'm fine to
> > > move it to vendor specific part.
> > >    
> > > >     
> > > > > 	__u32	pasid;
> > > > > 	__u64	vaddr;
> > > > > 	__u64	size;
> > > > > 	enum iommu_model model;    
> > > > 
> > > > How does a user learn which model(s) are supported by the
> > > > interface? How do they learn which ops are supported?  Perhaps
> > > > a good use for one of those flag bits in the outer data
> > > > structure is "probe".    
> > > 
> > > My initial plan to user fills it, if the underlying HW doesn't
> > > support the model, it refuses to service it. User should get a
> > > failure and stop to use it. But your suggestion to have a probe
> > > or kinds of query makes sense. How about we add one more
> > > operation for such purpose? Besides the supported model query,
> > > I'd like to add more. E.g the HW IOMMU capabilities.  
> > 
> > We also have VFIO_IOMMU_GET_INFO where the structure can be extended
> > for missing capabilities.  Depending on the capability you want to
> > describe, this might be a better, existing interface for it.
> >    
> > > > > 	/*
> > > > > 	 Vendor may have different HW version and thus the
> > > > > 	 data part of this structure differs, use sub_version
> > > > > 	 to indicate such difference.
> > > > > 	 */
> > > > > 	__u322 sub_version;    
> > > > 
> > > > Not sure I see the value of this vs creating an INTEL_IOMMUv2
> > > > entry in the model enum.    
> > > 
> > > Both are fine to me. Just see the opinions from other guys.
> > >   
> > > > > 	__u64 length; // length of the data[] part in byte    
> > > > 
> > > > Questionably useful vs calculating from argsz again , but it
> > > > certainly doesn't need to be a qword :-o    
> > > 
> > > Thx for the remind. 32bits would be enough. It is surely to get
> > > it from argsz. However, I would like to leave it here. Reason is:
> > > argsz is in vfio layer, the "length" here is actually used in
> > > vendor-specific iommu driver layer. So would require vfio to pass
> > > argsz or the size of " struct iommu_tlb_invalidate" to
> > > vendor-specific iommu driver layer by means of parameter or so.
> > > Personally, I prefer to pass it in the structure. If it's better
> > > to pass it as a parameter, I would do it.  
> > 
> > Ok, then the layer that does the copy_from_user will need to
> > validate that length is fully contained within the copied data
> > structure, we can't let the user trick the kernel into using kernel
> > memory for this.  
> 
> VFIO is still the layer which copy_from_user. would check the length.
> 
> >   
> > > > > 	__u8	data[];
> > > > > };
> > > > >
> > > > > For Intel, the data structue is:
> > > > > struct intel_iommu_invalidate_data {
> > > > > 	__u64 low;
> > > > > 	__u64 high;
> > > > > }    
> > > > 
> > > > high/low what?  This is a pretty weak uapi definition.
> > > > Thanks,    
> > > 
> > > For this part, for Intel platform, we plan to pass a 128 bit data
> > > for the invalidation. The structure varies from invalidation type
> > > to type. Here is my thought on it. Define an 128 bits union. List
> > > the invalidation data details for each invalidation type. What's
> > > your opinion on it? So far, we have 7 types for invalidation. The
> > > prq response is not included.  
> > 
> > I want this interface to be fully defined, but at the same time I
> > don't necessarily want to create useless data structures.  I
> > believe the intention here is to pass these directly through to a
> > QI entry, where  
> 
> yes, it's a QI entry from guest.
> 
> > we must match a hardware definition.  I'm tempted to suggest
> > referencing the hardware specification, but see below...
> > 
> > A concern for this model is that hardware may trust the iommu driver
> > not to create QI entries that don't set reserved bits or set invalid
> > field data.  If it does those kinds of things, it's a kernel driver
> > bug.  Once exposed to the user, we cannot guarantee that.  Does
> > Intel have confidence that a user cannot maliciously interfere with
> > other contexts or the general operation of the invalidation queue
> > if a user is effectively given direct access?  Will the
> > invalidation data be sanitized by the iommu driver?
> >    
> > > union intel_iommu_invalidate_data {
> > >  	struct {
> > > 		__u64 low;
> > >  		__u64 high;
> > > 	} invalidate_data;
> > > 
> > > 	struct {
> > > 		__u64 type: 4;
> > > 		__u64 gran: 2;
> > > 		__u64 rsv1: 10;
> > > 		__u64 did: 16;
> > > 		__u64 sid: 16;
> > > 		__u64 func_mask: 2;
> > > 		__u64 rsv2: 14;
> > > 		__64 rsv3: 64;
> > > 	} context_cache_inv;
> > > 	....  
> > 
> > Here's part of the issue with not fully defining these, we have did,
> > sid, and func_mask.  I think we're claiming that the benefit of
> > passing through the hardware data structure is performance, but the
> > user needs to replace these IDs to match the physical device rather
> > than the virtual device, perhaps even entirely recreating it
> > because there's not necessarily a 1:1 mapping of things like
> > func_mask between virtual and physical hardware topologies
> > (assuming I'm interpreting these fields correctly).  Doesn't the
> > kernel also need to validate any such field to prevent the user
> > spoofing entries for other devices?  Is there any actual
> > performance benefit remaining vs defining a generic interface after
> > multiple levels have manipulated, recreated, and sanitized these
> > structures?  We can't evaluate these sorts of risks if we don't
> > define what we're passing through.  Thanks, 
> 
> A potential proposal is to abstract the fields of the QI entry.
> However, here is a concern for it. Different type of QI entry would
> have diferent fields. It means we need to have a hyper set to include
> all the possible fields. Supposedly, the set would increase as more
> QI type is introduced. I'm not sure if it is an acceptable definition.
> 
> Based on the latest spec, the vendor-specific fields may have:
> 
> Global hint
> Drain read/write
> Source-ID
> MIP
> PFSID
> 
My thinking was that as long as the risk of having some opaque data is
limited to the device that is already exposed to the user space, it
should be fine. We have model specific IOMMU driver to sanitize the
data before putting the descriptor into hardware.

But I agree the overhead of disassemble/assemble may not be
significant. Though with vIOMMU and caching mode = 1 (requires
explicit invalidation of caches regardless present or not, VT-d spec
6.1), we will see more invalidation than the native pIOMMU case.

Anyway, we can do some micro benchmark to see the overhead.

> PRQ response is another topic. Not included here.
> 
> Thanks,
> Yi L
> 

[Jacob Pan]
