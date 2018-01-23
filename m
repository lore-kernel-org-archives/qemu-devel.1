Received: from eggs.gnu.org ([2001:4830:134:3::10]:55315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfE-0007jk-N9
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfD-00029B-SM
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:40 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:14 +0100
Message-Id: <1516694904-64879-16-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 15/25] s390x: cpu: add CPU_RESOLVING_TYPE
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

Along with change add target to null-machine test, so
that when switch to CPU_RESOLVING_TYPE happens,
test would ensure that null-mchine usecase still works.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Richard Henderson <rth@twiddle.net>
CC: Alexander Graf <agraf@suse.de>
CC: qemu-s390x@nongnu.org
---
 target/s390x/cpu.h        | 1 +
 tests/machine-none-test.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 1a8b6b9..b2121cb 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -731,6 +731,7 @@ void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
 
 #define S390_CPU_TYPE_SUFFIX "-" TYPE_S390_CPU
 #define S390_CPU_TYPE_NAME(name) (name S390_CPU_TYPE_SUFFIX)
+#define CPU_RESOLVING_TYPE TYPE_S390_CPU
 
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 052b8c0..b3a346d 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -44,6 +44,7 @@ static struct arch2cpu cpus_map[] = {
     { "ppc", "604" },
     { "ppc64", "power8e_v2.1" },
     { "ppcemb", "440epb" },
+    { "s390x", "qemu" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
