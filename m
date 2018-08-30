Received: from eggs.gnu.org ([2001:4830:134:3::10]:41333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eager@eagerm.com>) id 1fvPiu-00087v-Gs
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eager@eagerm.com>) id 1fvPip-0001jw-VM
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:23:08 -0400
Received: from resqmta-po-06v.sys.comcast.net
	([2001:558:fe16:19:96:114:154:165]:50842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eager@eagerm.com>) id 1fvPip-0001jJ-In
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:23:03 -0400
From: Michael Eager <eager@eagerm.com>
References: <f38111ad-3fbb-210e-e7ec-49ae675ea65e@eagerm.com>
	<a57fdd27-7a86-3f31-341c-e98101d17b9a@eagerm.com>
Message-ID: <61c2239b-f8db-6648-ba1b-203309d876eb@eagerm.com>
Date: Thu, 30 Aug 2018 09:22:57 -0700
MIME-Version: 1.0
In-Reply-To: <a57fdd27-7a86-3f31-341c-e98101d17b9a@eagerm.com>
Content-Type: multipart/mixed; boundary="------------F1C34548F03DDF98C8ED1E3C"
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] RISC-V - Dynamic parameterization of
 RISC-V memory map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Michael Eager <eager@eagercon.com>

This is a multi-part message in MIME format.
--------------F1C34548F03DDF98C8ED1E3C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Corrected patch attached.

On 08/29/2018 05:48 PM, Michael Eager wrote:
> Whoops.  I just noticed that this patch is against the riscv-qemu
> repo on github, not the qemu.org repo.  I will rework it for the 
> qemu.org repo.  Meanwhile, I welcome any comments.
> 
> On 08/29/2018 05:21 PM, Michael Eager wrote:
>> Memory parameters for RISC-V boards can be read from a configuration
>> file using the -readconfig command line option.  The configuration file
>> should have a section for the board and memory.  The configuration for
>> the VirtIO board has the following configuration variables:
>> [riscv-virt-mem]
>>    debug-base   = "0x0"
>>    debug-size   = "0x100"
>>    mrom-base    = "0x1000"
>>    mrom-size    = "0x11000"
>>    test-base    = "0x100000"
>>    test-size    = "0x1000"
>>    clint-base   = "0x2000000"
>>    clint-size   = "0x10000"
>>    plic-base    = "0xc000000"
>>    plic-size    = "0x4000000"
>>    uart0-base   = "0x10000000"
>>    uart0-size   = "0x100"
>>    virtio-base  = "0x10001000"
>>    virtio-size  = "0x1000"
>>    dram-base    = "0x80000000"
>>    dram-size    = "0x0"
>>
>> Values must be enclosed within quotes.
>>
>> Signed-off-by: Michael Eager <eager@eagercon.com>
>>
> 

-- 
Michael Eager    eager@eagerm.com
1960 Park Blvd., Palo Alto, CA 94306

--------------F1C34548F03DDF98C8ED1E3C
Content-Type: text/x-patch;
 name="0001-RISC-V-Dynamic-parameterization-of-RISC-V-memory-map.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-RISC-V-Dynamic-parameterization-of-RISC-V-memory-map.pa";
 filename*1="tch"

>From 18f0ef098e6f9ff561d30113e6ca139e66a90f09 Mon Sep 17 00:00:00 2001
From: Michael Eager <eager@eagercon.com>
Date: Thu, 30 Aug 2018 09:20:54 -0700
Subject: [PATCH] RISC-V - Dynamic parameterization of RISC-V memory map

