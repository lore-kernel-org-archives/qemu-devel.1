Received: from eggs.gnu.org ([2001:4830:134:3::10]:33671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNLA-00012l-Ad
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNL7-0002zA-8j
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:35:40 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:37247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNL7-0002ym-3e
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:35:37 -0400
Received: by mail-qt0-x241.google.com with SMTP id a18-v6so1932408qtj.4
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 08:35:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  3 Jul 2018 12:35:30 -0300
Message-Id: <20180703153530.9330-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] docker: Update debootstrap script after Debian
 migration from Alioth to Salsa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

This silents the following warning:

  Cloning into './debootstrap.git'...
  warning: redirecting to https://salsa.debian.org/installer-team/debootstrap.git/

See https://lists.debian.org/debian-devel-announce/2018/01/msg00004.html

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/debian-bootstrap.pre | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-bootstrap.pre b/tests/docker/dockerfiles/debian-bootstrap.pre
index 7c76dce663..44b18db7a2 100755
--- a/tests/docker/dockerfiles/debian-bootstrap.pre
+++ b/tests/docker/dockerfiles/debian-bootstrap.pre
@@ -53,7 +53,7 @@ if [ -z $DEBOOTSTRAP_DIR ]; then
         NEED_DEBOOTSTRAP=true
     fi
     if $NEED_DEBOOTSTRAP; then
-        DEBOOTSTRAP_SOURCE=https://anonscm.debian.org/git/d-i/debootstrap.git
+        DEBOOTSTRAP_SOURCE=https://salsa.debian.org/installer-team/debootstrap.git
         git clone ${DEBOOTSTRAP_SOURCE} ./debootstrap.git
         export DEBOOTSTRAP_DIR=./debootstrap.git
         DEBOOTSTRAP=./debootstrap.git/debootstrap
-- 
2.18.0
