Received: from eggs.gnu.org ([209.51.188.92]:49186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gtD7T-0006ou-Tm
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gtD7N-0002mF-J3
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:03:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gtD7J-00028g-Pb
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:03:31 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Mon, 11 Feb 2019 15:03:05 +0000
Message-Id: <1549897385-10091-3-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1549897385-10091-1-git-send-email-liam.merwick@oracle.com>
References: <1549897385-10091-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v2 3/3] tpm_tis: fix format string specifier in
 tpm_tis_show_buffer()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanb@linux.ibm.com, qemu-devel@nongnu.org

cppcheck reports:

[hw/tpm/tpm_tis.c:113]: (warning) %d in format string (no. 2) requires 'int' but the argument type is 'unsigned int'

Fix this by using %u instead of %d

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 hw/tpm/tpm_tis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 860c2ace7d99..395500e8a61d 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -110,7 +110,7 @@ static void tpm_tis_show_buffer(const unsigned char *buffer,
     uint32_t len, i;
 
     len = MIN(tpm_cmd_get_size(buffer), buffer_size);
-    printf("tpm_tis: %s length = %d\n", string, len);
+    printf("tpm_tis: %s length = %u\n", string, len);
     for (i = 0; i < len; i++) {
         if (i && !(i % 16)) {
             printf("\n");
-- 
1.8.3.1
