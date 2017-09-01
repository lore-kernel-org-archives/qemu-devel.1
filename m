Received: from eggs.gnu.org ([2001:4830:134:3::10]:57019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqJh-0008O9-5b
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqJS-0002VC-Pt
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:05:17 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Sep 2017 13:03:40 -0500
Message-Id: <20170901180340.30009-30-eblake@redhat.com>
In-Reply-To: <20170901180340.30009-1-eblake@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 29/29] libqtest: Rename qtest_init() to
 qtest_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, Keith Busch <keith.busch@intel.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>, Ben Warren <ben@skyportsystems.com>, "open list:Floppy" <qemu-block@nongnu.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>

We already have another qtest_init() in the tree, for the
top-level qtest.c device; having two functions with different
signatures is confusing.  Rename the libqtest version to
qtest_start() to eliminate the duplication.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h               |  8 ++++----
 tests/libqtest.c               |  8 ++++----
 tests/ac97-test.c              |  2 +-
 tests/bios-tables-test.c       | 12 ++++++------
 tests/boot-order-test.c        |  8 ++++----
 tests/boot-serial-test.c       |  8 ++++----
 tests/device-introspect-test.c | 12 ++++++------
 tests/display-vga-test.c       | 12 ++++++------
 tests/drive_del-test.c         |  6 +++---
 tests/ds1338-test.c            |  2 +-
 tests/e1000-test.c             |  2 +-
 tests/e1000e-test.c            |  6 +++---
 tests/eepro100-test.c          |  2 +-
 tests/endianness-test.c        | 24 ++++++++++++------------
 tests/es1370-test.c            |  2 +-
 tests/fdc-test.c               |  2 +-
 tests/fw_cfg-test.c            |  2 +-
 tests/hd-geo-test.c            |  8 ++++----
 tests/i440fx-test.c            |  6 +++---
 tests/i82801b11-test.c         |  4 ++--
 tests/ide-test.c               |  2 +-
 tests/intel-hda-test.c         |  4 ++--
 tests/ioh3420-test.c           |  2 +-
 tests/ipmi-bt-test.c           |  2 +-
 tests/ipmi-kcs-test.c          |  4 ++--
 tests/ipoctal232-test.c        |  4 ++--
 tests/ivshmem-test.c           |  2 +-
 tests/libqos/libqos.c          |  2 +-
 tests/m25p80-test.c            |  6 +++---
 tests/m48t59-test.c            |  2 +-
 tests/ne2000-test.c            |  2 +-
 tests/numa-test.c              | 14 +++++++-------
 tests/nvme-test.c              |  2 +-
 tests/pc-cpu-test.c            | 16 ++++++++--------
 tests/pcnet-test.c             |  2 +-
 tests/pnv-xscom-test.c         |  4 ++--
 tests/postcopy-test.c          |  4 ++--
 tests/prom-env-test.c          | 10 +++++-----
 tests/pvpanic-test.c           |  2 +-
 tests/pxe-test.c               | 10 +++++-----
 tests/q35-test.c               |  4 ++--
 tests/qmp-test.c               |  2 +-
 tests/qom-test.c               |  2 +-
 tests/rtc-test.c               |  2 +-
 tests/rtl8139-test.c           |  2 +-
 tests/spapr-phb-test.c         |  4 ++--
 tests/tco-test.c               |  6 +++---
 tests/test-arm-mptimer.c       |  2 +-
 tests/test-filter-mirror.c     |  2 +-
 tests/test-filter-redirector.c |  4 ++--
 tests/test-hmp.c               |  2 +-
 tests/test-netfilter.c         |  4 ++--
 tests/test-x86-cpuid-compat.c  |  8 ++++----
 tests/tmp105-test.c            |  7 ++++---
 tests/tpci200-test.c           |  2 +-
 tests/usb-hcd-ehci-test.c      |  2 +-
 tests/usb-hcd-ohci-test.c      |  2 +-
 tests/usb-hcd-xhci-test.c      |  5 +++--
 tests/vhost-user-test.c        | 22 +++++++++++-----------
 tests/virtio-balloon-test.c    |  2 +-
 tests/virtio-blk-test.c        |  8 ++++----
 tests/virtio-console-test.c    |  8 ++++----
 tests/virtio-net-test.c        |  2 +-
 tests/virtio-rng-test.c        |  2 +-
 tests/virtio-serial-test.c     |  2 +-
 tests/vmgenid-test.c           |  6 +++---
 tests/vmxnet3-test.c           |  2 +-
 tests/wdt_ib700-test.c         |  8 ++++----
 68 files changed, 179 insertions(+), 177 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 0459526187..3f6c71f0e3 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -24,21 +24,21 @@ typedef struct QTestState QTestState;
 extern QTestState *global_qtest;

 /**
- * qtest_init:
+ * qtest_start:
  * @extra_args...: other arguments to pass to QEMU, formatted as if by
  * sprintf().
  *
  * Returns: #QTestState instance.
  */
-QTestState *qtest_init(const char *extra_args, ...) GCC_FMT_ATTR(1, 2);
+QTestState *qtest_start(const char *extra_args, ...) GCC_FMT_ATTR(1, 2);

 /**
- * qtest_init_without_qmp_handshake:
+ * qtest_start_without_qmp_handshake:
  * @extra_args: other arguments to pass to QEMU.
  *
  * Returns: #QTestState instance.
  */
-QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
+QTestState *qtest_start_without_qmp_handshake(const char *extra_args);

 /**
  * qtest_quit:
diff --git a/tests/libqtest.c b/tests/libqtest.c
index fa4e47c137..76c8029f7e 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -266,7 +266,7 @@ void qtest_add_abrt_handler(GHookFunc fn, const void *data)
     g_hook_prepend(&abrt_hooks, hook);
 }

-QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
+QTestState *qtest_start_without_qmp_handshake(const char *extra_args)
 {
     QTestState *s;
     int sock, qmpsock, i;
@@ -347,7 +347,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     return s;
 }

-QTestState *qtest_init(const char *extra_args, ...)
+QTestState *qtest_start(const char *extra_args, ...)
 {
     va_list ap;
     QTestState *s;
@@ -357,7 +357,7 @@ QTestState *qtest_init(const char *extra_args, ...)
     cmd = g_strdup_vprintf(extra_args, ap);
     va_end(ap);

-    s = qtest_init_without_qmp_handshake(cmd);
+    s = qtest_start_without_qmp_handshake(cmd);
     g_free(cmd);

     /* Read the QMP greeting and then do the handshake */
@@ -970,7 +970,7 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine))
     QString *qstr;
     const char *mname;

-    global_qtest = qtest_init("-machine none");
+    global_qtest = qtest_start("-machine none");
     response = qmp("{ 'execute': 'query-machines' }");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
diff --git a/tests/ac97-test.c b/tests/ac97-test.c
index 6a1edaa85a..2f5fb10632 100644
--- a/tests/ac97-test.c
+++ b/tests/ac97-test.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/ac97/nop", nop);

