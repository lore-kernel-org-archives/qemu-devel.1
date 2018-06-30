Received: from eggs.gnu.org ([2001:4830:134:3::10]:37844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ964-00045m-BB
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ963-0001xZ-1v
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:00 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ962-0001vk-Hm
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:58 -0400
Received: by mail-wm0-x232.google.com with SMTP id u18-v6so3959234wmc.1
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:10:58 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:07 +0200
Message-Id: <20180630061040.6018-15-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/47] hw/tpm: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180625124238.25339-13-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/acpi/tpm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index 46ac4dc..3580ffd 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -16,6 +16,7 @@
 #ifndef HW_ACPI_TPM_H
 #define HW_ACPI_TPM_H
 
+#include "qemu/units.h"
 #include "hw/registerfields.h"
 
 #define TPM_TIS_ADDR_BASE           0xFED40000
@@ -176,7 +177,7 @@ REG32(CRB_DATA_BUFFER, 0x80)
 #define TPM_CRB_ADDR_CTRL           (TPM_CRB_ADDR_BASE + A_CRB_CTRL_REQ)
 #define TPM_CRB_R_MAX               R_CRB_DATA_BUFFER
 
-#define TPM_LOG_AREA_MINIMUM_SIZE   (64 * 1024)
+#define TPM_LOG_AREA_MINIMUM_SIZE   (64 * KiB)
 
 #define TPM_TCPA_ACPI_CLASS_CLIENT  0
 #define TPM_TCPA_ACPI_CLASS_SERVER  1
-- 
1.8.3.1
