Received: from eggs.gnu.org ([209.51.188.92]:44017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gwfjw-00015d-3b
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 23:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gwfju-0005EN-5j
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 23:13:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:17392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1gwfjt-0005Bx-S7
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 23:13:38 -0500
Date: Wed, 20 Feb 2019 23:08:15 -0500
From: Zhao Yan <yan.y.zhao@intel.com>
Message-ID: <20190221040815.GN16456@joy-OptiPlex-7040>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<33183CC9F5247A488A2544077AF19020DB25D374@dggeml511-mbx.china.huawei.com>
	<20190221002444.GH16456@joy-OptiPlex-7040>
	<33183CC9F5247A488A2544077AF19020DB25E1F3@dggeml511-mbx.china.huawei.com>
	<20190221015837.GK16456@joy-OptiPlex-7040>
	<33183CC9F5247A488A2544077AF19020DB25E834@dggeml511-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DB25E834@dggeml511-mbx.china.huawei.com>
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
Cc: "cjia@nvidia.com" <cjia@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "ziye.yang@intel.com" <ziye.yang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "changpeng.liu@intel.com" <changpeng.liu@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>

On Thu, Feb 21, 2019 at 03:33:24AM +0000, Gonglei (Arei) wrote:
> 
> > -----Original Message-----
> > From: Zhao Yan [mailto:yan.y.zhao@intel.com]
> > Sent: Thursday, February 21, 2019 9:59 AM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: alex.williamson@redhat.com; qemu-devel@nongnu.org;
> > intel-gvt-dev@lists.freedesktop.org; Zhengxiao.zx@Alibaba-inc.com;
> > yi.l.liu@intel.com; eskultet@redhat.com; ziye.yang@intel.com;
> > cohuck@redhat.com; shuangtai.tst@alibaba-inc.com; dgilbert@redhat.com;
> > zhi.a.wang@intel.com; mlevitsk@redhat.com; pasic@linux.ibm.com;
> > aik@ozlabs.ru; eauger@redhat.com; felipe@nutanix.com;
> > jonathan.davies@nutanix.com; changpeng.liu@intel.com; Ken.Xue@amd.com;
> > kwankhede@nvidia.com; kevin.tian@intel.com; cjia@nvidia.com;
> > kvm@vger.kernel.org
> > Subject: Re: [PATCH 0/5] QEMU VFIO live migration
> > 
> > On Thu, Feb 21, 2019 at 01:35:43AM +0000, Gonglei (Arei) wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Zhao Yan [mailto:yan.y.zhao@intel.com]
> > > > Sent: Thursday, February 21, 2019 8:25 AM
> > > > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > > > Cc: alex.williamson@redhat.com; qemu-devel@nongnu.org;
> > > > intel-gvt-dev@lists.freedesktop.org; Zhengxiao.zx@Alibaba-inc.com;
> > > > yi.l.liu@intel.com; eskultet@redhat.com; ziye.yang@intel.com;
> > > > cohuck@redhat.com; shuangtai.tst@alibaba-inc.com;
> > dgilbert@redhat.com;
> > > > zhi.a.wang@intel.com; mlevitsk@redhat.com; pasic@linux.ibm.com;
> > > > aik@ozlabs.ru; eauger@redhat.com; felipe@nutanix.com;
> > > > jonathan.davies@nutanix.com; changpeng.liu@intel.com;
> > Ken.Xue@amd.com;
> > > > kwankhede@nvidia.com; kevin.tian@intel.com; cjia@nvidia.com;
> > > > kvm@vger.kernel.org
> > > > Subject: Re: [PATCH 0/5] QEMU VFIO live migration
> > > >
> > > > On Wed, Feb 20, 2019 at 11:56:01AM +0000, Gonglei (Arei) wrote:
> > > > > Hi yan,
> > > > >
> > > > > Thanks for your work.
> > > > >
> > > > > I have some suggestions or questions:
> > > > >
> > > > > 1) Would you add msix mode support,? if not, pls add a check in
> > > > vfio_pci_save_config(), likes Nvidia's solution.
> > > > ok.
> > > >
> > > > > 2) We should start vfio devices before vcpu resumes, so we can't rely on
> > vm
> > > > start change handler completely.
> > > > vfio devices is by default set to running state.
> > > > In the target machine, its state transition flow is running->stop->running.
> > >
> > > That's confusing. We should start vfio devices after vfio_load_state,
> > otherwise
> > > how can you keep the devices' information are the same between source side
> > > and destination side?
> > >
> > so, your meaning is to set device state to running in the first call to
> > vfio_load_state?
> > 
> No, it should start devices after vfio_load_state and before vcpu resuming.
>

What about set device state to running in load_cleanup handler ?

> > > > so, maybe you can ignore the stop notification in kernel?
> > > > > 3) We'd better support live migration rollback since have many failure
> > > > scenarios,
> > > > >  register a migration notifier is a good choice.
> > > > I think this patchset can also handle the failure case well.
> > > > if migration failure or cancelling happens,
> > > > in cleanup handler, LOGGING state is cleared. device state(running or
> > > > stopped) keeps as it is).
> > >
> > > IIRC there're many failure paths don't calling cleanup handler.
> > >
> > could you take an example?
> 
> Never mind, that's another bug I think. 
> 
> > > > then,
> > > > if vm switches back to running, device state will be set to running;
> > > > if vm stayes at stopped state, device state is also stopped (it has no
> > > > meaning to let it in running state).
> > > > Do you think so ?
> > > >
> > > IF the underlying state machine is complicated,
> > > We should tell the canceling state to vendor driver proactively.
> > >
> > That makes sense.
> > 
> > > > > 4) Four memory region for live migration is too complicated IMHO.
> > > > one big region requires the sub-regions well padded.
> > > > like for the first control fields, they have to be padded to 4K.
> > > > the same for other data fields.
> > > > Otherwise, mmap simply fails, because the start-offset and size for mmap
> > > > both need to be PAGE aligned.
> > > >
> > > But if we don't need use mmap for control filed and device state, they are
> > small basically.
> > > The performance is enough using pread/pwrite.
> > >
> > we don't mmap control fields. but if data fields going immedately after
> > control fields (e.g. just 64 bytes), we can't mmap data fields
> > successfully because its start offset is 64. Therefore control fields have
> > to be padded to 4k to let data fields start from 4k.
> > That's the drawback of one big region holding both control and data fields.
> > 
> > > > Also, 4 regions is clearer in my view :)
> > > >
> > > > > 5) About log sync, why not register log_global_start/stop in
> > > > vfio_memory_listener?
> > > > >
> > > > >
> > > > seems log_global_start/stop cannot be iterately called in pre-copy phase?
> > > > for dirty pages in system memory, it's better to transfer dirty data
> > > > iteratively to reduce down time, right?
> > > >
> > >
> > > We just need invoking only once for start and stop logging. Why we need to
> > call
> > > them literately? See memory_listener of vhost.
> > >
> > 
> > 
> > 
> > > Regards,
> > > -Gonglei
> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev
