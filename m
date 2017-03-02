Received: from eggs.gnu.org ([2001:4830:134:3::10]:43609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cjHay-0002YH-Of
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:40:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cjHat-0006iT-TM
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:40:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cjHat-0006hD-NF
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:39:55 -0500
Date: Thu, 2 Mar 2017 11:39:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170302033949.GK13926@pxdev.xzpeter.org>
References: <1487910561-17825-1-git-send-email-peterx@redhat.com>
	<e547f430-d078-27a5-7064-4fc5b9f738d1@redhat.com>
	<20170301023635.GE13926@pxdev.xzpeter.org>
	<20170301043802-mutt-send-email-mst@kernel.org>
	<05a23bbc-4ebc-769b-aa62-d3387af57cae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <05a23bbc-4ebc-769b-aa62-d3387af57cae@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] intel_iommu: check misordered init when
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, yi.l.liu@intel.com, qemu-devel@nongnu.org, Jintack Lim <jintack@cs.columbia.edu>

On Wed, Mar 01, 2017 at 12:14:21PM +0800, Jason Wang wrote:
> On 2017=E5=B9=B403=E6=9C=8801=E6=97=A5 11:23, Michael S. Tsirkin wrote:

[...]

> >While I agree this fixes the specific problem, we have the ordering
> >issue in many other places.
>=20
> Yes, just post a fix for virtio-pci with IOMMU. With this fix, we meet =
the
> exact issue as this patch, IOMMU needs to be created before any virtio-=
pci
> devices.

I posted v3 to include detection of virtio-pci devices. Hope that's
what we needed for 2.9. Thanks,

-- peterx
