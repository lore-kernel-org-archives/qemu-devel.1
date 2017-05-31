Received: from eggs.gnu.org ([2001:4830:134:3::10]:44270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhi.a.wang@intel.com>) id 1dGBri-0003PS-MZ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhi.a.wang@intel.com>) id 1dGBrf-00028k-Fz
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:13:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:34146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhi.a.wang@intel.com>)
	id 1dGBrf-00028V-8e
	for qemu-devel@nongnu.org; Wed, 31 May 2017 18:13:15 -0400
From: "Wang, Zhi A" <zhi.a.wang@intel.com>
Date: Wed, 31 May 2017 22:13:03 +0000
Message-ID: <F3B0350DF4CB6849A642218320DE483D7D575A14@SHSMSX104.ccr.corp.intel.com>
References: <1496079043-26694-1-git-send-email-zhi.a.wang@intel.com>
	<592BDBCD.8030605@intel.com>
In-Reply-To: <592BDBCD.8030605@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC 0/6] Refine IGD stolen memory support in VFIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wang, Zhi A" <zhi.a.wang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, Alex Williamson <alex.williamson@redhat.com>, "Lv, Zhiyuan" <zhiyuan.lv@intel.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "Zhang, Xiong Y" <xiong.y.zhang@intel.com>

Ping.

-----Original Message-----
From: Qemu-devel [mailto:qemu-devel-bounces+zhi.a.wang=3Dintel.com@nongnu.o=
rg] On Behalf Of Zhi Wang
Sent: Monday, May 29, 2017 4:29 PM
To: qemu-devel@nongnu.org
Cc: Tian, Kevin <kevin.tian@intel.com>; daniel.vetter@ffwll.ch; joonas.laht=
inen@linux.intel.com; zhenyuw@linux.intel.com; Alex Williamson <alex.willia=
mson@redhat.com>; Lv, Zhiyuan <zhiyuan.lv@intel.com>; Dong, Chuanxiao <chua=
nxiao.dong@intel.com>; Zhang, Xiong Y <xiong.y.zhang@intel.com>
Subject: Re: [Qemu-devel] [RFC 0/6] Refine IGD stolen memory support in VFI=
O

Hi Alex:
     This the RFC patch of my ides in previous email. Could you shed some l=
ights here? :)

Thanks,
Zhi.

On 05/30/17 01:30, Zhi Wang wrote:
> This patch series are aim to refine the IGD stolen memory support in QEMU=
.
>
> Some features of Intel HW relies on the stolen memory to work, but=20
> some of registers used to indicate the base address of stolen memory=20
> can only be programmed once after system is powered-up. This will=20
> cause problems if the base of the stolen memory is changed during IGD pas=
sthrough.
>
> The solution of this patch series is allocating a new VM dedicated=20
> memory as "guest stolen memory" in QEMU for isolation and let the=20
> "guest stolen memory" sits in the same PA as host.
>
> Also it introduces Intel platform definitions and clears some old=20
> funtions and definitions.
>
> Zhi Wang (6):
>    vfio: Add Intel platform definitions
>    vfio: Setup IGD quirks earlier
>    vfio: Setup IGD stolen memory
>    vfio: Refine GGTT clearing
>    vfio: Remove extra quirks and old definitions
>    vfio: Setup IGD stolen memory under secondary mode
>
>   hw/vfio/Makefile.objs    |   2 +-
>   hw/vfio/intel-platform.c | 366 ++++++++++++++++++++++++++++++++++++++++=
+++++++
>   hw/vfio/intel-platform.h |  38 +++++
>   hw/vfio/pci-quirks.c     | 322 ++++++++--------------------------------=
-
>   4 files changed, 463 insertions(+), 265 deletions(-)
>   create mode 100644 hw/vfio/intel-platform.c
>   create mode 100644 hw/vfio/intel-platform.h
>
