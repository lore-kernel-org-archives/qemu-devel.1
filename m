Received: from eggs.gnu.org ([2001:4830:134:3::10]:52090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1e6ePz-000505-03
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1e6ePy-0002DL-35
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:13:30 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vadim.galitsyn@profitbricks.com>)
	id 1e6ePx-0002Ch-Rt
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:13:29 -0400
Received: by mail-wm0-x242.google.com with SMTP id 78so7673274wmb.1
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 08:13:29 -0700 (PDT)
From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Date: Mon, 23 Oct 2017 17:13:09 +0200
Message-Id: <20171023151310.6462-4-vadim.galitsyn@profitbricks.com>
In-Reply-To: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
References: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
Subject: [Qemu-devel] [PATCH 3/4] tests: test-hmp: extend with 'writeconfig'
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vadim.galitsyn@profitbricks.com, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

Extend list of test cases with 'writeconfig' command.

Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org
---
 tests/test-hmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 5677fbf775..8e21eee61c 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -68,6 +68,7 @@ static const char *hmp_cmds[] = {
     "sum 0 512",
     "x /8i 0x100",
     "xp /16x 0",
+    "writeconfig /dev/null",
     NULL
 };
 
-- 
2.13.1.394.g41dd433
