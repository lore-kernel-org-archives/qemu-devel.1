Received: from eggs.gnu.org ([209.51.188.92]:34688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gwQHN-0003hS-HW
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gwQHI-0003Zf-V1
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:43:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gwQHH-0002g8-Mw
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:43:04 -0500
Date: Wed, 20 Feb 2019 12:42:42 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190220124242.5a1685c5.cohuck@redhat.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DB25D30F@dggeml511-mbx.china.huawei.com>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<20190219113212.GC2941@work-vm>
	<20190220052838.GC16456@joy-OptiPlex-7040>
	<20190220110142.GD2608@work-vm>
	<33183CC9F5247A488A2544077AF19020DB25D30F@dggeml511-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Zhao Yan <yan.y.zhao@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "ziye.yang@intel.com" <ziye.yang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "changpeng.liu@intel.com" <changpeng.liu@intel.com>, "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>

On Wed, 20 Feb 2019 11:28:46 +0000
"Gonglei (Arei)" <arei.gonglei@huawei.com> wrote:

> > -----Original Message-----
> > From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> > Sent: Wednesday, February 20, 2019 7:02 PM
> > To: Zhao Yan <yan.y.zhao@intel.com>
> > Cc: cjia@nvidia.com; kvm@vger.kernel.org; aik@ozlabs.ru;
> > Zhengxiao.zx@alibaba-inc.com; shuangtai.tst@alibaba-inc.com;
> > qemu-devel@nongnu.org; kwankhede@nvidia.com; eauger@redhat.com;
> > yi.l.liu@intel.com; eskultet@redhat.com; ziye.yang@intel.com;
> > mlevitsk@redhat.com; pasic@linux.ibm.com; Gonglei (Arei)
> > <arei.gonglei@huawei.com>; felipe@nutanix.com; Ken.Xue@amd.com;
> > kevin.tian@intel.com; alex.williamson@redhat.com;
> > intel-gvt-dev@lists.freedesktop.org; changpeng.liu@intel.com;
> > cohuck@redhat.com; zhi.a.wang@intel.com; jonathan.davies@nutanix.com
> > Subject: Re: [PATCH 0/5] QEMU VFIO live migration
> > 
> > * Zhao Yan (yan.y.zhao@intel.com) wrote:  
> > > On Tue, Feb 19, 2019 at 11:32:13AM +0000, Dr. David Alan Gilbert wrote:  
> > > > * Yan Zhao (yan.y.zhao@intel.com) wrote:  
> > > > > This patchset enables VFIO devices to have live migration capability.
> > > > > Currently it does not support post-copy phase.
> > > > >
> > > > > It follows Alex's comments on last version of VFIO live migration patches,
> > > > > including device states, VFIO device state region layout, dirty bitmap's
> > > > > query.  

> > > >   b) How do we detect if we're migrating from/to the wrong device or
> > > > version of device?  Or say to a device with older firmware or perhaps
> > > > a device that has less device memory ?  
> > > Actually it's still an open for VFIO migration. Need to think about
> > > whether it's better to check that in libvirt or qemu (like a device magic
> > > along with verion ?).  
> 
> We must keep the hardware generation is the same with one POD of public cloud
> providers. But we still think about the live migration between from the the lower
> generation of hardware migrated to the higher generation.

Agreed, lower->higher is the one direction that might make sense to
support.

But regardless of that, I think we need to make sure that incompatible
devices/versions fail directly instead of failing in a subtle, hard to
debug way. Might be useful to do some initial sanity checks in libvirt
as well.

How easy is it to obtain that information in a form that can be
consumed by higher layers? Can we find out the device type at least?
What about some kind of revision?
