Received: from eggs.gnu.org ([2001:4830:134:3::10]:45742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.yang@ucloud.cn>) id 1dhBXW-0001cn-0x
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.yang@ucloud.cn>) id 1dhBXR-0005JG-Vd
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:20:02 -0400
Received: from m97136.mail.qiye.163.com ([220.181.97.136]:30230)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.yang@ucloud.cn>) id 1dhBXQ-0005HC-Oq
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:19:57 -0400
From: wei.yang@ucloud.cn
Date: Mon, 14 Aug 2017 16:48:38 +0800
Message-Id: <20170814084838.12233-1-wei.yang@ucloud.cn>
Subject: [Qemu-devel] [PATCH] bios-tables-test: delete a assert about block
 name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, imammedo@redhat.com
Cc: qemu-devel@nongnu.org, wei.yang@ucloud.cn

From: Wei Yang <wei.yang@ucloud.cn>

The assert would be touched when the version of acpica is greater than or
equal to 20160318. its reason is that "Disasembler: Update a couple
output items(commit id: 1ecbb3d)" is introduced by Robert, the patch
emits the AML filename as a zero-length string, and allows the compiler
to create the name later.

Signed-off-by: Yang, Wei <wei.yang@ucloud.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Igor Mammedov <imammedo@redhat.com>
CC: qemu-devel@nongnu.org
---
 tests/bios-tables-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 88dbf97853..d2ab073848 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -350,7 +350,6 @@ static GString *normalize_asl(gchar *asl_code)
     /* strip def block name (it has file path in it) */
     if (g_str_has_prefix(asl->str, DEF_BLOCK)) {
         block_name = g_strstr_len(asl->str, asl->len, BLOCK_NAME_END);
-        g_assert(block_name);
         asl = g_string_erase(asl, 0,
                              block_name + sizeof(BLOCK_NAME_END) - asl->str);
     }
-- 
2.11.0
