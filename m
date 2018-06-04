Received: from eggs.gnu.org ([2001:4830:134:3::10]:58628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fPqpK-0002og-MD
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fPqpJ-00041o-CX
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:51:18 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:41288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fPqpJ-00040z-5n
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:51:17 -0400
Received: by mail-wr0-x234.google.com with SMTP id h10-v6so2990515wrq.8
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 07:51:17 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  4 Jun 2018 15:51:06 +0100
Message-Id: <20180604145109.30498-5-alex.bennee@linaro.org>
In-Reply-To: <20180604145109.30498-1-alex.bennee@linaro.org>
References: <20180604145109.30498-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 4/7] docker: Add fedora-i386-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Fam Zheng <famz@redhat.com>

It has some basic *-devel.i686 packages to be used with "gcc -m32" as a
32 bit cross build environment.

Signed-off-by: Fam Zheng <famz@redhat.com>
[AJB: add glibc-static]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/fedora-i386-cross.docker | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 tests/docker/dockerfiles/fedora-i386-cross.docker

diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/docker/dockerfiles/fedora-i386-cross.docker
new file mode 100644
index 0000000000..8fbef2fa53
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora-i386-cross.docker
@@ -0,0 +1,14 @@
+FROM fedora:latest
+ENV PACKAGES \
+    gcc \
+    glibc-static.i686 \
+    glibc-devel.i686 \
+    glib2-devel.i686 \
+    zlib-devel.i686 \
+    glib2-devel.i686 \
+    nettle-devel.i686 \
+    pixman-devel.i686 \
+    gnutls-devel.i686
+
+RUN dnf install -y $PACKAGES
+RUN rpm -q $PACKAGES | sort > /packages.txt
-- 
2.17.0
