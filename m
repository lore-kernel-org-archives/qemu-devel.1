Received: from eggs.gnu.org ([209.51.188.92]:44527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwP1s-0000Sh-1Z
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:23:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwP1r-0004vX-Ay
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:23:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gwP1r-0004uV-3l
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:23:03 -0500
Date: Wed, 20 Feb 2019 10:22:53 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190220102252.GB2608@work-vm>
References: <1550611400-13703-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550611400-13703-1-git-send-email-kwankhede@nvidia.com>
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
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: alex.williamson@redhat.com, cjia@nvidia.com, kevin.tian@intel.com, ziye.yang@intel.com, changpeng.liu@intel.com, yi.l.liu@intel.com, mlevitsk@redhat.com, eskultet@redhat.com, cohuck@redhat.com, jonathan.davies@nutanix.com, eauger@redhat.com, aik@ozlabs.ru, pasic@linux.ibm.com, felipe@nutanix.com, Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com, Ken.Xue@amd.com, zhi.a.wang@intel.com, yan.y.zhao@intel.com, yulei.zhang@intel.com, qemu-devel@nongnu.org

* Kirti Wankhede (kwankhede@nvidia.com) wrote:
> Add migration support for VFIO device

Hi Kirti,
  Can you explain how this compares and works with Yan Zhao's
set?
  These look like two incompatible solutions to me - if that's
the case we need to take a step back and figure out how to combine
them into one.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
