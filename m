Received: from eggs.gnu.org ([2001:4830:134:3::10]:56706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFt-0002Xd-4w
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFr-0002X1-Qz
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33898 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKFr-0002WM-MN
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:03 -0400
Date: Thu, 3 May 2018 22:51:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-24-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 23/67] slirp: add include directory headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org

This way they are easier to find using standard rules.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/slirp/ip6.h      | 1 +
 include/slirp/libslirp.h | 1 +
 include/slirp/slirp.h    | 1 +
 3 files changed, 3 insertions(+)
 create mode 100644 include/slirp/ip6.h
 create mode 100644 include/slirp/libslirp.h
 create mode 100644 include/slirp/slirp.h

diff --git a/include/slirp/ip6.h b/include/slirp/ip6.h
new file mode 100644
index 0000000..432cc36
--- /dev/null
+++ b/include/slirp/ip6.h
@@ -0,0 +1 @@
+#include_next "../slirp/ip6.h"
diff --git a/include/slirp/libslirp.h b/include/slirp/libslirp.h
new file mode 100644
index 0000000..acab168
--- /dev/null
+++ b/include/slirp/libslirp.h
@@ -0,0 +1 @@
+#include_next "../slirp/libslirp.h"
diff --git a/include/slirp/slirp.h b/include/slirp/slirp.h
new file mode 100644
index 0000000..826a97d
--- /dev/null
+++ b/include/slirp/slirp.h
@@ -0,0 +1 @@
+#include_next "../slirp/slirp.h"
-- 
MST