-    global_qtest = qtest_init("-device AC97");
+    global_qtest = qtest_start("-device AC97");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index f8a107499f..9735073c22 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -624,12 +624,12 @@ static void test_smbios_structs(test_data *data)
 static void test_acpi_one(const char *params, test_data *data)
 {
     /* Disable kernel irqchip to be able to override apic irq0. */
-    data->qts = qtest_init("-machine %s,accel=%s,kernel-irqchip=off "
-                           "-net none -display none %s "
-                           "-drive id=hd0,if=none,file=%s,format=raw "
-                           "-device ide-hd,drive=hd0 ",
-                           data->machine, "kvm:tcg",
-                           params ? params : "", disk);
+    data->qts = qtest_start("-machine %s,accel=%s,kernel-irqchip=off "
+                            "-net none -display none %s "
+                            "-drive id=hd0,if=none,file=%s,format=raw "
+                            "-device ide-hd,drive=hd0 ",
+                            data->machine, "kvm:tcg",
+                            params ? params : "", disk);

     boot_sector_test(data->qts);

diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index e6efea6852..81b0d32a01 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -30,10 +30,10 @@ static void test_a_boot_order(const char *machine,
 {
     uint64_t actual;

-    global_qtest = qtest_init("-nodefaults%s%s %s",
-                              machine ? " -M " : "",
-                              machine ?: "",
-                              test_args);
+    global_qtest = qtest_start("-nodefaults%s%s %s",
+                               machine ? " -M " : "",
+                               machine ?: "",
+                               test_args);
     actual = read_boot_order();
     g_assert_cmphex(actual, ==, expected_boot);
     qmp_discard_response("{ 'execute': 'system_reset' }");
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index d7c0c320d7..d337fc9c4b 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -81,10 +81,10 @@ static void test_machine(const void *data)
      * Make sure that this test uses tcg if available: It is used as a
      * fast-enough smoketest for that.
      */
-    global_qtest = qtest_init("-M %s,accel=tcg:kvm "
-                              "-chardev file,id=serial0,path=%s "
-                              "-no-shutdown -serial chardev:serial0 %s",
-                              test->machine, tmpname, test->extra);
+    global_qtest = qtest_start("-M %s,accel=tcg:kvm "
+                               "-chardev file,id=serial0,path=%s "
+                               "-no-shutdown -serial chardev:serial0 %s",
+                               test->machine, tmpname, test->extra);
     unlink(tmpname);

     check_guest_output(test, fd);
diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index 1c23b71038..f7af40acc2 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -126,7 +126,7 @@ static void test_device_intro_list(void)
     QList *types;
     char *help;

-    global_qtest = qtest_init("%s", common_args);
+    global_qtest = qtest_start("%s", common_args);

     types = device_type_list(true);
     QDECREF(types);
@@ -167,7 +167,7 @@ static void test_qom_list_fields(void)
     QList *non_abstract;
     QListEntry *e;

-    global_qtest = qtest_init("%s", common_args);
+    global_qtest = qtest_start("%s", common_args);

     all_types = qom_list_types(NULL, true);
     non_abstract = qom_list_types(NULL, false);
@@ -194,14 +194,14 @@ static void test_qom_list_fields(void)

 static void test_device_intro_none(void)
 {
-    global_qtest = qtest_init("%s", common_args);
+    global_qtest = qtest_start("%s", common_args);
     test_one_device("nonexistent");
     qtest_quit(global_qtest);
 }

 static void test_device_intro_abstract(void)
 {
-    global_qtest = qtest_init("%s", common_args);
+    global_qtest = qtest_start("%s", common_args);
     test_one_device("device");
     qtest_quit(global_qtest);
 }
@@ -212,7 +212,7 @@ static void test_device_intro_concrete(void)
     QListEntry *entry;
     const char *type;

-    global_qtest = qtest_init("%s", common_args);
+    global_qtest = qtest_start("%s", common_args);
     types = device_type_list(false);

     QLIST_FOREACH_ENTRY(types, entry) {
@@ -232,7 +232,7 @@ static void test_abstract_interfaces(void)
     QListEntry *e;
     QDict *index;

-    global_qtest = qtest_init("%s", common_args);
+    global_qtest = qtest_start("%s", common_args);

     all_types = qom_list_types("interface", true);
     index = qom_type_index(all_types);
diff --git a/tests/display-vga-test.c b/tests/display-vga-test.c
index 51c6feaaf1..d638f15ec3 100644
--- a/tests/display-vga-test.c
+++ b/tests/display-vga-test.c
@@ -12,33 +12,33 @@

 static void pci_cirrus(void)
 {
-    qtest_quit(qtest_init("-vga none -device cirrus-vga"));
+    qtest_quit(qtest_start("-vga none -device cirrus-vga"));
 }

 static void pci_stdvga(void)
 {
-    qtest_quit(qtest_init("-vga none -device VGA"));
+    qtest_quit(qtest_start("-vga none -device VGA"));
 }

 static void pci_secondary(void)
 {
-    qtest_quit(qtest_init("-vga none -device secondary-vga"));
+    qtest_quit(qtest_start("-vga none -device secondary-vga"));
 }

 static void pci_multihead(void)
 {
-    qtest_quit(qtest_init("-vga none -device VGA -device secondary-vga"));
+    qtest_quit(qtest_start("-vga none -device VGA -device secondary-vga"));
 }

 static void pci_virtio_gpu(void)
 {
-    qtest_quit(qtest_init("-vga none -device virtio-gpu-pci"));
+    qtest_quit(qtest_start("-vga none -device virtio-gpu-pci"));
 }

 #ifdef CONFIG_VIRTIO_VGA
 static void pci_virtio_vga(void)
 {
-    qtest_quit(qtest_init("-vga none -device virtio-vga"));
+    qtest_quit(qtest_start("-vga none -device virtio-vga"));
 }
 #endif

diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 602ab062b4..f68c4bc176 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -45,7 +45,7 @@ static void device_del(void)
 static void test_drive_without_dev(void)
 {
     /* Start with an empty drive */
-    global_qtest = qtest_init("-drive if=none,id=drive0");
+    global_qtest = qtest_start("-drive if=none,id=drive0");

     /* Delete the drive */
     drive_del();
@@ -63,7 +63,7 @@ static void test_after_failed_device_add(void)
     QDict *response;
     QDict *error;

-    global_qtest = qtest_init("-drive if=none,id=drive0");
+    global_qtest = qtest_start("-drive if=none,id=drive0");

     /* Make device_add fail.  If this leaks the virtio-blk-pci device then a
      * reference to drive0 will also be held (via qdev properties).
@@ -92,7 +92,7 @@ static void test_after_failed_device_add(void)
 static void test_drive_del_device_del(void)
 {
     /* Start with a drive used by a device that unplugs instantaneously */
-    global_qtest = qtest_init(
+    global_qtest = qtest_start(
         "-drive if=none,id=drive0,file=null-co://,format=raw"
         " -device virtio-scsi-pci"
         " -device scsi-hd,drive=drive0,id=dev0");
diff --git a/tests/ds1338-test.c b/tests/ds1338-test.c
index da5b852351..ad5f5b138a 100644
--- a/tests/ds1338-test.c
+++ b/tests/ds1338-test.c
@@ -60,7 +60,7 @@ int main(int argc, char **argv)

     g_test_init(&argc, &argv, NULL);

-    s = global_qtest = qtest_init("-display none -machine imx25-pdk");
+    s = global_qtest = qtest_start("-display none -machine imx25-pdk");
     i2c = imx_i2c_create(IMX25_I2C_0_BASE);
     addr = DS1338_ADDR;

diff --git a/tests/e1000-test.c b/tests/e1000-test.c
index 59bd8b781f..1ee33fdd52 100644
--- a/tests/e1000-test.c
+++ b/tests/e1000-test.c
@@ -16,7 +16,7 @@ static void test_device(gconstpointer data)
     const char *model = data;
     QTestState *s;

-    s = qtest_init("-device %s", model);
+    s = qtest_start("-device %s", model);
     qtest_quit(s);
 }

diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
index 6ef240dc8f..0f6214b70a 100644
--- a/tests/e1000e-test.c
+++ b/tests/e1000e-test.c
@@ -383,8 +383,8 @@ static void data_test_init(e1000e_device *d)
     int ret = socketpair(PF_UNIX, SOCK_STREAM, 0, test_sockets);
     g_assert_cmpint(ret, != , -1);

-    global_qtest = qtest_init("-netdev socket,fd=%d,id=hs0 "
-                              "-device e1000e,netdev=hs0", test_sockets[1]);
+    global_qtest = qtest_start("-netdev socket,fd=%d,id=hs0 "
+                               "-device e1000e,netdev=hs0", test_sockets[1]);

     test_alloc = pc_alloc_init(global_qtest);
     g_assert_nonnull(test_alloc);
@@ -452,7 +452,7 @@ static void test_e1000e_hotplug(gconstpointer data)
 {
     static const uint8_t slot = 0x06;

-    global_qtest = qtest_init("-device e1000e");
+    global_qtest = qtest_start("-device e1000e");

     qpci_plug_device_test("e1000e", "e1000e_net", slot, NULL);
     qpci_unplug_acpi_device_test("e1000e_net", slot);
diff --git a/tests/eepro100-test.c b/tests/eepro100-test.c
index 6f49ac2656..be31f5d40d 100644
--- a/tests/eepro100-test.c
+++ b/tests/eepro100-test.c
@@ -16,7 +16,7 @@ static void test_device(gconstpointer data)
     QTestState *s;

     /* Tests only initialization so far. TODO: Implement functional tests */
-    s = qtest_init("-device %s", model);
+    s = qtest_start("-device %s", model);
     qtest_quit(s);
 }

diff --git a/tests/endianness-test.c b/tests/endianness-test.c
index 68d5dbcd14..2c0f2df366 100644
--- a/tests/endianness-test.c
+++ b/tests/endianness-test.c
@@ -115,10 +115,10 @@ static void test_endianness(gconstpointer data)
 {
     const TestCase *test = data;

-    global_qtest = qtest_init("-M %s%s%s -device pc-testdev",
-                              test->machine,
-                              test->superio ? " -device " : "",
-                              test->superio ?: "");
+    global_qtest = qtest_start("-M %s%s%s -device pc-testdev",
+                               test->machine,
+                               test->superio ? " -device " : "",
+                               test->superio ?: "");
     isa_outl(test, 0xe0, 0x87654321);
     g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x87654321);
     g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8765);
@@ -187,10 +187,10 @@ static void test_endianness_split(gconstpointer data)
 {
     const TestCase *test = data;

-    global_qtest = qtest_init("-M %s%s%s -device pc-testdev",
-                              test->machine,
-                              test->superio ? " -device " : "",
-                              test->superio ?: "");
+    global_qtest = qtest_start("-M %s%s%s -device pc-testdev",
+                               test->machine,
+                               test->superio ? " -device " : "",
+                               test->superio ?: "");
     isa_outl(test, 0xe8, 0x87654321);
     g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x87654321);
     g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8765);
@@ -231,10 +231,10 @@ static void test_endianness_combine(gconstpointer data)
 {
     const TestCase *test = data;

-    global_qtest = qtest_init("-M %s%s%s -device pc-testdev",
-                              test->machine,
-                              test->superio ? " -device " : "",
-                              test->superio ?: "");
+    global_qtest = qtest_start("-M %s%s%s -device pc-testdev",
+                               test->machine,
+                               test->superio ? " -device " : "",
+                               test->superio ?: "");
     isa_outl(test, 0xe0, 0x87654321);
     g_assert_cmphex(isa_inl(test, 0xe8), ==, 0x87654321);
     g_assert_cmphex(isa_inw(test, 0xea), ==, 0x8765);
diff --git a/tests/es1370-test.c b/tests/es1370-test.c
index edeea13ae7..ff6fdbfe57 100644
--- a/tests/es1370-test.c
+++ b/tests/es1370-test.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/es1370/nop", nop);

-    global_qtest = qtest_init("-device ES1370");
+    global_qtest = qtest_start("-device ES1370");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/fdc-test.c b/tests/fdc-test.c
index 893097f5a3..ec83625db2 100644
--- a/tests/fdc-test.c
+++ b/tests/fdc-test.c
@@ -564,7 +564,7 @@ int main(int argc, char **argv)
     /* Run the tests */
     g_test_init(&argc, &argv, NULL);

-    global_qtest = qtest_init("-device floppy,id=floppy0");
+    global_qtest = qtest_start("-device floppy,id=floppy0");
     qtest_irq_intercept_in(global_qtest, "ioapic");
     qtest_add_func("/fdc/cmos", test_cmos);
     qtest_add_func("/fdc/no_media_on_start", test_no_media_on_start);
diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 3a8dc7a2cd..37214fdf10 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -106,7 +106,7 @@ int main(int argc, char **argv)

     g_test_init(&argc, &argv, NULL);

-    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
+    s = qtest_start("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");

     fw_cfg = pc_fw_cfg_init(s);

diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
index e0b19cdf17..73d23b14b8 100644
--- a/tests/hd-geo-test.c
+++ b/tests/hd-geo-test.c
@@ -241,7 +241,7 @@ static void test_ide_none(void)

     setup_common(argv, ARGV_SIZE);
     args = g_strjoinv(" ", argv);
-    global_qtest = qtest_init("%s", args);
+    global_qtest = qtest_start("%s", args);
     g_strfreev(argv);
     g_free(args);
     test_cmos();
@@ -263,7 +263,7 @@ static void test_ide_mbr(bool use_device, MBRcontents mbr)
         argc = setup_ide(argc, argv, ARGV_SIZE, i, dev, i, mbr, "");
     }
     args = g_strjoinv(" ", argv);
-    global_qtest = qtest_init("%s", args);
+    global_qtest = qtest_start("%s", args);
     g_strfreev(argv);
     g_free(args);
     test_cmos();
@@ -339,7 +339,7 @@ static void test_ide_drive_user(const char *dev, bool trans)
                      dev ? "" : opts);
     g_free(opts);
     args = g_strjoinv(" ", argv);
-    global_qtest = qtest_init("%s", args);
+    global_qtest = qtest_start("%s", args);
     g_strfreev(argv);
     g_free(args);
     test_cmos();
@@ -396,7 +396,7 @@ static void test_ide_drive_cd_0(void)
                          ide_idx, NULL, i, mbr_blank, "");
     }
     args = g_strjoinv(" ", argv);
