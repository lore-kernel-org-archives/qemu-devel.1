Received: from eggs.gnu.org ([2001:4830:134:3::10]:33441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gH7ni-0006EO-QY
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gH7ne-0007XX-Lw
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:41:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 29 Oct 2018 13:41:23 +0000
Message-Id: <20181029134123.3365-3-stefanha@redhat.com>
In-Reply-To: <20181029134123.3365-1-stefanha@redhat.com>
References: <20181029134123.3365-1-stefanha@redhat.com>
Subject: [Qemu-devel] [0 2/2] nvdimm: Add docs hint for Linux driver name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Kees Cook <keescook@chromium.org>

From: Kees Cook <keescook@chromium.org>

I spent way too much time trying to figure out why the emulated NVDIMM
was missing under Linux. In an effort to help others who might be looking
for these kinds of things in the future, include a hint.

Signed-off-by: Kees Cook <keescook@chromium.org>
Message-id: 20181018201351.GA25286@beast
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/nvdimm.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index 5f158a6170..7231c2d78f 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -49,8 +49,9 @@ Multiple vNVDIMM devices can be created if multiple pairs of "-object"
 and "-device" are provided.
 
 For above command line options, if the guest OS has the proper NVDIMM
-driver, it should be able to detect a NVDIMM device which is in the
-persistent memory mode and whose size is $NVDIMM_SIZE.
+driver (e.g. "CONFIG_ACPI_NFIT=y" under Linux), it should be able to
+detect a NVDIMM device which is in the persistent memory mode and whose
+size is $NVDIMM_SIZE.
 
 Note:
 
-- 
2.17.2
