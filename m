Received: from eggs.gnu.org ([209.51.188.92]:49053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmJog-0000Yr-C9
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmJoR-0000tN-UX
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:47:39 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 23 Jan 2019 15:46:10 +0100
Message-Id: <20190123144610.8842-10-mreitz@redhat.com>
In-Reply-To: <20190123144610.8842-1-mreitz@redhat.com>
References: <20190123144610.8842-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 9/9] iotests.py: s/_/-/g on keys in qmp_log()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

This follows what qmp() does, so the output will correspond to the
actual QMP command.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/206.out    | 56 +++++++++++++++++------------------
 tests/qemu-iotests/207.out    | 18 +++++------
 tests/qemu-iotests/210.out    | 28 +++++++++---------
 tests/qemu-iotests/211.out    | 26 ++++++++--------
 tests/qemu-iotests/212.out    | 44 +++++++++++++--------------
 tests/qemu-iotests/213.out    | 46 ++++++++++++++--------------
 tests/qemu-iotests/237.out    | 54 ++++++++++++++++-----------------
 tests/qemu-iotests/iotests.py |  6 ++--
 8 files changed, 140 insertions(+), 138 deletions(-)

diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
index 91f4db55d3..0f1c23babb 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -1,13 +1,13 @@
 =3D=3D=3D Successful image creation (defaults) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.qcow2", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.qcow2", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.qcow2", "node_name": "imgfile"}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.qcow2", "node-name": "imgfile"}}
 {"return": {}}
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "qcow2", "file": "imgfile", "size": 134217728}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "qcow2", "file": "imgfile", "size": 134217728}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -24,12 +24,12 @@ Format specific information:
=20
 =3D=3D=3D Successful image creation (inline blockdev-add, explicit defau=
lts) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.qcow2", "nocow": false, =
"preallocation": "off", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.qcow2", "nocow": false, =
"preallocation": "off", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"cluster-size": 65536, "driver": "qcow2", "file": {"driver": "file", "=
filename": "TEST_DIR/PID-t.qcow2"}, "lazy-refcounts": false, "preallocati=
on": "off", "refcount-bits": 16, "size": 67108864, "version": "v3"}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"cluster-size": 65536, "driver": "qcow2", "file": {"driver": "file", "=
filename": "TEST_DIR/PID-t.qcow2"}, "lazy-refcounts": false, "preallocati=
on": "off", "refcount-bits": 16, "size": 67108864, "version": "v3"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -46,12 +46,12 @@ Format specific information:
=20
 =3D=3D=3D Successful image creation (v3 non-default options) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.qcow2", "nocow": true, "=
preallocation": "falloc", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.qcow2", "nocow": true, "=
preallocation": "falloc", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"cluster-size": 2097152, "driver": "qcow2", "file": {"driver": "file",=
 "filename": "TEST_DIR/PID-t.qcow2"}, "lazy-refcounts": true, "preallocat=
ion": "metadata", "refcount-bits": 1, "size": 33554432, "version": "v3"}}=
}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"cluster-size": 2097152, "driver": "qcow2", "file": {"driver": "file",=
 "filename": "TEST_DIR/PID-t.qcow2"}, "lazy-refcounts": true, "preallocat=
ion": "metadata", "refcount-bits": 1, "size": 33554432, "version": "v3"}}=
}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -68,12 +68,12 @@ Format specific information:
=20
 =3D=3D=3D Successful image creation (v2 non-default options) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.qcow2", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.qcow2", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"backing-file": "TEST_DIR/PID-t.qcow2.base", "backing-fmt": "qcow2", "=
cluster-size": 512, "driver": "qcow2", "file": {"driver": "file", "filena=
me": "TEST_DIR/PID-t.qcow2"}, "size": 33554432, "version": "v2"}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"backing-file": "TEST_DIR/PID-t.qcow2.base", "backing-fmt": "qcow2", "=
cluster-size": 512, "driver": "qcow2", "file": {"driver": "file", "filena=
me": "TEST_DIR/PID-t.qcow2"}, "size": 33554432, "version": "v2"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -90,7 +90,7 @@ Format specific information:
=20
 =3D=3D=3D Successful image creation (encrypted) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "qcow2", "encrypt": {"cipher-alg": "twofish-128", "cipher-mo=
de": "ctr", "format": "luks", "hash-alg": "sha1", "iter-time": 10, "ivgen=
-alg": "plain64", "ivgen-hash-alg": "md5", "key-secret": "keysec0"}, "fil=
e": {"driver": "file", "filename": "TEST_DIR/PID-t.qcow2"}, "size": 33554=
432}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "qcow2", "encrypt": {"cipher-alg": "twofish-128", "cipher-mo=
de": "ctr", "format": "luks", "hash-alg": "sha1", "iter-time": 10, "ivgen=
-alg": "plain64", "ivgen-hash-alg": "md5", "key-secret": "keysec0"}, "fil=
e": {"driver": "file", "filename": "TEST_DIR/PID-t.qcow2"}, "size": 33554=
432}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -144,111 +144,111 @@ Format specific information:
=20
 =3D=3D=3D Invalid BlockdevRef =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "qcow2", "file": "this doesn't exist", "size": 33554432}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "qcow2", "file": "this doesn't exist", "size": 33554432}}}
 {"return": {}}
 Job failed: Cannot find device=3Dthis doesn't exist nor node_name=3Dthis=
 doesn't exist
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
 =3D=3D=3D Invalid sizes =3D=3D=3D
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "size": 1234}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "size": 1234}}}
 {"return": {}}
 Job failed: Image size must be a multiple of 512 bytes
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "size": 18446744073709551104}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "size": 18446744073709551104}}}
 {"return": {}}
 Job failed: Could not resize image: Image size cannot be negative
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "size": 9223372036854775808}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "size": 9223372036854775808}}}
 {"return": {}}
 Job failed: Could not resize image: Image size cannot be negative
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "size": 9223372036854775296}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "size": 9223372036854775296}}}
 {"return": {}}
 Job failed: Could not resize image: Failed to grow the L1 table: File to=
