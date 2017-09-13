Received: from eggs.gnu.org ([2001:4830:134:3::10]:35646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ds8XJ-0004jc-Pt
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ds8XD-0003Yr-Rv
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:21:05 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 13 Sep 2017 16:20:36 +0200
Message-Id: <20170913142036.2469-5-lvivier@redhat.com>
In-Reply-To: <20170913142036.2469-1-lvivier@redhat.com>
References: <20170913142036.2469-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/4] tests/hmp: test "none" machine with
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>

and add a test case of dump-guest-memory without
"[begin length]" parameters.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
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
