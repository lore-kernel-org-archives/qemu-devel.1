Received: from eggs.gnu.org ([2001:4830:134:3::10]:37432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1gCyFu-0005u0-Ix
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 22:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1gCyFq-0004AY-Mz
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 22:41:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:9964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1gCyFo-00044K-Vp
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 22:41:41 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Thu, 18 Oct 2018 02:41:30 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19BDF416A@SHSMSX101.ccr.corp.intel.com>
References: <1539713558-2453-1-git-send-email-kwankhede@nvidia.com>
In-Reply-To: <1539713558-2453-1-git-send-email-kwankhede@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH v1 0/4] Add migration support for VFIO
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "cjia@nvidia.com" <cjia@nvidia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

> From: Kirti Wankhede
> Sent: Wednesday, October 17, 2018 2:13 AM
>=20
> Add migration support for VFIO device
>=20
> This Patch set include patches as below:
> - Define KABI for VFIO device for migration support.
> - Generic migration functionality for VFIO device.
>   * This patch set adds functionality only for PCI devices, but can be
>     extended to other VFIO devices.
>   * Added all the basic functions required for pre-copy, stop-and-copy an=
d
>     resume phases of migration.
>   * Added state change notifier and from that notifier function, VFIO
>     device's state changed is conveyed to VFIO vendor driver.
>   * During save setup phase and resume/load setup phase, migration region
>     is queried from vendor driver and is mmaped by QEMU. This region is
>     used to read/write data from and to vendor driver.
>   * .save_live_pending, .save_live_iterate and .is_active_iterate are
>     implemented to use QEMU's functionality of iteration during pre-copy
>     phase.
>   * In .save_live_complete_precopy, that is in stop-and-copy phase,
>     iteration to read data from vendor driver is implemented till pending
>     bytes returned by vendor driver are not zero.
>   * .save_cleanup and .load_cleanup are implemented to unmap migration
>     region that was setup duing setup phase.
>   * Added function to get dirty pages bitmap from vendor driver.
> - Add vfio_listerner_log_sync to mark dirty pages.
> - Make VFIO PCI device migration capable.
>=20

I didn't see a kernel part change implementing the new KABI. If there is,
can you point out?

btw how is this work related to previous effort on adding live migration=20
to VFIO?

https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg01134.html
https://www.spinics.net/linux/fedora/libvir/msg170669.html=20

Thanks
Kevin
