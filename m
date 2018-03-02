Received: from eggs.gnu.org ([2001:4830:134:3::10]:52798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermIv-0003OA-KJ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:09:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermIq-0007xW-Kn
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:09:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40558 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ermIq-0007x1-FT
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:08:56 -0500
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-10-git-send-email-yi.l.liu@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <866c7e97-26c7-334c-634b-ecf10c8e0efb@redhat.com>
Date: Fri, 2 Mar 2018 16:08:47 +0100
MIME-Version: 1.0
In-Reply-To: <1519900415-30314-10-git-send-email-yi.l.liu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 09/12] intel_iommu: record assigned
 devices in a list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com

On 01/03/2018 11:33, Liu, Yi L wrote:
>  
> +struct IntelIOMMUAssignedDeviceNode {
> +    VTDAddressSpace *vtd_as;
> +    QLIST_ENTRY(IntelIOMMUAssignedDeviceNode) next;
> +};
> +

This QLIST_ENTRY can also be placed directly in VTDAddressSpace (e.g.
next_assigned_dev), so that the notify function can simply do a
QLIST_REMOVE when an assigned device is hot-unplugged.

Does the notify_func need an "unbind from PASID address space" step,
that does the opposite of vtd_bind_device_to_pasid_as?

Paolo
