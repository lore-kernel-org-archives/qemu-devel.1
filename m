Received: from eggs.gnu.org ([2001:4830:134:3::10]:50152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1etAdy-0002oP-LF
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:20:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1etAdv-00021X-De
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:20:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:63952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1etAdv-000212-34
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:20:27 -0500
Date: Tue, 6 Mar 2018 19:03:37 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20180306110337.GC3158@sky-dev>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-9-git-send-email-yi.l.liu@linux.intel.com>
	<f9ee648a-ff93-b57a-4b05-6bd0f40c15bf@redhat.com>
	<20180305084207.GE2482@sky-dev>
	<2160f478-2c8a-8fbe-1df8-78c1984cf375@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2160f478-2c8a-8fbe-1df8-78c1984cf375@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 08/12] hw/pci: introduce
 pci_device_notify_iommu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, david@gibson.dropbear.id.au

On Tue, Mar 06, 2018 at 11:18:43AM +0100, Paolo Bonzini wrote:
> On 05/03/2018 09:42, Liu, Yi L wrote:
> >> In general I think it's better to change your names from "assigned_dev"
> >> to "sva_dev", because the point of the list is to only iterate over
> >> devices that might be interested in using SVA.
> >
> > For "assigned_dev", my purpose is to distinguish "assigned devices" from
> > emulated devices. Only the SVA usage on "assigned devices" is cared here.
> > But it is true only SVA capable device is interested. So I may need to
> > rename it as "assigned_sva_dev". How about your opinion?
> 
> What you care about is not whether the device assigned, but rather
> whether it called or not pci_setup_sva_ops.  Currently only VFIO does
> this, but that's not a requirement.  Hence my suggestion of calling it
> sva_dev.

Yes, only VFIO calls pci_setup_sva_ops so far, but it should not limited to.
I'll apply in next version.

Thanks,
Yi Liu
