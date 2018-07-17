Received: from eggs.gnu.org ([2001:4830:134:3::10]:42601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffWBX-0000cQ-RD
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffWBW-0001iq-79
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:02:59 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:37378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffWBV-0001iN-Vl
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:02:58 -0400
Received: by mail-wm0-x244.google.com with SMTP id a19-v6so565997wmb.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 13:02:57 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 17 Jul 2018 20:55:49 +0100
Message-Id: <20180717195553.9111-15-alex.bennee@linaro.org>
In-Reply-To: <20180717195553.9111-1-alex.bennee@linaro.org>
References: <20180717195553.9111-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 for 3.0 14/18] docker: Update debootstrap
 script after Debian migration from Alioth to Salsa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

This silents the following warning:

  Cloning into './debootstrap.git'...
  warning: redirecting to https://salsa.debian.org/installer-team/debootstrap.git/

See https://lists.debian.org/debian-devel-announce/2018/01/msg00004.html

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-bootstrap.pre | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-bootstrap.pre b/tests/docker/dockerfiles/debian-bootstrap.pre
index 56e1aa7a21..ea324d6e4a 100755
--- a/tests/docker/dockerfiles/debian-bootstrap.pre
+++ b/tests/docker/dockerfiles/debian-bootstrap.pre
@@ -62,7 +62,7 @@ if [ -z $DEBOOTSTRAP_DIR ]; then
         NEED_DEBOOTSTRAP=true
     fi
     if $NEED_DEBOOTSTRAP; then
-        DEBOOTSTRAP_SOURCE=https://anonscm.debian.org/git/d-i/debootstrap.git
+        DEBOOTSTRAP_SOURCE=https://salsa.debian.org/installer-team/debootstrap.git
         git clone ${DEBOOTSTRAP_SOURCE} ./debootstrap.git
         export DEBOOTSTRAP_DIR=./debootstrap.git
         DEBOOTSTRAP=./debootstrap.git/debootstrap
-- 
2.17.1
