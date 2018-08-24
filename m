Received: from eggs.gnu.org ([2001:4830:134:3::10]:54527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ftFVr-000579-Mv
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ftFVq-0007qj-2u
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:04:43 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ftFVp-0007ZW-BW
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:04:41 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 18:04:22 +0100
Message-Id: <20180824170422.5783-4-peter.maydell@linaro.org>
In-Reply-To: <20180824170422.5783-1-peter.maydell@linaro.org>
References: <20180824170422.5783-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/3] docs/devel/memory.txt: Document
 _with_attrs accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

When we added the _with_attrs accessors we forgot to mention
them in the documentation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/memory.txt | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/docs/devel/memory.txt b/docs/devel/memory.txt
index 4fff0d56031..42577e1d860 100644
--- a/docs/devel/memory.txt
+++ b/docs/devel/memory.txt
@@ -326,8 +326,15 @@ visible as the pci-hole alias clips it to a 0.5GB range.
 MMIO Operations
 ---------------
 
-MMIO regions are provided with ->read() and ->write() callbacks; in addition
-various constraints can be supplied to control how these callbacks are called:
+MMIO regions are provided with ->read() and ->write() callbacks,
+which are sufficient for most devices. Some devices change behaviour
+based on the attributes used for the memory transaction, or need
+to be able to respond that the access should provoke a bus error
+rather than completing successfully; those devices can use the
+->read_with_attrs() and ->write_with_attrs() callbacks instead.
+
+In addition various constraints can be supplied to control how these
+callbacks are called:
 
  - .valid.min_access_size, .valid.max_access_size define the access sizes
    (in bytes) which the device accepts; accesses outside this range will
-- 
2.18.0
