Received: from eggs.gnu.org ([2001:4830:134:3::10]:53855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangxinxin.wang@huawei.com>) id 1egifK-0001X0-H8
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 22:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangxinxin.wang@huawei.com>) id 1egifF-0002KF-M3
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 22:02:26 -0500
Received: from [45.249.212.32] (port=56195 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wangxinxin.wang@huawei.com>)
	id 1egifF-0002ID-Af
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 22:02:21 -0500
From: Wang Xin <wangxinxin.wang@huawei.com>
Date: Wed, 31 Jan 2018 11:01:08 +0800
Message-ID: <1517367668-25048-1-git-send-email-wangxinxin.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] pc: correct misspelled CPU model-id for pc 2.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com
Cc: ehabkost@redhat.com, arei.gonglei@huawei.com, Wang Xin <wangxinxin.wang@huawei.com>

Signed-off-by: Wang Xin <wangxinxin.wang@huawei.com>

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index bb49165..635c8b2 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -617,7 +617,7 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
 #define PC_COMPAT_2_2 \
     HW_COMPAT_2_2 \
-    PC_CPU_MODEL_IDS("2.3.0") \
+    PC_CPU_MODEL_IDS("2.2.0") \
     {\
         .driver = "kvm64" "-" TYPE_X86_CPU,\
         .property = "vme",\
-- 
2.8.1.windows.1
