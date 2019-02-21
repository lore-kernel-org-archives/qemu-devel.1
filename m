Received: from eggs.gnu.org ([209.51.188.92]:50825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gwdyB-0004VZ-3z
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 21:20:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gwdoZ-0002YE-8E
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 21:10:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:18741)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1gwdoY-0002XX-V3
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 21:10:19 -0500
Date: Wed, 20 Feb 2019 21:04:58 -0500
From: Zhao Yan <yan.y.zhao@intel.com>
Message-ID: <20190221020457.GL16456@joy-OptiPlex-7040>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<33183CC9F5247A488A2544077AF19020DB25D374@dggeml511-mbx.china.huawei.com>
	<20190221002444.GH16456@joy-OptiPlex-7040>
	<33183CC9F5247A488A2544077AF19020DB25E1F3@dggeml511-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DB25E1F3@dggeml511-mbx.china.huawei.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] QEMU VFIO live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "ziye.yang@intel.com" <ziye.yang@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "eauger@redhat.com" <eauger@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "changpeng.liu@intel.com" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

> > 
> > > 5) About log sync, why not register log_global_start/stop in
> > vfio_memory_listener?
> > >
> > >
> > seems log_global_start/stop cannot be iterately called in pre-copy phase?
> > for dirty pages in system memory, it's better to transfer dirty data
> > iteratively to reduce down time, right?
> > 
> 
> We just need invoking only once for start and stop logging. Why we need to call
> them literately? See memory_listener of vhost.
>
the dirty pages in system memory produces by device is incremental.
if it can be got iteratively, the dirty pages in stop-and-copy phase can be
minimal. 
:)

> Regards,
> -Gonglei
