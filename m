Received: from eggs.gnu.org ([2001:4830:134:3::10]:53991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJJad-0004Gl-HI
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJJaZ-0003wT-Jf
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:04:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dJJaZ-0003w6-ED
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:04:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 512246408A
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 13:04:30 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Jun 2017 21:04:10 +0800
Message-Id: <1497013453-13688-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] VT-d: convert the rest of DPRINTF()s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

Mainly I am doing the translation and then we can get rid of that.
Finally we won't need to recompile for its debugging any more.

I did spend some time on considering which DPRINTF to remove, which
one to convert to trace_*, also I am more careful this time with the
naming, e.g., I named all the error cases with trace_vtd_err_*, so
that we can easily get them when as long as we have a HMP interface,
using:

  trace-event vtd_err* on

The next two patches are simple cleanups. Please review. Thanks.

(I really want this series to be in asap... I should just do this
 months ago)

Peter Xu (3):
  intel_iommu: switching the rest DPRINTF to trace
  intel_iommu: cleanup vtd_iommu_translate()
  intel_iommu: cleanup vtd_interrupt_remap_msi()

 hw/i386/intel_iommu.c | 378 ++++++++++++++++----------------------------------
 hw/i386/trace-events  |  42 ++++++
 2 files changed, 162 insertions(+), 258 deletions(-)

-- 
2.7.4
