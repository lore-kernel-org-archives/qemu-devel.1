Received: from eggs.gnu.org ([2001:4830:134:3::10]:34879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBn-0008Un-OQ
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBn-0004iL-0v
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:31 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:40565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBm-0004i6-TC
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:30 -0500
Received: by mail-qt0-x242.google.com with SMTP id c19so10465556qtm.7
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 20:30:30 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 01:28:59 -0300
Message-Id: <20180215042900.16078-30-f4bug@amsat.org>
In-Reply-To: <20180215042900.16078-1-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 29/30] tpm: use the BYTE-based definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

It ease code review, unit is explicit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/acpi/tpm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index 96fd3a92f7..751567a73a 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -71,7 +71,7 @@ REG32(CRB_DATA_BUFFER, 0x80)
 #define TPM_CRB_ADDR_CTRL           (TPM_CRB_ADDR_BASE + A_CRB_CTRL_REQ)
 #define TPM_CRB_R_MAX               R_CRB_DATA_BUFFER
 
-#define TPM_LOG_AREA_MINIMUM_SIZE   (64 * 1024)
+#define TPM_LOG_AREA_MINIMUM_SIZE   (64 * K_BYTE)
 
 #define TPM_TCPA_ACPI_CLASS_CLIENT  0
 #define TPM_TCPA_ACPI_CLASS_SERVER  1
-- 
2.16.1
