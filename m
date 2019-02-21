Received: from eggs.gnu.org ([209.51.188.92]:33817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1gwhLC-0002YE-DH
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 00:56:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1gwhLB-0007bv-HK
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 00:56:14 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2058 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1gwhLB-0007a7-63
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 00:56:13 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 21 Feb 2019 05:56:04 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB260AD0@dggeml511-mbx.china.huawei.com>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<33183CC9F5247A488A2544077AF19020DB25D374@dggeml511-mbx.china.huawei.com>
	<20190221002444.GH16456@joy-OptiPlex-7040>
	<33183CC9F5247A488A2544077AF19020DB25E1F3@dggeml511-mbx.china.huawei.com>
	<20190221020457.GL16456@joy-OptiPlex-7040>
	<33183CC9F5247A488A2544077AF19020DB25E7CD@dggeml511-mbx.china.huawei.com>
	<20190221042111.GO16456@joy-OptiPlex-7040>
In-Reply-To: <20190221042111.GO16456@joy-OptiPlex-7040>
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
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "ziye.yang@intel.com" <ziye.yang@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "eauger@redhat.com" <eauger@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "changpeng.liu@intel.com" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

> >
> > > -----Original Message-----
> > > From: Zhao Yan [mailto:yan.y.zhao@intel.com]
> > > Sent: Thursday, February 21, 2019 10:05 AM
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
> > > > >
> > > > > > 5) About log sync, why not register log_global_start/stop in
> > > > > vfio_memory_listener?
> > > > > >
> > > > > >
> > > > > seems log_global_start/stop cannot be iterately called in pre-cop=
y
> phase?
> > > > > for dirty pages in system memory, it's better to transfer dirty d=
ata
> > > > > iteratively to reduce down time, right?
> > > > >
> > > >
> > > > We just need invoking only once for start and stop logging. Why we =
need
> to
> > > call
> > > > them literately? See memory_listener of vhost.
> > > >
> > > the dirty pages in system memory produces by device is incremental.
> > > if it can be got iteratively, the dirty pages in stop-and-copy phase =
can be
> > > minimal.
> > > :)
> > >
> > I mean starting or stopping the capability of logging, not log sync.
> >
> > We register the below callbacks:
> >
> > .log_sync =3D vfio_log_sync,
> > .log_global_start =3D vfio_log_global_start,
> > .log_global_stop =3D vfio_log_global_stop,
> >
> .log_global_start is also a good point to notify logging state.
> But if notifying in .save_setup handler, we can do fine-grained
> control of when to notify of logging starting together with get_buffer
> operation.
> Is there any special benifit by registering to .log_global_start/stop?
>=20

Performance benefit when one VM has multiple same vfio devices.


Regards,
-Gonglei
