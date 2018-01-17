Received: from eggs.gnu.org ([2001:4830:134:3::10]:55422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuK-0005CB-OA
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuJ-0008IC-Td
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:44 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:24 +0100
Message-Id: <1516203816-19374-13-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 12/24] s390x: cpu: add TARGET_DEFAULT_CPU_TYPE
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
Cc: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org

it will be used for for 2 purposes, 1st is to
provide to cpu name resolving class for machine 'none'
  cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model)
and later to drop a bunch of ifdefs *-user/main.c that
set default cpu_model.

Use default value from linux-user for TARGET_DEFAULT_CPU_TYPE.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Richard Henderson <rth@twiddle.net>
CC: Alexander Graf <agraf@suse.de>
CC: qemu-s390x@nongnu.org
---
 target/s390x/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 1a8b6b9..174624a 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -731,6 +731,7 @@ void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
 
 #define S390_CPU_TYPE_SUFFIX "-" TYPE_S390_CPU
 #define S390_CPU_TYPE_NAME(name) (name S390_CPU_TYPE_SUFFIX)
+#define TARGET_DEFAULT_CPU_TYPE S390_CPU_TYPE_NAME("qemu")
 
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
-- 
2.7.4
