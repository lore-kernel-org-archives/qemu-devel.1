Received: from eggs.gnu.org ([2001:4830:134:3::10]:58690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhi.a.wang@intel.com>) id 1dFGEe-0003X5-Fo
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhi.a.wang@intel.com>) id 1dFGEb-0007kU-Eh
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:41:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:8000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhi.a.wang@intel.com>)
	id 1dFGEb-0007kJ-3r
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:41:05 -0400
Message-ID: <592BDBCD.8030605@intel.com>
Date: Mon, 29 May 2017 16:29:01 +0800
From: Zhi Wang <zhi.a.wang@intel.com>
MIME-Version: 1.0
References: <1496079043-26694-1-git-send-email-zhi.a.wang@intel.com>
In-Reply-To: <1496079043-26694-1-git-send-email-zhi.a.wang@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/6] Refine IGD stolen memory support in VFIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: chuanxiao.dong@intel.com, daniel.vetter@ffwll.ch, xiong.y.zhang@intel.com, joonas.lahtinen@linux.intel.com, zhiyuan.lv@intel.com, zhenyuw@linux.intel.com, kevin.tian@intel.com, Alex Williamson <alex.williamson@redhat.com>

Hi Alex:
     This the RFC patch of my ides in previous email. Could you shed 
some lights here? :)

Thanks,
Zhi.

On 05/30/17 01:30, Zhi Wang wrote:
> This patch series are aim to refine the IGD stolen memory support in QEMU.
>
> Some features of Intel HW relies on the stolen memory to work, but some of
> registers used to indicate the base address of stolen memory can only be
> programmed once after system is powered-up. This will cause problems if
> the base of the stolen memory is changed during IGD passthrough.
>
> The solution of this patch series is allocating a new VM dedicated memory
> as "guest stolen memory" in QEMU for isolation and let the "guest stolen
> memory" sits in the same PA as host.
>
> Also it introduces Intel platform definitions and clears some old funtions
> and definitions.
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
>   hw/vfio/intel-platform.c | 366 +++++++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/intel-platform.h |  38 +++++
>   hw/vfio/pci-quirks.c     | 322 ++++++++---------------------------------
>   4 files changed, 463 insertions(+), 265 deletions(-)
>   create mode 100644 hw/vfio/intel-platform.c
>   create mode 100644 hw/vfio/intel-platform.h
>
