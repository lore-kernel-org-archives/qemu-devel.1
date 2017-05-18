Received: from eggs.gnu.org ([2001:4830:134:3::10]:60548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dBJZI-0002fg-KP
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dBJZD-0005YD-So
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:26:08 -0400
Received: from foss.arm.com ([217.140.101.70]:37844)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dBJZD-0005Xg-GG
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:26:03 -0400
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-6-git-send-email-yi.l.liu@intel.com>
	<20170512155851.627409ed@t450s.home> <20170517102759.GF22110@gmail.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <d75f198a-8589-a9d7-cc48-9b92c3d5e3b7@arm.com>
Date: Thu, 18 May 2017 12:29:27 +0100
MIME-Version: 1.0
In-Reply-To: <20170517102759.GF22110@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 5/8] VFIO: Add new IOTCL for PASID
 Table bind propagation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, tianyu.lan@intel.com, kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org, jasowang@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com

On 17/05/17 11:27, Liu, Yi L wrote:
> On Fri, May 12, 2017 at 03:58:51PM -0600, Alex Williamson wrote:
>> On Wed, 26 Apr 2017 18:12:02 +0800
>> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
>>>  
>>> +/* IOCTL for Shared Virtual Memory Bind */
>>> +struct vfio_device_svm {
>>> +	__u32	argsz;
>>> +#define VFIO_SVM_BIND_PASIDTBL	(1 << 0) /* Bind PASID Table */
>>> +#define VFIO_SVM_BIND_PASID	(1 << 1) /* Bind PASID from userspace driver */
>>> +#define VFIO_SVM_BIND_PGTABLE	(1 << 2) /* Bind guest mmu page table */
>>> +	__u32	flags;
>>> +	__u32	length;
>>> +	__u8	data[];
>>
>> In the case of VFIO_SVM_BIND_PASIDTBL this is clearly struct
>> pasid_table_info?  So at a minimum this is a union including struct
>> pasid_table_info.  Furthermore how does a user learn what the opaque
>> data in struct pasid_table_info is without looking at the code?  A user
>> API needs to be clear and documented, not opaque and variable.  We
>> should also have references to the hardware spec for an Intel or ARM
>> PASID table in uapi.  flags should be defined as they're used, let's
>> not reserve them with the expectation of future use.
>>
> 
> Agree. would add description accordingly. For the flags, I would remove
> the last two as I wouldn't use. I think Jean would add them in his/her
> patchset. Anyhow, one of us need to do merge on the flags.

Yes, I can add the VFIO_SVM_BIND_PASID (or rather _TASK) flag as (1 << 1)
in my series if it helps the merge. The PGTABLE flag is for another series
which I don't plan to send out anytime soon, since there already is enough
pending work on this.

Thanks,
Jean