o large
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
 =3D=3D=3D Invalid version =3D=3D=3D
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "size": 67108864, "version": "v1"}=
}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "size": 67108864, "version": "v1"}=
}}
 {"error": {"class": "GenericError", "desc": "Invalid parameter 'v1'"}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "lazy-refcounts": true, "size": 67=
108864, "version": "v2"}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "lazy-refcounts": true, "size": 67=
108864, "version": "v2"}}}
 {"return": {}}
 Job failed: Lazy refcounts only supported with compatibility level 1.1 a=
nd above (use version=3Dv3 or greater)
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "refcount-bits": 8, "size": 671088=
64, "version": "v2"}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "refcount-bits": 8, "size": 671088=
64, "version": "v2"}}}
 {"return": {}}
 Job failed: Different refcount widths than 16 bits require compatibility=
 level 1.1 or above (use version=3Dv3 or greater)
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
 =3D=3D=3D Invalid backing file options =3D=3D=3D
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"backing-file": "/dev/null", "driver": "qcow2", "file": "node0", "prea=
llocation": "full", "size": 67108864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"backing-file": "/dev/null", "driver": "qcow2", "file": "node0", "prea=
llocation": "full", "size": 67108864}}}
 {"return": {}}
 Job failed: Backing file and preallocation cannot be used at the same ti=
me
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"backing-fmt": "qcow2", "driver": "qcow2", "file": "node0", "size": 67=
108864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"backing-fmt": "qcow2", "driver": "qcow2", "file": "node0", "size": 67=
108864}}}
 {"return": {}}
 Job failed: Backing format cannot be used without backing file
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
 =3D=3D=3D Invalid cluster size =3D=3D=3D
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"cluster-size": 1234, "driver": "qcow2", "file": "node0", "size": 6710=
8864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"cluster-size": 1234, "driver": "qcow2", "file": "node0", "size": 6710=
8864}}}
 {"return": {}}
 Job failed: Cluster size must be a power of two between 512 and 2048k
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"cluster-size": 128, "driver": "qcow2", "file": "node0", "size": 67108=
864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"cluster-size": 128, "driver": "qcow2", "file": "node0", "size": 67108=
864}}}
 {"return": {}}
 Job failed: Cluster size must be a power of two between 512 and 2048k
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"cluster-size": 4194304, "driver": "qcow2", "file": "node0", "size": 6=
7108864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"cluster-size": 4194304, "driver": "qcow2", "file": "node0", "size": 6=
7108864}}}
 {"return": {}}
 Job failed: Cluster size must be a power of two between 512 and 2048k
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"cluster-size": 0, "driver": "qcow2", "file": "node0", "size": 6710886=
4}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"cluster-size": 0, "driver": "qcow2", "file": "node0", "size": 6710886=
4}}}
 {"return": {}}
 Job failed: Cluster size must be a power of two between 512 and 2048k
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"cluster-size": 512, "driver": "qcow2", "file": "node0", "size": 28147=
4976710656}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"cluster-size": 512, "driver": "qcow2", "file": "node0", "size": 28147=
4976710656}}}
 {"return": {}}
 Job failed: Could not resize image: Failed to grow the L1 table: File to=
o large
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
 =3D=3D=3D Invalid refcount width =3D=3D=3D
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "refcount-bits": 128, "size": 6710=
8864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "refcount-bits": 128, "size": 6710=
8864}}}
 {"return": {}}
 Job failed: Refcount width must be a power of two and may not exceed 64 =
bits
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "refcount-bits": 0, "size": 671088=
64}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "refcount-bits": 0, "size": 671088=
64}}}
 {"return": {}}
 Job failed: Refcount width must be a power of two and may not exceed 64 =
bits
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "refcount-bits": 7, "size": 671088=
64}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "qcow2", "file": "node0", "refcount-bits": 7, "size": 671088=
64}}}
 {"return": {}}
 Job failed: Refcount width must be a power of two and may not exceed 64 =
bits
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
diff --git a/tests/qemu-iotests/207.out b/tests/qemu-iotests/207.out
index 88d2240f54..568e8619d0 100644
--- a/tests/qemu-iotests/207.out
+++ b/tests/qemu-iotests/207.out
@@ -1,6 +1,6 @@
 =3D=3D=3D Successful image creation (defaults) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "ssh", "location": {"path": "TEST_DIR/PID-t.img", "server": =
{"host": "127.0.0.1", "port": "22"}}, "size": 4194304}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "ssh", "location": {"path": "TEST_DIR/PID-t.img", "server": =
{"host": "127.0.0.1", "port": "22"}}, "size": 4194304}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -16,7 +16,7 @@ virtual size: 4.0M (4194304 bytes)
=20
 =3D=3D=3D Test host-key-check options =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"mode": "none"}, "pat=
