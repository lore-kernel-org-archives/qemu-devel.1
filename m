Received: from eggs.gnu.org ([2001:4830:134:3::10]:33952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZL7-0007Xe-Fb
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZL4-0002y9-3b
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:00:57 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:56:37 -0800
Message-ID: <da0b12a6c412264bdd5936380f90d6614e6692fc.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 04/45] tests: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some of the error_report()'s were manually kept as fprintf(stderr, ) to
maintain standalone test cases.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-block@nongnu.org
---
V2:
 - Keep some of the fprintf() calls
 - Remove a file I accidently checked in

 tests/Makefile.include                 |  4 ++--
 tests/ahci-test.c                      |  3 ++-
 tests/bios-tables-test.c               |  5 +++--
 tests/i440fx-test.c                    |  8 ++++----
 tests/libqos/ahci.c                    | 10 +++++-----
 tests/libqos/libqos.c                  |  7 ++++---
 tests/libqos/malloc.c                  | 13 ++++++------
 tests/libqtest.c                       | 13 ++++++------
 tests/migration-test.c                 |  8 ++++----
 tests/migration/stress.c               | 36 +++++++++++++++++-----------------
 tests/qemu-iotests/socket_scm_helper.c | 11 ++++++-----
 tests/rcutorture.c                     |  5 +++--
 tests/tcg/linux-test.c                 |  2 +-
 tests/tcg/runcom.c                     |  6 +++---
 tests/tcg/test-i386-fprem.c            |  2 +-
 tests/tcg/test_path.c                  |  4 ++--
 tests/test-hmp.c                       |  5 +++--
 tests/test-rcu-list.c                  |  5 +++--
 tests/usb-hcd-ehci-test.c              |  2 +-
 tests/vhost-user-bridge.c              | 28 +++++++++++++-------------
 20 files changed, 93 insertions(+), 84 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 434a2ce868..5fcd63eda5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -621,7 +621,7 @@ tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
 	$(test-io-obj-y)
 tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-obj-y)
 tests/test-base64$(EXESUF): tests/test-base64.o $(test-util-obj-y)
-tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o
+tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o $(test-util-obj-y)
 
 tests/test-logging$(EXESUF): tests/test-logging.o $(test-util-obj-y)
 
@@ -788,7 +788,7 @@ tests/migration-test$(EXESUF): tests/migration-test.o
 tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o $(test-util-obj-y) \
 	$(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-pc-obj-y) \
 	$(chardev-obj-y)
-tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_scm_helper.o
+tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_scm_helper.o $(test-util-obj-y)
 tests/test-qemu-opts$(EXESUF): tests/test-qemu-opts.o $(test-util-obj-y)
 tests/test-keyval$(EXESUF): tests/test-keyval.o $(test-util-obj-y) $(test-qapi-obj-y)
 tests/test-write-threshold$(EXESUF): tests/test-write-threshold.o $(test-block-obj-y)
diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index cb84edc8fb..ac8a30ab8b 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include <getopt.h>
 
 #include "libqtest.h"
@@ -1859,7 +1860,7 @@ int main(int argc, char **argv)
             ahci_pedantic = 1;
             break;
         default:
-            fprintf(stderr, "Unrecognized ahci_test option.\n");
+            error_report("Unrecognized ahci_test option.");
             g_assert_not_reached();
         }
     }
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 564da45f65..0955c72a74 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include <glib/gstdio.h>
 #include "qemu-common.h"
 #include "hw/smbios/smbios.h"
@@ -396,7 +397,7 @@ try_again:
         aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
                                    (gchar *)&signature, ext);
         if (getenv("V")) {
-            fprintf(stderr, "\nLooking for expected file '%s'\n", aml_file);
+            error_report("Looking for expected file '%s'", aml_file);
         }
         if (g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
             exp_sdt.aml_file = aml_file;
@@ -408,7 +409,7 @@ try_again:
         }
         g_assert(exp_sdt.aml_file);
         if (getenv("V")) {
-            fprintf(stderr, "\nUsing expected file '%s'\n", aml_file);
+            error_report("Using expected file '%s'", aml_file);
         }
         ret = g_file_get_contents(aml_file, &exp_sdt.aml,
                                   &exp_sdt.aml_len, &error);
