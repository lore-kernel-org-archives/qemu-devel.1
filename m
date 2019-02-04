Received: from eggs.gnu.org ([209.51.188.92]:46089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfaa-0006Fc-Ab
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfTT-0005bB-8m
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:52 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqfTT-0005av-2A
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:51 -0500
Received: by mail-qk1-f196.google.com with SMTP id z18so28214qkj.10
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:43:51 -0800 (PST)
Date: Mon, 4 Feb 2019 09:43:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204142638.27021-16-mst@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204142638.27021-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 15/25] contrib: compile vhost-user-blk tool by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Changpeng Liu <changpeng.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

From: Changpeng Liu <changpeng.liu@intel.com>

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure b/configure
index 31cf6f584d..5c619d4e03 100755
--- a/configure
+++ b/configure
@@ -5831,6 +5831,9 @@ if test "$want_tools" = "yes" ; then
   if [ "$posix" = "yes" ] && [ "$curl" = "yes" ]; then
     tools="elf2dmp $tools"
   fi
+  if [ "$linux" = "yes" ]; then
+    tools="vhost-user-blk\$(EXESUF) $tools"
+  fi
 fi
 if test "$softmmu" = yes ; then
   if test "$linux" = yes; then
-- 
MST
