Received: from eggs.gnu.org ([2001:4830:134:3::10]:54403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGp7w-0005wt-DW
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGp7v-0004z6-FM
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:08:40 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dGp7v-0004yj-8c
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:08:39 -0400
Received: by mail-wm0-x234.google.com with SMTP id d127so30557378wmf.0
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 09:08:39 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  2 Jun 2017 17:08:41 +0100
Message-Id: <20170602160848.4913-4-alex.bennee@linaro.org>
In-Reply-To: <20170602160848.4913-1-alex.bennee@linaro.org>
References: <20170602160848.4913-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 03/10] build-all-archs: support
 --static flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 build-all-archs | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/build-all-archs b/build-all-archs
index 78f062e..788ba36 100755
--- a/build-all-archs
+++ b/build-all-archs
@@ -18,6 +18,7 @@ usage() {
 
 	Options include:
 	    --use-docker[=tags]    use docker cross compile
+            --static               build a static binary
 
         If specifying docker the default will be to use the any
         qemu:debian-FOO-cross targets available on your system.
@@ -41,6 +42,9 @@ while [[ "$1" = -* ]]; do
 	        docker_tags="$arg"
             fi
 	    ;;
+        --static)
+            CONF="--static"
+            ;;
 	--help)
 	    usage
 	    ;;
@@ -88,7 +92,7 @@ for triplet in aarch64-linux-gnu arm-linux-gnueabihf m68k-linux-gnu \
     rm -rf build/${triplet}
     mkdir -p build/${triplet}
 
-    CONFIGURE="cd build/${triplet} && CROSS_PREFIX="${triplet}-"  ../../configure"
+    CONFIGURE="cd build/${triplet} && CROSS_PREFIX=${triplet}-  ../../configure ${CONF}"
     MAKE="make -C build/${triplet} EXTRA_CFLAGS=-Werror"
 
     if [ -z "$use_docker_tag" ]; then
-- 
2.13.0
