Received: from eggs.gnu.org ([2001:4830:134:3::10]:54211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK4Fy-0001kw-Ry
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK4Fx-0007T5-My
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:26:38 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 29 Nov 2017 16:26:19 +0100
Message-Id: <20171129152628.14906-2-kwolf@redhat.com>
In-Reply-To: <20171129152628.14906-1-kwolf@redhat.com>
References: <20171129152628.14906-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/10] iotests: fix 075 and 078
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: John Snow <jsnow@redhat.com>

Both of these tests are for formats which now stipulate that they are
read-only. Adjust the tests to match.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/075 | 18 +++++++++---------
 tests/qemu-iotests/078 | 14 +++++++-------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tests/qemu-iotests/075 b/tests/qemu-iotests/075
index 770d51c6cb..caa30d4743 100755
--- a/tests/qemu-iotests/075
+++ b/tests/qemu-iotests/075
@@ -48,56 +48,56 @@ offsets_offset=3D136
 echo
 echo "=3D=3D check that the first sector can be read =3D=3D"
 _use_sample_img simple-pattern.cloop.bz2
-$QEMU_IO -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_test=
dir
+$QEMU_IO -r -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_t=
estdir
=20
 echo
 echo "=3D=3D check that the last sector can be read =3D=3D"
 _use_sample_img simple-pattern.cloop.bz2
-$QEMU_IO -c "read $((1024 * 1024 - 512)) 512" $TEST_IMG 2>&1 | _filter_q=
emu_io | _filter_testdir
+$QEMU_IO -r -c "read $((1024 * 1024 - 512)) 512" $TEST_IMG 2>&1 | _filte=
r_qemu_io | _filter_testdir
=20
 echo
 echo "=3D=3D block_size must be a multiple of 512 =3D=3D"
 _use_sample_img simple-pattern.cloop.bz2
 poke_file "$TEST_IMG" "$block_size_offset" "\x00\x00\x02\x01"
-$QEMU_IO -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_test=
dir
+$QEMU_IO -r -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_t=
estdir
=20
 echo
 echo "=3D=3D block_size cannot be zero =3D=3D"
 _use_sample_img simple-pattern.cloop.bz2
 poke_file "$TEST_IMG" "$block_size_offset" "\x00\x00\x00\x00"
-$QEMU_IO -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_test=
dir
+$QEMU_IO -r -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_t=
estdir
=20
 echo
 echo "=3D=3D huge block_size =3D=3D=3D"
 _use_sample_img simple-pattern.cloop.bz2
 poke_file "$TEST_IMG" "$block_size_offset" "\xff\xff\xfe\x00"
-$QEMU_IO -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_test=
dir
+$QEMU_IO -r -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_t=
estdir
=20
 echo
 echo "=3D=3D offsets_size overflow =3D=3D=3D"
 _use_sample_img simple-pattern.cloop.bz2
 poke_file "$TEST_IMG" "$n_blocks_offset" "\xff\xff\xff\xff"
-$QEMU_IO -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_test=
dir
+$QEMU_IO -r -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_t=
estdir
=20
 echo
 echo "=3D=3D refuse images that require too many offsets =3D=3D=3D"
 _use_sample_img simple-pattern.cloop.bz2
 poke_file "$TEST_IMG" "$n_blocks_offset" "\x04\x00\x00\x01"
-$QEMU_IO -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_test=
dir
+$QEMU_IO -r -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_t=
estdir
=20
 echo
 echo "=3D=3D refuse images with non-monotonically increasing offsets =3D=
=3D"
 _use_sample_img simple-pattern.cloop.bz2
 poke_file "$TEST_IMG" "$offsets_offset" "\x00\x00\x00\x00\xff\xff\xff\xf=
f"
 poke_file "$TEST_IMG" $((offsets_offset + 8)) "\x00\x00\x00\x00\xff\xfe\=
x00\x00"
-$QEMU_IO -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_test=
dir
+$QEMU_IO -r -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_t=
estdir
=20
 echo
 echo "=3D=3D refuse images with invalid compressed block size =3D=3D"
 _use_sample_img simple-pattern.cloop.bz2
 poke_file "$TEST_IMG" "$offsets_offset" "\x00\x00\x00\x00\x00\x00\x00\x0=
0"
 poke_file "$TEST_IMG" $((offsets_offset + 8)) "\xff\xff\xff\xff\xff\xff\=
xff\xff"
-$QEMU_IO -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_test=
dir
+$QEMU_IO -r -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_t=
estdir
=20
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/078 b/tests/qemu-iotests/078
index f333e9ac84..a106c26f6b 100755
--- a/tests/qemu-iotests/078
+++ b/tests/qemu-iotests/078
@@ -48,41 +48,41 @@ disk_size_offset=3D$((0x58))
 echo
 echo "=3D=3D Read from a valid image =3D=3D"
 _use_sample_img empty.bochs.bz2
-{ $QEMU_IO -c "read 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter=
_testdir
+{ $QEMU_IO -r -c "read 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _fil=
ter_testdir
=20
 echo
 echo "=3D=3D Negative catalog size =3D=3D"
 _use_sample_img empty.bochs.bz2
 poke_file "$TEST_IMG" "$catalog_size_offset" "\xff\xff\xff\xff"
-{ $QEMU_IO -c "read 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter=
_testdir
+{ $QEMU_IO -r -c "read 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _fil=
ter_testdir
=20
 echo
 echo "=3D=3D Overflow for catalog size * sizeof(uint32_t) =3D=3D"
 _use_sample_img empty.bochs.bz2
 poke_file "$TEST_IMG" "$catalog_size_offset" "\x00\x00\x00\x40"
-{ $QEMU_IO -c "read 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter=
_testdir
+{ $QEMU_IO -r -c "read 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _fil=
ter_testdir
=20
 echo
 echo "=3D=3D Too small catalog bitmap for image size =3D=3D"
 _use_sample_img empty.bochs.bz2
 poke_file "$TEST_IMG" "$disk_size_offset" "\x00\xc0\x0f\x00\x00\x00\x00\=
x7f"
-{ $QEMU_IO -c "read 2T 4k" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter=
_testdir
+{ $QEMU_IO -r -c "read 2T 4k" $TEST_IMG; } 2>&1 | _filter_qemu_io | _fil=
ter_testdir
=20
 _use_sample_img empty.bochs.bz2
 poke_file "$TEST_IMG" "$catalog_size_offset" "\x10\x00\x00\x00"
-{ $QEMU_IO -c "read 0xfbe00 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _=
filter_testdir
+{ $QEMU_IO -r -c "read 0xfbe00 512" $TEST_IMG; } 2>&1 | _filter_qemu_io =
| _filter_testdir
=20
 echo
 echo "=3D=3D Negative extent size =3D=3D"
 _use_sample_img empty.bochs.bz2
 poke_file "$TEST_IMG" "$extent_size_offset" "\x00\x00\x00\x80"
-{ $QEMU_IO -c "read 768k 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _fil=
ter_testdir
+{ $QEMU_IO -r -c "read 768k 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _=
filter_testdir
=20
 echo
 echo "=3D=3D Zero extent size =3D=3D"
 _use_sample_img empty.bochs.bz2
 poke_file "$TEST_IMG" "$extent_size_offset" "\x00\x00\x00\x00"
-{ $QEMU_IO -c "read 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter=
_testdir
+{ $QEMU_IO -r -c "read 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _fil=
ter_testdir
=20
 # success, all done
 echo "*** done"
--=20
2.13.6
