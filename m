Received: from eggs.gnu.org ([2001:4830:134:3::10]:44346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLKI0-0000fR-RU
	for qemu-devel@nongnu.org; Tue, 22 May 2018 23:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLKHx-00087l-OT
	for qemu-devel@nongnu.org; Tue, 22 May 2018 23:18:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60374 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fLKHx-00087f-K6
	for qemu-devel@nongnu.org; Tue, 22 May 2018 23:18:09 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 23 May 2018 11:18:03 +0800
Message-Id: <20180523031805.27101-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] error-report: introduce
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

v3:
- reindent in patch 2, dump more things [Philippe]

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

 include/qemu/error-report.h | 26 ++++++++++++++++
 hw/i386/intel_iommu.c       | 59 +++++++++++++++++++++----------------
 hw/i386/trace-events        |  1 -
 3 files changed, 59 insertions(+), 27 deletions(-)

-- 
2.17.0
