Received: from eggs.gnu.org ([2001:4830:134:3::10]:51051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnpDt-00061k-OF
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 12:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnpDo-00069v-HB
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 12:55:13 -0400
Received: from mail-co1nam03on0066.outbound.protection.outlook.com
	([104.47.40.66]:35376
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dnpDo-00067g-4g
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 12:55:08 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 1 Sep 2017 09:51:21 -0700
Message-ID: <cbc16f480d26b40e12cd03a992d89830f271182a.1504228916.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1504228916.git.alistair.francis@xilinx.com>
References: <cover.1504228916.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 5/7] General warn report fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, pbonzini@redhat.com

Tidy up some of the warn_report() messages after having converted them
to use warn_report().

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 block/vvfat.c               | 3 +--
 hw/arm/vexpress.c           | 2 +-
 hw/i386/xen/xen-mapcache.c  | 2 +-
 hw/mips/mips_malta.c        | 4 ++--
 hw/mips/mips_r4k.c          | 3 +--
 hw/s390x/s390-virtio.c      | 7 ++++---
 net/hub.c                   | 6 ++----
 net/net.c                   | 5 +++--
 target/i386/hax-mem.c       | 5 ++---
 target/ppc/translate_init.c | 3 +--
 ui/keymaps.c                | 3 +--
 11 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 04801f3136..55f416868a 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1227,8 +1227,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
 
     switch (s->fat_type) {
     case 32:
-        warn_report("FAT32 has not been tested. "
-                    "You are welcome to do so!");
+        warn_report("FAT32 has not been tested. You are welcome to do so!");
         break;
     case 16:
     case 12:
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 2445eb4408..fa53cf96b4 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -492,7 +492,7 @@ static void vexpress_modify_dtb(const struct arm_boot_info *info, void *fdt)
          * happen with older device tree blobs.
          */
         warn_report("couldn't find interrupt controller in "
-                    "dtb; will not include virtio-mmio devices in the dtb.");
+                    "dtb; will not include virtio-mmio devices in the dtb");
     } else {
         int i;
         const hwaddr *map = daughterboard->motherboard_map;
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index 91a4fd6984..baab93b614 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -127,7 +127,7 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
 
         if (rlimit_as.rlim_max != RLIM_INFINITY) {
             warn_report("QEMU's maximum size of virtual"
-                        " memory is not infinity.");
+                        " memory is not infinity");
         }
         if (rlimit_as.rlim_max < MCACHE_MAX_SIZE + NON_MCACHE_MEMORY_SIZE) {
             mapcache->max_mcache_size = rlimit_as.rlim_max -
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 233e2ee802..b8ba684c93 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -216,8 +216,8 @@ static void generate_eeprom_spd(uint8_t *eeprom, ram_addr_t ram_size)
     }
 
     if (ram_size) {
-        warn_report("SPD cannot represent final %dMB"
-                    " of SDRAM", (int)ram_size);
+        warn_report("SPD cannot represent final "RAM_ADDR_FMT"MB"
+                    " of SDRAM", ram_size);
     }
 
     /* fill in SPD memory information */
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 6ffb88fd70..b48a4d72ac 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -254,8 +254,7 @@ void mips_r4k_init(MachineState *machine)
 	}
     } else if (!qtest_enabled()) {
         /* not fatal */
-        warn_report("could not load MIPS bios '%s'",
-                    bios_name);
+        warn_report("could not load MIPS bios '%s'", bios_name);
     }
     g_free(filename);
 
diff --git a/hw/s390x/s390-virtio.c b/hw/s390x/s390-virtio.c
index 964df517b4..946f23fc23 100644
--- a/hw/s390x/s390-virtio.c
+++ b/hw/s390x/s390-virtio.c
@@ -146,9 +146,10 @@ void gtod_save(QEMUFile *f, void *opaque)
 
     r = s390_get_clock(&tod_high, &tod_low);
     if (r) {
-        warn_report("Unable to get guest clock for migration. "
-                    "Error code %d. Guest clock will not be migrated "
-                    "which could cause the guest to hang.", r);
+        warn_report("Unable to get guest clock for migration: %s",
+                    strerror(-r));
+        error_printf("Guest clock will not be migrated "
+                     "which could cause the guest to hang.");
         qemu_put_byte(f, S390_TOD_CLOCK_VALUE_MISSING);
         return;
     }
diff --git a/net/hub.c b/net/hub.c
index 745a2168a1..14b4eec68f 100644
--- a/net/hub.c
+++ b/net/hub.c
@@ -310,8 +310,7 @@ void net_hub_check_clients(void)
         QLIST_FOREACH(port, &hub->ports, next) {
             peer = port->nc.peer;
             if (!peer) {
-                warn_report("hub port %s has no peer",
-                            port->nc.name);
+                warn_report("hub port %s has no peer", port->nc.name);
                 continue;
             }
 
@@ -334,8 +333,7 @@ void net_hub_check_clients(void)
             warn_report("vlan %d with no nics", hub->id);
         }
         if (has_nic && !has_host_dev) {
-            warn_report("vlan %d is not connected to host network",
-                        hub->id);
+            warn_report("vlan %d is not connected to host network", hub->id);
         }
     }
 }
diff --git a/net/net.c b/net/net.c
index 45ab2a1a02..5e5e27f7e0 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1482,8 +1482,9 @@ void net_check_clients(void)
     QTAILQ_FOREACH(nc, &net_clients, next) {
         if (!nc->peer) {
             warn_report("%s %s has no peer",
-                        nc->info->type == NET_CLIENT_DRIVER_NIC ?
-                        "nic" : "netdev", nc->name);
+                        nc->info->type == NET_CLIENT_DRIVER_NIC
+                        ? "nic" : "netdev",
+                        nc->name);
         }
     }
 
diff --git a/target/i386/hax-mem.c b/target/i386/hax-mem.c
index 756f2dd268..ad1248fece 100644
--- a/target/i386/hax-mem.c
+++ b/target/i386/hax-mem.c
@@ -178,9 +178,8 @@ static void hax_process_section(MemoryRegionSection *section, uint8_t flags)
     if (!memory_region_is_ram(mr)) {
         if (memory_region_is_romd(mr)) {
             /* HAXM kernel module does not support ROMD yet  */
-            warn_report("Ignoring ROMD region 0x%016" PRIx64
-                        "->0x%016" PRIx64 "", __func__, start_pa,
-                        start_pa + size);
+            warn_report("Ignoring ROMD region 0x%016"PRIx64"->0x%016"PRIx64"",
+                        start_pa, start_pa + size);
         }
         return;
     }
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 989c104b76..be09aadfd9 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9230,8 +9230,7 @@ static void init_ppc_proc(PowerPCCPU *cpu)
     }
 #endif
     if (env->check_pow == NULL) {
-        warn_report("no power management check handler "
-                    "registered."
+        warn_report("no power management check handler registered."
                     " Attempt QEMU to crash very soon !");
     }
 }
diff --git a/ui/keymaps.c b/ui/keymaps.c
index a6cefdaff9..f9762d1497 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -198,8 +198,7 @@ int keysym2scancode(void *kbd_layout, int keysym)
     if (keysym < MAX_NORMAL_KEYCODE) {
         if (k->keysym2keycode[keysym] == 0) {
             trace_keymap_unmapped(keysym);
-            warn_report("no scancode found for keysym %d",
-                        keysym);
+            warn_report("no scancode found for keysym %d", keysym);
         }
         return k->keysym2keycode[keysym];
     } else {
-- 
2.11.0
