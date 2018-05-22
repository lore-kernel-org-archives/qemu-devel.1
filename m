Received: from eggs.gnu.org ([2001:4830:134:3::10]:44224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fKyPh-0004Sz-Ej
	for qemu-devel@nongnu.org; Mon, 21 May 2018 23:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fKyPe-0002xt-CO
	for qemu-devel@nongnu.org; Mon, 21 May 2018 23:56:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fKyPe-0002xa-7S
	for qemu-devel@nongnu.org; Mon, 21 May 2018 23:56:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB1D981FE14D
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 03:56:37 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 22 May 2018 11:56:27 +0800
Message-Id: <20180522035629.30428-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] error-report: introduce
 {error|warn}_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

v2:
- for patch 1: replace tabs, add trivial comment [Markus]
  (I didn't add much comment otherwise I'll need to duplicate what's
   there in error_report())
- add patch 2

Patch 1 introduce the helpers.

Patch 2 use it to replace VT-d trace_vtd_err().

Please review.  Thanks.

Peter Xu (2):
  qemu-error: introduce {error|warn}_report_once
  intel-iommu: start to use error_report_once

 include/qemu/error-report.h | 26 ++++++++++++++++++++++++++
 hw/i386/intel_iommu.c       | 34 +++++++++++++++++-----------------
 hw/i386/trace-events        |  1 -
 3 files changed, 43 insertions(+), 18 deletions(-)

-- 
2.17.0
