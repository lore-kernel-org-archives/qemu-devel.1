Received: from eggs.gnu.org ([2001:4830:134:3::10]:51599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnlF-0000Vy-4p
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnlC-0002qn-DR
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:55:01 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 19 Nov 2018 11:54:27 -0600
Message-Id: <20181119175427.2298497-13-eblake@redhat.com>
In-Reply-To: <20181119175427.2298497-1-eblake@redhat.com>
References: <20181119175427.2298497-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/12] iotests: Drop use of bash keyword
 'function'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Bash allows functions to be declared with or without the leading
keyword 'function'; but including the keyword does not comply with
POSIX syntax, and is confusing to ksh users where the use of the
keyword changes the scoping rules for functions.  Stick to the
POSIX form through iotests.

Done mechanically with:
  sed -i 's/^function //' $(git ls-files tests/qemu-iotests)

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181116215002.2124581-1-eblake@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/qemu-iotests/common.nbd     | 12 ++++++------
 tests/qemu-iotests/common.pattern | 16 ++++++++--------
 tests/qemu-iotests/common.qemu    |  8 ++++----
 tests/qemu-iotests/common.tls     | 10 +++++-----
 tests/qemu-iotests/035            |  2 +-
 tests/qemu-iotests/037            |  2 +-
 tests/qemu-iotests/038            |  6 +++---
 tests/qemu-iotests/046            |  6 +++---
 tests/qemu-iotests/047            |  2 +-
 tests/qemu-iotests/049            |  4 ++--
 tests/qemu-iotests/051            |  4 ++--
 tests/qemu-iotests/067            |  4 ++--
 tests/qemu-iotests/071            |  4 ++--
 tests/qemu-iotests/077            |  4 ++--
 tests/qemu-iotests/081            |  4 ++--
 tests/qemu-iotests/082            |  2 +-
 tests/qemu-iotests/085            | 10 +++++-----
 tests/qemu-iotests/086            |  2 +-
 tests/qemu-iotests/087            |  6 +++---
 tests/qemu-iotests/099            |  6 +++---
 tests/qemu-iotests/109            |  2 +-
 tests/qemu-iotests/112            |  2 +-
 tests/qemu-iotests/142            |  8 ++++----
 tests/qemu-iotests/153            |  4 ++--
 tests/qemu-iotests/157            |  4 ++--
 tests/qemu-iotests/172            |  6 +++---
 tests/qemu-iotests/176            |  2 +-
 tests/qemu-iotests/177            |  2 +-
 tests/qemu-iotests/184            |  4 ++--
 tests/qemu-iotests/186            |  4 ++--
 tests/qemu-iotests/195            |  4 ++--
 tests/qemu-iotests/204            |  2 +-
 tests/qemu-iotests/223            |  4 ++--
 tests/qemu-iotests/227            |  4 ++--
 tests/qemu-iotests/232            |  6 +++---
 35 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nb=
d
index 0f4497a7ea5..233187a25cc 100644
--- a/tests/qemu-iotests/common.nbd
+++ b/tests/qemu-iotests/common.nbd
@@ -23,7 +23,7 @@ nbd_unix_socket=3D"${TEST_DIR}/qemu-nbd.sock"
 nbd_tcp_addr=3D"127.0.0.1"
 nbd_pid_file=3D"${TEST_DIR}/qemu-nbd.pid"

-function nbd_server_stop()
+nbd_server_stop()
 {
     local NBD_PID
     if [ -f "$nbd_pid_file" ]; then
@@ -36,7 +36,7 @@ function nbd_server_stop()
     rm -f "$nbd_unix_socket"
 }

-function nbd_server_wait_for_unix_socket()
+nbd_server_wait_for_unix_socket()
 {
     pid=3D$1

@@ -57,14 +57,14 @@ function nbd_server_wait_for_unix_socket()
     exit 1
 }

-function nbd_server_start_unix_socket()
+nbd_server_start_unix_socket()
 {
     nbd_server_stop
     $QEMU_NBD -v -t -k "$nbd_unix_socket" "$@" &
     nbd_server_wait_for_unix_socket $!
 }

-function nbd_server_set_tcp_port()
+nbd_server_set_tcp_port()
 {
     (ss --help) >/dev/null 2>&1 || _notrun "ss utility not found, skippi=
ng test"

@@ -80,7 +80,7 @@ function nbd_server_set_tcp_port()
     exit 1
 }

