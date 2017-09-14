Received: from eggs.gnu.org ([2001:4830:134:3::10]:60404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsVhv-0006x0-Sy
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsVhq-0002fd-8Y
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:05:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dsVhq-0002ep-2y
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:05:30 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 14 Sep 2017 16:04:44 +0100
Message-Id: <20170914150447.19352-5-dgilbert@redhat.com>
In-Reply-To: <20170914150447.19352-1-dgilbert@redhat.com>
References: <20170914150447.19352-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] tests/hmp: test "none" machine with memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lvivier@redhat.com, cohuck@redhat.com, vadim.galitsyn@profitbricks.com
Cc: imammedo@redhat.com, thuth@redhat.com, peterx@redhat.com, groug@kaod.org

From: Laurent Vivier <lvivier@redhat.com>

and add a test case of dump-guest-memory without
"[begin length]" parameters.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20170913142036.2469-5-lvivier@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/test-hmp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 729c0339f7..d124e81850 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -35,6 +35,7 @@ static const char *hmp_cmds[] = {
     "mouse_button 0",
     "device_del mouse1",
     "dump-guest-memory /dev/null 0 4096",
+    "dump-guest-memory /dev/null",
     "gdbserver",
     "host_net_add user id=net0",
     "hostfwd_add tcp::43210-:43210",
@@ -159,5 +160,8 @@ int main(int argc, char **argv)
 
     qtest_cb_for_every_machine(add_machine_test_case);
 
+    /* as none machine has no memory by default, add a test case with memory */
+    qtest_add_data_func("hmp/none+2MB", g_strdup("none -m 2"), test_machine);
+
     return g_test_run();
 }
-- 
2.13.5
