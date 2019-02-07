Received: from eggs.gnu.org ([209.51.188.92]:58015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnws-0002rl-2A
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwq-0002j5-CG
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:53 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwq-0002ZH-2s
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:52 -0500
Received: by mail-wr1-x444.google.com with SMTP id q15so772003wro.12
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:27 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:33 +0100
Message-Id: <1549562254-41157-51-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 50/51] .travis.yml: test that no-default-device
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
Cc: thuth@redhat.com, philmd@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .travis.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 87d9fa9..a095d22 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -132,6 +132,12 @@ matrix:
 
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