-function nbd_server_wait_for_tcp_socket()
+nbd_server_wait_for_tcp_socket()
 {
     pid=3D$1

@@ -101,7 +101,7 @@ function nbd_server_wait_for_tcp_socket()
     exit 1
 }

-function nbd_server_start_tcp_socket()
+nbd_server_start_tcp_socket()
 {
     nbd_server_stop
     $QEMU_NBD -v -t -b $nbd_tcp_addr -p $nbd_tcp_port "$@" &
diff --git a/tests/qemu-iotests/common.pattern b/tests/qemu-iotests/commo=
n.pattern
index 34f4a8dc9b4..b67bb341360 100644
--- a/tests/qemu-iotests/common.pattern
+++ b/tests/qemu-iotests/common.pattern
@@ -16,7 +16,7 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #

-function do_is_allocated() {
+do_is_allocated() {
     local start=3D$1
     local size=3D$2
     local step=3D$3
@@ -27,11 +27,11 @@ function do_is_allocated() {
     done
 }

-function is_allocated() {
+is_allocated() {
     do_is_allocated "$@" | $QEMU_IO "$TEST_IMG" | _filter_qemu_io
 }

-function do_io() {
+do_io() {
     local op=3D$1
     local start=3D$2
     local size=3D$3
@@ -45,22 +45,22 @@ function do_io() {
     done
 }

-function io_pattern() {
+io_pattern() {
     do_io "$@" | $QEMU_IO "$TEST_IMG" | _filter_qemu_io
 }

-function io() {
+io() {
     local start=3D$2
     local pattern=3D$(( (start >> 9) % 256 ))

     do_io "$@" $pattern | $QEMU_IO "$TEST_IMG" | _filter_qemu_io
 }

-function io_zero() {
+io_zero() {
     do_io "$@" 0 | $QEMU_IO "$TEST_IMG" | _filter_qemu_io
 }

-function io_test() {
+io_test() {
     local op=3D$1
     local offset=3D$2
     local cluster_size=3D$3
@@ -100,7 +100,7 @@ function io_test() {
     offset=3D$((offset + num_large * ( l2_size + half_cluster )))
 }

-function io_test2() {
+io_test2() {
     local orig_offset=3D$1
     local cluster_size=3D$2
     local num=3D$3
diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.q=
emu
index dadde2a266c..7c87b897fa3 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -60,7 +60,7 @@ _in_fd=3D4
 # $3: A string to search for in the response; if found, this indicates
 #     failure and the test is either aborted (if $qemu_error_no_exit
 #     is not set) or ${QEMU_STATUS[$1]} is set to -1 (otherwise).
-function _timed_wait_for()
+_timed_wait_for()
 {
     local h=3D${1}
     shift
@@ -131,7 +131,7 @@ function _timed_wait_for()
 # strings the response will be scanned for.  The first of the two
 # indicates success, the latter indicates failure.  Failure is handled
 # like a timeout.
-function _send_qemu_cmd()
+_send_qemu_cmd()
 {
     local h=3D${1}
     local count=3D1
@@ -186,7 +186,7 @@ function _send_qemu_cmd()
 # Returns:
 # $QEMU_HANDLE: set to a handle value to communicate with this QEMU inst=
ance.
 #
-function _launch_qemu()
+_launch_qemu()
 {
     local comm=3D
     local fifo_out=3D
@@ -262,7 +262,7 @@ function _launch_qemu()
 # If $wait is set to anything other than the empty string, the process w=
ill not
 # be killed but only waited for, and any output will be forwarded to std=
out. If
 # $wait is empty, the process will be killed and all output will be supp=
ressed.
-function _cleanup_qemu()
+_cleanup_qemu()
 {
     # QEMU_PID[], QEMU_IN[], QEMU_OUT[] all use same indices
     for i in "${!QEMU_OUT[@]}"
diff --git a/tests/qemu-iotests/common.tls b/tests/qemu-iotests/common.tl=
s
index cecab269ec6..39f17c1b999 100644
--- a/tests/qemu-iotests/common.tls
+++ b/tests/qemu-iotests/common.tls
@@ -20,7 +20,7 @@

 tls_dir=3D"${TEST_DIR}/tls"

-function tls_x509_cleanup()
+tls_x509_cleanup()
 {
     rm -f "${tls_dir}"/*.pem
     rm -f "${tls_dir}"/*/*.pem
@@ -29,7 +29,7 @@ function tls_x509_cleanup()
 }


-function tls_x509_init()
+tls_x509_init()
 {
     mkdir -p "${tls_dir}"

@@ -58,7 +58,7 @@ EOF
 }


-function tls_x509_create_root_ca()
+tls_x509_create_root_ca()
 {
     name=3D${1:-ca-cert}

@@ -77,7 +77,7 @@ EOF
 }


-function tls_x509_create_server()
+tls_x509_create_server()
 {
     caname=3D$1
     name=3D$2
@@ -108,7 +108,7 @@ EOF
 }


-function tls_x509_create_client()
+tls_x509_create_client()
 {
     caname=3D$1
     name=3D$2
diff --git a/tests/qemu-iotests/035 b/tests/qemu-iotests/035
index a5716caf327..85d9ef7f8e1 100755
--- a/tests/qemu-iotests/035
+++ b/tests/qemu-iotests/035
@@ -49,7 +49,7 @@ echo
 echo "creating image"
 _make_test_img $size

-function generate_requests() {
+generate_requests() {
     for i in $(seq 0 63); do
         echo "aio_write ${i}M 512"
         echo "aio_write ${i}M 512"
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index 2e43b19ed04..a11992dad20 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -54,7 +54,7 @@ TEST_IMG=3D"$TEST_IMG.base"

 _make_test_img $size

-function backing_io()
+backing_io()
 {
     local offset=3D$1
     local sectors=3D$2
diff --git a/tests/qemu-iotests/038 b/tests/qemu-iotests/038
index 4e03976023d..575093e8cfd 100755
--- a/tests/qemu-iotests/038
+++ b/tests/qemu-iotests/038
@@ -51,7 +51,7 @@ TEST_IMG=3D"$TEST_IMG.base"

 _make_test_img $size

-function backing_io()
+backing_io()
 {
     local offset=3D$1
     local sectors=3D$2
@@ -76,7 +76,7 @@ _make_test_img -b "$TEST_IMG.base" 6G
 echo
 echo "=3D=3D Some concurrent requests touching the same cluster =3D=3D"

-function overlay_io()
+overlay_io()
 {
     # Start with a request touching two clusters
     echo aio_write -P 0x80 2020k 80k
@@ -102,7 +102,7 @@ overlay_io | $QEMU_IO "$TEST_IMG" | _filter_qemu_io |=
\
 echo
 echo "=3D=3D Verify image content =3D=3D"

-function verify_io()
+verify_io()
 {
     echo read -P 31 2016k 4k
     echo read -P 0x80 2020k 80k
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index 01c0de62d82..5e41d96daa1 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -48,7 +48,7 @@ echo "=3D=3D creating backing file for COW tests =3D=3D=
"

 _make_test_img $size

-function backing_io()
+backing_io()
 {
     local offset=3D$1
     local sectors=3D$2
@@ -73,7 +73,7 @@ _make_test_img -b "$TEST_IMG.base" 6G
 echo
 echo "=3D=3D Some concurrent requests touching the same cluster =3D=3D"

-function overlay_io()
+overlay_io()
 {
 # Allocate middle of cluster 1, then write to somewhere before and after=
 it
 cat  <<EOF
@@ -189,7 +189,7 @@ overlay_io | $QEMU_IO blkdebug::"$TEST_IMG" | _filter=
_qemu_io |\
 echo
 echo "=3D=3D Verify image content =3D=3D"

-function verify_io()
+verify_io()
 {
     if ($QEMU_IMG info -U -f "$IMGFMT" "$TEST_IMG" | grep "compat: 0.10"=
 > /dev/null); then
         # For v2 images, discarded clusters are read from the backing fi=
le
diff --git a/tests/qemu-iotests/047 b/tests/qemu-iotests/047
index c168373cf0f..6e776d2ce5c 100755
--- a/tests/qemu-iotests/047
+++ b/tests/qemu-iotests/047
@@ -45,7 +45,7 @@ size=3D128M

 _make_test_img $size

-function qemu_io_cmds()
+qemu_io_cmds()
 {
 cat <<EOF
 write -P 0x66 0 320k
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index 4d0ad5cd50c..97d8a64697a 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -40,13 +40,13 @@ _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux

-function filter_test_dir()
+filter_test_dir()
 {
     sed -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
         -e "s#$TEST_DIR#TEST_DIR#g"
 }

-function test_qemu_img()
+test_qemu_img()
 {
     echo qemu-img "$@" | filter_test_dir
     $QEMU_IMG "$@" 2>&1 | filter_test_dir
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index a676da82734..32741d7efdf 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -43,7 +43,7 @@ _supported_os Linux
 # other than refcount_bits=3D16
 _unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'

-function do_run_qemu()
+do_run_qemu()
 {
     echo Testing: "$@"
     (
@@ -57,7 +57,7 @@ function do_run_qemu()
     echo
 }

-function run_qemu()
+run_qemu()
 {
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu |
         _filter_generated_node_ids | _filter_hmp
diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
index f8d584f4873..342b2b0a309 100755
--- a/tests/qemu-iotests/067
+++ b/tests/qemu-iotests/067
@@ -36,7 +36,7 @@ _supported_os Linux
 # Because anything other than 16 would change the output of query-block
 _unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'

-function do_run_qemu()
+do_run_qemu()
 {
     echo Testing: "$@"
     $QEMU -nographic -qmp-pretty stdio -serial none "$@"
@@ -52,7 +52,7 @@ _filter_qmp_events()
 	| tr '\t' '\n'
 }

-function run_qemu()
+run_qemu()
 {
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qmp | _filter_qemu=
 \
                           | _filter_actual_image_size \
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 6448e9e75bc..6e467dc1da1 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -40,14 +40,14 @@ _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux

-function do_run_qemu()
+do_run_qemu()
 {
     echo Testing: "$@" | _filter_imgfmt
     $QEMU -nographic -qmp stdio -serial none "$@"
     echo
 }

-function run_qemu()
+run_qemu()
 {
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp=
 | _filter_qemu_io
 }
diff --git a/tests/qemu-iotests/077 b/tests/qemu-iotests/077
index a40f319d371..58fe8932b30 100755
--- a/tests/qemu-iotests/077
+++ b/tests/qemu-iotests/077
@@ -48,7 +48,7 @@ _make_test_img $size
 echo
 echo "=3D=3D Some concurrent requests involving RMW =3D=3D"

-function test_io()
+test_io()
 {
 echo "open -o driver=3D$IMGFMT,file.align=3D4k blkdebug::$TEST_IMG"
 # A simple RMW request
@@ -193,7 +193,7 @@ test_io | $QEMU_IO  | _filter_qemu_io | \
 echo
 echo "=3D=3D Verify image content =3D=3D"

-function verify_io()
+verify_io()
 {
     # A simple RMW request
     echo read -P 0       0 0x200
diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index ccb6becaef0..edf6e6172aa 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -42,14 +42,14 @@ _supported_fmt raw
 _supported_proto file
 _supported_os Linux

-function do_run_qemu()
+do_run_qemu()
 {
     echo Testing: "$@" | _filter_imgfmt
     $QEMU -nographic -qmp stdio -serial none "$@"
     echo
 }

-function run_qemu()
+run_qemu()
 {
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp=
\
                           | _filter_qemu_io | _filter_generated_node_ids
diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index 14f6631071d..61eec63797c 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -40,7 +40,7 @@ _supported_fmt qcow2
 _supported_proto file nfs
 _supported_os Linux

-function run_qemu_img()
+run_qemu_img()
 {
     echo
     echo Testing: "$@" | _filter_testdir
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index 2ef84077b8f..ade68ef853b 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -60,7 +60,7 @@ _supported_os Linux


 # ${1}: unique identifier for the snapshot filename
-function create_single_snapshot()
+create_single_snapshot()
 {
     cmd=3D"{ 'execute': 'blockdev-snapshot-sync',
                       'arguments': { 'device': 'virtio0',
@@ -70,7 +70,7 @@ function create_single_snapshot()
 }

 # ${1}: unique identifier for the snapshot filename
-function create_group_snapshot()
+create_group_snapshot()
 {
     cmd=3D"{ 'execute': 'transaction', 'arguments':
            {'actions': [
@@ -88,7 +88,7 @@ function create_group_snapshot()
 # ${1}: unique identifier for the snapshot filename
 # ${2}: extra_params to the blockdev-add command
 # ${3}: filename
-function do_blockdev_add()
+do_blockdev_add()
 {
     cmd=3D"{ 'execute': 'blockdev-add', 'arguments':
            { 'driver': 'qcow2', 'node-name': 'snap_${1}', ${2}
@@ -99,7 +99,7 @@ function do_blockdev_add()
 }

 # ${1}: unique identifier for the snapshot filename
-function add_snapshot_image()
+add_snapshot_image()
 {
     base_image=3D"${TEST_DIR}/$((${1}-1))-${snapshot_virt0}"
     snapshot_file=3D"${TEST_DIR}/${1}-${snapshot_virt0}"
@@ -110,7 +110,7 @@ function add_snapshot_image()

 # ${1}: unique identifier for the snapshot filename
 # ${2}: expected response, defaults to 'return'
-function blockdev_snapshot()
+blockdev_snapshot()
 {
     cmd=3D"{ 'execute': 'blockdev-snapshot',
                       'arguments': { 'node': 'virtio0',
diff --git a/tests/qemu-iotests/086 b/tests/qemu-iotests/086
index 971de7dc355..3cca3687ea8 100755
--- a/tests/qemu-iotests/086
+++ b/tests/qemu-iotests/086
@@ -40,7 +40,7 @@ _supported_fmt qcow2 raw
 _supported_proto file
 _supported_os Linux

-function run_qemu_img()
+run_qemu_img()
 {
     echo
     echo Testing: "$@" | _filter_testdir
diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index 109cdf5ea43..f6258870822 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -34,14 +34,14 @@ _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux

-function do_run_qemu()
+do_run_qemu()
 {
     echo Testing: "$@"
     $QEMU -nographic -qmp stdio -serial none "$@"
     echo
 }

-function run_qemu()
+run_qemu()
 {
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qmp \
                           | _filter_qemu | _filter_imgfmt \
@@ -102,7 +102,7 @@ echo =3D=3D=3D aio=3Dnative without O_DIRECT =3D=3D=3D
 echo

 # Skip this test if AIO is not enabled in this build
-function run_qemu_filter_aio()
+run_qemu_filter_aio()
 {
     run_qemu "$@" | \
         sed -e 's/is not supported in this build/it requires cache.direc=
t=3Don, which was not specified/'
diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
index 4a6275d4bca..578808b7474 100755
--- a/tests/qemu-iotests/099
+++ b/tests/qemu-iotests/099
@@ -45,12 +45,12 @@ _supported_os Linux
 _unsupported_imgopts "subformat=3DmonolithicFlat" "subformat=3DtwoGbMaxE=
xtentFlat" \
     "subformat=3DtwoGbMaxExtentSparse"

-function do_run_qemu()
+do_run_qemu()
 {
     $QEMU -nographic -qmp stdio -serial none "$@"
 }

-function run_qemu()
+run_qemu()
 {
     # Get the "file": "foo" entry ($foo may only contain escaped double =
quotes,
     # which is how we can extract it)
@@ -59,7 +59,7 @@ function run_qemu()
         | sed -e 's/^.*"file": "\(\(\\"\|[^"]\)*\)".*$/\1/' -e 's/\\"/"/=
g'
 }

-function test_qemu()
+test_qemu()
 {
     run_qemu -drive "if=3Dnone,id=3Ddrv0,$1" <<EOF
         { 'execute': 'qmp_capabilities' }
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index 90bdae459b8..b51e4616c67 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -45,7 +45,7 @@ _supported_os Linux

 qemu_comm_method=3Dqmp

-function run_qemu()
+run_qemu()
 {
     local raw_img=3D"$1"
     local source_img=3D"$2"
diff --git a/tests/qemu-iotests/112 b/tests/qemu-iotests/112
index fba2965322d..d67e6ebe9cf 100755
--- a/tests/qemu-iotests/112
+++ b/tests/qemu-iotests/112
@@ -44,7 +44,7 @@ _supported_os Linux
 # manual setting; compat will be overridden as well
 _unsupported_imgopts refcount_bits 'compat=3D0.10'

-function print_refcount_bits()
+print_refcount_bits()
 {
     $QEMU_IMG info "$TEST_IMG" | sed -n '/refcount bits:/ s/^ *//p'
 }
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index c7c360d11b5..5fc488f5d23 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -45,7 +45,7 @@ _supported_os Linux
 _default_cache_mode none
 _supported_cache_modes none directsync

-function do_run_qemu()
+do_run_qemu()
 {
     echo Testing: "$@"
     (
@@ -59,7 +59,7 @@ function do_run_qemu()
     echo
 }

-function run_qemu()
+run_qemu()
 {
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_hmp
 }
@@ -88,7 +88,7 @@ echo
 files=3D"if=3Dnone,file=3D$TEST_IMG,backing.file.filename=3D$TEST_IMG.ba=
se"
 ids=3D"node-name=3Dimage,backing.node-name=3Dbacking,backing.file.node-n=
ame=3Dbacking-file,file.node-name=3Dfile"

-function check_cache_all()
+check_cache_all()
 {
     # cache.direct is supposed to be inherited by both bs->file and
     # bs->backing
@@ -231,7 +231,7 @@ drv_bk=3D"if=3Dnone,file=3Djson:{'driver':'$IMGFMT',,=
'file':'backing-file',,'node-name
 drv_file=3D"if=3Dnone,driver=3Dfile,filename=3D$TEST_IMG,node-name=3Dfil=
e"
 drv_img=3D"if=3Dnone,id=3Dblk,file=3Djson:{'driver':'$IMGFMT',,'file':'f=
ile',,'backing':'backing',,'node-name':'image'}"

-function check_cache_all_separate()
+check_cache_all_separate()
 {
     # Check cache.direct

diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index 00092b84b9f..3120a61da47 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -70,7 +70,7 @@ _run_cmd()
     (echo "$@"; "$@" 2>&1 1>/dev/null) | _filter_testdir
 }

-function _do_run_qemu()
+_do_run_qemu()
 {
     (
         if ! test -t 0; then
@@ -82,7 +82,7 @@ function _do_run_qemu()
     ) | $QEMU -nographic -monitor stdio -serial none "$@" 1>/dev/null
 }

-function _run_qemu_with_images()
+_run_qemu_with_images()
 {
     _do_run_qemu \
         $(for i in $@; do echo "-drive if=3Dnone,file=3D$i"; done) 2>&1 =
\
diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index c3231b787a1..6fb26596ada 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -40,7 +40,7 @@ _supported_fmt generic
 _supported_proto file
 _supported_os Linux

-function do_run_qemu()
+do_run_qemu()
 {
     (
         if ! test -t 0; then
@@ -53,7 +53,7 @@ function do_run_qemu()
     echo
 }

-function run_qemu()
+run_qemu()
 {
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_imgfmt \
                           | _filter_qemu | _filter_generated_node_ids
diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index c5ee33ee81b..1e60a7e3d68 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -46,7 +46,7 @@ if [ "$QEMU_DEFAULT_MACHINE" !=3D "pc" ]; then
     _notrun "Requires a PC machine"
 fi

-function do_run_qemu()
+do_run_qemu()
 {
     (
         if ! test -t 0; then
@@ -59,7 +59,7 @@ function do_run_qemu()
     echo
 }

-function check_floppy_qtree()
+check_floppy_qtree()
 {
     echo
     echo Testing: "$@" | _filter_testdir
@@ -75,7 +75,7 @@ function check_floppy_qtree()
     _filter_win32 | _filter_qemu
 }

-function check_cache_mode()
+check_cache_mode()
 {
     echo "info block none0" |
     QEMU_OPTIONS=3D"" do_run_qemu -drive if=3Dnone,file=3D"$TEST_IMG" "$=
@" |
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index c091d0bd1e0..4ecd5894a39 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -50,7 +50,7 @@ _supported_os Linux
 # Persistent dirty bitmaps require compat=3D1.1
 _unsupported_imgopts 'compat=3D0.10'

-function run_qemu()
+run_qemu()
 {
     $QEMU -nographic -qmp stdio -serial none "$@" 2>&1 \
 	| _filter_testdir | _filter_qmp | _filter_qemu \
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index 7bf8e1daf39..f0c1155e807 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -85,7 +85,7 @@ $QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_I=
MG" \
 echo
 echo "=3D=3D verify image content =3D=3D"

-function verify_io()
+verify_io()
 {
     if ($QEMU_IMG info -f "$IMGFMT" "$TEST_IMG" |
 	    grep "compat: 0.10" > /dev/null); then
diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index 2f3259d5587..0af7a73aca1 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -34,14 +34,14 @@ trap "exit \$status" 0 1 2 3 15

 _supported_os Linux

-function do_run_qemu()
+do_run_qemu()
 {
     echo Testing: "$@" | _filter_imgfmt
     $QEMU -nographic -qmp-pretty stdio -serial none "$@"
     echo
 }

-function run_qemu()
+run_qemu()
 {
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp=
\
                           | _filter_qemu_io | _filter_generated_node_ids=
 \
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 29681bf45c6..c27dc953b6f 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -44,7 +44,7 @@ if [ "$QEMU_DEFAULT_MACHINE" !=3D "pc" ]; then
     _notrun "Requires a PC machine"
 fi

-function do_run_qemu()
+do_run_qemu()
 {
     echo Testing: "$@"

@@ -59,7 +59,7 @@ function do_run_qemu()
     echo
 }

-function check_info_block()
+check_info_block()
 {
     echo "info block" |
     do_run_qemu "$@" | _filter_win32 | _filter_hmp | _filter_qemu |
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index f56f2557153..a977c9798e3 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -41,14 +41,14 @@ _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux

-function do_run_qemu()
+do_run_qemu()
 {
     echo Testing: "$@"
     $QEMU -nographic -qmp-pretty stdio -serial none "$@"
     echo
 }

-function run_qemu()
+run_qemu()
 {
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_imgfmt | _filter_q=
emu \
                           | _filter_qmp | _filter_qemu_io \
diff --git a/tests/qemu-iotests/204 b/tests/qemu-iotests/204
index 57f3afe1d73..30f0653ce97 100755
--- a/tests/qemu-iotests/204
+++ b/tests/qemu-iotests/204
@@ -93,7 +93,7 @@ $QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_I=
MG" \
 echo
 echo "=3D=3D verify image content =3D=3D"

-function verify_io()
+verify_io()
 {
     echo read -P 22 0 1000
     echo read -P 33 1000 128k
diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 58a3f3ff408..72419e03388 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -42,14 +42,14 @@ _supported_os Linux
 # Persistent dirty bitmaps require compat=3D1.1
 _unsupported_imgopts 'compat=3D0.10'

-function do_run_qemu()
+do_run_qemu()
 {
     echo Testing: "$@"
     $QEMU -nographic -qmp stdio -serial none "$@"
     echo
 }

-function run_qemu()
+run_qemu()
 {
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qmp \
                           | _filter_qemu | _filter_imgfmt \
diff --git a/tests/qemu-iotests/227 b/tests/qemu-iotests/227
index 43f2323ff2c..be1b636af06 100755
--- a/tests/qemu-iotests/227
+++ b/tests/qemu-iotests/227
@@ -40,14 +40,14 @@ _supported_fmt generic
 _supported_proto file
 _supported_os Linux

-function do_run_qemu()
+do_run_qemu()
 {
     echo Testing: "$@"
     $QEMU -nographic -qmp-pretty stdio -serial none "$@"
     echo
 }

-function run_qemu()
+run_qemu()
 {
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qmp \
                           | _filter_qemu | _filter_imgfmt \
diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
index b125e54093d..0708b8b155e 100755
--- a/tests/qemu-iotests/232
+++ b/tests/qemu-iotests/232
@@ -41,7 +41,7 @@ _supported_fmt generic
 _supported_proto file
 _supported_os Linux

-function do_run_qemu()
+do_run_qemu()
 {
     echo Testing: "$@"
     (
@@ -55,13 +55,13 @@ function do_run_qemu()
     echo
 }

-function run_qemu()
+run_qemu()
 {
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_hmp=
 |
         _filter_generated_node_ids | _filter_imgfmt
 }

-function run_qemu_info_block()
+run_qemu_info_block()
 {
     echo "info block -n" | run_qemu "$@" | grep -e "(file" -e "QEMU_PROG=
"
 }
--=20
2.17.2