h": "TEST_DIR/PID-t.img", "server": {"host": "127.0.0.1", "port": "22"}},=
 "size": 8388608}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"mode": "none"}, "pat=
h": "TEST_DIR/PID-t.img", "server": {"host": "127.0.0.1", "port": "22"}},=
 "size": 8388608}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -25,7 +25,7 @@ image: json:{"driver": "IMGFMT", "file": {"server.host"=
: "127.0.0.1", "server.po
 file format: IMGFMT
 virtual size: 8.0M (8388608 bytes)
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"mode": "known_hosts"=
}, "path": "TEST_DIR/PID-t.img", "server": {"host": "127.0.0.1", "port": =
"22"}}, "size": 4194304}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"mode": "known_hosts"=
}, "path": "TEST_DIR/PID-t.img", "server": {"host": "127.0.0.1", "port": =
"22"}}, "size": 4194304}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -34,13 +34,13 @@ image: json:{"driver": "IMGFMT", "file": {"server.hos=
t": "127.0.0.1", "server.po
 file format: IMGFMT
 virtual size: 4.0M (4194304 bytes)
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"hash": "wrong", "mod=
e": "hash", "type": "md5"}, "path": "TEST_DIR/PID-t.img", "server": {"hos=
t": "127.0.0.1", "port": "22"}}, "size": 2097152}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"hash": "wrong", "mod=
e": "hash", "type": "md5"}, "path": "TEST_DIR/PID-t.img", "server": {"hos=
t": "127.0.0.1", "port": "22"}}, "size": 2097152}}}
 {"return": {}}
 Job failed: remote host key does not match host_key_check 'wrong'
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"hash": "HASH", "mode=
": "hash", "type": "md5"}, "path": "TEST_DIR/PID-t.img", "server": {"host=
": "127.0.0.1", "port": "22"}}, "size": 8388608}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"hash": "HASH", "mode=
": "hash", "type": "md5"}, "path": "TEST_DIR/PID-t.img", "server": {"host=
": "127.0.0.1", "port": "22"}}, "size": 8388608}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -49,13 +49,13 @@ image: json:{"driver": "IMGFMT", "file": {"server.hos=
t": "127.0.0.1", "server.po
 file format: IMGFMT
 virtual size: 8.0M (8388608 bytes)
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"hash": "wrong", "mod=
e": "hash", "type": "sha1"}, "path": "TEST_DIR/PID-t.img", "server": {"ho=
st": "127.0.0.1", "port": "22"}}, "size": 2097152}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"hash": "wrong", "mod=
e": "hash", "type": "sha1"}, "path": "TEST_DIR/PID-t.img", "server": {"ho=
st": "127.0.0.1", "port": "22"}}, "size": 2097152}}}
 {"return": {}}
 Job failed: remote host key does not match host_key_check 'wrong'
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"hash": "HASH", "mode=
": "hash", "type": "sha1"}, "path": "TEST_DIR/PID-t.img", "server": {"hos=
t": "127.0.0.1", "port": "22"}}, "size": 4194304}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"hash": "HASH", "mode=
": "hash", "type": "sha1"}, "path": "TEST_DIR/PID-t.img", "server": {"hos=
t": "127.0.0.1", "port": "22"}}, "size": 4194304}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -66,13 +66,13 @@ virtual size: 4.0M (4194304 bytes)
=20
 =3D=3D=3D Invalid path and user =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"mode": "none"}, "pat=
h": "/this/is/not/an/existing/path", "server": {"host": "127.0.0.1", "por=
t": "22"}}, "size": 4194304}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"mode": "none"}, "pat=
h": "/this/is/not/an/existing/path", "server": {"host": "127.0.0.1", "por=
t": "22"}}, "size": 4194304}}}
 {"return": {}}
 Job failed: failed to open remote file '/this/is/not/an/existing/path': =
Failed opening remote file (libssh2 error code: -31)
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"mode": "none"}, "pat=
h": "TEST_DIR/PID-t.img", "server": {"host": "127.0.0.1", "port": "22"}, =
"user": "invalid user"}, "size": 4194304}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "ssh", "location": {"host-key-check": {"mode": "none"}, "pat=
h": "TEST_DIR/PID-t.img", "server": {"host": "127.0.0.1", "port": "22"}, =
"user": "invalid user"}, "size": 4194304}}}
 {"return": {}}
 Job failed: failed to authenticate using publickey authentication and th=
e identities held by your ssh-agent
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
diff --git a/tests/qemu-iotests/210.out b/tests/qemu-iotests/210.out
index 923cb05117..a3692ce00d 100644
--- a/tests/qemu-iotests/210.out
+++ b/tests/qemu-iotests/210.out
@@ -1,13 +1,13 @@
 =3D=3D=3D Successful image creation (defaults) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.luks", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.luks", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.luks", "node_name": "imgfile"}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.luks", "node-name": "imgfile"}}
 {"return": {}}
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "luks", "file": "imgfile", "iter-time": 10, "key-secret": "k=
eysec0", "size": 134217728}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "luks", "file": "imgfile", "iter-time": 10, "key-secret": "k=
eysec0", "size": 134217728}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -54,12 +54,12 @@ Format specific information:
=20
 =3D=3D=3D Successful image creation (with non-default options) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.luks", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.luks", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"cipher-alg": "twofish-128", "cipher-mode": "ctr", "driver": "luks", "=
file": {"driver": "file", "filename": "TEST_DIR/PID-t.luks"}, "hash-alg":=
 "sha1", "iter-time": 10, "ivgen-alg": "plain64", "ivgen-hash-alg": "md5"=
