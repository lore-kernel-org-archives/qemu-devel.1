Received: from eggs.gnu.org ([2001:4830:134:3::10]:33704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1exwr4-00017D-OB
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1exwr1-0005CX-Lq
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:37:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58934 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1exwr1-0005CE-G5
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:37:43 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 19 Mar 2018 16:36:28 +0100
Message-Id: <1521473788-206688-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <20180315181420.8694-4-ehabkost@redhat.com>
References: <20180315181420.8694-4-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 3/7] fixup! tests: add machine 'none' with
 -cpu test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Fixup test to account for 2 new targets that were merged
since this test was written.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/machine-none-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 596ad01..efdd4be 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -55,6 +55,8 @@ static struct arch2cpu cpus_map[] = {
     { "xtensa", "dc233c" },
     { "xtensaeb", "fsf" },
     { "hppa", "hppa" },
+    { "riscv64", "rv64gcsu-v1.10.0" },
+    { "riscv32", "rv32gcsu-v1.9.1" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
