Received: from eggs.gnu.org ([2001:4830:134:3::10]:34483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cUZvW-0004Ru-PQ
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cUZvS-0003CZ-2j
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:12:26 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cUZvR-0003CC-Sn
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:12:22 -0500
Received: by mail-wm0-x243.google.com with SMTP id c85so6982944wmi.1
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 06:12:21 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Fri, 20 Jan 2017 15:11:36 +0100
Message-Id: <1484921496-11257-4-git-send-email-phil@philjordan.eu>
In-Reply-To: <1484921496-11257-1-git-send-email-phil@philjordan.eu>
References: <1484921496-11257-1-git-send-email-phil@philjordan.eu>
Subject: [Qemu-devel] [PATCH v2 3/3] pc: Enable vmware-cpuid-freq CPU option
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, Phil Dennis-Jordan <phil@philjordan.eu>

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 include/hw/i386/pc.h | 5 +++++
 target/i386/cpu.c    | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 853edf8..e0ad244 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -376,6 +376,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
 #define PC_COMPAT_2_8 \
     HW_COMPAT_2_8 \
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
2.3.2 (Apple Git-55)
