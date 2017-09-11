Received: from eggs.gnu.org ([2001:4830:134:3::10]:50873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1drPaT-0007ee-B0
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1drPaN-0001qC-QS
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:21:21 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon, 11 Sep 2017 16:20:56 +0200
Message-Id: <20170911142056.15643-4-lvivier@redhat.com>
In-Reply-To: <20170911142056.15643-1-lvivier@redhat.com>
References: <20170911142056.15643-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] tests/hmp: test "none" machine with
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>

and add a test case of dump-guest-memory without
"[begin length]" parameters.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 tests/test-hmp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 729c0339f7..90693c0ce2 100644
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
@@ -159,5 +160,9 @@ int main(int argc, char **argv)
 
     qtest_cb_for_every_machine(add_machine_test_case);
 
+    /* as none machine has no memory, add a test case with memory */
+
+    qtest_add_data_func("hmp/none+2MB", g_strdup("none -m 2"), test_machine);
+
     return g_test_run();
 }
-- 
2.13.5