Memory parameters for RISC-V boards can be read from a configuration
file using the -readconfig command line option.  The configuration file
should have a section for the board and memory.  The configuration for
the VirtIO board has the following configuration variables:
[riscv-virt-mem]
  debug-base   = "0x0"
  debug-size   = "0x100"
  mrom-base    = "0x1000"
  mrom-size    = "0x11000"
  test-base    = "0x100000"
  test-size    = "0x1000"
  clint-base   = "0x2000000"
  clint-size   = "0x10000"
  plic-base    = "0xc000000"
  plic-size    = "0x4000000"
  uart0-base   = "0x10000000"
  uart0-size   = "0x100"
  virtio-base  = "0x10001000"
  virtio-size  = "0x1000"
  dram-base    = "0x80000000"
  dram-size    = "0x0"

Values must be enclosed within quotes.

Signed-off-by: Michael Eager <eager@eagercon.com>
---
 hw/riscv/riscv.config |  86 ++++++++++++++++++++++++++++++++++++++++
 hw/riscv/sifive_e.c   | 107 ++++++++++++++++++++++++++++++++++++++++----------
 hw/riscv/sifive_u.c   |  96 +++++++++++++++++++++++++++++++++++++++-----
 hw/riscv/spike.c      |  75 +++++++++++++++++++++++++++++++++--
 hw/riscv/virt.c       |  85 ++++++++++++++++++++++++++++++++++-----
 5 files changed, 406 insertions(+), 43 deletions(-)
 create mode 100644 hw/riscv/riscv.config

diff --git a/hw/riscv/riscv.config b/hw/riscv/riscv.config
new file mode 100644
index 0000000..58c4add
--- /dev/null
+++ b/hw/riscv/riscv.config
@@ -0,0 +1,86 @@
+# Memory map for RISC-V VirtIO board
+[riscv-virt-mem]
+  debug-base    = "0x0"
+  debug-size    = "0x100"
+  mrom-base     = "0x1000"
+  mrom-size     = "0x11000"
+  test-base     = "0x100000"
+  test-size     = "0x1000"
+  clint-base    = "0x2000000"
+  clint-size    = "0x10000"
+  plic-base     = "0xc000000"
+  plic-size     = "0x4000000"
+  uart0-base    = "0x10000000"
+  uart0-size    = "0x100"
+  virtio-base   = "0x10001000"
+  virtio-size   = "0x1000"
+  dram-base     = "0x80000000"
+  dram-size     = "0x0"
+
+# Memory map for RISC-V Sifive E board
+[riscv-sifive-e-mem]
+  debug-base    = "0x0"
+  debug-size    = "0x100"
+  mrom-base     = "0x1000"
+  mrom-size     = "0x2000"
+  otp-base      = "0x20000"
+  otp-size      = "0x2000"
+  clint-base    = "0x2000000"
+  clint-size    = "0x10000"
+  plic-base     = "0xc000000"
+  plic-size     = "0x4000000"
+  aon-base      = "0x10000000"
+  aon-size      = "0x8000"
+  prci-base     = "0x10008000"
+  prci-size     = "0x8000"
+  otp_ctrl-base = "0x10010000"
+  otp_ctrl-size = "0x1000"
+  gpio0-base    = "0x10012000"
+  gpio0-size    = "0x1000"
+  uart0-base    = "0x10013000"
+  uart0-size    = "0x1000"
+  qspi0-base    = "0x10014000"
+  qspi0-size    = "0x1000"
+  pwm0-base     = "0x10015000"
+  pwm0-size     = "0x1000"
+  uart1-base    = "0x10023000"
+  uart1-size    = "0x1000"
+  qspi1-base    = "0x10024000"
+  qspi1-size    = "0x1000"
+  pwm1-base     = "0x10025000"
+  pwm1-size     = "0x1000"
+  qspi2-base    = "0x10034000"
+  qspi2-size    = "0x1000"
+  pwm2-base     = "0x10035000"
+  pwm2-size     = "0x1000"
+  xip-base      = "0x20000000"
+  xip-size      = "0x20000000"
+  dtim-base     = " 0x80000000"
+  dtim-size     = "0x4000"
+
+[riscv-sifive-u-mem]
+  debug-base    = "0x0"
+  debug-size    = "0x100"
+  mrom-base     = "0x1000"
+  mrom-size     = "0x11000"
+  clint-base    = "0x2000000"
+  clint-size    = "0x10000"
+  plic-base     = "0xc000000"
+  plic-size     = "0x4000000"
+  uart0-base    = "0x10013000"
+  uart0-size    = "0x1000"
+  uart1-base    = "0x10023000"
+  uart1-size    = "0x1000"
+  dram-base     = "0x80000000"
+  dram-size     = "0x0"
+  gem-base      = "0x100900FC"
+  gem-size      = "0x2000"
+
+[riscv-spike-mem]
+  mrom-base     = "0x1000"
+  mrom-spike    = "0x11000"
+  clint-base    = "0x2000000"
+  clint-spike   = "0x10000"
+  dram-base     = "0x80000000"
+  dram-spike    = "0x0"
+
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 4577d72..c6b6ccf 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -31,6 +31,8 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
@@ -49,31 +51,85 @@
 #include "exec/address-spaces.h"
 #include "elf.h"
 
