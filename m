Received: from eggs.gnu.org ([2001:4830:134:3::10]:39215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1et9gR-000837-Lp
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:19:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1et9gO-0007rD-Is
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:18:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51822 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1et9gO-0007qG-EU
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:18:56 -0500
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-9-git-send-email-yi.l.liu@linux.intel.com>
	<f9ee648a-ff93-b57a-4b05-6bd0f40c15bf@redhat.com>
	<20180305084207.GE2482@sky-dev>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2160f478-2c8a-8fbe-1df8-78c1984cf375@redhat.com>
Date: Tue, 6 Mar 2018 11:18:43 +0100
MIME-Version: 1.0
In-Reply-To: <20180305084207.GE2482@sky-dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com

On 05/03/2018 09:42, Liu, Yi L wrote:
>> In general I think it's better to change your names from "assigned_dev"
>> to "sva_dev", because the point of the list is to only iterate over
>> devices that might be interested in using SVA.
>
> For "assigned_dev", my purpose is to distinguish "assigned devices" from
> emulated devices. Only the SVA usage on "assigned devices" is cared here.
> But it is true only SVA capable device is interested. So I may need to
> rename it as "assigned_sva_dev". How about your opinion?

What you care about is not whether the device assigned, but rather
whether it called or not pci_setup_sva_ops.  Currently only VFIO does
this, but that's not a requirement.  Hence my suggestion of calling it
sva_dev.

Paolo
