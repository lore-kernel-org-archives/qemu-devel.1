Received: from eggs.gnu.org ([209.51.188.92]:46441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sDA-0002Ve-3j
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sD7-0005C6-FC
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:11 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:51879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sD5-000570-R0
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:08 -0500
Received: by mail-wm1-x330.google.com with SMTP id n19so141981wmi.1
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:21:06 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:20:13 +0100
Message-Id: <1551723614-1823-54-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 53/54] .travis.yml: test that no-default-device
 builds do not regress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, Yang Zhong <yang.zhong@intel.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .travis.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index cca57f4..e942175 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -151,6 +151,12 @@ matrix:
 
     # We manually include builds which we disable "make check" for
     - env:
+        - CONFIG="--without-default-devices"
+        - TEST_CMD=""
+
+
+    # We manually include builds which we disable "make check" for
+    - env:
         - CONFIG="--enable-debug --enable-tcg-interpreter"
         - TEST_CMD=""
 
-- 
1.8.3.1
