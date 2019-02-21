Received: from eggs.gnu.org ([209.51.188.92]:60734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1gwhCD-00088z-P0
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 00:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1gwhCB-0002fs-F8
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 00:46:57 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2484 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1gwhCB-0002du-0j
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 00:46:55 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 21 Feb 2019 05:46:48 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB260AB2@dggeml511-mbx.china.huawei.com>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<33183CC9F5247A488A2544077AF19020DB25D374@dggeml511-mbx.china.huawei.com>
	<20190221002444.GH16456@joy-OptiPlex-7040>
	<33183CC9F5247A488A2544077AF19020DB25E1F3@dggeml511-mbx.china.huawei.com>
	<20190221015837.GK16456@joy-OptiPlex-7040>
	<33183CC9F5247A488A2544077AF19020DB25E834@dggeml511-mbx.china.huawei.com>
	<20190221040815.GN16456@joy-OptiPlex-7040>
In-Reply-To: <20190221040815.GN16456@joy-OptiPlex-7040>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/5] QEMU VFIO live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhao Yan <yan.y.zhao@intel.com>
Cc: "cjia@nvidia.com" <cjia@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "ziye.yang@intel.com" <ziye.yang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "changpeng.liu@intel.com" <changpeng.liu@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>







> -----Original Message-----
> From: Zhao Yan [mailto:yan.y.zhao@intel.com]
> Sent: Thursday, February 21, 2019 12:08 PM
> To: Gonglei (Arei) <arei.gonglei@huawei.com>
> Cc: cjia@nvidia.com; kvm@vger.kernel.org; aik@ozlabs.ru;
> Zhengxiao.zx@Alibaba-inc.com; shuangtai.tst@alibaba-inc.com;
> qemu-devel@nongnu.org; kwankhede@nvidia.com; eauger@redhat.com;
> yi.l.liu@intel.com; eskultet@redhat.com; ziye.yang@intel.com;
> mlevitsk@redhat.com; pasic@linux.ibm.com; felipe@nutanix.com;
> Ken.Xue@amd.com; kevin.tian@intel.com; dgilbert@redhat.com;
> alex.williamson@redhat.com; intel-gvt-dev@lists.freedesktop.org;
> changpeng.liu@intel.com; cohuck@redhat.com; zhi.a.wang@intel.com;
> jonathan.davies@nutanix.com
> Subject: Re: [PATCH 0/5] QEMU VFIO live migration
>=20
> On Thu, Feb 21, 2019 at 03:33:24AM +0000, Gonglei (Arei) wrote:
> >
> > > -----Original Message-----
> > > From: Zhao Yan [mailto:yan.y.zhao@intel.com]
> > > Sent: Thursday, February 21, 2019 9:59 AM
> > > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > > Cc: alex.williamson@redhat.com; qemu-devel@nongnu.org;
> > > intel-gvt-dev@lists.freedesktop.org; Zhengxiao.zx@Alibaba-inc.com;
> > > yi.l.liu@intel.com; eskultet@redhat.com; ziye.yang@intel.com;
> > > cohuck@redhat.com; shuangtai.tst@alibaba-inc.com;
> dgilbert@redhat.com;
> > > zhi.a.wang@intel.com; mlevitsk@redhat.com; pasic@linux.ibm.com;
> > > aik@ozlabs.ru; eauger@redhat.com; felipe@nutanix.com;
> > > jonathan.davies@nutanix.com; changpeng.liu@intel.com;
> Ken.Xue@amd.com;
> > > kwankhede@nvidia.com; kevin.tian@intel.com; cjia@nvidia.com;
> > > kvm@vger.kernel.org
> > > Subject: Re: [PATCH 0/5] QEMU VFIO live migration
> > >
> > > On Thu, Feb 21, 2019 at 01:35:43AM +0000, Gonglei (Arei) wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Zhao Yan [mailto:yan.y.zhao@intel.com]
> > > > > Sent: Thursday, February 21, 2019 8:25 AM
> > > > > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > > > > Cc: alex.williamson@redhat.com; qemu-devel@nongnu.org;
> > > > > intel-gvt-dev@lists.freedesktop.org; Zhengxiao.zx@Alibaba-inc.com=
;
> > > > > yi.l.liu@intel.com; eskultet@redhat.com; ziye.yang@intel.com;
> > > > > cohuck@redhat.com; shuangtai.tst@alibaba-inc.com;
> > > dgilbert@redhat.com;
> > > > > zhi.a.wang@intel.com; mlevitsk@redhat.com; pasic@linux.ibm.com;
> > > > > aik@ozlabs.ru; eauger@redhat.com; felipe@nutanix.com;
> > > > > jonathan.davies@nutanix.com; changpeng.liu@intel.com;
> > > Ken.Xue@amd.com;
> > > > > kwankhede@nvidia.com; kevin.tian@intel.com; cjia@nvidia.com;
> > > > > kvm@vger.kernel.org
> > > > > Subject: Re: [PATCH 0/5] QEMU VFIO live migration
> > > > >
> > > > > On Wed, Feb 20, 2019 at 11:56:01AM +0000, Gonglei (Arei) wrote:
> > > > > > Hi yan,
> > > > > >
> > > > > > Thanks for your work.
> > > > > >
> > > > > > I have some suggestions or questions:
> > > > > >
> > > > > > 1) Would you add msix mode support,? if not, pls add a check in
> > > > > vfio_pci_save_config(), likes Nvidia's solution.
> > > > > ok.
> > > > >
> > > > > > 2) We should start vfio devices before vcpu resumes, so we can'=
t rely
> on
> > > vm
> > > > > start change handler completely.
> > > > > vfio devices is by default set to running state.
> > > > > In the target machine, its state transition flow is
> running->stop->running.
> > > >
> > > > That's confusing. We should start vfio devices after vfio_load_stat=
e,
> > > otherwise
> > > > how can you keep the devices' information are the same between sour=
ce
> side
> > > > and destination side?
> > > >
> > > so, your meaning is to set device state to running in the first call =
to
> > > vfio_load_state?
> > >
> > No, it should start devices after vfio_load_state and before vcpu resum=
ing.
> >
>=20
> What about set device state to running in load_cleanup handler ?
>=20

The timing is fine, but you should also think about if should set device st=
ate=20
to running in failure branches when calling load_cleanup handler.

Regards,
-Gonglei
