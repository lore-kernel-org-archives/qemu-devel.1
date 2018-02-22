Received: from eggs.gnu.org ([2001:4830:134:3::10]:47088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1eojoE-00052u-Uv
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 00:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1eojoA-0002K7-Ah
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 00:52:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1eojoA-0002JG-2W
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 00:52:42 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1M5ojmJ059920
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 00:52:39 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g9kd10y4d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 00:52:39 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Thu, 22 Feb 2018 05:52:37 -0000
Date: Thu, 22 Feb 2018 11:22:29 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1519022574-6817-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1519022574-6817-2-git-send-email-bharata@linux.vnet.ibm.com>
	<20180220153510.27451354@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220153510.27451354@redhat.com>
Message-Id: <20180222055229.GC30038@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v0 1/2] pc-dimm: Make
 pc_dimm_built_list() global
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com

On Tue, Feb 20, 2018 at 03:35:10PM +0100, Igor Mammedov wrote:
> On Mon, 19 Feb 2018 12:12:53 +0530
> Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> 
> > Making pc_dimm_built_list() global allows other parts of QEMU code
> > to build and walk through the DIMM list in address-sorted order.
> > 
> > This is needed in the next patch for sPAPR code to create
> > ibm,dynamic-memory-v2 device tree property that will have entries
> > for populated DIMMs as well as available hotpluggable areas.
> > 
> > CHECK: List of DIMMs is already available via qmp_pc_dimm_device_list(),
> maybe make it sorted first and use it?
> 
> (i.e. use pc_dimm_built_list in qmp_pc_dimm_device_list) and hide
> recursive callback ugliness from external users.
> 
> MemoryDeviceInfoList *qmp_pc_dimm_device_list(void) {
>     object_child_foreach(qdev_get_machine(), pc_dimm_built_list, &list);
>     ...
> }

Thanks will attempt this in my next version.

Regards,
Bharata.