, "key-secret": "keysec0", "size": 67108864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"cipher-alg": "twofish-128", "cipher-mode": "ctr", "driver": "luks", "=
file": {"driver": "file", "filename": "TEST_DIR/PID-t.luks"}, "hash-alg":=
 "sha1", "iter-time": 10, "ivgen-alg": "plain64", "ivgen-hash-alg": "md5"=
, "key-secret": "keysec0", "size": 67108864}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -106,7 +106,7 @@ Format specific information:
=20
 =3D=3D=3D Invalid BlockdevRef =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "luks", "file": "this doesn't exist", "size": 67108864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "luks", "file": "this doesn't exist", "size": 67108864}}}
 {"return": {}}
 Job failed: Cannot find device=3Dthis doesn't exist nor node_name=3Dthis=
 doesn't exist
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
@@ -114,7 +114,7 @@ Job failed: Cannot find device=3Dthis doesn't exist n=
or node_name=3Dthis doesn't exi
=20
 =3D=3D=3D Zero size =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "luks", "file": "node0", "iter-time": 10, "key-secret": "key=
sec0", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "luks", "file": "node0", "iter-time": 10, "key-secret": "key=
sec0", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -161,19 +161,19 @@ Format specific information:
=20
 =3D=3D=3D Invalid sizes =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "luks", "file": "node0", "key-secret": "keysec0", "size": 18=
446744073709551104}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "luks", "file": "node0", "key-secret": "keysec0", "size": 18=
446744073709551104}}}
 {"return": {}}
 Job failed: The requested file size is too large
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "luks", "file": "node0", "key-secret": "keysec0", "size": 92=
23372036854775808}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "luks", "file": "node0", "key-secret": "keysec0", "size": 92=
23372036854775808}}}
 {"return": {}}
 Job failed: The requested file size is too large
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "luks", "file": "node0", "key-secret": "keysec0", "size": 92=
23372036854775296}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "luks", "file": "node0", "key-secret": "keysec0", "size": 92=
23372036854775296}}}
 {"return": {}}
 Job failed: The requested file size is too large
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
@@ -181,13 +181,13 @@ Job failed: The requested file size is too large
=20
 =3D=3D=3D Resize image with invalid sizes =3D=3D=3D
