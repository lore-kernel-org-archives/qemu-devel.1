Received: from eggs.gnu.org ([2001:4830:134:3::10]:51793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1etmaa-00088Y-W5
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 22:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1etmaX-0002Ry-Uc
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 22:51:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38874
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1etmaX-0002Rk-PH
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 22:51:29 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w283o704131026
	for <qemu-devel@nongnu.org>; Wed, 7 Mar 2018 22:51:28 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gjudbv70b-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 22:51:27 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Thu, 8 Mar 2018 03:51:25 -0000
Date: Thu, 8 Mar 2018 09:21:14 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <20180308023337.21062-1-haozhong.zhang@intel.com>
	<20180308023337.21062-2-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308023337.21062-2-haozhong.zhang@intel.com>
Message-Id: <20180308035114.GB2001@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/5] pc-dimm: make
 qmp_pc_dimm_device_list() sort devices by address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org

On Thu, Mar 08, 2018 at 10:33:33AM +0800, Haozhong Zhang wrote:
> Make qmp_pc_dimm_device_list() return sorted by start address
> list of devices so that it could be reused in places that
> would need sorted list*. Reuse existing pc_dimm_built_list()
> to get sorted list.
> 
> While at it hide recursive callbacks from callers, so that:
> 
>   qmp_pc_dimm_device_list(qdev_get_machine(), &list);
> 
> could be replaced with simpler:
> 
>   list = qmp_pc_dimm_device_list();
> 
> * follow up patch will use it in build_srat()
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/mem/pc-dimm.c         | 83 +++++++++++++++++++++++++-----------------------
>  hw/ppc/spapr.c           |  3 +-

I have used this patch with SPAPR to implement the new device tree property
ibm,dynamic-memory-v2 at http://patchwork.ozlabs.org/patch/882387/

Reviewed-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