-static const struct MemmapEntry {
+static struct MemmapEntry {
     hwaddr base;
     hwaddr size;
+    const char *name;
 } sifive_e_memmap[] = {
-    [SIFIVE_E_DEBUG] =    {        0x0,      0x100 },
-    [SIFIVE_E_MROM] =     {     0x1000,     0x2000 },
-    [SIFIVE_E_OTP] =      {    0x20000,     0x2000 },
-    [SIFIVE_E_CLINT] =    {  0x2000000,    0x10000 },
-    [SIFIVE_E_PLIC] =     {  0xc000000,  0x4000000 },
-    [SIFIVE_E_AON] =      { 0x10000000,     0x8000 },
-    [SIFIVE_E_PRCI] =     { 0x10008000,     0x8000 },
-    [SIFIVE_E_OTP_CTRL] = { 0x10010000,     0x1000 },
-    [SIFIVE_E_GPIO0] =    { 0x10012000,     0x1000 },
-    [SIFIVE_E_UART0] =    { 0x10013000,     0x1000 },
-    [SIFIVE_E_QSPI0] =    { 0x10014000,     0x1000 },
-    [SIFIVE_E_PWM0] =     { 0x10015000,     0x1000 },
-    [SIFIVE_E_UART1] =    { 0x10023000,     0x1000 },
-    [SIFIVE_E_QSPI1] =    { 0x10024000,     0x1000 },
-    [SIFIVE_E_PWM1] =     { 0x10025000,     0x1000 },
-    [SIFIVE_E_QSPI2] =    { 0x10034000,     0x1000 },
-    [SIFIVE_E_PWM2] =     { 0x10035000,     0x1000 },
-    [SIFIVE_E_XIP] =      { 0x20000000, 0x20000000 },
-    [SIFIVE_E_DTIM] =     { 0x80000000,     0x4000 }
+    [SIFIVE_E_DEBUG] =    {        0x0,      0x100, "debug" },
+    [SIFIVE_E_MROM] =     {     0x1000,     0x2000, "mrom"  },
+    [SIFIVE_E_OTP] =      {    0x20000,     0x2000, "otp"   },
+    [SIFIVE_E_CLINT] =    {  0x2000000,    0x10000, "clint" },
+    [SIFIVE_E_PLIC] =     {  0xc000000,  0x4000000, "plic"  },
+    [SIFIVE_E_AON] =      { 0x10000000,     0x8000, "aon"   },
+    [SIFIVE_E_PRCI] =     { 0x10008000,     0x8000, "prci"  },
+    [SIFIVE_E_OTP_CTRL] = { 0x10010000,     0x1000, "otp_ctrl" },
+    [SIFIVE_E_GPIO0] =    { 0x10012000,     0x1000, "gpio0" },
+    [SIFIVE_E_UART0] =    { 0x10013000,     0x1000, "uart0" },
+    [SIFIVE_E_QSPI0] =    { 0x10014000,     0x1000, "qspi0" },
+    [SIFIVE_E_PWM0] =     { 0x10015000,     0x1000, "pwm0"  },
+    [SIFIVE_E_UART1] =    { 0x10023000,     0x1000, "uart1" },
+    [SIFIVE_E_QSPI1] =    { 0x10024000,     0x1000, "qspi1" },
+    [SIFIVE_E_PWM1] =     { 0x10025000,     0x1000, "pwm1"  },
+    [SIFIVE_E_QSPI2] =    { 0x10034000,     0x1000, "qspi2" },
+    [SIFIVE_E_PWM2] =     { 0x10035000,     0x1000, "pwm2"  },
+    [SIFIVE_E_XIP] =      { 0x20000000, 0x20000000, "xip"   },
+    [SIFIVE_E_DTIM] =     { 0x80000000,     0x4000, "dtim"  },
+    { 0, 0, 0 }
 };
 
+static QemuOptsList qemu_riscv_sifive_e_opts = {
+    .name = "riscv-sifive-e-mem",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_riscv_sifive_e_opts.head),
+    .desc = {
+        /* No options defined -- accept any option. */
+        { /* End of list */ }
+    },
+};
+
+static int riscv_sifive_e_parse_1(QemuOpts *opts, const char *name,
+			      const char *suffix, hwaddr *ret)
+{
+    const char *value;
+    hwaddr uval;
+    char buf[32];
+    char *endptr;
+
+    strcpy(buf, name);
+    strcat(buf, suffix);
+    value = qemu_opt_get(opts, buf);
+    if (value) {
+	if (strlen(value) == 0) {
+	    error_report("invalid format for riscv-sifive_e-mem[%s]", buf);
+	    return 1;
+        }
+        uval = strtoll(value, &endptr, 0);
+        if (errno == 0 && ((endptr - value) == strlen(value))) {
+	    *ret = uval;
+	}
+        else {
+	    error_report("invalid value for riscv-sifive_e-mem[%s] = \"%s\"", buf, value);
+	    return 1;
+        }
+    }
+    return 0;
+}
+
+/* Parse configuration values and overwrite defaults. */
+static int riscv_sifive_e_parse(void *opaque, QemuOpts *opts, Error **errp)
+{
+    struct MemmapEntry *entry;
+
+    for (entry = sifive_e_memmap; entry->name != NULL; entry++) {
+	if (riscv_sifive_e_parse_1(opts, entry->name, "-base", &entry->base))
+	    exit(EXIT_FAILURE);
+	if (riscv_sifive_e_parse_1(opts, entry->name, "-size", &entry->size))
+	    exit(EXIT_FAILURE);
+    }
+
+    return 0;
+}
+
 static uint64_t load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
