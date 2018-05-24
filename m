Received: from eggs.gnu.org ([2001:4830:134:3::10]:43546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLi7c-0006v5-Sp
	for qemu-devel@nongnu.org; Thu, 24 May 2018 00:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLi7Y-00028S-2M
	for qemu-devel@nongnu.org; Thu, 24 May 2018 00:45:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42058 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fLi7X-00028D-UH
	for qemu-devel@nongnu.org; Thu, 24 May 2018 00:45:00 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 24 May 2018 12:44:52 +0800
Message-Id: <20180524044454.11792-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/2] error-report: introduce
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

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

Patch 2 use it to replace VT-d trace_vtd_err().

Please review.  Thanks.

Peter Xu (2):
  qemu-error: introduce {error|warn}_report_once
  intel-iommu: start to use error_report_once

 include/qemu/error-report.h | 32 ++++++++++++++++++++
 hw/i386/intel_iommu.c       | 59 +++++++++++++++++++++----------------
 hw/i386/trace-events        |  1 -
 3 files changed, 65 insertions(+), 27 deletions(-)

--=20
2.17.0
