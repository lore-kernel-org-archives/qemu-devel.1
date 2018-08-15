Received: from eggs.gnu.org ([2001:4830:134:3::10]:52611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpsUr-0004BE-Vu
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 05:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpsUm-0002b2-FC
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 05:53:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39100 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fpsUm-0002Xy-1a
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 05:53:40 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 15 Aug 2018 17:53:25 +0800
Message-Id: <20180815095328.32414-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/3] error-report: introduce
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>

v5:
- rebase to master, especially fix up the last one trace_vtd_err()
  introduced in commit 63b88968f13 [Markus]
- add one more patch to replace the rest of trace_vtd_err*() hooks too

v4:
- patch 2: pick r-b from Philippe
- patch 1: replace all __* variables into *_ [Eric]
- patch 1: enhance the commit message of patch 1, mention return code
  of macros [Markus]

v3:
- reindent in patch 2, dump more things [Philippe]

v2:
- for patch 1: replace tabs, add trivial comment [Markus]
  (I didn't add much comment otherwise I'll need to duplicate what's
   there in error_report())
- add patch 2

Patch 1 introduce the helpers.

Patch 2&3 firstly uses it.

Please review.  Thanks.

Peter Xu (3):
  qemu-error: introduce {error|warn}_report_once
  intel-iommu: start to use error_report_once
  intel-iommu: replace more vtd_err_* traces

 hw/i386/intel_iommu.c       | 127 +++++++++++++++++++++++-------------
 hw/i386/trace-events        |  13 ----
 include/qemu/error-report.h |  32 +++++++++
 3 files changed, 113 insertions(+), 59 deletions(-)

-- 
2.17.1
