Received: from eggs.gnu.org ([2001:4830:134:3::10]:35778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dGGEL-0001lW-4D
	for qemu-devel@nongnu.org; Wed, 31 May 2017 22:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1dGGEH-0003zr-VK
	for qemu-devel@nongnu.org; Wed, 31 May 2017 22:52:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:63406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1dGGEH-0003zP-Mf
	for qemu-devel@nongnu.org; Wed, 31 May 2017 22:52:53 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Thu, 1 Jun 2017 02:52:46 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190CF4174@SHSMSX101.ccr.corp.intel.com>
References: <1496079043-26694-1-git-send-email-zhi.a.wang@intel.com>
	<1496079043-26694-8-git-send-email-zhi.a.wang@intel.com>
In-Reply-To: <1496079043-26694-8-git-send-email-zhi.a.wang@intel.com>
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
Cc: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "Zhang, Xiong Y" <xiong.y.zhang@intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "Lv,
	Zhiyuan" <zhiyuan.lv@intel.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>

> From: Wang, Zhi A
> Sent: Tuesday, May 30, 2017 1:31 AM
>=20
> This patch series are aim to refine the IGD stolen memory support in QEMU=
.
>=20
> Some features of Intel HW relies on the stolen memory to work, but some o=
f
> registers used to indicate the base address of stolen memory can only be
> programmed once after system is powered-up. This will cause problems if
> the base of the stolen memory is changed during IGD passthrough.

'programmed once' suppose by BIOS. Then why would the base be changed
later?

>=20
> The solution of this patch series is allocating a new VM dedicated memory
> as "guest stolen memory" in QEMU for isolation and let the "guest stolen
> memory" sits in the same PA as host.

As a RFC you need tell the whole story of the problem and your proposal.
Just one sentence is far away from the RFC purpose, e.g. people may
immediately ask whether you fake a guest stolen memory to work around
some limitation in guest driver (which e.g. only boots when observing the
presence of stolen memory) or to activate a feature which strictly uses
stolen memory (e.g. framebuffer compression). If the latter then what
matters is the real stolen memory instead of faked one, blah, blah, ...

>=20
> Also it introduces Intel platform definitions and clears some old funtion=
s
> and definitions.
>=20
> Zhi Wang (6):
>   vfio: Add Intel platform definitions
>   vfio: Setup IGD quirks earlier
>   vfio: Setup IGD stolen memory
>   vfio: Refine GGTT clearing
>   vfio: Remove extra quirks and old definitions
>   vfio: Setup IGD stolen memory under secondary mode
>=20
>  hw/vfio/Makefile.objs    |   2 +-
>  hw/vfio/intel-platform.c | 366
> +++++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/intel-platform.h |  38 +++++
>  hw/vfio/pci-quirks.c     | 322 ++++++++---------------------------------
>  4 files changed, 463 insertions(+), 265 deletions(-)
>  create mode 100644 hw/vfio/intel-platform.c
>  create mode 100644 hw/vfio/intel-platform.h
>=20
> --
> 2.7.4
