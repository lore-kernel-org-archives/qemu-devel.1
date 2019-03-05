Received: from eggs.gnu.org ([209.51.188.92]:57772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h12kZ-00081d-DR
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h12kY-0008C9-JK
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:36:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1h12kY-0008A2-Cc
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:36:22 -0500
Date: Tue, 5 Mar 2019 13:36:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190305053611.GJ1657@xz-x1>
References: <1551753295-30167-1-git-send-email-yi.y.sun@linux.intel.com>
	<20190305030934.GH1657@xz-x1> <20190305032424.GJ26129@yi.y.sun>
	<20190305044836.GI1657@xz-x1> <20190305051553.GK26129@yi.y.sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190305051553.GK26129@yi.y.sun>
Subject: Re: [Qemu-devel] [PATCH v1 0/3] intel_iommu: support scalable mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Sun <yi.y.sun@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com

On Tue, Mar 05, 2019 at 01:15:53PM +0800, Yi Sun wrote:

[...]

> > > w/o passthr
> > >     -device intel-iommu \
> > >     -netdev tap,id=net1,vhost=off|on \
> > >     -device virtio-net-pci,netdev=net1 \
> > 
> > Virtio devices require explicit enabling of DMAR:
> > 
> > https://wiki.qemu.org/Features/VT-d#With_Virtio_Devices
> > 
> > Otherwise it could probably still be bypassing the translation unit.
> > 
> > If you retest any, please feel free to skip some of the tests like
> > kernel build.  Quick netperf should work, which can save you time.
> > 
> Thanks! Just made a quick test. It works well. Please check below
> command.
> 
>     -device intel-iommu,intremap=on,device-iotlb=on \
>     -netdev tap,id=net1,vhost=off \
>     -device ioh3420,id=pcie.1,chassis=1 \
>     -device
> virtio-net-pci,bus=pcie.1,netdev=net1,disable-legacy=on,disable-modern=off,iommu_platform=on,ats=on
> \

Please also consider to try vhost=on with/without iommu=pt.

Regards,

-- 
Peter Xu