diff --git a/tests/i440fx-test.c b/tests/i440fx-test.c
index e9d05c87d1..75fb9742ce 100644
--- a/tests/i440fx-test.c
+++ b/tests/i440fx-test.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-
+#include "qemu/error-report.h"
 #include "libqtest.h"
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
@@ -295,18 +295,18 @@ static char *create_blob_file(void)
     ret = -1;
     fd = g_file_open_tmp("blob_XXXXXX", &pathname, &error);
     if (fd == -1) {
-        fprintf(stderr, "unable to create blob file: %s\n", error->message);
+        error_report("unable to create blob file: %s", error->message);
         g_error_free(error);
     } else {
         if (ftruncate(fd, BLOB_SIZE) == -1) {
-            fprintf(stderr, "ftruncate(\"%s\", %zu): %s\n", pathname,
+            error_report("ftruncate(\"%s\", %zu): %s", pathname,
                     BLOB_SIZE, strerror(errno));
         } else {
             void *buf;
 
             buf = mmap(NULL, BLOB_SIZE, PROT_WRITE, MAP_SHARED, fd, 0);
             if (buf == MAP_FAILED) {
-                fprintf(stderr, "mmap(\"%s\", %zu): %s\n", pathname, BLOB_SIZE,
+                error_report("mmap(\"%s\", %zu): %s", pathname, BLOB_SIZE,
                         strerror(errno));
             } else {
                 size_t i;
diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
index 13c0749582..286f5c3e64 100644
--- a/tests/libqos/ahci.c
+++ b/tests/libqos/ahci.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-
+#include "qemu/error-report.h"
 #include "libqtest.h"
 #include "libqos/ahci.h"
 #include "libqos/pci-pc.h"
@@ -985,9 +985,9 @@ static void ahci_atapi_command_set_offset(AHCICommand *cmd, uint64_t lba)
     default:
         /* SCSI doesn't have uniform packet formats,
          * so you have to add support for it manually. Sorry! */
-        fprintf(stderr, "The Libqos AHCI driver does not support the "
+        error_report("The Libqos AHCI driver does not support the "
                 "set_offset operation for ATAPI command 0x%02x, "
-                "please add support.\n",
+                "please add support.",
                 cbd[0]);
         g_assert_not_reached();
     }
@@ -1060,8 +1060,8 @@ static void ahci_atapi_set_size(AHCICommand *cmd, uint64_t xbytes)
     default:
         /* SCSI doesn't have uniform packet formats,
          * so you have to add support for it manually. Sorry! */
-        fprintf(stderr, "The Libqos AHCI driver does not support the set_size "
-                "operation for ATAPI command 0x%02x, please add support.\n",
+        error_report("The Libqos AHCI driver does not support the set_size "
+                "operation for ATAPI command 0x%02x, please add support.",
                 cbd[0]);
         g_assert_not_reached();
     }
diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index 991bc1aec2..c84ffb6925 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include <sys/wait.h>
 
 #include "libqtest.h"
@@ -155,7 +156,7 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
             continue;
         }
 
-        fprintf(stderr, "Migration did not complete, status: %s\n", st);
+        error_report("Migration did not complete, status: %s", st);
         g_assert_not_reached();
     }
 
@@ -199,7 +200,7 @@ void mkimg(const char *file, const char *fmt, unsigned size_mb)
                           fmt, file, size_mb);
     ret = g_spawn_command_line_sync(cli, &out, &out2, &rc, &err);
     if (err) {
-        fprintf(stderr, "%s\n", err->message);
+        error_report("%s", err->message);
         g_error_free(err);
     }
     g_assert(ret && !err);
@@ -210,7 +211,7 @@ void mkimg(const char *file, const char *fmt, unsigned size_mb)
      * 0 is only possible if the program exited normally, so that should be
      * sufficient for our purposes on all platforms, here. */
     if (rc) {
-        fprintf(stderr, "qemu-img returned status code %d\n", rc);
+        error_report("qemu-img returned status code %d", rc);
     }
     g_assert(!rc);
 
diff --git a/tests/libqos/malloc.c b/tests/libqos/malloc.c
index ac05874b0a..a655a25f1f 100644
--- a/tests/libqos/malloc.c
+++ b/tests/libqos/malloc.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "libqos/malloc.h"
 #include "qemu-common.h"
 #include "qemu/host-utils.h"
@@ -193,7 +194,7 @@ static uint64_t mlist_alloc(QGuestAllocator *s, uint64_t size)
 
     node = mlist_find_space(s->free, size);
     if (!node) {
-        fprintf(stderr, "Out of guest memory.\n");
+        error_report("Out of guest memory.");
         g_assert_not_reached();
     }
     return mlist_fulfill(s, node, size);
@@ -209,8 +210,8 @@ static void mlist_free(QGuestAllocator *s, uint64_t addr)
 
     node = mlist_find_key(s->used, addr);
     if (!node) {
-        fprintf(stderr, "Error: no record found for an allocation at "
-                "0x%016" PRIx64 ".\n",
+        error_report("Error: no record found for an allocation at "
+                "0x%016" PRIx64 ".",
                 addr);
         g_assert_not_reached();
     }
@@ -234,8 +235,8 @@ void alloc_uninit(QGuestAllocator *allocator)
     /* Check for guest leaks, and destroy the list. */
     QTAILQ_FOREACH_SAFE(node, allocator->used, MLIST_ENTNAME, tmp) {
         if (allocator->opts & (ALLOC_LEAK_WARN | ALLOC_LEAK_ASSERT)) {
-            fprintf(stderr, "guest malloc leak @ 0x%016" PRIx64 "; "
-                    "size 0x%016" PRIx64 ".\n",
+            error_report("guest malloc leak @ 0x%016" PRIx64 "; "
+                    "size 0x%016" PRIx64 ".",
                     node->addr, node->size);
         }
         if (allocator->opts & (ALLOC_LEAK_ASSERT)) {
@@ -251,7 +252,7 @@ void alloc_uninit(QGuestAllocator *allocator)
         if ((allocator->opts & mask) == mask) {
             if ((node->addr != allocator->start) ||
                 (node->size != allocator->end - allocator->start)) {
-                fprintf(stderr, "Free list is corrupted.\n");
+                error_report("Free list is corrupted.");
                 g_assert_not_reached();
             }
         }
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 0ec8af2923..b0fca61f79 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -15,6 +15,7 @@
  *
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "libqtest.h"
 
 #include <sys/socket.h>
@@ -89,7 +90,7 @@ static int socket_accept(int sock)
         ret = accept(sock, (struct sockaddr *)&addr, &addrlen);
     } while (ret == -1 && errno == EINTR);
     if (ret == -1) {
-        fprintf(stderr, "%s failed: %s\n", __func__, strerror(errno));
+        error_report("%s failed: %s", __func__, strerror(errno));
     }
     close(sock);
 
@@ -155,7 +156,7 @@ static const char *qtest_qemu_binary(void)
 
     qemu_bin = getenv("QTEST_QEMU_BINARY");
     if (!qemu_bin) {
-        fprintf(stderr, "Environment variable QTEST_QEMU_BINARY required\n");
+        error_report("Environment variable QTEST_QEMU_BINARY required");
         exit(1);
     }
 
@@ -334,7 +335,7 @@ static GString *qtest_recv_line(QTestState *s)
         }
 
         if (len == -1 || len == 0) {
-            fprintf(stderr, "Broken pipe\n");
+            error_report("Broken pipe");
             exit(1);
         }
 
@@ -419,7 +420,7 @@ static void qmp_response(JSONMessageParser *parser, GQueue *tokens)
 
     obj = json_parser_parse(tokens, NULL);
     if (!obj) {
-        fprintf(stderr, "QMP JSON response parsing failed\n");
+        error_report("QMP JSON response parsing failed");
         exit(1);
     }
 
@@ -445,7 +446,7 @@ QDict *qmp_fd_receive(int fd)
         }
 
         if (len == -1 || len == 0) {
-            fprintf(stderr, "Broken pipe\n");
+            error_report("Broken pipe");
             exit(1);
         }
 
@@ -902,7 +903,7 @@ void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size)
 
     g_base64_decode_inplace(args[1], &len);
     if (size != len) {
-        fprintf(stderr, "bufread: asked for %zu bytes but decoded %zu\n",
+        error_report("bufread: asked for %zu bytes but decoded %zu",
                 size, len);
         len = MIN(len, size);
     }
diff --git a/tests/migration-test.c b/tests/migration-test.c
index be598d3257..2918a322fb 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-
+#include "qemu/error-report.h"
 #include "libqtest.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
@@ -214,7 +214,7 @@ static void wait_for_serial(const char *side)
             break;
 
         default:
-            fprintf(stderr, "Unexpected %d on %s serial\n", readvalue, side);
+            error_report("Unexpected %d on %s serial", readvalue, side);
             g_assert_not_reached();
         }
     } while (true);
@@ -334,9 +334,9 @@ static void check_guests_ram(QTestState *who)
                  */
                 hit_edge = true;
             } else {
-                fprintf(stderr, "Memory content inconsistency at %x"
+                error_report("Memory content inconsistency at %x"
                                 " first_byte = %x last_byte = %x current = %x"
-                                " hit_edge = %x\n",
+                                " hit_edge = %x",
                                 address, first_byte, last_byte, b, hit_edge);
                 bad = true;
             }
diff --git a/tests/migration/stress.c b/tests/migration/stress.c
index cf8ce8b16d..49e1ff4555 100644
--- a/tests/migration/stress.c
+++ b/tests/migration/stress.c
@@ -47,7 +47,7 @@ static __attribute__((noreturn)) void exit_failure(void)
     if (getpid() == 1) {
         sync();
         reboot(RB_POWER_OFF);
-        fprintf(stderr, "%s (%05d): ERROR: cannot reboot: %s\n",
+        error_report("%s (%05d): cannot reboot: %s",
                 argv0, gettid(), strerror(errno));
         abort();
     } else {
@@ -60,7 +60,7 @@ static __attribute__((noreturn)) void exit_success(void)
     if (getpid() == 1) {
         sync();
         reboot(RB_POWER_OFF);
-        fprintf(stderr, "%s (%05d): ERROR: cannot reboot: %s\n",
+        error_report("%s (%05d): cannot reboot: %s",
                 argv0, gettid(), strerror(errno));
         abort();
     } else {
@@ -76,13 +76,13 @@ static int get_command_arg_str(const char *name,
     char *start, *end;
 
     if (fp == NULL) {
-        fprintf(stderr, "%s (%05d): ERROR: cannot open /proc/cmdline: %s\n",
+        error_report("%s (%05d): cannot open /proc/cmdline: %s",
                 argv0, gettid(), strerror(errno));
         return -1;
     }
 
     if (!fgets(line, sizeof line, fp)) {
-        fprintf(stderr, "%s (%05d): ERROR: cannot read /proc/cmdline: %s\n",
+        error_report("%s (%05d): cannot read /proc/cmdline: %s",
                 argv0, gettid(), strerror(errno));
         fclose(fp);
         return -1;
@@ -96,8 +96,8 @@ static int get_command_arg_str(const char *name,
     start += strlen(name);
 
     if (*start != '=') {
-        fprintf(stderr, "%s (%05d): ERROR: no value provided for '%s' in /proc/cmdline\n",
-                argv0, gettid(), name);
+        error_report("%s (%05d): no value provided for '%s' in /proc/cmdline",
+                     argv0, gettid(), name);
     }
     start++;
 
@@ -106,8 +106,8 @@ static int get_command_arg_str(const char *name,
         end = strstr(start, "\n");
 
     if (end == start) {
-        fprintf(stderr, "%s (%05d): ERROR: no value provided for '%s' in /proc/cmdline\n",
-                argv0, gettid(), name);
+        error_report("%s (%05d): no value provided for '%s' in /proc/cmdline",
+                     argv0, gettid(), name);
         return -1;
     }
 
@@ -132,7 +132,7 @@ static int get_command_arg_ull(const char *name,
     errno = 0;
     *val = strtoll(valstr, &end, 10);
     if (errno || *end) {
-        fprintf(stderr, "%s (%05d): ERROR: cannot parse %s value %s\n",
+        error_report("%s (%05d): cannot parse %s value %s",
                 argv0, gettid(), name, valstr);
         free(valstr);
         return -1;
@@ -148,13 +148,13 @@ static int random_bytes(char *buf, size_t len)
 
     fd = open("/dev/urandom", O_RDONLY);
     if (fd < 0) {
-        fprintf(stderr, "%s (%05d): ERROR: cannot open /dev/urandom: %s\n",
+        error_report("%s (%05d): cannot open /dev/urandom: %s",
                 argv0, gettid(), strerror(errno));
         return -1;
     }
 
     if (read(fd, buf, len) != len) {
-        fprintf(stderr, "%s (%05d): ERROR: cannot read /dev/urandom: %s\n",
+        error_report("%s (%05d): cannot read /dev/urandom: %s",
                 argv0, gettid(), strerror(errno));
         close(fd);
         return -1;
@@ -187,12 +187,12 @@ static int stressone(unsigned long long ramsizeMB)
     unsigned long long before, after;
 
     if (!ram) {
-        fprintf(stderr, "%s (%05d): ERROR: cannot allocate %llu MB of RAM: %s\n",
+        error_report("%s (%05d): cannot allocate %llu MB of RAM: %s",
                 argv0, gettid(), ramsizeMB, strerror(errno));
         return -1;
     }
     if (!data) {
-        fprintf(stderr, "%s (%d): ERROR: cannot allocate %d bytes of RAM: %s\n",
+        error_report("%s (%d): cannot allocate %d bytes of RAM: %s",
                 argv0, gettid(), PAGE_SIZE, strerror(errno));
         free(ram);
         return -1;
@@ -271,13 +271,13 @@ static int stress(unsigned long long ramsizeGB, int ncpus)
 static int mount_misc(const char *fstype, const char *dir)
 {
     if (mkdir(dir, 0755) < 0 && errno != EEXIST) {
-        fprintf(stderr, "%s (%05d): ERROR: cannot create %s: %s\n",
+        error_report("%s (%05d): cannot create %s: %s",
                 argv0, gettid(), dir, strerror(errno));
         return -1;
     }
 
     if (mount("none", dir, fstype, 0, NULL) < 0) {
-        fprintf(stderr, "%s (%05d): ERROR: cannot mount %s: %s\n",
+        error_report("%s (%05d): cannot mount %s: %s",
                 argv0, gettid(), dir, strerror(errno));
         return -1;
     }
@@ -322,7 +322,7 @@ int main(int argc, char **argv)
             errno = 0;
             ramsizeGB = strtoll(optarg, &end, 10);
             if (errno != 0 || *end) {
-                fprintf(stderr, "%s (%05d): ERROR: Cannot parse RAM size %s\n",
+                error_report("%s (%05d): Cannot parse RAM size %s",
                         argv0, gettid(), optarg);
                 exit_failure();
             }
@@ -332,7 +332,7 @@ int main(int argc, char **argv)
             errno = 0;
             ncpus = strtoll(optarg, &end, 10);
             if (errno != 0 || *end) {
-                fprintf(stderr, "%s (%05d): ERROR: Cannot parse CPU count %s\n",
+                error_report("%s (%05d): Cannot parse CPU count %s",
                         argv0, gettid(), optarg);
                 exit_failure();
             }
@@ -340,7 +340,7 @@ int main(int argc, char **argv)
 
         case '?':
         case 'h':
-            fprintf(stderr, "%s: [--help][--ramsize GB][--cpus N]\n", argv0);
+            error_report("%s: [--help][--ramsize GB][--cpus N]", argv0);
             exit_failure();
         }
     }
diff --git a/tests/qemu-iotests/socket_scm_helper.c b/tests/qemu-iotests/socket_scm_helper.c
index eb76d31aa9..7785da953a 100644
--- a/tests/qemu-iotests/socket_scm_helper.c
+++ b/tests/qemu-iotests/socket_scm_helper.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include <sys/socket.h>
 #include <sys/un.h>
 
@@ -53,7 +54,7 @@ static int send_fd(int fd, int fd_to_send)
     } while (ret < 0 && errno == EINTR);
 
     if (ret < 0) {
-        fprintf(stderr, "Failed to send msg, reason: %s\n", strerror(errno));
+        error_report("Failed to send msg, reason: %s", strerror(errno));
     }
 
     return ret;
@@ -69,14 +70,14 @@ static int get_fd_num(const char *fd_str, bool silent)
     sock = strtol(fd_str, &err, 10);
     if (errno) {
         if (!silent) {
-            fprintf(stderr, "Failed in strtol for socket fd, reason: %s\n",
+            error_report("Failed in strtol for socket fd, reason: %s",
                     strerror(errno));
         }
         return -1;
     }
     if (!*fd_str || *err || sock < 0) {
         if (!silent) {
-            fprintf(stderr, "bad numerical value for socket fd '%s'\n", fd_str);
+            error_report("bad numerical value for socket fd '%s'", fd_str);
         }
         return -1;
     }
@@ -96,7 +97,7 @@ int main(int argc, char **argv, char **envp)
 #ifdef SOCKET_SCM_DEBUG
     int i;
     for (i = 0; i < argc; i++) {
-        fprintf(stderr, "Parameter %d: %s\n", i, argv[i]);
+        error_report("Parameter %d: %s", i, argv[i]);
     }
 #endif
 
@@ -120,7 +121,7 @@ int main(int argc, char **argv, char **envp)
            is supposed to fork and exec this program. */
         fd = open(argv[2], O_RDONLY);
         if (fd < 0) {
-            fprintf(stderr, "Failed to open file '%s'\n", argv[2]);
+            error_report("Failed to open file '%s'", argv[2]);
             return EXIT_FAILURE;
         }
     }
diff --git a/tests/rcutorture.c b/tests/rcutorture.c
index 4002ecf123..21d2c76d0b 100644
--- a/tests/rcutorture.c
+++ b/tests/rcutorture.c
@@ -61,6 +61,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/atomic.h"
 #include "qemu/rcu.h"
 #include "qemu/thread.h"
@@ -86,7 +87,7 @@ static int n_threads;
 static void create_thread(void *(*func)(void *))
 {
     if (n_threads >= NR_THREADS) {
-        fprintf(stderr, "Thread limit of %d exceeded!\n", NR_THREADS);
+        error_report("Thread limit of %d exceeded!", NR_THREADS);
         exit(-1);
     }
     qemu_thread_create(&threads[n_threads], "test", func, &data[n_threads],
@@ -417,7 +418,7 @@ static void gtest_stress_10_5(void)
 
 static void usage(int argc, char *argv[])
 {
-    fprintf(stderr, "Usage: %s [nreaders [ perf | stress ] ]\n", argv[0]);
+    error_report("Usage: %s [nreaders [ perf | stress ] ]", argv[0]);
     exit(-1);
 }
 
diff --git a/tests/tcg/linux-test.c b/tests/tcg/linux-test.c
index 5070d31446..76c9059073 100644
--- a/tests/tcg/linux-test.c
+++ b/tests/tcg/linux-test.c
@@ -51,7 +51,7 @@ void error1(const char *filename, int line, const char *fmt, ...)
     va_start(ap, fmt);
     fprintf(stderr, "%s:%d: ", filename, line);
     vfprintf(stderr, fmt, ap);
-    fprintf(stderr, "\n");
+    error_report("");
     va_end(ap);
     exit(1);
 }
diff --git a/tests/tcg/runcom.c b/tests/tcg/runcom.c
index d60342bfc6..7acf0239c8 100644
--- a/tests/tcg/runcom.c
+++ b/tests/tcg/runcom.c
@@ -61,7 +61,7 @@ void dump_regs(struct vm86_regs *r)
 #ifdef SIGTEST
 void alarm_handler(int sig)
 {
-    fprintf(stderr, "alarm signal=%d\n", sig);
+    error_report("alarm signal=%d", sig);
     alarm(1);
 }
 #endif
@@ -172,7 +172,7 @@ int main(int argc, char **argv)
                     break;
                 default:
                 unknown_int:
-                    fprintf(stderr, "unsupported int 0x%02x\n", int_num);
+                    error_report("unsupported int 0x%02x", int_num);
                     dump_regs(&ctx.regs);
                     //                    exit(1);
                 }
@@ -184,7 +184,7 @@ int main(int argc, char **argv)
         case VM86_STI:
             break;
         default:
-            fprintf(stderr, "unhandled vm86 return code (0x%x)\n", ret);
+            error_report("unhandled vm86 return code (0x%x)", ret);
             dump_regs(&ctx.regs);
             exit(1);
         }
diff --git a/tests/tcg/test-i386-fprem.c b/tests/tcg/test-i386-fprem.c
index 1a71623204..7c3d37d07a 100644
--- a/tests/tcg/test-i386-fprem.c
+++ b/tests/tcg/test-i386-fprem.c
@@ -340,7 +340,7 @@ static void test_fprem_pairs(void)
         }
     }
 
-    fprintf(stderr, "test-i386-fprem: tested %llu cases\n", count);
+    error_report("test-i386-fprem: tested %llu cases", count);
 }
 
 int main(int argc, char **argv)
diff --git a/tests/tcg/test_path.c b/tests/tcg/test_path.c
index 1c29bce263..d543bb76ef 100644
--- a/tests/tcg/test_path.c
+++ b/tests/tcg/test_path.c
@@ -150,8 +150,8 @@ int main(int argc, char *argv[])
     ret = do_test();
     cleanup();
     if (ret) {
-	fprintf(stderr, "test_path: failed on line %i\n", ret);
-	return 1;
+        error_report("test_path: failed on line %i", ret);
+        return 1;
     }
     return 0;
 }
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 5677fbf775..ff86220814 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "libqtest.h"
 
 static int verbose;
@@ -79,7 +80,7 @@ static void test_commands(void)
 
     for (i = 0; hmp_cmds[i] != NULL; i++) {
         if (verbose) {
-            fprintf(stderr, "\t%s\n", hmp_cmds[i]);
+            error_report("\t%s", hmp_cmds[i]);
         }
         response = hmp("%s", hmp_cmds[i]);
         g_free(response);
@@ -102,7 +103,7 @@ static void test_info_commands(void)
         *endp = '\0';
         /* Now run the info command */
         if (verbose) {
-            fprintf(stderr, "\t%s\n", info);
+            error_report("\t%s", info);
         }
         resp = hmp("%s", info);
         g_free(resp);
diff --git a/tests/test-rcu-list.c b/tests/test-rcu-list.c
index 1514d7ec97..00a03de370 100644
--- a/tests/test-rcu-list.c
+++ b/tests/test-rcu-list.c
@@ -21,6 +21,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/atomic.h"
 #include "qemu/rcu.h"
 #include "qemu/thread.h"
@@ -64,7 +65,7 @@ static int select_random_el(int max)
 static void create_thread(void *(*func)(void *))
 {
     if (n_threads >= NR_THREADS) {
-        fprintf(stderr, "Thread limit of %d exceeded!\n", NR_THREADS);
+        error_report("Thread limit of %d exceeded!", NR_THREADS);
         exit(-1);
     }
     qemu_thread_create(&threads[n_threads], "test", func, &data[n_threads],
@@ -255,7 +256,7 @@ static void rcu_qtest(const char *test, int duration, int nreaders)
 
 static void usage(int argc, char *argv[])
 {
-    fprintf(stderr, "Usage: %s duration nreaders\n", argv[0]);
+    error_report("Usage: %s duration nreaders", argv[0]);
     exit(-1);
 }
 
diff --git a/tests/usb-hcd-ehci-test.c b/tests/usb-hcd-ehci-test.c
index 944eb1c088..1e7ef842e5 100644
--- a/tests/usb-hcd-ehci-test.c
+++ b/tests/usb-hcd-ehci-test.c
@@ -42,7 +42,7 @@ static void ehci_port_test(struct qhc *hc, int port, uint32_t expect)
     uint16_t mask = ~(PORTSC_CSC | PORTSC_PEDC | PORTSC_OCC);
 
 #if 0
-    fprintf(stderr, "%s: %d, have 0x%08x, want 0x%08x\n",
+    error_report("%s: %d, have 0x%08x, want 0x%08x",
             __func__, port, value & mask, expect & mask);
 #endif
     g_assert((value & mask) == (expect & mask));
diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index d820033a72..31a884e0da 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -181,7 +181,7 @@ vubr_handle_tx(VuDev *dev, int qidx)
         out_num = elem->out_num;
         out_sg = elem->out_sg;
         if (out_num < 1) {
-            fprintf(stderr, "virtio-net header not in first element\n");
+            error_report("virtio-net header not in first element");
             break;
         }
         if (VHOST_USER_BRIDGE_DEBUG) {
@@ -294,7 +294,7 @@ vubr_backend_recv_cb(int sock, void *ctx)
         }
 
         if (elem->in_num < 1) {
-            fprintf(stderr, "virtio-net contains no in buffers\n");
+            error_report("virtio-net contains no in buffers");
             break;
         }
 
@@ -364,7 +364,7 @@ vubr_receive_cb(int sock, void *ctx)
     VubrDev *vubr = (VubrDev *)ctx;
 
     if (!vu_dispatch(&vubr->vudev)) {
-        fprintf(stderr, "Error while dispatching\n");
+        error_report("Error while dispatching");
     }
 }
 
@@ -461,7 +461,7 @@ vubr_panic(VuDev *dev, const char *msg)
 {
     VubrDev *vubr = container_of(dev, VubrDev, vudev);
 
-    fprintf(stderr, "PANIC: %s\n", msg);
+    error_report("PANIC: %s", msg);
 
     dispatcher_remove(&vubr->dispatcher, dev->sock);
     vubr->quit = 1;
@@ -562,14 +562,14 @@ vubr_set_host(struct sockaddr_in *saddr, const char *host)
 {
     if (isdigit(host[0])) {
         if (!inet_aton(host, &saddr->sin_addr)) {
-            fprintf(stderr, "inet_aton() failed.\n");
+            error_report("inet_aton() failed.");
             exit(1);
         }
     } else {
         struct hostent *he = gethostbyname(host);
 
         if (!he) {
-            fprintf(stderr, "gethostbyname() failed.\n");
+            error_report("gethostbyname() failed.");
             exit(1);
         }
         saddr->sin_addr = *(struct in_addr *)he->h_addr;
@@ -590,13 +590,13 @@ vubr_backend_udp_setup(VubrDev *dev,
 
     lport = strtol(local_port, (char **)&r, 0);
     if (r == local_port) {
-        fprintf(stderr, "lport parsing failed.\n");
+        error_report("lport parsing failed.");
         exit(1);
     }
 
     rport = strtol(remote_port, (char **)&r, 0);
     if (r == remote_port) {
-        fprintf(stderr, "rport parsing failed.\n");
+        error_report("rport parsing failed.");
         exit(1);
     }
 
@@ -714,15 +714,15 @@ main(int argc, char *argv[])
     return 0;
 
 out:
-    fprintf(stderr, "Usage: %s ", argv[0]);
-    fprintf(stderr, "[-c] [-u ud_socket_path] [-l lhost:lport] [-r rhost:rport]\n");
-    fprintf(stderr, "\t-u path to unix doman socket. default: %s\n",
+    error_report("Usage: %s ", argv[0]);
+    error_report("[-c] [-u ud_socket_path] [-l lhost:lport] [-r rhost:rport]");
+    error_report("\t-u path to unix doman socket. default: %s",
             DEFAULT_UD_SOCKET);
-    fprintf(stderr, "\t-l local host and port. default: %s:%s\n",
+    fprintf(stderr, "\t-l local host and port. default: %s:%s",
             DEFAULT_LHOST, DEFAULT_LPORT);
-    fprintf(stderr, "\t-r remote host and port. default: %s:%s\n",
+    error_report("\t-r remote host and port. default: %s:%s",
             DEFAULT_RHOST, DEFAULT_RPORT);
-    fprintf(stderr, "\t-c client mode\n");
+    error_report("\t-c client mode");
 
     return 1;
 }
-- 
2.14.1