@@ -104,6 +160,10 @@ static void riscv_sifive_e_init(MachineState *machine)
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     int i;
 
+    /* Read configuration file */
+    qemu_opts_foreach(qemu_find_opts("riscv-sifive-e-mem"),
+                      riscv_sifive_e_parse, NULL, NULL);
+
     /* Initialize SoC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
                             sizeof(s->soc), TYPE_RISCV_E_SOC,
@@ -243,3 +303,10 @@ static void riscv_sifive_e_soc_register_types(void)
 }
 
 type_init(riscv_sifive_e_soc_register_types)
+
+static void riscv_sifive_e_opts_init(void)
+{
+    qemu_add_opts(&qemu_riscv_sifive_e_opts);
+}
+
+opts_init(riscv_sifive_e_opts_init);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 59ae1ce..f30c465 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -28,6 +28,8 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
@@ -49,21 +51,82 @@
 
 #include <libfdt.h>
 
-static const struct MemmapEntry {
+static struct MemmapEntry {
     hwaddr base;
     hwaddr size;
+    const char *name;
 } sifive_u_memmap[] = {
-    [SIFIVE_U_DEBUG] =    {        0x0,      0x100 },
-    [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
-    [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
-    [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
-    [SIFIVE_U_UART0] =    { 0x10013000,     0x1000 },
-    [SIFIVE_U_UART1] =    { 0x10023000,     0x1000 },
-    [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
-    [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000 },
+    [SIFIVE_U_DEBUG] =    {        0x0,      0x100, "debug" },
+    [SIFIVE_U_MROM] =     {     0x1000,    0x11000, "mrom"  },
+    [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000, "clint" },
+    [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000, "plic"  },
+    [SIFIVE_U_UART0] =    { 0x10013000,     0x1000, "uart0" },
+    [SIFIVE_U_UART1] =    { 0x10023000,     0x1000, "uart1" },
+    [SIFIVE_U_DRAM] =     { 0x80000000,        0x0, "dram"  },
+    [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000, "gem"   },
+    { 0, 0, 0 }
 };
 
-#define GEM_REVISION        0x10070109
+static QemuOptsList qemu_riscv_sifive_u_opts = {
+    .name = "riscv-sifive-u-mem",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_riscv_sifive_u_opts.head),
+    .desc = {
+        /* No options defined -- accept any option. */
+        { /* End of list */ }
+    },
+};
+
+static QemuOptsList qemu_sifive_u_opts = {
+    .name = "sifive_u",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_sifive_u_opts.head),
+    .desc = {
+        /* No options defined -- accept any option. */
+        { /* End of list */ }
+    },
+};
+
+static int riscv_sifive_u_parse_1(QemuOpts *opts, const char *name,
+			      const char *suffix, hwaddr *ret)
+{
+    const char *value;
+    hwaddr uval;
+    char buf[32];
+    char *endptr;
+
+    strcpy(buf, name);
+    strcat(buf, suffix);
+    value = qemu_opt_get(opts, buf);
+    if (value) {
+	if (strlen(value) == 0) {
+	    error_report("invalid format for riscv-sifive_u-mem[%s]", buf);
+	    return 1;
+        }
+        uval = strtoll(value, &endptr, 0);
+        if (errno == 0 && ((endptr - value) == strlen(value))) {
+	    *ret = uval;
+	}
+        else {
+	    error_report("invalid value for riscv-sifive_u-mem[%s] = \"%s\"", buf, value);
+	    return 1;
+        }
+    }
+    return 0;
+}
+
+/* Parse configuration values and overwrite defaults. */
+static int riscv_sifive_u_parse(void *opaque, QemuOpts *opts, Error **errp)
+{
+    struct MemmapEntry *entry;
+
+    for (entry = sifive_u_memmap; entry->name != NULL; entry++) {
+	if (riscv_sifive_u_parse_1(opts, entry->name, "-base", &entry->base))
+	    exit(EXIT_FAILURE);
+	if (riscv_sifive_u_parse_1(opts, entry->name, "-size", &entry->size))
+	    exit(EXIT_FAILURE);
+    }
+
+    return 0;
+}
 
 static uint64_t load_kernel(const char *kernel_filename)
 {
@@ -78,6 +141,8 @@ static uint64_t load_kernel(const char *kernel_filename)
     return kernel_entry;
 }
 
