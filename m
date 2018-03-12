Received: from eggs.gnu.org ([2001:4830:134:3::10]:35901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evW2d-0004DP-R7
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evW2a-0003v9-KH
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:35:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evW2a-0003uw-Ex
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:35:36 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 12 Mar 2018 19:34:49 -0300
Message-Id: <20180312223455.18124-2-ehabkost@redhat.com>
In-Reply-To: <20180312223455.18124-1-ehabkost@redhat.com>
References: <20180312223455.18124-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] pc: correct misspelled CPU model-id for pc
 2.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Wang Xin <wangxinxin.wang@huawei.com>

From: Wang Xin <wangxinxin.wang@huawei.com>

Signed-off-by: Wang Xin <wangxinxin.wang@huawei.com>
Message-Id: <1517367668-25048-1-git-send-email-wangxinxin.wang@huawei.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index bb49165fe0..635c8b2a3b 100644
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
2.14.3
