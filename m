Received: from eggs.gnu.org ([2001:4830:134:3::10]:42386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keescook@chromium.org>) id 1gDEgD-0007xy-3p
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keescook@chromium.org>) id 1gDEg8-0006Oo-7X
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:14:01 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keescook@chromium.org>)
	id 1gDEg7-0006NE-WB
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:13:56 -0400
Received: by mail-pf1-x444.google.com with SMTP id j23-v6so15384422pfi.4
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:13:55 -0700 (PDT)
Date: Thu, 18 Oct 2018 13:13:51 -0700
From: Kees Cook <keescook@chromium.org>
Message-ID: <20181018201351.GA25286@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] nvdimm: Add docs hint for Linux driver name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, qemu-devel@nongnu.org

I spent way too much time trying to figure out why the emulated NVDIMM
was missing under Linux. In an effort to help others who might be looking
for these kinds of things in the future, include a hint.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 docs/nvdimm.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index 5f158a61708e..7231c2d78f65 100644
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
2.17.1


-- 
Kees Cook
Pixel Security
