Received: from eggs.gnu.org ([2001:4830:134:3::10]:33569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qy-00055E-Vc
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qy-00042x-2A
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:13 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6qx-00042R-Ry
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:11 -0500
Received: by mail-wm0-x244.google.com with SMTP id r126so58371543wmr.3
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:11 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:27 +0100
Message-Id: <1485524749-118532-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 19/41] pc: Enable vmware-cpuid-freq CPU option
 for 2.9+ machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>

From: Phil Dennis-Jordan <phil@philjordan.eu>

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Message-Id: <1484921496-11257-4-git-send-email-phil@philjordan.eu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/pc.h | 6 +++++-
 target/i386/cpu.c    | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 020b632..e34ab30 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -386,7 +386,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .property = "x-smi-broadcast",\
         .value    = "off",\
     },\
-
+    {\
+        .driver   = TYPE_X86_CPU,\
+        .property = "vmware-cpuid-freq",\
+        .value    = "off",\
+    },
 
 #define PC_COMPAT_2_7 \
     HW_COMPAT_2_7 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index dabad37..feded98 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3677,7 +3677,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
-    DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, false),
+    DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
1.8.3.1