=20
-{"execute": "block_resize", "arguments": {"node_name": "node1", "size": =
9223372036854775296}}
+{"execute": "block_resize", "arguments": {"node-name": "node1", "size": =
9223372036854775296}}
 {"error": {"class": "GenericError", "desc": "The requested file size is =
too large"}}
-{"execute": "block_resize", "arguments": {"node_name": "node1", "size": =
9223372036854775808}}
+{"execute": "block_resize", "arguments": {"node-name": "node1", "size": =
9223372036854775808}}
 {"error": {"class": "GenericError", "desc": "Invalid parameter type for =
'size', expected: integer"}}
-{"execute": "block_resize", "arguments": {"node_name": "node1", "size": =
18446744073709551104}}
+{"execute": "block_resize", "arguments": {"node-name": "node1", "size": =
18446744073709551104}}
 {"error": {"class": "GenericError", "desc": "Invalid parameter type for =
'size', expected: integer"}}
-{"execute": "block_resize", "arguments": {"node_name": "node1", "size": =
-9223372036854775808}}
+{"execute": "block_resize", "arguments": {"node-name": "node1", "size": =
-9223372036854775808}}
 {"error": {"class": "GenericError", "desc": "Parameter 'size' expects a =
>0 size"}}
 image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": =
"TEST_IMG"}, "key-secret": "keysec0"}
 file format: IMGFMT
diff --git a/tests/qemu-iotests/211.out b/tests/qemu-iotests/211.out
index eebb0ea086..682adc2a10 100644
--- a/tests/qemu-iotests/211.out
+++ b/tests/qemu-iotests/211.out
@@ -1,13 +1,13 @@
 =3D=3D=3D Successful image creation (defaults) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vdi", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vdi", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.vdi", "node_name": "imgfile"}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.vdi", "node-name": "imgfile"}}
 {"return": {}}
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vdi", "file": "imgfile", "size": 134217728}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vdi", "file": "imgfile", "size": 134217728}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -21,12 +21,12 @@ cluster_size: 1048576
=20
 =3D=3D=3D Successful image creation (explicit defaults) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vdi", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vdi", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vdi", "file": {"driver": "file", "filename": "TEST_DIR/PID-=
t.vdi"}, "preallocation": "off", "size": 67108864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vdi", "file": {"driver": "file", "filename": "TEST_DIR/PID-=
t.vdi"}, "preallocation": "off", "size": 67108864}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -40,12 +40,12 @@ cluster_size: 1048576
=20
 =3D=3D=3D Successful image creation (with non-default options) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vdi", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vdi", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vdi", "file": {"driver": "file", "filename": "TEST_DIR/PID-=
t.vdi"}, "preallocation": "metadata", "size": 33554432}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vdi", "file": {"driver": "file", "filename": "TEST_DIR/PID-=
t.vdi"}, "preallocation": "metadata", "size": 33554432}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -60,7 +60,7 @@ cluster_size: 1048576
=20
 =3D=3D=3D Invalid BlockdevRef =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vdi", "file": "this doesn't exist", "size": 33554432}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vdi", "file": "this doesn't exist", "size": 33554432}}}
 {"return": {}}
 Job failed: Cannot find device=3Dthis doesn't exist nor node_name=3Dthis=
 doesn't exist
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
@@ -68,7 +68,7 @@ Job failed: Cannot find device=3Dthis doesn't exist nor=
 node_name=3Dthis doesn't exi
=20
 =3D=3D=3D Zero size =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vdi", "file": "node0", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vdi", "file": "node0", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -80,7 +80,7 @@ cluster_size: 1048576
=20
 =3D=3D=3D Maximum size =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vdi", "file": "node0", "size": 562949819203584}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vdi", "file": "node0", "size": 562949819203584}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -92,19 +92,19 @@ cluster_size: 1048576
=20
 =3D=3D=3D Invalid sizes =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vdi", "file": "node0", "size": 18446744073709551104}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vdi", "file": "node0", "size": 18446744073709551104}}}
 {"return": {}}
 Job failed: Unsupported VDI image size (size is 0xfffffffffffffe00, max =
supported is 0x1fffff8000000)
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vdi", "file": "node0", "size": 9223372036854775808}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vdi", "file": "node0", "size": 9223372036854775808}}}
 {"return": {}}
 Job failed: Unsupported VDI image size (size is 0x8000000000000000, max =
supported is 0x1fffff8000000)
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vdi", "file": "node0", "size": 562949819203585}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vdi", "file": "node0", "size": 562949819203585}}}
 {"return": {}}
 Job failed: Unsupported VDI image size (size is 0x1fffff8000001, max sup=
ported is 0x1fffff8000000)
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
diff --git a/tests/qemu-iotests/212.out b/tests/qemu-iotests/212.out
index 01da467282..22810720cf 100644
--- a/tests/qemu-iotests/212.out
+++ b/tests/qemu-iotests/212.out
@@ -1,13 +1,13 @@
 =3D=3D=3D Successful image creation (defaults) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.parallels", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.parallels", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.parallels", "node_name": "imgfile"}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.parallels", "node-name": "imgfile"}}
 {"return": {}}
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "parallels", "file": "imgfile", "size": 134217728}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "parallels", "file": "imgfile", "size": 134217728}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -18,12 +18,12 @@ virtual size: 128M (134217728 bytes)
=20
 =3D=3D=3D Successful image creation (explicit defaults) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.parallels", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.parallels", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"cluster-size": 1048576, "driver": "parallels", "file": {"driver": "fi=
le", "filename": "TEST_DIR/PID-t.parallels"}, "size": 67108864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"cluster-size": 1048576, "driver": "parallels", "file": {"driver": "fi=
le", "filename": "TEST_DIR/PID-t.parallels"}, "size": 67108864}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -34,12 +34,12 @@ virtual size: 64M (67108864 bytes)
=20
 =3D=3D=3D Successful image creation (with non-default options) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.parallels", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.parallels", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"cluster-size": 65536, "driver": "parallels", "file": {"driver": "file=
", "filename": "TEST_DIR/PID-t.parallels"}, "size": 33554432}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"cluster-size": 65536, "driver": "parallels", "file": {"driver": "file=
", "filename": "TEST_DIR/PID-t.parallels"}, "size": 33554432}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -50,7 +50,7 @@ virtual size: 32M (33554432 bytes)
=20
 =3D=3D=3D Invalid BlockdevRef =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "parallels", "file": "this doesn't exist", "size": 33554432}=
}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "parallels", "file": "this doesn't exist", "size": 33554432}=
}}
 {"return": {}}
 Job failed: Cannot find device=3Dthis doesn't exist nor node_name=3Dthis=
 doesn't exist
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
@@ -58,7 +58,7 @@ Job failed: Cannot find device=3Dthis doesn't exist nor=
 node_name=3Dthis doesn't exi
=20
 =3D=3D=3D Zero size =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "parallels", "file": "node0", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "parallels", "file": "node0", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -69,7 +69,7 @@ virtual size: 0 (0 bytes)
=20
 =3D=3D=3D Maximum size =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "parallels", "file": "node0", "size": 4503599627369984}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "parallels", "file": "node0", "size": 4503599627369984}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -80,31 +80,31 @@ virtual size: 4096T (4503599627369984 bytes)
=20
 =3D=3D=3D Invalid sizes =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "parallels", "file": "node0", "size": 1234}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "parallels", "file": "node0", "size": 1234}}}
 {"return": {}}
 Job failed: Image size must be a multiple of 512 bytes
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "parallels", "file": "node0", "size": 18446744073709551104}}=
}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "parallels", "file": "node0", "size": 18446744073709551104}}=
}
 {"return": {}}
 Job failed: Image size is too large for this cluster size
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "parallels", "file": "node0", "size": 9223372036854775808}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "parallels", "file": "node0", "size": 9223372036854775808}}}
 {"return": {}}
 Job failed: Image size is too large for this cluster size
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "parallels", "file": "node0", "size": 9223372036854775296}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "parallels", "file": "node0", "size": 9223372036854775296}}}
 {"return": {}}
 Job failed: Image size is too large for this cluster size
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "parallels", "file": "node0", "size": 4503599627370497}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "parallels", "file": "node0", "size": 4503599627370497}}}
 {"return": {}}
 Job failed: Image size is too large for this cluster size
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
@@ -112,43 +112,43 @@ Job failed: Image size is too large for this cluste=
r size
=20
 =3D=3D=3D Invalid cluster size =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"cluster-size": 1234, "driver": "parallels", "file": "node0", "size": =