-    global_qtest = qtest_init("%s", args);
+    global_qtest = qtest_start("%s", args);
     g_strfreev(argv);
     g_free(args);
     test_cmos();
diff --git a/tests/i440fx-test.c b/tests/i440fx-test.c
index bfedd5d953..ac98101e6f 100644
--- a/tests/i440fx-test.c
+++ b/tests/i440fx-test.c
@@ -33,7 +33,7 @@ typedef struct FirmwareTestFixture {

 static QPCIBus *test_start_get_bus(const TestData *s)
 {
-    global_qtest = qtest_init("-smp %d", s->num_cpus);
+    global_qtest = qtest_start("-smp %d", s->num_cpus);
     return qpci_init_pc(global_qtest, NULL);
 }

@@ -340,10 +340,10 @@ static void test_i440fx_firmware(FirmwareTestFixture *fixture,
                                          : "-drive if=pflash,format=raw,file=",
                               fw_pathname);
     g_test_message("qemu cmdline: %s", cmdline);
-    global_qtest = qtest_init("%s", cmdline);
+    global_qtest = qtest_start("%s", cmdline);
     g_free(cmdline);

-    /* QEMU has loaded the firmware (because qtest_init() only returns after
+    /* QEMU has loaded the firmware (because qtest_start() only returns after
      * the QMP handshake completes). We must unlink the firmware blob right
      * here, because any assertion firing below would leak it in the
      * filesystem. This is also the reason why we recreate the blob every time
diff --git a/tests/i82801b11-test.c b/tests/i82801b11-test.c
index 58436172b7..b76714ae16 100644
--- a/tests/i82801b11-test.c
+++ b/tests/i82801b11-test.c
@@ -22,8 +22,8 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/i82801b11/nop", nop);

-    global_qtest = qtest_init("-machine q35 "
-                              "-device i82801b11-bridge,bus=pcie.0,addr=1e.0");
+    global_qtest = qtest_start("-machine q35 "
+                               "-device i82801b11-bridge,bus=pcie.0,addr=1e.0");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/ide-test.c b/tests/ide-test.c
index b22a4fc1c5..7b7cc10176 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -124,7 +124,7 @@ static void ide_test_start(const char *cmdline_fmt, ...)
     cmdline = g_strdup_vprintf(cmdline_fmt, ap);
     va_end(ap);

-    global_qtest = qtest_init("%s", cmdline);
+    global_qtest = qtest_start("%s", cmdline);
     guest_malloc = pc_alloc_init(global_qtest);

     g_free(cmdline);
diff --git a/tests/intel-hda-test.c b/tests/intel-hda-test.c
index c10a59d932..86f7719d39 100644
--- a/tests/intel-hda-test.c
+++ b/tests/intel-hda-test.c
@@ -18,13 +18,13 @@
 /* Tests only initialization so far. TODO: Replace with functional tests */
 static void ich6_test(void)
 {
-    global_qtest = qtest_init("-device intel-hda,id=" HDA_ID CODEC_DEVICES);
+    global_qtest = qtest_start("-device intel-hda,id=" HDA_ID CODEC_DEVICES);
     qtest_quit(global_qtest);
 }

 static void ich9_test(void)
 {
-    global_qtest = qtest_init(
+    global_qtest = qtest_start(
         "-machine q35 -device ich9-intel-hda,bus=pcie.0,addr=1b.0,id="
         HDA_ID CODEC_DEVICES);
     qtest_quit(global_qtest);
diff --git a/tests/ioh3420-test.c b/tests/ioh3420-test.c
index cd5d062370..aff569b99e 100644
--- a/tests/ioh3420-test.c
+++ b/tests/ioh3420-test.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/ioh3420/nop", nop);

-    global_qtest = qtest_init(
+    global_qtest = qtest_start(
         "-machine q35 -device ioh3420,bus=pcie.0,addr=1c.0,port=1,"
         "chassis=1,multifunction=on");
     ret = g_test_run();
diff --git a/tests/ipmi-bt-test.c b/tests/ipmi-bt-test.c
index 476d527cfd..fdcbadb755 100644
--- a/tests/ipmi-bt-test.c
+++ b/tests/ipmi-bt-test.c
@@ -414,7 +414,7 @@ int main(int argc, char **argv)
     /* Run the tests */
     g_test_init(&argc, &argv, NULL);

-    global_qtest = qtest_init(
+    global_qtest = qtest_start(
         " -chardev socket,id=ipmi0,host=localhost,port=%d,reconnect=10"
         " -device ipmi-bmc-extern,chardev=ipmi0,id=bmc0"
         " -device isa-ipmi-bt,bmc=bmc0", emu_port);
diff --git a/tests/ipmi-kcs-test.c b/tests/ipmi-kcs-test.c
index 2bd3771e9f..5acc0d9e35 100644
--- a/tests/ipmi-kcs-test.c
+++ b/tests/ipmi-kcs-test.c
@@ -275,8 +275,8 @@ int main(int argc, char **argv)
     /* Run the tests */
     g_test_init(&argc, &argv, NULL);

-    global_qtest = qtest_init("-device ipmi-bmc-sim,id=bmc0"
-                              " -device isa-ipmi-kcs,bmc=bmc0");
+    global_qtest = qtest_start("-device ipmi-bmc-sim,id=bmc0"
+                               " -device isa-ipmi-kcs,bmc=bmc0");
     qtest_irq_intercept_in(global_qtest, "ioapic");
     qtest_add_func("/ipmi/local/kcs_base", test_kcs_base);
     qtest_add_func("/ipmi/local/kcs_abort", test_kcs_abort);
diff --git a/tests/ipoctal232-test.c b/tests/ipoctal232-test.c
index 5e1cae3917..90b683284a 100644
--- a/tests/ipoctal232-test.c
+++ b/tests/ipoctal232-test.c
@@ -22,8 +22,8 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/ipoctal232/tpci200/nop", nop);

-    global_qtest = qtest_init("-device tpci200,id=ipack0 "
-                              "-device ipoctal232,bus=ipack0.0");
+    global_qtest = qtest_start("-device tpci200,id=ipack0 "
+                               "-device ipoctal232,bus=ipack0.0");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index f254f09487..6ad3e5f834 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -407,7 +407,7 @@ static void test_ivshmem_hotplug(void)
     const char *arch = qtest_get_arch();
     gchar *opts;

-    global_qtest = qtest_init(" ");
+    global_qtest = qtest_start(" ");

     opts = g_strdup_printf("'shm': '%s', 'size': '1M'", tmpshm);

diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index bd9106a132..1dea434e37 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -20,7 +20,7 @@ QOSState *qtest_vboot(QOSOps *ops, const char *cmdline_fmt, va_list ap)
     struct QOSState *qs = g_malloc(sizeof(QOSState));

     cmdline = g_strdup_vprintf(cmdline_fmt, ap);
-    qs->qts = global_qtest = qtest_init("%s", cmdline);
+    qs->qts = global_qtest = qtest_start("%s", cmdline);
     qs->ops = ops;
     if (ops) {
         if (ops->init_allocator) {
diff --git a/tests/m25p80-test.c b/tests/m25p80-test.c
index 18135cfb86..82d9bb9ff0 100644
--- a/tests/m25p80-test.c
+++ b/tests/m25p80-test.c
@@ -363,9 +363,9 @@ int main(int argc, char **argv)
     g_assert(ret == 0);
     close(fd);

-    global_qtest = qtest_init("-m 256 -machine palmetto-bmc "
-                              "-drive file=%s,format=raw,if=mtd",
-                              tmp_path);
+    global_qtest = qtest_start("-m 256 -machine palmetto-bmc "
+                               "-drive file=%s,format=raw,if=mtd",
+                               tmp_path);

     qtest_add_func("/m25p80/read_jedec", test_read_jedec);
     qtest_add_func("/m25p80/erase_sector", test_erase_sector);
diff --git a/tests/m48t59-test.c b/tests/m48t59-test.c
index 52c61fe33e..aadd770f4f 100644
--- a/tests/m48t59-test.c
+++ b/tests/m48t59-test.c
@@ -246,7 +246,7 @@ int main(int argc, char **argv)

     g_test_init(&argc, &argv, NULL);

-    s = global_qtest = qtest_init("-rtc clock=vm");
+    s = global_qtest = qtest_start("-rtc clock=vm");

     qtest_add_func("/rtc/bcd/check-time", bcd_check_time);
     qtest_add_func("/rtc/fuzz-registers", fuzz_registers);
diff --git a/tests/ne2000-test.c b/tests/ne2000-test.c
index d205bc91a6..8e6f7b07c6 100644
--- a/tests/ne2000-test.c
+++ b/tests/ne2000-test.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/ne2000/pci/nop", pci_nop);

-    global_qtest = qtest_init("-device ne2k_pci");
+    global_qtest = qtest_start("-device ne2k_pci");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/numa-test.c b/tests/numa-test.c
index 17bbc0f5f8..5653eaac47 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -25,7 +25,7 @@ static void test_mon_explicit(const void *data)
     cli = make_cli(data, "-smp 8 "
                    "-numa node,nodeid=0,cpus=0-3 "
                    "-numa node,nodeid=1,cpus=4-7 ");
-    global_qtest = qtest_init("%s", cli);
+    global_qtest = qtest_start("%s", cli);

     s = hmp("info numa");
     g_assert(strstr(s, "node 0 cpus: 0 1 2 3"));
@@ -42,7 +42,7 @@ static void test_mon_default(const void *data)
     char *cli;

     cli = make_cli(data, "-smp 8 -numa node -numa node");
-    global_qtest = qtest_init("%s", cli);
+    global_qtest = qtest_start("%s", cli);

     s = hmp("info numa");
     g_assert(strstr(s, "node 0 cpus: 0 2 4 6"));
@@ -61,7 +61,7 @@ static void test_mon_partial(const void *data)
     cli = make_cli(data, "-smp 8 "
                    "-numa node,nodeid=0,cpus=0-1 "
                    "-numa node,nodeid=1,cpus=4-5 ");
-    global_qtest = qtest_init("%s", cli);
+    global_qtest = qtest_start("%s", cli);

     s = hmp("info numa");
     g_assert(strstr(s, "node 0 cpus: 0 1 2 3 6 7"));
@@ -88,7 +88,7 @@ static void test_query_cpus(const void *data)
     QObject *e;

     cli = make_cli(data, "-smp 8 -numa node,cpus=0-3 -numa node,cpus=4-7");
-    global_qtest = qtest_init("%s", cli);
+    global_qtest = qtest_start("%s", cli);
     cpus = get_cpus(&resp);
     g_assert(cpus);

@@ -130,7 +130,7 @@ static void pc_numa_cpu(const void *data)
         "-numa cpu,node-id=0,socket-id=1,core-id=0 "
         "-numa cpu,node-id=0,socket-id=1,core-id=1,thread-id=0 "
         "-numa cpu,node-id=1,socket-id=1,core-id=1,thread-id=1");
-    global_qtest = qtest_init("%s", cli);
+    global_qtest = qtest_start("%s", cli);
     cpus = get_cpus(&resp);
     g_assert(cpus);

@@ -183,7 +183,7 @@ static void spapr_numa_cpu(const void *data)
         "-numa cpu,node-id=0,core-id=1 "
         "-numa cpu,node-id=0,core-id=2 "
         "-numa cpu,node-id=1,core-id=3");
-    global_qtest = qtest_init("%s", cli);
+    global_qtest = qtest_start("%s", cli);
     cpus = get_cpus(&resp);
     g_assert(cpus);

@@ -226,7 +226,7 @@ static void aarch64_numa_cpu(const void *data)
         "-numa node,nodeid=0 -numa node,nodeid=1 "
         "-numa cpu,node-id=1,thread-id=0 "
         "-numa cpu,node-id=0,thread-id=1");
-    global_qtest = qtest_init("%s", cli);
+    global_qtest = qtest_start("%s", cli);
     cpus = get_cpus(&resp);
     g_assert(cpus);

diff --git a/tests/nvme-test.c b/tests/nvme-test.c
index 382d26671f..b054ad6fcd 100644
--- a/tests/nvme-test.c
+++ b/tests/nvme-test.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/nvme/nop", nop);

-    global_qtest = qtest_init(
+    global_qtest = qtest_start(
         "-drive id=drv0,if=none,file=null-co://,format=raw "
         "-device nvme,drive=drv0,serial=foo");
     ret = g_test_run();
diff --git a/tests/pc-cpu-test.c b/tests/pc-cpu-test.c
index 9c36051c07..1243bc64b8 100644
--- a/tests/pc-cpu-test.c
+++ b/tests/pc-cpu-test.c
@@ -29,10 +29,10 @@ static void test_pc_with_cpu_add(gconstpointer data)
     QDict *response;
     unsigned int i;

-    global_qtest = qtest_init("-machine %s -cpu %s "
-                              "-smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
-                              s->machine, s->cpu_model,
-                              s->sockets, s->cores, s->threads, s->maxcpus);
+    global_qtest = qtest_start("-machine %s -cpu %s "
+                               "-smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
+                               s->machine, s->cpu_model,
+                               s->sockets, s->cores, s->threads, s->maxcpus);

     for (i = s->sockets * s->cores * s->threads; i < s->maxcpus; i++) {
         response = qmp("{ 'execute': 'cpu-add',"
@@ -50,10 +50,10 @@ static void test_pc_without_cpu_add(gconstpointer data)
     const PCTestData *s = data;
     QDict *response;

-    global_qtest = qtest_init("-machine %s -cpu %s "
-                              "-smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
-                              s->machine, s->cpu_model,
-                              s->sockets, s->cores, s->threads, s->maxcpus);
+    global_qtest = qtest_start("-machine %s -cpu %s "
+                               "-smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
+                               s->machine, s->cpu_model,
+                               s->sockets, s->cores, s->threads, s->maxcpus);

     response = qmp("{ 'execute': 'cpu-add',"
                    "  'arguments': { 'id': %d } }",
diff --git a/tests/pcnet-test.c b/tests/pcnet-test.c
index 23e36da805..a58a5fd7bf 100644
--- a/tests/pcnet-test.c
+++ b/tests/pcnet-test.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/pcnet/pci/nop", pci_nop);

-    global_qtest = qtest_init("-device pcnet");
+    global_qtest = qtest_start("-device pcnet");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/pnv-xscom-test.c b/tests/pnv-xscom-test.c
index 852322b3f2..ee25bf7dae 100644
--- a/tests/pnv-xscom-test.c
+++ b/tests/pnv-xscom-test.c
@@ -83,7 +83,7 @@ static void test_cfam_id(const void *data)
 {
     const PnvChip *chip = data;

-    global_qtest = qtest_init("-M powernv,accel=tcg -cpu %s", chip->cpu_model);
+    global_qtest = qtest_start("-M powernv,accel=tcg -cpu %s", chip->cpu_model);
     test_xscom_cfam_id(chip);
     qtest_quit(global_qtest);
 }
@@ -106,7 +106,7 @@ static void test_core(const void *data)
 {
     const PnvChip *chip = data;

-    global_qtest = qtest_init("-M powernv,accel=tcg -cpu %s", chip->cpu_model);
+    global_qtest = qtest_start("-M powernv,accel=tcg -cpu %s", chip->cpu_model);
     test_xscom_core(chip);
     qtest_quit(global_qtest);
 }
diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index 20cfb280f6..4cd75400af 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -403,10 +403,10 @@ static void test_migrate(void)

     g_free(bootpath);

-    from = qtest_init("%s", cmd_src);
+    from = qtest_start("%s", cmd_src);
     g_free(cmd_src);

-    to = qtest_init("%s", cmd_dst);
+    to = qtest_start("%s", cmd_dst);
     g_free(cmd_dst);

     assert(!global_qtest);
diff --git a/tests/prom-env-test.c b/tests/prom-env-test.c
index fffef0b252..501075724a 100644
--- a/tests/prom-env-test.c
+++ b/tests/prom-env-test.c
@@ -49,11 +49,11 @@ static void test_machine(const void *machine)
     /* The pseries firmware boots much faster without the default devices */
     extra_args = strcmp(machine, "pseries") == 0 ? "-nodefaults" : "";

-    global_qtest = qtest_init("-M %s,accel=tcg %s "
-                              "-prom-env 'use-nvramrc?=true' "
-                              "-prom-env 'nvramrc=%x %x l!' ",
-                              (const char *)machine, extra_args,
-                              MAGIC, ADDRESS);
+    global_qtest = qtest_start("-M %s,accel=tcg %s "
+                               "-prom-env 'use-nvramrc?=true' "
+                               "-prom-env 'nvramrc=%x %x l!' ",
+                               (const char *)machine, extra_args,
+                               MAGIC, ADDRESS);
     check_guest_memory();
     qtest_quit(global_qtest);
 }
diff --git a/tests/pvpanic-test.c b/tests/pvpanic-test.c
index 48b71be26f..c09b3ddac6 100644
--- a/tests/pvpanic-test.c
+++ b/tests/pvpanic-test.c
@@ -37,7 +37,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/pvpanic/panic", test_panic);

-    global_qtest = qtest_init("-device pvpanic");
+    global_qtest = qtest_start("-device pvpanic");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index eaad88601a..4bcf8ce124 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -23,11 +23,11 @@ static char disk[] = "tests/pxe-test-disk-XXXXXX";

 static void test_pxe_one(const char *params, bool ipv6)
 {
-    global_qtest = qtest_init("-machine accel=kvm:tcg -nodefaults "
-                              "-boot order=n "
-                              "-netdev user,id=" NETNAME ",tftp=./,bootfile=%s,"
-                              "ipv4=%s,ipv6=%s %s", disk, ipv6 ? "off" : "on",
-                              ipv6 ? "on" : "off", params);
+    global_qtest = qtest_start(
+        "-machine accel=kvm:tcg -nodefaults -boot order=n "
+        "-netdev user,id=" NETNAME ",tftp=./,bootfile=%s,"
+        "ipv4=%s,ipv6=%s %s", disk, ipv6 ? "off" : "on",
+        ipv6 ? "on" : "off", params);
     boot_sector_test(global_qtest);
     qtest_quit(global_qtest);
 }
diff --git a/tests/q35-test.c b/tests/q35-test.c
index 91a189ce62..21c0fd9bab 100644
--- a/tests/q35-test.c
+++ b/tests/q35-test.c
@@ -84,7 +84,7 @@ static void test_smram_lock(void)
     QPCIDevice *pcidev;
     QDict *response;

-    global_qtest = qtest_init("-M q35");
+    global_qtest = qtest_start("-M q35");

     pcibus = qpci_init_pc(global_qtest, NULL);
     g_assert(pcibus != NULL);
@@ -141,7 +141,7 @@ static void test_tseg_size(const void *data)
         cmdline = g_strdup_printf("-M q35 -m %uM",
                                   TSEG_SIZE_TEST_GUEST_RAM_MBYTES);
     }
-    global_qtest = qtest_init("%s", cmdline);
+    global_qtest = qtest_start("%s", cmdline);
     g_free(cmdline);

     /* locate the DRAM controller */
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index cf523b325e..14f4f57600 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -76,7 +76,7 @@ static void test_qmp_protocol(void)
     QList *capabilities;
     QTestState *qts;

-    qts = qtest_init_without_qmp_handshake(common_args);
+    qts = qtest_start_without_qmp_handshake(common_args);

     /* Test greeting */
     resp = qtest_qmp_receive(qts);
diff --git a/tests/qom-test.c b/tests/qom-test.c
index 5edd735387..9aecf40f96 100644
--- a/tests/qom-test.c
+++ b/tests/qom-test.c
@@ -92,7 +92,7 @@ static void test_machine(gconstpointer data)
     const char *machine = data;
     QDict *response;

-    global_qtest = qtest_init("-machine %s", machine);
+    global_qtest = qtest_start("-machine %s", machine);

     test_properties("/machine", true);

diff --git a/tests/rtc-test.c b/tests/rtc-test.c
index b6058d28f5..dd5430dd2d 100644
--- a/tests/rtc-test.c
+++ b/tests/rtc-test.c
@@ -690,7 +690,7 @@ int main(int argc, char **argv)

     g_test_init(&argc, &argv, NULL);

-    s = global_qtest = qtest_init("-rtc clock=vm");
+    s = global_qtest = qtest_start("-rtc clock=vm");
     qtest_irq_intercept_in(s, "ioapic");

     qtest_add_func("/rtc/check-time/bcd", bcd_check_time);
diff --git a/tests/rtl8139-test.c b/tests/rtl8139-test.c
index dc9935439f..1741f0ec47 100644
--- a/tests/rtl8139-test.c
+++ b/tests/rtl8139-test.c
@@ -197,7 +197,7 @@ int main(int argc, char **argv)
 {
     int ret;

-    global_qtest = qtest_init("-device rtl8139");
+    global_qtest = qtest_start("-device rtl8139");

     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/rtl8139/nop", nop);
diff --git a/tests/spapr-phb-test.c b/tests/spapr-phb-test.c
index 0d26cbda6c..058ab447d7 100644
--- a/tests/spapr-phb-test.c
+++ b/tests/spapr-phb-test.c
@@ -25,8 +25,8 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/spapr-phb/device", test_phb_device);

-    global_qtest = qtest_init("-device " TYPE_SPAPR_PCI_HOST_BRIDGE
-                              ",index=30");
+    global_qtest = qtest_start("-device " TYPE_SPAPR_PCI_HOST_BRIDGE
+                               ",index=30");

     ret = g_test_run();

diff --git a/tests/tco-test.c b/tests/tco-test.c
index b2a4baeeef..9d406dcdc7 100644
--- a/tests/tco-test.c
+++ b/tests/tco-test.c
@@ -56,9 +56,9 @@ static void test_init(TestData *d)
 {
     QTestState *qs;

-    qs = qtest_init("-machine q35 %s %s",
-                    d->noreboot ? "" : "-global ICH9-LPC.noreboot=false",
-                    !d->args ? "" : d->args);
+    qs = qtest_start("-machine q35 %s %s",
+                     d->noreboot ? "" : "-global ICH9-LPC.noreboot=false",
+                     !d->args ? "" : d->args);
     global_qtest = qs;
     qtest_irq_intercept_in(qs, "ioapic");

diff --git a/tests/test-arm-mptimer.c b/tests/test-arm-mptimer.c
index a4bef2322a..9631c55fe3 100644
--- a/tests/test-arm-mptimer.c
+++ b/tests/test-arm-mptimer.c
@@ -1097,7 +1097,7 @@ tests_with_prescaler_arg:
         goto tests_with_prescaler_arg;
     }

-    global_qtest = qtest_init("-machine vexpress-a9");
+    global_qtest = qtest_start("-machine vexpress-a9");
     ret = g_test_run();
     qtest_quit(global_qtest);

diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index 9d8608a609..18f7af5f25 100644
--- a/tests/test-filter-mirror.c
+++ b/tests/test-filter-mirror.c
@@ -36,7 +36,7 @@ static void test_mirror(void)
     ret = mkstemp(sock_path);
     g_assert_cmpint(ret, !=, -1);

-    global_qtest = qtest_init(
+    global_qtest = qtest_start(
         "-netdev socket,id=qtest-bn0,fd=%d "
         "-device %s,netdev=qtest-bn0,id=qtest-e0 "
         "-chardev socket,id=mirror0,path=%s,server,nowait "
diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirector.c
index b34f8ec2ad..becf74ef14 100644
--- a/tests/test-filter-redirector.c
+++ b/tests/test-filter-redirector.c
@@ -86,7 +86,7 @@ static void test_redirector_tx(void)
     ret = mkstemp(sock_path1);
     g_assert_cmpint(ret, !=, -1);

-    global_qtest = qtest_init(
+    global_qtest = qtest_start(
         "-netdev socket,id=qtest-bn0,fd=%d "
         "-device %s,netdev=qtest-bn0,id=qtest-e0 "
         "-chardev socket,id=redirector0,path=%s,server,nowait "
@@ -155,7 +155,7 @@ static void test_redirector_rx(void)
     ret = mkstemp(sock_path1);
     g_assert_cmpint(ret, !=, -1);

-    global_qtest = qtest_init(
+    global_qtest = qtest_start(
         "-netdev socket,id=qtest-bn0,fd=%d "
         "-device %s,netdev=qtest-bn0,id=qtest-e0 "
         "-chardev socket,id=redirector0,path=%s,server,nowait "
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index dd03693707..d7d5f13a14 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -120,7 +120,7 @@ static void test_machine(gconstpointer data)
 {
     const char *machine = data;

-    global_qtest = qtest_init("-S -M %s", machine);
+    global_qtest = qtest_start("-S -M %s", machine);

     test_info_commands();
     test_commands();
diff --git a/tests/test-netfilter.c b/tests/test-netfilter.c
index 76caaedfc1..1215d13a62 100644
--- a/tests/test-netfilter.c
+++ b/tests/test-netfilter.c
@@ -196,8 +196,8 @@ int main(int argc, char **argv)
     qtest_add_func("/netfilter/remove_netdev_multi",
                    remove_netdev_with_multi_netfilter);

-    global_qtest = qtest_init("-netdev user,id=qtest-bn0 "
-                              "-device %s,netdev=qtest-bn0", devstr);
+    global_qtest = qtest_start("-netdev user,id=qtest-bn0 "
+                               "-device %s,netdev=qtest-bn0", devstr);
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
index 5b026ac38a..a5c2f10ebb 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -59,7 +59,7 @@ static void test_cpuid_prop(const void *data)
     QNum *value;
     int64_t val;

-    global_qtest = qtest_init("%s", args->cmdline);
+    global_qtest = qtest_start("%s", args->cmdline);
     path = get_cpu0_qom_path();
     value = qobject_to_qnum(qom_get(path, args->property));
     g_assert(qnum_get_try_int(value, &val));
@@ -131,7 +131,7 @@ static void test_feature_flag(const void *data)
     QList *present, *filtered;
     uint32_t value;

-    global_qtest = qtest_init("%s", args->cmdline);
+    global_qtest = qtest_start("%s", args->cmdline);
     path = get_cpu0_qom_path();
     present = qobject_to_qlist(qom_get(path, "feature-words"));
     filtered = qobject_to_qlist(qom_get(path, "filtered-features"));
@@ -181,8 +181,8 @@ static void test_plus_minus_subprocess(void)
      * Note: rules 1 and 2 are planned to be removed soon, and
      * should generate a warning.
      */
-    global_qtest = qtest_init("-cpu pentium,-fpu,+fpu,-mce,mce=on,+cx8,"
-                              "cx8=off,+sse4_1,sse4_2=on");
+    global_qtest = qtest_start("-cpu pentium,-fpu,+fpu,-mce,mce=on,+cx8,"
+                               "cx8=off,+sse4_1,sse4_2=on");
     path = get_cpu0_qom_path();

     g_assert_false(qom_get_bool(path, "fpu"));
diff --git a/tests/tmp105-test.c b/tests/tmp105-test.c
index 3ef2efff6e..9233585e4b 100644
--- a/tests/tmp105-test.c
+++ b/tests/tmp105-test.c
@@ -151,9 +151,10 @@ int main(int argc, char **argv)

     g_test_init(&argc, &argv, NULL);

-    s = global_qtest = qtest_init("-machine n800 "
-                    "-device tmp105,bus=i2c-bus.0,id=" TMP105_TEST_ID
-                    ",address=0x49");
+    s = global_qtest = qtest_start(
+        "-machine n800 "
+        "-device tmp105,bus=i2c-bus.0,id=" TMP105_TEST_ID
+        ",address=0x49");
     i2c = omap_i2c_create(OMAP2_I2C_1_BASE);

     qtest_add_func("/tmp105/tx-rx", send_and_receive);
diff --git a/tests/tpci200-test.c b/tests/tpci200-test.c
index 2ed378196d..223d44da35 100644
--- a/tests/tpci200-test.c
+++ b/tests/tpci200-test.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/tpci200/nop", nop);

-    global_qtest = qtest_init("-device tpci200");
+    global_qtest = qtest_start("-device tpci200");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/usb-hcd-ehci-test.c b/tests/usb-hcd-ehci-test.c
index 55349a39a2..c3568a1782 100644
--- a/tests/usb-hcd-ehci-test.c
+++ b/tests/usb-hcd-ehci-test.c
@@ -156,7 +156,7 @@ int main(int argc, char **argv)
     qtest_add_func("/ehci/pci/ehci-port-2", pci_ehci_port_2);
     qtest_add_func("/ehci/pci/ehci-port-3-hotplug", pci_ehci_port_hotplug);

-    global_qtest = qtest_init(
+    global_qtest = qtest_start(
         "-machine q35 -device ich9-usb-ehci1,bus=pcie.0,addr=1d.7,"
         "multifunction=on,id=ich9-ehci-1 "
         "-device ich9-usb-uhci1,bus=pcie.0,addr=1d.0,"
diff --git a/tests/usb-hcd-ohci-test.c b/tests/usb-hcd-ohci-test.c
index 2763c9ec24..62fd35f69a 100644
--- a/tests/usb-hcd-ohci-test.c
+++ b/tests/usb-hcd-ohci-test.c
@@ -31,7 +31,7 @@ int main(int argc, char **argv)
     qtest_add_func("/ohci/pci/init", test_ohci_init);
     qtest_add_func("/ohci/pci/hotplug", test_ohci_hotplug);

-    global_qtest = qtest_init("-device pci-ohci,id=ohci");
+    global_qtest = qtest_start("-device pci-ohci,id=ohci");
     ret = g_test_run();
     qtest_quit(global_qtest);

diff --git a/tests/usb-hcd-xhci-test.c b/tests/usb-hcd-xhci-test.c
index cc3fcd82fa..bd3c65ae85 100644
--- a/tests/usb-hcd-xhci-test.c
+++ b/tests/usb-hcd-xhci-test.c
@@ -80,8 +80,9 @@ int main(int argc, char **argv)
     qtest_add_func("/xhci/pci/hotplug", test_xhci_hotplug);
     qtest_add_func("/xhci/pci/hotplug/usb-uas", test_usb_uas_hotplug);

-    global_qtest = qtest_init("-device nec-usb-xhci,id=xhci"
-                " -drive id=drive0,if=none,file=null-co://,format=raw");
+    global_qtest = qtest_start(
+        "-device nec-usb-xhci,id=xhci"
+        " -drive id=drive0,if=none,file=null-co://,format=raw");
     ret = g_test_run();
     qtest_quit(global_qtest);

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 0dbed5a36a..0fe52428e6 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -644,14 +644,14 @@ static void test_migrate(void)
     test_server_listen(s);
     test_server_listen(dest);

-    s->qts = qtest_init(GET_QEMU_CMDE(s, 2, "", ""));
+    s->qts = qtest_start(GET_QEMU_CMDE(s, 2, "", ""));

     init_virtio_dev(s);
     wait_for_fds(s);
     size = get_log_size(s);
     g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));

-    dest->qts = qtest_init(GET_QEMU_CMDE(dest, 2, "", " -incoming %s", uri));
+    dest->qts = qtest_start(GET_QEMU_CMDE(dest, 2, "", " -incoming %s", uri));

     source = g_source_new(&test_migrate_source_funcs,
                           sizeof(TestMigrateSource));
@@ -746,7 +746,7 @@ static void test_reconnect_subprocess(void)
     TestServer *s = test_server_new("reconnect");

     g_thread_new("connect", connect_thread, s);
-    s->qts = qtest_init(GET_QEMU_CMDE(s, 2, ",server", ""));
+    s->qts = qtest_start(GET_QEMU_CMDE(s, 2, ",server", ""));

     init_virtio_dev(s);
     wait_for_fds(s);
@@ -778,7 +778,7 @@ static void test_connect_fail_subprocess(void)

     s->test_fail = true;
     g_thread_new("connect", connect_thread, s);
-    s->qts = qtest_init(GET_QEMU_CMDE(s, 2, ",server", ""));
+    s->qts = qtest_start(GET_QEMU_CMDE(s, 2, ",server", ""));

     init_virtio_dev(s);
     wait_for_fds(s);
@@ -802,7 +802,7 @@ static void test_flags_mismatch_subprocess(void)

     s->test_flags = TEST_FLAGS_DISCONNECT;
     g_thread_new("connect", connect_thread, s);
-    s->qts = qtest_init(GET_QEMU_CMDE(s, 2, ",server", ""));
+    s->qts = qtest_start(GET_QEMU_CMDE(s, 2, ",server", ""));

     init_virtio_dev(s);
     wait_for_fds(s);
@@ -866,11 +866,11 @@ static void test_multiqueue(void)
     s->queues = queues;
     test_server_listen(s);

-    s->qts = qtest_init(QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=%d "
-                        "-device virtio-net-pci,netdev=net0,mq=on,vectors=%d",
-                        512, 512, root, s->chr_name,
-                        s->socket_path, "", s->chr_name,
-                        queues, queues * 2 + 2);
+    s->qts = qtest_start(QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=%d "
+                         "-device virtio-net-pci,netdev=net0,mq=on,vectors=%d",
+                         512, 512, root, s->chr_name,
+                         s->socket_path, "", s->chr_name,
+                         queues, queues * 2 + 2);

     bus = qpci_init_pc(s->qts, NULL);
     dev = virtio_net_pci_init(bus, PCI_SLOT);
@@ -931,7 +931,7 @@ int main(int argc, char **argv)
     /* run the main loop thread so the chardev may operate */
     thread = g_thread_new(NULL, thread_function, loop);

-    server->qts = qtest_init(GET_QEMU_CMD(server));
+    server->qts = qtest_start(GET_QEMU_CMD(server));
     init_virtio_dev(server);

     qtest_add_data_func("/vhost-user/read-guest-mem", server, read_guest_mem);
diff --git a/tests/virtio-balloon-test.c b/tests/virtio-balloon-test.c
index 7304392c17..cca7b0e8fb 100644
--- a/tests/virtio-balloon-test.c
+++ b/tests/virtio-balloon-test.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/virtio/balloon/pci/nop", pci_nop);

-    global_qtest = qtest_init("-device virtio-balloon-pci");
+    global_qtest = qtest_start("-device virtio-balloon-pci");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 063b0f4013..146e182ae9 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -88,10 +88,10 @@ static void arm_test_start(void)

     tmp_path = drive_create();

-    global_qtest = qtest_init("-machine virt "
-                              "-drive if=none,id=drive0,file=%s,format=raw "
-                              "-device virtio-blk-device,drive=drive0",
-                              tmp_path);
+    global_qtest = qtest_start("-machine virt "
+                               "-drive if=none,id=drive0,file=%s,format=raw "
+                               "-device virtio-blk-device,drive=drive0",
+                               tmp_path);
     unlink(tmp_path);
     g_free(tmp_path);
 }
diff --git a/tests/virtio-console-test.c b/tests/virtio-console-test.c
index 73fb30b051..ce0da47b2d 100644
--- a/tests/virtio-console-test.c
+++ b/tests/virtio-console-test.c
@@ -13,15 +13,15 @@
 /* Tests only initialization so far. TODO: Replace with functional tests */
 static void console_pci_nop(void)
 {
-    global_qtest = qtest_init("-device virtio-serial-pci,id=vser0 "
-                "-device virtconsole,bus=vser0.0");
+    global_qtest = qtest_start("-device virtio-serial-pci,id=vser0 "
+                               "-device virtconsole,bus=vser0.0");
     qtest_quit(global_qtest);
 }

 static void serialport_pci_nop(void)
 {
-    global_qtest = qtest_init("-device virtio-serial-pci,id=vser0 "
-                "-device virtserialport,bus=vser0.0");
+    global_qtest = qtest_start("-device virtio-serial-pci,id=vser0 "
+                               "-device virtserialport,bus=vser0.0");
     qtest_quit(global_qtest);
 }

diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 9b32866fb1..13a4116d26 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -243,7 +243,7 @@ static void hotplug(void)
 {
     const char *arch = qtest_get_arch();

-    global_qtest = qtest_init("-device virtio-net-pci");
+    global_qtest = qtest_start("-device virtio-net-pci");

     qpci_plug_device_test("virtio-net-pci", "net1", PCI_SLOT_HP, NULL);

diff --git a/tests/virtio-rng-test.c b/tests/virtio-rng-test.c
index e1b1e89b59..64b2bd4b19 100644
--- a/tests/virtio-rng-test.c
+++ b/tests/virtio-rng-test.c
@@ -37,7 +37,7 @@ int main(int argc, char **argv)
     qtest_add_func("/virtio/rng/pci/nop", pci_nop);
     qtest_add_func("/virtio/rng/pci/hotplug", hotplug);

-    global_qtest = qtest_init("-device virtio-rng-pci");
+    global_qtest = qtest_start("-device virtio-rng-pci");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/virtio-serial-test.c b/tests/virtio-serial-test.c
index ce708cc11e..1cc43465e6 100644
--- a/tests/virtio-serial-test.c
+++ b/tests/virtio-serial-test.c
@@ -49,7 +49,7 @@ int main(int argc, char **argv)
     qtest_add_func("/virtio/serial/pci/nop", pci_nop);
     qtest_add_func("/virtio/serial/pci/hotplug", hotplug);

-    global_qtest = qtest_init("-device virtio-serial-pci");
+    global_qtest = qtest_start("-device virtio-serial-pci");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index b149690a1a..832c82c32f 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -142,7 +142,7 @@ static void vmgenid_set_guid_test(void)

     g_assert(qemu_uuid_parse(VGID_GUID, &expected) == 0);

-    global_qtest = qtest_init(GUID_CMD(VGID_GUID));
+    global_qtest = qtest_start(GUID_CMD(VGID_GUID));

     /* Read the GUID from accessing guest memory */
     read_guid_from_memory(&measured);
@@ -155,7 +155,7 @@ static void vmgenid_set_guid_auto_test(void)
 {
     QemuUUID measured;

-    global_qtest = qtest_init(GUID_CMD("auto"));
+    global_qtest = qtest_start(GUID_CMD("auto"));

     read_guid_from_memory(&measured);

@@ -171,7 +171,7 @@ static void vmgenid_query_monitor_test(void)

     g_assert(qemu_uuid_parse(VGID_GUID, &expected) == 0);

-    global_qtest = qtest_init(GUID_CMD(VGID_GUID));
+    global_qtest = qtest_start(GUID_CMD(VGID_GUID));

     /* Read the GUID via the monitor */
     read_guid_from_monitor(&measured);
diff --git a/tests/vmxnet3-test.c b/tests/vmxnet3-test.c
index c9a876bcd9..0b4b807616 100644
--- a/tests/vmxnet3-test.c
+++ b/tests/vmxnet3-test.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/vmxnet3/nop", nop);

-    global_qtest = qtest_init("-device vmxnet3");
+    global_qtest = qtest_start("-device vmxnet3");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/wdt_ib700-test.c b/tests/wdt_ib700-test.c
index 4bb8374011..a169265e16 100644
--- a/tests/wdt_ib700-test.c
+++ b/tests/wdt_ib700-test.c
@@ -56,7 +56,7 @@ static QDict *ib700_program_and_wait(QTestState *s)
 static void ib700_pause(void)
 {
     QDict *d;
-    QTestState *s = qtest_init("-watchdog-action pause -device ib700");
+    QTestState *s = qtest_start("-watchdog-action pause -device ib700");

     qtest_irq_intercept_in(s, "ioapic");
     d = ib700_program_and_wait(s);
@@ -69,7 +69,7 @@ static void ib700_pause(void)
 static void ib700_reset(void)
 {
     QDict *d;
-    QTestState *s = qtest_init("-watchdog-action reset -device ib700");
+    QTestState *s = qtest_start("-watchdog-action reset -device ib700");

     qtest_irq_intercept_in(s, "ioapic");
     d = ib700_program_and_wait(s);
@@ -84,7 +84,7 @@ static void ib700_shutdown(void)
     QDict *d;
     QTestState *s;

-    s = qtest_init("-watchdog-action reset -no-reboot -device ib700");
+    s = qtest_start("-watchdog-action reset -no-reboot -device ib700");
     qtest_irq_intercept_in(s, "ioapic");
     d = ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "reset"));
@@ -96,7 +96,7 @@ static void ib700_shutdown(void)
 static void ib700_none(void)
 {
     QDict *d;
-    QTestState *s = qtest_init("-watchdog-action none -device ib700");
+    QTestState *s = qtest_start("-watchdog-action none -device ib700");

     qtest_irq_intercept_in(s, "ioapic");
     d = ib700_program_and_wait(s);
-- 
2.13.5
