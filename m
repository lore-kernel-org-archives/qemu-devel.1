Received: from eggs.gnu.org ([2001:4830:134:3::10]:51907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmRS-00043X-Mg
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmRO-0001uD-1f
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:34 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 Sep 2017 16:44:54 +0200
Message-Id: <20170912144459.11359-6-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-1-pbonzini@redhat.com>
References: <20170912144459.11359-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 05/10] qemu-iotests: limit non-_PROG-suffixed
 variables to common.rc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

These are never used by "check", with one exception that does not need
$QEMU_OPTIONS.  Keep them in common.rc, which will be soon included only
by the tests.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qemu-iotests/039.out       | 10 +++---
 tests/qemu-iotests/061.out       |  4 +--
 tests/qemu-iotests/137.out       |  2 +-
 tests/qemu-iotests/common.config | 69 ++--------------------------------------
 tests/qemu-iotests/common.rc     | 65 +++++++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
index c6e0ac2da3..724d7b2508 100644
--- a/tests/qemu-iotests/039.out
+++ b/tests/qemu-iotests/039.out
@@ -11,7 +11,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.config: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
+./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
     exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
 else
     exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
@@ -50,7 +50,7 @@ read 512/512 bytes at offset 0
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.config: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
+./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
     exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
 else
     exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
@@ -68,7 +68,7 @@ incompatible_features     0x0
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.config: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
+./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
     exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
 else
     exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
@@ -91,7 +91,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.config: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
+./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
     exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
 else
     exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
@@ -105,7 +105,7 @@ Data may be corrupted, or further writes to the image may corrupt it.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.config: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
+./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
     exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
 else
     exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index a431b7f305..942485de99 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -57,7 +57,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.config: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
+./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
     exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
 else
     exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
@@ -219,7 +219,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.config: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
+./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
     exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
 else
     exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
index c0e753483b..05efd74d17 100644
--- a/tests/qemu-iotests/137.out
+++ b/tests/qemu-iotests/137.out
@@ -31,7 +31,7 @@ Cache clean interval too big
 Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allowed are any of the following: none, constant, cached, all
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.config: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
+./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
     exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
 else
     exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index c97c63983f..c7f0a7a7e0 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -40,71 +40,6 @@ _optstr_add()
     fi
 }
 
-_qemu_wrapper()
-{
-    (
-        if [ -n "${QEMU_NEED_PID}" ]; then
-            echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid"
-        fi
-        exec "$QEMU_PROG" $QEMU_OPTIONS "$@"
-    )
-}
-
-_qemu_img_wrapper()
-{
-    (exec "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@")
-}
-
-_qemu_io_wrapper()
-{
-    local VALGRIND_LOGFILE="${TEST_DIR}"/$$.valgrind
-    local QEMU_IO_ARGS="$QEMU_IO_OPTIONS"
-    if [ "$IMGOPTSSYNTAX" = "true" ]; then
-        QEMU_IO_ARGS="--image-opts $QEMU_IO_ARGS"
-        if [ -n "$IMGKEYSECRET" ]; then
-            QEMU_IO_ARGS="--object secret,id=keysec0,data=$IMGKEYSECRET $QEMU_IO_ARGS"
-        fi
-    fi
-    local RETVAL
-    (
-        if [ "${VALGRIND_QEMU}" == "y" ]; then
-            exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"
-        else
-            exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"
-        fi
-    )
-    RETVAL=$?
-    if [ "${VALGRIND_QEMU}" == "y" ]; then
-        if [ $RETVAL == 99 ]; then
-            cat "${VALGRIND_LOGFILE}"
-        fi
-        rm -f "${VALGRIND_LOGFILE}"
-    fi
-    (exit $RETVAL)
-}
-
-_qemu_nbd_wrapper()
-{
-    (
-        echo $BASHPID > "${QEMU_TEST_DIR}/qemu-nbd.pid"
-        exec "$QEMU_NBD_PROG" $QEMU_NBD_OPTIONS "$@"
-    )
-}
-
-_qemu_vxhs_wrapper()
-{
-    (
-        echo $BASHPID > "${TEST_DIR}/qemu-vxhs.pid"
-        exec "$QEMU_VXHS_PROG" $QEMU_VXHS_OPTIONS "$@"
-    )
-}
-
-export QEMU=_qemu_wrapper
-export QEMU_IMG=_qemu_img_wrapper
-export QEMU_IO=_qemu_io_wrapper
-export QEMU_NBD=_qemu_nbd_wrapper
-export QEMU_VXHS=_qemu_vxhs_wrapper
-
 QEMU_IMG_EXTRA_ARGS=
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     QEMU_IMG_EXTRA_ARGS="--image-opts $QEMU_IMG_EXTRA_ARGS"
@@ -115,8 +50,8 @@ fi
 export QEMU_IMG_EXTRA_ARGS
 
 