67108864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"cluster-size": 1234, "driver": "parallels", "file": "node0", "size": =
67108864}}}
 {"return": {}}
 Job failed: Cluster size must be a multiple of 512 bytes
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"cluster-size": 128, "driver": "parallels", "file": "node0", "size": 6=
7108864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"cluster-size": 128, "driver": "parallels", "file": "node0", "size": 6=
7108864}}}
 {"return": {}}
 Job failed: Cluster size must be a multiple of 512 bytes
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"cluster-size": 4294967296, "driver": "parallels", "file": "node0", "s=
ize": 67108864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"cluster-size": 4294967296, "driver": "parallels", "file": "node0", "s=
ize": 67108864}}}
 {"return": {}}
 Job failed: Cluster size is too large
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"cluster-size": 9223372036854775808, "driver": "parallels", "file": "n=
ode0", "size": 67108864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"cluster-size": 9223372036854775808, "driver": "parallels", "file": "n=
ode0", "size": 67108864}}}
 {"return": {}}
 Job failed: Cluster size is too large
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"cluster-size": 18446744073709551104, "driver": "parallels", "file": "=
node0", "size": 67108864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"cluster-size": 18446744073709551104, "driver": "parallels", "file": "=
node0", "size": 67108864}}}
 {"return": {}}
 Job failed: Cluster size is too large
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"cluster-size": 0, "driver": "parallels", "file": "node0", "size": 671=
08864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"cluster-size": 0, "driver": "parallels", "file": "node0", "size": 671=
08864}}}
 {"return": {}}
 Job failed: Image size is too large for this cluster size
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"cluster-size": 512, "driver": "parallels", "file": "node0", "size": 2=
81474976710656}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"cluster-size": 512, "driver": "parallels", "file": "node0", "size": 2=
81474976710656}}}
 {"return": {}}
 Job failed: Image size is too large for this cluster size
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
diff --git a/tests/qemu-iotests/213.out b/tests/qemu-iotests/213.out
index 0c9d65b2fe..169083e08e 100644
--- a/tests/qemu-iotests/213.out
+++ b/tests/qemu-iotests/213.out
@@ -1,13 +1,13 @@
 =3D=3D=3D Successful image creation (defaults) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vhdx", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vhdx", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.vhdx", "node_name": "imgfile"}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.vhdx", "node-name": "imgfile"}}
 {"return": {}}
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vhdx", "file": "imgfile", "size": 134217728}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vhdx", "file": "imgfile", "size": 134217728}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -19,12 +19,12 @@ cluster_size: 8388608
=20
 =3D=3D=3D Successful image creation (explicit defaults) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vhdx", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vhdx", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"block-size": 8388608, "block-state-zero": true, "driver": "vhdx", "fi=
le": {"driver": "file", "filename": "TEST_DIR/PID-t.vhdx"}, "log-size": 1=
048576, "size": 67108864, "subformat": "dynamic"}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"block-size": 8388608, "block-state-zero": true, "driver": "vhdx", "fi=
le": {"driver": "file", "filename": "TEST_DIR/PID-t.vhdx"}, "log-size": 1=
048576, "size": 67108864, "subformat": "dynamic"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -36,12 +36,12 @@ cluster_size: 8388608
=20
 =3D=3D=3D Successful image creation (with non-default options) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vhdx", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vhdx", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"block-size": 268435456, "block-state-zero": false, "driver": "vhdx", =
"file": {"driver": "file", "filename": "TEST_DIR/PID-t.vhdx"}, "log-size"=
: 8388608, "size": 33554432, "subformat": "fixed"}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"block-size": 268435456, "block-state-zero": false, "driver": "vhdx", =
"file": {"driver": "file", "filename": "TEST_DIR/PID-t.vhdx"}, "log-size"=
: 8388608, "size": 33554432, "subformat": "fixed"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -53,7 +53,7 @@ cluster_size: 268435456
=20
 =3D=3D=3D Invalid BlockdevRef =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vhdx", "file": "this doesn't exist", "size": 33554432}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vhdx", "file": "this doesn't exist", "size": 33554432}}}
 {"return": {}}
 Job failed: Cannot find device=3Dthis doesn't exist nor node_name=3Dthis=
 doesn't exist
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
@@ -61,7 +61,7 @@ Job failed: Cannot find device=3Dthis doesn't exist nor=
 node_name=3Dthis doesn't exi
=20
 =3D=3D=3D Zero size =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -73,7 +73,7 @@ cluster_size: 8388608
=20
 =3D=3D=3D Maximum size =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "size": 70368744177664}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "size": 70368744177664}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -85,25 +85,25 @@ cluster_size: 67108864
=20
 =3D=3D=3D Invalid sizes =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "size": 18446744073709551104}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "size": 18446744073709551104}}}
 {"return": {}}
 Job failed: Image size too large; max of 64TB
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "size": 9223372036854775808}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "size": 9223372036854775808}}}
 {"return": {}}
 Job failed: Image size too large; max of 64TB
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "size": 9223372036854775296}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "size": 9223372036854775296}}}
 {"return": {}}
 Job failed: Image size too large; max of 64TB
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "size": 70368744177665}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "size": 70368744177665}}}
 {"return": {}}
 Job failed: Image size too large; max of 64TB
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
@@ -111,31 +111,31 @@ Job failed: Image size too large; max of 64TB
=20
 =3D=3D=3D Invalid block size =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"block-size": 1234567, "driver": "vhdx", "file": "node0", "size": 6710=
