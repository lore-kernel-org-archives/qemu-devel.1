Received: from eggs.gnu.org ([2001:4830:134:3::10]:34050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhv1m-0007PT-AG
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhv1l-0000km-Cy
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:58:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhv1l-0000kS-4o
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:58:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id t6-v6so3676080wrn.7
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 03:58:48 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jul 2018 11:51:05 +0100
Message-Id: <20180724105109.8392-14-alex.bennee@linaro.org>
In-Reply-To: <20180724105109.8392-1-alex.bennee@linaro.org>
References: <20180724105109.8392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/17] docker: Update debootstrap script after
 Debian migration from Alioth to Salsa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

This silents the following warning:

  Cloning into './debootstrap.git'...
  warning: redirecting to https://salsa.debian.org/installer-team/debootstrap.git/

See https://lists.debian.org/debian-devel-announce/2018/01/msg00004.html

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
