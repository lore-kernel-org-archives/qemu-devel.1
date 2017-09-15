Received: from eggs.gnu.org ([2001:4830:134:3::10]:54698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslaE-0007ih-V5
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslaE-0000bB-25
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dslaD-0000Zq-SC
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:41 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 15 Sep 2017 10:02:22 +0200
Message-Id: <1505462549-27298-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1505462549-27298-1-git-send-email-thuth@redhat.com>
References: <1505462549-27298-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 2/9] tests/test-hmp: Remove puv3 and
 tricore_testboard from the blacklist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, John Snow <jsnow@redhat.com>

The problem with puv3 has been fixed with 0ac241bcf9f9d99a252a352a162f
('unicore32: abort when entering "x 0" on the monitor') and the problem
with tricore_testboard has been fixed with b190f477e29c7cd03a8fee49c96d
('qemu-system-tricore: segfault when entering "x 0" on the monitor').

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/test-hmp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index d124e81..4156d61 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -138,8 +138,7 @@ static void add_machine_test_case(const char *mname)
     char *path;
 
     /* Ignore blacklisted machines that have known problems */
-    if (!strcmp("puv3", mname) || !strcmp("tricore_testboard", mname) ||
-        !strcmp("xenfv", mname) || !strcmp("xenpv", mname)) {
+    if (!strcmp("xenfv", mname) || !strcmp("xenpv", mname)) {
         return;
     }
 
-- 
1.8.3.1