8864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"block-size": 1234567, "driver": "vhdx", "file": "node0", "size": 6710=
8864}}}
 {"return": {}}
 Job failed: Block size must be a multiple of 1 MB
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"block-size": 128, "driver": "vhdx", "file": "node0", "size": 67108864=
}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"block-size": 128, "driver": "vhdx", "file": "node0", "size": 67108864=
}}}
 {"return": {}}
 Job failed: Block size must be a multiple of 1 MB
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"block-size": 3145728, "driver": "vhdx", "file": "node0", "size": 6710=
8864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"block-size": 3145728, "driver": "vhdx", "file": "node0", "size": 6710=
8864}}}
 {"return": {}}
 Job failed: Block size must be a power of two
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"block-size": 536870912, "driver": "vhdx", "file": "node0", "size": 67=
108864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"block-size": 536870912, "driver": "vhdx", "file": "node0", "size": 67=
108864}}}
 {"return": {}}
 Job failed: Block size must not exceed 268435456
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"block-size": 0, "driver": "vhdx", "file": "node0", "size": 67108864}}=
}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"block-size": 0, "driver": "vhdx", "file": "node0", "size": 67108864}}=
}
 {"return": {}}
 Job failed: Block size must be a multiple of 1 MB
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
@@ -143,25 +143,25 @@ Job failed: Block size must be a multiple of 1 MB
=20
 =3D=3D=3D Invalid log size =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "log-size": 1234567, "size": 671088=
64}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "log-size": 1234567, "size": 671088=
64}}}
 {"return": {}}
 Job failed: Log size must be a multiple of 1 MB
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "log-size": 128, "size": 67108864}}=
}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "log-size": 128, "size": 67108864}}=
}
 {"return": {}}
 Job failed: Log size must be a multiple of 1 MB
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "log-size": 4294967296, "size": 671=
08864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "log-size": 4294967296, "size": 671=
08864}}}
 {"return": {}}
 Job failed: Log size must be smaller than 4 GB
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "log-size": 0, "size": 67108864}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vhdx", "file": "node0", "log-size": 0, "size": 67108864}}}
 {"return": {}}
 Job failed: Log size must be a multiple of 1 MB
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
diff --git a/tests/qemu-iotests/237.out b/tests/qemu-iotests/237.out
index 241c864369..2aaa68f672 100644
--- a/tests/qemu-iotests/237.out
+++ b/tests/qemu-iotests/237.out
@@ -1,13 +1,13 @@
 =3D=3D=3D Successful image creation (defaults) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vmdk", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vmdk", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.vmdk", "node_name": "imgfile"}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.vmdk", "node-name": "imgfile"}}
 {"return": {}}
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "file": "imgfile", "size": 5368709120}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vmdk", "file": "imgfile", "size": 5368709120}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -29,12 +29,12 @@ Format specific information:
=20
 =3D=3D=3D Successful image creation (inline blockdev-add, explicit defau=
lts) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vmdk", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vmdk", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "ide", "driver": "vmdk", "extents": [], "file": {"driv=
er": "file", "filename": "TEST_DIR/PID-t.vmdk"}, "hwversion": "4", "size"=
: 67108864, "subformat": "monolithicSparse", "zeroed-grain": false}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"adapter-type": "ide", "driver": "vmdk", "extents": [], "file": {"driv=
er": "file", "filename": "TEST_DIR/PID-t.vmdk"}, "hwversion": "4", "size"=
: 67108864, "subformat": "monolithicSparse", "zeroed-grain": false}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -56,12 +56,12 @@ Format specific information:
=20
 =3D=3D=3D Successful image creation (with non-default options) =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vmdk", "size": 0}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vmdk", "size": 0}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "buslogic", "driver": "vmdk", "extents": [], "file": {=
"driver": "file", "filename": "TEST_DIR/PID-t.vmdk"}, "size": 33554432, "=
subformat": "monolithicSparse", "zeroed-grain": true}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"adapter-type": "buslogic", "driver": "vmdk", "extents": [], "file": {=
"driver": "file", "filename": "TEST_DIR/PID-t.vmdk"}, "size": 33554432, "=
subformat": "monolithicSparse", "zeroed-grain": true}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -83,7 +83,7 @@ Format specific information:
=20
 =3D=3D=3D Invalid BlockdevRef =3D=3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "file": "this doesn't exist", "size": 33554432}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vmdk", "file": "this doesn't exist", "size": 33554432}}}
 {"return": {}}
 Job failed: Cannot find device=3Dthis doesn't exist nor node_name=3Dthis=
 doesn't exist
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
@@ -93,38 +93,38 @@ Job failed: Cannot find device=3Dthis doesn't exist n=
or node_name=3Dthis doesn't exi
=20
 =3D=3D Valid adapter types =3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "ide", "driver": "vmdk", "file": "node0", "size": 3355=
4432}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"adapter-type": "ide", "driver": "vmdk", "file": "node0", "size": 3355=
4432}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "buslogic", "driver": "vmdk", "file": "node0", "size":=
 33554432}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"adapter-type": "buslogic", "driver": "vmdk", "file": "node0", "size":=
 33554432}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "lsilogic", "driver": "vmdk", "file": "node0", "size":=
 33554432}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"adapter-type": "lsilogic", "driver": "vmdk", "file": "node0", "size":=
 33554432}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "legacyESX", "driver": "vmdk", "file": "node0", "size"=