+#define GEM_REVISION        0x10070109
+
 static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
@@ -243,6 +308,10 @@ static void riscv_sifive_u_init(MachineState *machine)
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     int i;
 
+    /* Read configuration file */
+    qemu_opts_foreach(qemu_find_opts("riscv-sifive-u-mem"),
+                      riscv_sifive_u_parse, NULL, NULL);
+
     /* Initialize SoC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
                             sizeof(s->soc), TYPE_RISCV_U_SOC,
@@ -407,3 +476,10 @@ static void riscv_sifive_u_soc_register_types(void)
 }
 
 type_init(riscv_sifive_u_soc_register_types)
+
+static void riscv_sifive_u_opts_init(void)
+{
+    qemu_add_opts(&qemu_riscv_sifive_u_opts);
+}
+
+opts_init(riscv_sifive_u_opts_init);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index c8c056c..2fb111d 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -26,6 +26,8 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
@@ -44,15 +46,69 @@
 
 #include <libfdt.h>
 
-static const struct MemmapEntry {
+static struct MemmapEntry {
     hwaddr base;
     hwaddr size;
+    const char *name;
 } spike_memmap[] = {
-    [SPIKE_MROM] =     {     0x1000,    0x11000 },
-    [SPIKE_CLINT] =    {  0x2000000,    0x10000 },
-    [SPIKE_DRAM] =     { 0x80000000,        0x0 },
+    [SPIKE_MROM] =     {     0x1000,    0x11000, "mrom"  },
+    [SPIKE_CLINT] =    {  0x2000000,    0x10000, "clint" },
+    [SPIKE_DRAM] =     { 0x80000000,        0x0, "dram"  },
+    { 0, 0, 0 }
 };
 
+static QemuOptsList qemu_riscv_spike_opts = {
+    .name = "riscv-spike-mem",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_riscv_spike_opts.head),
+    .desc = {
+        /* No options defined -- accept any option. */
+        { /* End of list */ }
+    },
+};
+
+static int riscv_spike_parse_1(QemuOpts *opts, const char *name,
+			      const char *suffix, hwaddr *ret)
+{
+    const char *value;
+    hwaddr uval;
+    char buf[32];
+    char *endptr;
+
+    strcpy(buf, name);
+    strcat(buf, suffix);
+    value = qemu_opt_get(opts, buf);
+    if (value) {
+	if (strlen(value) == 0) {
+	    error_report("invalid format for riscv-spike-mem[%s]", buf);
+	    return 1;
+        }
+        uval = strtoll(value, &endptr, 0);
+        if (errno == 0 && ((endptr - value) == strlen(value))) {
+	    *ret = uval;
+	}
+        else {
+	    error_report("invalid value for riscv-spike-mem[%s] = \"%s\"", buf, value);
+	    return 1;
+        }
+    }
+    return 0;
+}
+
+/* Parse configuration values and overwrite defaults. */
+static int riscv_spike_parse(void *opaque, QemuOpts *opts, Error **errp)
+{
+    struct MemmapEntry *entry;
+
+    for (entry = spike_memmap; entry->name != NULL; entry++) {
+	if (riscv_spike_parse_1(opts, entry->name, "-base", &entry->base))
+	    exit(EXIT_FAILURE);
+	if (riscv_spike_parse_1(opts, entry->name, "-size", &entry->size))
+	    exit(EXIT_FAILURE);
+    }
+
+    return 0;
+}
+
 static uint64_t load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
