Received: from eggs.gnu.org ([2001:4830:134:3::10]:37855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.yang@ucloud.cn>) id 1dhU28-0003WM-G2
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 01:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.yang@ucloud.cn>) id 1dhU25-00081X-CD
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 01:04:52 -0400
Received: from m97139.mail.qiye.163.com ([220.181.97.139]:43848)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.yang@ucloud.cn>) id 1dhU1y-0007xT-HV
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 01:04:49 -0400
From: wei.yang@ucloud.cn
Date: Tue, 15 Aug 2017 13:04:14 +0800
Message-Id: <20170815050414.29222-1-wei.yang@ucloud.cn>
Subject: [Qemu-devel] [PATCH] bios-tables-test: use strlen instead of sizeof
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, wei.yang@ucloud.cn

From: Wei Yang <wei.yang@ucloud.cn>

sizeof(BLOCK_NAME_END) is actually 2.  it can work
because there's a space after ,. but It is better to
replace it with strlen so it will work without a space too.

Signed-off-by: Wei Yang <wei.yang@ucloud.cn>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: qemu-devel@nongnu.org
---
 tests/bios-tables-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 88dbf97853..d1f31b19d3 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -352,7 +352,7 @@ static GString *normalize_asl(gchar *asl_code)
         block_name = g_strstr_len(asl->str, asl->len, BLOCK_NAME_END);
         g_assert(block_name);
         asl = g_string_erase(asl, 0,
-                             block_name + sizeof(BLOCK_NAME_END) - asl->str);
+                             block_name + strlen(BLOCK_NAME_END) - asl->str);
     }
 
     return asl;
-- 
2.11.0