: 33554432}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"adapter-type": "legacyESX", "driver": "vmdk", "file": "node0", "size"=
: 33554432}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
 =3D=3D Invalid adapter types =3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "foo", "driver": "vmdk", "file": "node0", "size": 3355=
4432}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"adapter-type": "foo", "driver": "vmdk", "file": "node0", "size": 3355=
4432}}}
 {"error": {"class": "GenericError", "desc": "Invalid parameter 'foo'"}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "IDE", "driver": "vmdk", "file": "node0", "size": 3355=
4432}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"adapter-type": "IDE", "driver": "vmdk", "file": "node0", "size": 3355=
4432}}}
 {"error": {"class": "GenericError", "desc": "Invalid parameter 'IDE'"}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": "legacyesx", "driver": "vmdk", "file": "node0", "size"=
: 33554432}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"adapter-type": "legacyesx", "driver": "vmdk", "file": "node0", "size"=
: 33554432}}}
 {"error": {"class": "GenericError", "desc": "Invalid parameter 'legacyes=
x'"}}
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"adapter-type": 1, "driver": "vmdk", "file": "node0", "size": 33554432=
}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"adapter-type": 1, "driver": "vmdk", "file": "node0", "size": 33554432=
}}}
 {"error": {"class": "GenericError", "desc": "Invalid parameter type for =
'options.adapter-type', expected: string"}}
=20
 =3D=3D=3D Other subformats =3D=3D=3D
@@ -137,7 +137,7 @@ Formatting 'TEST_DIR/PID-t.vmdk.3', fmt=3Dvmdk size=3D=
0 compat6=3Doff hwversion=3Dundefi
=20
 =3D=3D Missing extent =3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "file": "node0", "size": 33554432, "subformat": "mon=
olithicFlat"}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vmdk", "file": "node0", "size": 33554432, "subformat": "mon=
olithicFlat"}}}
 {"return": {}}
 Job failed: Extent [0] not specified
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
@@ -145,14 +145,14 @@ Job failed: Extent [0] not specified
=20
 =3D=3D Correct extent =3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 335544=
32, "subformat": "monolithicFlat"}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 335544=
32, "subformat": "monolithicFlat"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
 =3D=3D Extra extent =3D=3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 512, "subformat": "monolithicFlat"}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 512, "subformat": "monolithicFlat"}}}
 {"return": {}}
 Job failed: List of extents contains unused extents
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
@@ -162,7 +162,7 @@ Job failed: List of extents contains unused extents
=20
 =3D twoGbMaxExtentFlat 512 =3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 512, "=
subformat": "twoGbMaxExtentFlat"}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 512, "=
subformat": "twoGbMaxExtentFlat"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -182,7 +182,7 @@ Format specific information:
=20
 =3D twoGbMaxExtentSparse 512 =3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 512, "=
subformat": "twoGbMaxExtentSparse"}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 512, "=
subformat": "twoGbMaxExtentSparse"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -204,7 +204,7 @@ Format specific information:
=20
 =3D twoGbMaxExtentFlat 1073741824 =3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 107374=
1824, "subformat": "twoGbMaxExtentFlat"}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 107374=
1824, "subformat": "twoGbMaxExtentFlat"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -224,7 +224,7 @@ Format specific information:
=20
 =3D twoGbMaxExtentSparse 1073741824 =3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 107374=
1824, "subformat": "twoGbMaxExtentSparse"}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 107374=
1824, "subformat": "twoGbMaxExtentSparse"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -246,7 +246,7 @@ Format specific information:
=20
 =3D twoGbMaxExtentFlat 2147483648 =3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 214748=
3648, "subformat": "twoGbMaxExtentFlat"}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 214748=
3648, "subformat": "twoGbMaxExtentFlat"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -266,7 +266,7 @@ Format specific information:
=20
 =3D twoGbMaxExtentSparse 2147483648 =3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 214748=
3648, "subformat": "twoGbMaxExtentSparse"}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1"], "file": "node0", "size": 214748=
3648, "subformat": "twoGbMaxExtentSparse"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -288,7 +288,7 @@ Format specific information:
=20
 =3D twoGbMaxExtentFlat 5368709120 =3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 5368709120, "subformat": "twoGbMaxExtentFlat"}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 5368709120, "subformat": "twoGbMaxExtentFlat"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
@@ -316,7 +316,7 @@ Format specific information:
=20
 =3D twoGbMaxExtentSparse 5368709120 =3D
=20
-{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 5368709120, "subformat": "twoGbMaxExtentSparse"}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vmdk", "extents": ["ext1", "ext2", "ext3"], "file": "node0"=
, "size": 5368709120, "subformat": "twoGbMaxExtentSparse"}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index b6cb73e108..390954437c 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -76,12 +76,14 @@ def qemu_img(*args):
         sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcod=
e, ' '.join(qemu_img_args + list(args))))
     return exitcode
=20
-def ordered_kwargs(kwargs):
+def ordered_kwargs(kwargs, conv_keys=3DTrue):
     # kwargs prior to 3.6 are not ordered, so:
     od =3D OrderedDict()
     for k, v in sorted(kwargs.items()):
+        if conv_keys:
+            k =3D k.replace('_', '-')
         if isinstance(v, dict):
-            od[k] =3D ordered_kwargs(v)
+            od[k] =3D ordered_kwargs(v, conv_keys=3DFalse)
         else:
             od[k] =3D v
     return od
--=20
2.20.1
