Received: from eggs.gnu.org ([2001:4830:134:3::10]:35415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFz1I-0006GF-9P
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFz1G-0005jh-Sa
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:07:08 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 26 Oct 2018 11:06:49 +0100
Message-Id: <1540548409-22560-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1540548409-22560-1-git-send-email-thuth@redhat.com>
References: <1540548409-22560-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] arm: Deprecate the Strongarm sa1100 and
 sa1110 processors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

The deprecated "collie" board is the only user of the Strongarm
devices, so if "collie" goes away, we should remove the Strongarm
devices, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-deprecated.texi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index acf9809..0de5c7f 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -116,6 +116,11 @@ The @option{[hub_id name]} parameter tuple of the 'hostfwd_add' and
 The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
 or ``ivshmem-doorbell`` device types.
 
+@subsection Strongarm sa1100 and sa1110 and related devices (since 3.1)
+
+Without the deprecated "collie" board there is no other machine which is
+able to use these devices.
+
 @section System emulator machines
 
 @subsection pc-0.10 and pc-0.11 (since 3.0)
-- 
1.8.3.1
