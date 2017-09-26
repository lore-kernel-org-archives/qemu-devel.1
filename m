Received: from eggs.gnu.org ([2001:4830:134:3::10]:55925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dwdVW-0003X3-1u
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 20:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dwdVB-00061r-OY
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 20:13:50 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 25 Sep 2017 17:08:48 -0700
Message-ID: <50c325943b1547813567efe6a11fb44644494d70.1506384414.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1506384414.git.alistair.francis@xilinx.com>
References: <cover.1506384414.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 2/8] tests: Replace fprintf(stderr,
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

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-block@nongnu.org
---

 tests/Makefile.include                 |   4 ++--
 tests/ahci-test.c                      |   3 ++-
 tests/atomic_add-bench.c               |   2 +-
 tests/bios-tables-test.c               |   5 +++--
 tests/check-qlit                       | Bin 0 -> 272776 bytes
 tests/i440fx-test.c                    |   8 ++++----
 tests/libqos/ahci.c                    |  10 ++++-----
 tests/libqos/libqos.c                  |   7 ++++---
 tests/libqos/malloc.c                  |  13 ++++++------
 tests/libqtest.c                       |  13 ++++++------
 tests/migration/stress.c               |  36 ++++++++++++++++-----------------
 tests/postcopy-test.c                  |   8 ++++----
 tests/qemu-iotests/socket_scm_helper.c |  11 +++++-----
 tests/qht-bench.c                      |   5 +++--
 tests/rcutorture.c                     |   5 +++--
 tests/tcg/linux-test.c                 |   2 +-
 tests/tcg/runcom.c                     |   6 +++---
 tests/tcg/test-i386-fprem.c            |   2 +-
 tests/tcg/test_path.c                  |   4 ++--
 tests/test-hmp.c                       |   5 +++--
 tests/test-rcu-list.c                  |   5 +++--
 tests/usb-hcd-ehci-test.c              |   2 +-
 tests/vhost-user-bridge.c              |  28 ++++++++++++-------------
 23 files changed, 97 insertions(+), 87 deletions(-)
 create mode 100755 tests/check-qlit

diff --git a/tests/Makefile.include b/tests/Makefile.include
index abc6707ef2..485d258b17 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -618,7 +618,7 @@ tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
 	$(test-io-obj-y)
 tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-obj-y)
 tests/test-base64$(EXESUF): tests/test-base64.o $(test-util-obj-y)
-tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o
+tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o $(test-util-obj-y)
 
 tests/test-logging$(EXESUF): tests/test-logging.o $(test-util-obj-y)
 
@@ -785,7 +785,7 @@ tests/postcopy-test$(EXESUF): tests/postcopy-test.o
 tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o $(test-util-obj-y) \
 	$(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-pc-obj-y) \
 	$(chardev-obj-y)
-tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_scm_helper.o
+tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_scm_helper.o $(test-util-obj-y)
 tests/test-qemu-opts$(EXESUF): tests/test-qemu-opts.o $(test-util-obj-y)
 tests/test-keyval$(EXESUF): tests/test-keyval.o $(test-util-obj-y) $(test-qapi-obj-y)
 tests/test-write-threshold$(EXESUF): tests/test-write-threshold.o $(test-block-obj-y)
diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 999121bb7c..0a0c7a459a 100644
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
diff --git a/tests/atomic_add-bench.c b/tests/atomic_add-bench.c
index caa1e8e689..41ba1600c0 100644
--- a/tests/atomic_add-bench.c
+++ b/tests/atomic_add-bench.c
@@ -29,7 +29,7 @@ static const char commands_string[] =
 static void usage_complete(char *argv[])
 {
     fprintf(stderr, "Usage: %s [options]\n", argv[0]);
-    fprintf(stderr, "options:\n%s\n", commands_string);
+    fprintf(stderr, "options:\n%s", commands_string);
 }
 
 /*
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
diff --git a/tests/check-qlit b/tests/check-qlit
new file mode 100755
index 0000000000000000000000000000000000000000..950429524e3eb07e6daed1fe01caad0f5d554809
GIT binary patch
literal 272776
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
G)&IXoEYhC<

literal 0
HcmV?d00001

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
index 1ca7f456b5..dffe625444 100644
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
index 6226546c28..e125d885ef 100644
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
index b8eff5f495..e81e0bb8f2 100644
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
index cbd709470b..b7c488444e 100644
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
 
@@ -312,7 +313,7 @@ static GString *qtest_recv_line(QTestState *s)
         }
 
         if (len == -1 || len == 0) {
-            fprintf(stderr, "Broken pipe\n");
+            error_report("Broken pipe");
             exit(1);
         }
 
@@ -397,7 +398,7 @@ static void qmp_response(JSONMessageParser *parser, GQueue *tokens)
 
     obj = json_parser_parse(tokens, NULL);
     if (!obj) {
-        fprintf(stderr, "QMP JSON response parsing failed\n");
+        error_report("QMP JSON response parsing failed");
         exit(1);
     }
 
@@ -423,7 +424,7 @@ QDict *qmp_fd_receive(int fd)
         }
 
         if (len == -1 || len == 0) {
-            fprintf(stderr, "Broken pipe\n");
+            error_report("Broken pipe");
             exit(1);
         }
 
@@ -880,7 +881,7 @@ void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size)
 
     g_base64_decode_inplace(args[1], &len);
     if (size != len) {
-        fprintf(stderr, "bufread: asked for %zu bytes but decoded %zu\n",
+        error_report("bufread: asked for %zu bytes but decoded %zu",
                 size, len);
         len = MIN(len, size);
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
diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index 8142f2ab90..32bb11ba82 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
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
@@ -333,9 +333,9 @@ static void check_guests_ram(void)
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
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index 11c1cec766..2637d601a9 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -5,6 +5,7 @@
  *   See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/processor.h"
 #include "qemu/atomic.h"
 #include "qemu/qht.h"
@@ -89,7 +90,7 @@ static const char commands_string[] =
 static void usage_complete(int argc, char *argv[])
 {
     fprintf(stderr, "Usage: %s [options]\n", argv[0]);
-    fprintf(stderr, "options:\n%s\n", commands_string);
+    fprintf(stderr, "options:\n%s", commands_string);
     exit(-1);
 }
 
@@ -328,7 +329,7 @@ static void htable_init(void)
             retries++;
         }
     }
-    fprintf(stderr, " populated after %zu retries\n", retries);
+    error_report(" populated after %zu retries", retries);
 }
 
 static void add_stats(struct thread_stats *s, struct thread_info *info, int n)
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
index f922cc75ae..c70a453cef 100644
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
@@ -293,7 +293,7 @@ vubr_backend_recv_cb(int sock, void *ctx)
         }
 
         if (elem->in_num < 1) {
-            fprintf(stderr, "virtio-net contains no in buffers\n");
+            error_report("virtio-net contains no in buffers");
             break;
         }
 
@@ -363,7 +363,7 @@ vubr_receive_cb(int sock, void *ctx)
     VubrDev *vubr = (VubrDev *)ctx;
 
     if (!vu_dispatch(&vubr->vudev)) {
-        fprintf(stderr, "Error while dispatching\n");
+        error_report("Error while dispatching");
     }
 }
 
@@ -460,7 +460,7 @@ vubr_panic(VuDev *dev, const char *msg)
 {
     VubrDev *vubr = container_of(dev, VubrDev, vudev);
 
-    fprintf(stderr, "PANIC: %s\n", msg);
+    error_report("PANIC: %s", msg);
 
     dispatcher_remove(&vubr->dispatcher, dev->sock);
     vubr->quit = 1;
@@ -561,14 +561,14 @@ vubr_set_host(struct sockaddr_in *saddr, const char *host)
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
@@ -589,13 +589,13 @@ vubr_backend_udp_setup(VubrDev *dev,
 
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
 
@@ -713,15 +713,15 @@ main(int argc, char *argv[])
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
2.11.0
