Received: from eggs.gnu.org ([209.51.188.92]:47533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grjWG-0004Bt-7m
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grjWF-0007de-BI
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:15:08 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  7 Feb 2019 14:14:55 +0100
Message-Id: <1549545296-18903-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1549545296-18903-1-git-send-email-thuth@redhat.com>
References: <1549545296-18903-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] qemu-deprecated: Remove -virtioconsole and
 -no-frame for good
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-trivial@nongnu.org

The two sections have accidentally been added again during the
merge of Paolo's and Gerd's trees.

Fixes: 3e29da9fd81002a0c03041aaa26dea6d9dd9bd65
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-deprecated.texi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 80b0702..90e5860 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -37,18 +37,6 @@ would automatically enable USB support on the machine type.
 If using the new syntax, USB support must be explicitly
 enabled via the ``-machine usb=on'' argument.
 
-@subsection -virtioconsole (since 3.0.0)
-
-Option @option{-virtioconsole} has been replaced by
-@option{-device virtconsole}.
-
-@subsection -no-frame (since 2.12.0)
-
-The @code{--no-frame} argument works with SDL 1.2 only. The other user
-interfaces never implemented this in the first place. So this will be
-removed together with SDL 1.2 support.
->>>>>>> remotes/bonzini/tags/for-upstream
-
 @subsection -clock (since 3.0.0)
 
 The @code{-clock} option is ignored since QEMU version 1.7.0. There is no
-- 
1.8.3.1
