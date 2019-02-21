Received: from eggs.gnu.org ([209.51.188.92]:58696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gwh10-00055f-Us
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 00:35:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gwgrb-0007xz-RW
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 00:25:41 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16733)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1gwgrX-0007uc-U2
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 00:25:38 -0500
References: <1550611400-13703-1-git-send-email-kwankhede@nvidia.com>
	<20190220102252.GB2608@work-vm>
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <e76e19a8-1c98-7c62-5587-ab0b898d2473@nvidia.com>
Date: Thu, 21 Feb 2019 10:55:10 +0530
MIME-Version: 1.0
In-Reply-To: <20190220102252.GB2608@work-vm>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Add migration support for VFIO
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: alex.williamson@redhat.com, cjia@nvidia.com, kevin.tian@intel.com, ziye.yang@intel.com, changpeng.liu@intel.com, yi.l.liu@intel.com, mlevitsk@redhat.com, eskultet@redhat.com, cohuck@redhat.com, jonathan.davies@nutanix.com, eauger@redhat.com, aik@ozlabs.ru, pasic@linux.ibm.com, felipe@nutanix.com, Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com, Ken.Xue@amd.com, zhi.a.wang@intel.com, yan.y.zhao@intel.com, yulei.zhang@intel.com, qemu-devel@nongnu.org



On 2/20/2019 3:52 PM, Dr. David Alan Gilbert wrote:
> * Kirti Wankhede (kwankhede@nvidia.com) wrote:
>> Add migration support for VFIO device
> 
> Hi Kirti,
>   Can you explain how this compares and works with Yan Zhao's
> set?

This patch set is incremental version of my previous patch set:
https://patchwork.ozlabs.org/cover/1000719/
This takes care of the feedbacks received on previous version.

This patch set is different than Yan Zhao's set.

Thanks,
Kirti

>   These look like two incompatible solutions to me - if that's
> the case we need to take a step back and figure out how to combine
> them into one.
> 
> Dave
> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
