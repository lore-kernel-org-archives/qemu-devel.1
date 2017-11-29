Received: from eggs.gnu.org ([2001:4830:134:3::10]:54274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK4G4-0001si-Kj
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK4G3-0007V1-8N
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:26:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 29 Nov 2017 16:26:21 +0100
Message-Id: <20171129152628.14906-4-kwolf@redhat.com>
In-Reply-To: <20171129152628.14906-1-kwolf@redhat.com>
References: <20171129152628.14906-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/10] qemu-options: Mention locking option of
 file driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-options.hx | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 3728e9b4dd..f11c4ac960 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -693,6 +693,10 @@ This is the protocol-level block driver for accessing regular files.
 The path to the image file in the local filesystem
 @item aio
 Specifies the AIO backend (threads/native, default: threads)
+@item locking
+Specifies whether the image file is protected with Linux OFD / POSIX locks. The
+default is to use the Linux Open File Descriptor API if available, otherwise no
+lock is applied.  (auto/on/off, default: auto)
 @end table
 Example:
 @example
-- 
2.13.6
