Received: from eggs.gnu.org ([2001:4830:134:3::10]:35650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7h-0008Dg-TS
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7d-00013x-S0
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:17 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dSP7d-00013I-KF
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:13 -0400
Received: by mail-wr0-x231.google.com with SMTP id k67so249660520wrc.2
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 07:48:13 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  4 Jul 2017 15:48:51 +0100
Message-Id: <20170704144859.17644-4-alex.bennee@linaro.org>
In-Reply-To: <20170704144859.17644-1-alex.bennee@linaro.org>
References: <20170704144859.17644-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 03/11] README: document --static builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 README | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 858a349..e0bf5c5 100644
--- a/README
+++ b/README
@@ -17,7 +17,7 @@ test blobs (which can be run anywhere), and a Linux executable
 'risu' which runs on the target architecture (ie ARM). To
 build the executable part:
 
-    [VAR=VALUE] ... ./configure
+    [VAR=VALUE] ... ./configure [--static]
     make
 
 where [VAR=VALUE] ... allows you to specify any options.
@@ -25,6 +25,10 @@ Most useful is
  CROSS_PREFIX= which specifies the cross compiler prefix; you'll
    need this if you're not building on the target system
    (Example: CROSS_PREFIX=arm-linux-gnueabihf- )
+
+Passing --static will build a statically linked binary which is useful
+if you don't want to mess around with chroot's to run the binary.
+
 For other possibilities run 'configure --help'.
 
 Building into a separate build tree from the source code is supported:
@@ -86,8 +90,14 @@ as simple as:
 
 However since you actually need to run it under qemu or similar
 you probably need an ARM chroot to run it in, and to do something
-like
- sudo chroot /srv/chroot/arm-mav /risu --host ipaddr vqshlimm.out
+like:
+
+  sudo chroot /srv/chroot/arm-mav /risu --host ipaddr vqshlimm.out
+
+If you built the binary statically you can simply run:
+
+  /path/to/qemu ./risu --host ipaddr vqshlimm.out
+
 
 When the apprentice connects to the master, they will both start
 running the binary and checking results with each other. When the
-- 
2.13.0