-default_machine=$($QEMU -machine help | sed -n '/(default)/ s/ .*//p')
-default_alias_machine=$($QEMU -machine help | \
+default_machine=$($QEMU_PROG -machine help | sed -n '/(default)/ s/ .*//p')
+default_alias_machine=$($QEMU_PROG -machine help | \
    sed -n "/(alias of $default_machine)/ { s/ .*//p; q; }")
 if [[ "$default_alias_machine" ]]; then
     default_machine="$default_alias_machine"
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 6f6e03366f..e7f74b4dbd 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -50,6 +50,71 @@ then
     fi
 fi
 
+_qemu_wrapper()
+{
+    (
+        if [ -n "${QEMU_NEED_PID}" ]; then
+            echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid"
+        fi
+        exec "$QEMU_PROG" $QEMU_OPTIONS "$@"
+    )
+}
+
+_qemu_img_wrapper()
+{
+    (exec "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@")
+}
+
+_qemu_io_wrapper()
+{
+    local VALGRIND_LOGFILE="${TEST_DIR}"/$$.valgrind
+    local QEMU_IO_ARGS="$QEMU_IO_OPTIONS"
+    if [ "$IMGOPTSSYNTAX" = "true" ]; then
+        QEMU_IO_ARGS="--image-opts $QEMU_IO_ARGS"
+        if [ -n "$IMGKEYSECRET" ]; then
+            QEMU_IO_ARGS="--object secret,id=keysec0,data=$IMGKEYSECRET $QEMU_IO_ARGS"
+        fi
+    fi
+    local RETVAL
+    (
+        if [ "${VALGRIND_QEMU}" == "y" ]; then
+            exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"
+        else
+            exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"
+        fi
+    )
+    RETVAL=$?
+    if [ "${VALGRIND_QEMU}" == "y" ]; then
+        if [ $RETVAL == 99 ]; then
+            cat "${VALGRIND_LOGFILE}"
+        fi
+        rm -f "${VALGRIND_LOGFILE}"
+    fi
+    (exit $RETVAL)
+}
+
+_qemu_nbd_wrapper()
+{
+    (
+        echo $BASHPID > "${QEMU_TEST_DIR}/qemu-nbd.pid"
+        exec "$QEMU_NBD_PROG" $QEMU_NBD_OPTIONS "$@"
+    )
+}
+
+_qemu_vxhs_wrapper()
+{
+    (
+        echo $BASHPID > "${TEST_DIR}/qemu-vxhs.pid"
+        exec "$QEMU_VXHS_PROG" $QEMU_VXHS_OPTIONS "$@"
+    )
+}
+
+export QEMU=_qemu_wrapper
+export QEMU_IMG=_qemu_img_wrapper
+export QEMU_IO=_qemu_io_wrapper
+export QEMU_NBD=_qemu_nbd_wrapper
+export QEMU_VXHS=_qemu_vxhs_wrapper
+
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     DRIVER="driver=$IMGFMT"
     if [ "$IMGFMT" = "luks" ]; then
-- 
2.13.5
