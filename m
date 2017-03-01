Received: from eggs.gnu.org ([2001:4830:134:3::10]:50557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cj0PB-00064E-Ex
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cj0P8-0006eO-B4
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:18:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cj0P8-0006e1-5s
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:18:38 -0500
Date: Wed, 1 Mar 2017 17:18:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170301091831.GF13926@pxdev.xzpeter.org>
References: <1487910561-17825-1-git-send-email-peterx@redhat.com>
	<e547f430-d078-27a5-7064-4fc5b9f738d1@redhat.com>
	<20170301023635.GE13926@pxdev.xzpeter.org>
	<20170301043802-mutt-send-email-mst@kernel.org>
	<05a23bbc-4ebc-769b-aa62-d3387af57cae@redhat.com>
	<a35dbe8f-770e-c792-e5ea-1f4f8ef8df37@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a35dbe8f-770e-c792-e5ea-1f4f8ef8df37@redhat.com>
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
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, yi.l.liu@intel.com, qemu-devel@nongnu.org, Jintack Lim <jintack@cs.columbia.edu>

On Wed, Mar 01, 2017 at 09:03:47AM +0200, Marcel Apfelbaum wrote:
> On 03/01/2017 06:14 AM, Jason Wang wrote:

[...]

> Hi Jason,
> 
> I am not saying we don't need to create the IOMMU before some other device,
> I just don't think that the command line order should matter to user.
> 
> BTW, are you working on a way to limit the IOMMU scope to a specific set of devices?
> If yes, this approach will also help you work.

Marcel,

Do you have any plan after 2.9 to re-arrange the init order thing a
bit? In general, maybe we need an ordering support for devices.
Besides that, I am thinking whether it would be wise that we just init
the IOMMUs during machine init just like before, but keep the
"-device" interface? After all, at least the root IOMMU device should
be with root complex, and it feels a little strange we just split the
init process apart (we delay the IOMMU init into device
initializations).

Not sure whether above makes sense though. Thanks,

-- peterx