@@ -170,6 +226,10 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     int i;
 
+    /* Read configuration file */
+    qemu_opts_foreach(qemu_find_opts("riscv-sparc-mem"),
+                      riscv_spike_parse, NULL, NULL);
+
     /* Initialize SOC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
                             TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
@@ -362,3 +422,10 @@ static void spike_v1_10_0_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE("spike_v1.9.1", spike_v1_09_1_machine_init)
 DEFINE_MACHINE("spike_v1.10", spike_v1_10_0_machine_init)
+
+static void riscv_sifive_spike_opts_init(void)
+{
+    qemu_add_opts(&qemu_riscv_spike_opts);
+}
+
+opts_init(riscv_sifive_spike_opts_init);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 248bbdf..ff5d942 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -22,6 +22,8 @@
 #include "qemu/units.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
@@ -43,20 +45,74 @@
 
 #include <libfdt.h>
 
-static const struct MemmapEntry {
+static struct MemmapEntry {
     hwaddr base;
     hwaddr size;
+    const char *name;
 } virt_memmap[] = {
-    [VIRT_DEBUG] =    {        0x0,      0x100 },
-    [VIRT_MROM] =     {     0x1000,    0x11000 },
-    [VIRT_TEST] =     {   0x100000,     0x1000 },
-    [VIRT_CLINT] =    {  0x2000000,    0x10000 },
-    [VIRT_PLIC] =     {  0xc000000,  0x4000000 },
-    [VIRT_UART0] =    { 0x10000000,      0x100 },
-    [VIRT_VIRTIO] =   { 0x10001000,     0x1000 },
-    [VIRT_DRAM] =     { 0x80000000,        0x0 },
+    [VIRT_DEBUG] =    {        0x0,      0x100, "debug"  },
+    [VIRT_MROM] =     {     0x1000,    0x11000, "mrom"   },
+    [VIRT_TEST] =     {   0x100000,     0x1000, "test"   },
+    [VIRT_CLINT] =    {  0x2000000,    0x10000, "clint"  },
+    [VIRT_PLIC] =     {  0xc000000,  0x4000000, "plic"   },
+    [VIRT_UART0] =    { 0x10000000,      0x100, "uart0"  },
+    [VIRT_VIRTIO] =   { 0x10001000,     0x1000, "virtio" },
+    [VIRT_DRAM] =     { 0x80000000,        0x0, "dram"   },
+    { 0, 0, 0 }
 };
 
+static QemuOptsList qemu_riscv_virt_opts = {
+    .name = "riscv-virt-mem",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_riscv_virt_opts.head),
+    .desc = {
+        /* No options defined -- accept any option. */
+        { /* End of list */ }
+    },
+};
+
+static int riscv_virt_parse_1(QemuOpts *opts, const char *name,
+			      const char *suffix, hwaddr *ret)
+{
+    const char *value;
+    hwaddr uval;
+    char buf[32];
+    char *endptr;
+
+    strcpy(buf, name);
+    strcat(buf, suffix);
+    value = qemu_opt_get(opts, buf);
+    if (value) {
+	if (strlen(value) == 0) {
+	    error_report("invalid format for riscv-virt-mem[%s]", buf);
+	    return 1;
+        }
+        uval = strtoll(value, &endptr, 0);
+        if (errno == 0 && ((endptr - value) == strlen(value))) {
+	    *ret = uval;
+	}
+        else {
+	    error_report("invalid value for riscv-virt-mem[%s] = \"%s\"", buf, value);
+	    return 1;
+        }
+    }
+    return 0;
+}
+
+/* Parse configuration values and overwrite defaults. */
+static int riscv_virt_parse(void *opaque, QemuOpts *opts, Error **errp)
+{
+    struct MemmapEntry *entry;
+
+    for (entry = virt_memmap; entry->name != NULL; entry++) {
+	if (riscv_virt_parse_1(opts, entry->name, "-base", &entry->base))
+	    exit(EXIT_FAILURE);
+	if (riscv_virt_parse_1(opts, entry->name, "-size", &entry->size))
+	    exit(EXIT_FAILURE);
+    }
+
+    return 0;
+}
+
 static uint64_t load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
@@ -273,6 +329,10 @@ static void riscv_virt_board_init(MachineState *machine)
     int i;
     void *fdt;
 
+    /* Read configuration file */
+    qemu_opts_foreach(qemu_find_opts("riscv-virt-mem"),
+                      riscv_virt_parse, NULL, NULL);
+
     /* Initialize SOC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
                             TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
@@ -395,3 +455,10 @@ static void riscv_virt_board_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE("virt", riscv_virt_board_machine_init)
+
+static void riscv_sifive_virt_opts_init(void)
+{
+    qemu_add_opts(&qemu_riscv_virt_opts);
+}
+
+opts_init(riscv_sifive_virt_opts_init);
-- 
1.8.3.1


--------------F1C34548F03DDF98C8ED1E3C--
