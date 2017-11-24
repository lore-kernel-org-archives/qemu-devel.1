Received: from eggs.gnu.org ([2001:4830:134:3::10]:59540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eI9kM-0005dw-EW
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 03:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eI9kL-0001fM-R8
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 03:54:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eI9kL-0001dg-Ke
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 03:54:05 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 24 Nov 2017 16:53:51 +0800
Message-Id: <20171124085351.26386-3-famz@redhat.com>
In-Reply-To: <20171124085351.26386-1-famz@redhat.com>
References: <20171124085351.26386-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] qemu-options: Mention locking option of
 file driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Philipp Hahn <hahn@univention.de>, famz@redhat.com, mreitz@redhat.com

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-options.hx | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 3728e9b4dd..f10c2a3ddb 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -693,6 +693,10 @@ This is the protocol-level block driver for accessing regular files.
 The path to the image file in the local filesystem
 @item aio
 Specifies the AIO backend (threads/native, default: threads)
+@item locking
+Specifies whether the image file is protected with Linux OFD / POSIX locks. The
+default is to use the Linux Open File Descriptor API if avaiable, otherwise no
+lock is applied.  (auto/on/off, default: auto)
 @end table
 Example:
 @example
-- 
2.14.3
