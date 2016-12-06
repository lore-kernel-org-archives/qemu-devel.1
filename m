Received: from eggs.gnu.org ([2001:4830:134:3::10]:55005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cEA5I-00021R-Th
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 02:22:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cEA5D-0008BL-VT
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 02:22:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cEA5D-0008B7-PL
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 02:22:35 -0500
Date: Tue, 6 Dec 2016 15:22:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161206072228.GC4344@pxdev.xzpeter.org>
References: <1480348315-13332-1-git-send-email-bd.aviv@gmail.com>
	<8188dd5e-2c71-dbd0-9a1a-9c8af6f74b96@intel.com>
	<20161202065214.GF21601@pxdev.xzpeter.org>
	<088c2afd-575e-99af-1686-023c116352ab@intel.com>
	<20161206065155.GB4344@pxdev.xzpeter.org>
	<6d37d046-8e5a-7662-baa6-445d3985fde7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d37d046-8e5a-7662-baa6-445d3985fde7@intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 0/5] IOMMU: intel_iommu support map and
 unmap notifications
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: "Aviv B.D" <bd.aviv@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Alex Williamson <alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Fengguang" <fengguang.wu@intel.com>

On Tue, Dec 06, 2016 at 03:06:20PM +0800, Lan Tianyu wrote:
> On 2016=E5=B9=B412=E6=9C=8806=E6=97=A5 14:51, Peter Xu wrote:
> > On Tue, Dec 06, 2016 at 02:30:24PM +0800, Lan Tianyu wrote:
> >=20
> > [...]
> >=20
> >>>> 2. How to restore GPA->HPA mapping when IOVA is disabled by guest.
> >>>> When guest enables IOVA for device, vIOMMU will invalidate all pre=
vious
> >>>> GPA->HPA mapping and update IOVA->HPA mapping to pIOMMU via iommu
> >>>> notifier. But if IOVA is disabled, I think we should restore GPA->=
HPA
> >>>> mapping for the device otherwise the device won't work again in th=
e VM.
> >>>
> >>> If we can have a workable replay mechanism, this problem will be
> >>> solved IMHO.
> >>
> >> Basic idea is to replay related memory regions to restore GPA->HPA
> >> mapping when guest disables IOVA.
> >=20
> > Btw, could you help elaborate in what case we will trigger such a
> > condition? Or, can we dynamically enable/disable an IOMMU?
>=20
> First case I think of is nest virtualization and we assign physical
> device to l2 guest.

If we assign physical device to l2 guest, then it will belongs to an
IOMMU domain in either l1 guest and host, right? (assuming we are
using vfio-pci to do device assignment)

> User space driver(E.G DPDK) also can enable/disable
> IOVA for device dynamically.

Could you provide more detailed (or any pointer) on how to do that? I
did try to find it myself, I see an VFIO_IOMMU_ENABLE ioctl, but looks
like it is for ppc only.

Thanks,

-- peterx
