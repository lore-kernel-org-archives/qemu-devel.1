Received: from eggs.gnu.org ([2001:4830:134:3::10]:56823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM9-0006ZA-CU
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM8-0006Bd-5R
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:33 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:43517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SM7-00065p-NX
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:31 -0400
Received: by mail-wr1-x431.google.com with SMTP id n1-v6so14043191wrt.10
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:49:24 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:49:01 +0100
Message-Id: <20181005154910.3099-13-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 12/21] configure: expose a plugin to the
 trace-backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We also enable gmodule support for use with plugins.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configure b/configure
index f3d4b799a5..87d71bbdcd 100755
--- a/configure
+++ b/configure
@@ -3513,6 +3513,9 @@ glib_modules=gthread-2.0
 if test "$modules" = yes; then
     glib_modules="$glib_modules gmodule-export-2.0"
 fi
+if have_backend "plugin"; then
+    glib_modules="$glib_modules gmodule-2.0"
+fi
 
 # This workaround is required due to a bug in pkg-config file for glib as it
 # doesn't define GLIB_STATIC_COMPILATION for pkg-config --static
@@ -6793,6 +6796,9 @@ if have_backend "syslog"; then
     feature_not_found "syslog(trace backend)" "syslog not available"
   fi
 fi
+if have_backend "plugin"; then
+  echo "CONFIG_TRACE_PLUGIN=y" >> $config_host_mak
+fi
 echo "CONFIG_TRACE_FILE=$trace_file" >> $config_host_mak
 
 if test "$rdma" = "yes" ; then
-- 
2.17.1
