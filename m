Received: from eggs.gnu.org ([2001:4830:134:3::10]:42025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1e4h0t-0000Jm-57
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1e4h0q-0006JW-2f
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:35:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:31516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1e4h0p-0006Im-Q3
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:35:27 -0400
Date: Wed, 18 Oct 2017 13:34:59 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20171018053459.GA4352@yangzhon-Virtual>
References: <1508144183-30844-1-git-send-email-yang.zhong@intel.com>
	<ebb88add-3173-78b9-397e-53a364ca0d53@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebb88add-3173-78b9-397e-53a364ca0d53@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] add "nopin" option in the
 memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, anthony.xu@intel.com, yang.zhong@intel.com

On Mon, Oct 16, 2017 at 06:20:32PM +0800, Xiao Guangrong wrote:
> 
> 
> On 10/16/2017 04:56 PM, Yang Zhong wrote:
> >Qemu does not need pin NVDIMM memory for VFIO device during VFIO
> >hotplug, what's more, if there is no NVDIMM hw in the test machine,
> >the VFIO hotplug operation will need at least 10 minutes to pin RAM
> >as the NVDIMM, this time is not accepted. So we add "nopin=on" option
> >in the memory-backed-file, which can avoid to pin RAM memory for NVDIMM.
> 
> No.
> 
> memory-backed-file does not dedicate for nvdimm only, it can be mapped
> as normal memory as well. Rather more, this is no way to stop guest to
> use it as DMA.

Guangrong, thanks for your comments.

This issue was found in ClearContainer test and the general Qemu should also face
same issue. If test machine does not have nvdimm hw and RAM is limitted, the
VFIO hotplug or SRIOV will cost some minutes to preallocate memory for nvdimm, 
even the hotplug faild because of RAM is not enough.

We want to find a way to avoid this kind of issue, so the configurable "nopin" is added,
but the default operation is not changed, the nvdimm still can be DMA target. thanks!

Regards,

Yang
  
