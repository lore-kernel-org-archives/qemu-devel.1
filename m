Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C05EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 22:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5643A20674
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 22:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHYBLA3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5643A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i20e1-0008At-CY
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 18:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nirsof@gmail.com>) id 1i20br-000721-2l
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 18:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1i20bp-0003td-6C
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 18:03:39 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39149)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1i20bo-0003sT-HQ; Sun, 25 Aug 2019 18:03:36 -0400
Received: by mail-wr1-x442.google.com with SMTP id t16so13449933wra.6;
 Sun, 25 Aug 2019 15:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xV5Uc/r1q2RUVM7UqlbKezyyGHpCUTZy6HjETubTb9M=;
 b=IHYBLA3EQYJhrbokXC70yQrFdD1SVh3vuSkT6VHGhufgY8+aOKoGy3M9Q7MyMgF9NG
 Nsp7kvFqutbe2vWYbeX8QEv2tooyoljvMLUsyS3dN3BmYql9nb0PmsJC5DhrlKOc5cAV
 p9TIoAqvg60oidSSnjrHCLlKb8BER2j2K31d6IZZxxfLTftCzPmGSwzf+bFcfEBw4cg7
 RK++By5Cd3bIRW43f4EYrcjGmKAJzyLcqsv5/o8VcNg2VCAhU3gGHI8sACC+mcJZYFbb
 mgrm09uUZz7lzVvzTYHqHdqKS95EJr7tFduLYXGz5fIEDB+B+1i8/gMCuF73oQKqA+a4
 c/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xV5Uc/r1q2RUVM7UqlbKezyyGHpCUTZy6HjETubTb9M=;
 b=eX19de0IwHixnAWNg9ghCOKxC18F2iDFimGjtJ1IiceuV7LU+B0QL3SuxdoKaiPoT4
 VfCv7SWzuvBNNso4ScYvyCL9PQQpaW8s05LeFIfVilSv6jBQ6sq19cRYV7B3tTWRV1LO
 nQsb8sfA9N5+cfbUG8dTWz4Rf2CBkHR4wFCyWpLoceSprLccerAteXtNp21TXePxFuN5
 nWHgtWC2gzvVnvB9hRmYy+XTj6IX9/ItaiZxuOEwsmfhwY4ecXjzwnNrgJXNgNnbnLNu
 bJq5tG0ZZ25stUH+1Kry1RJe8LQA0rFdAHF3vWETv+VaI1qebM3SdQwZxAD/63hklqxM
 4exw==
X-Gm-Message-State: APjAAAW5j1FOpJU+d9nUgeagK5lcehC5d4o68uHBua8p5qLkdbDhDHJ2
 OZfH8Sh/TGmTJv367x2ni+3jEwSRNPg=
X-Google-Smtp-Source: APXvYqzP7fCtC1i9PMcQcB1xGZlC6rqQYlNiNV4xVaODZaRvILy2rjz9VNjlk/jJFTxU/fcWakslzg==
X-Received: by 2002:adf:f507:: with SMTP id q7mr18405597wro.210.1566770614776; 
 Sun, 25 Aug 2019 15:03:34 -0700 (PDT)
Received: from localhost.localdomain (93-173-200-237.bb.netvision.net.il.
 [93.173.200.237])
 by smtp.gmail.com with ESMTPSA id f134sm17578257wmg.20.2019.08.25.15.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Aug 2019 15:03:34 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 01:03:28 +0300
Message-Id: <20190825220329.7942-2-nsoffer@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190825220329.7942-1-nsoffer@redhat.com>
References: <20190825220329.7942-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v2 1/2] block: posix: Always allocate the first
 block
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When creating an image with preallocation "off" or "falloc", the first
block of the image is typically not allocated. When using Gluster
storage backed by XFS filesystem, reading this block using direct I/O
succeeds regardless of request length, fooling alignment detection.

In this case we fallback to a safe value (4096) instead of the optimal
value (512), which may lead to unneeded data copying when aligning
requests.  Allocating the first block avoids the fallback.

Since we allocate the first block even with preallocation=off, we no
longer create images with zero disk size:

    $ ./qemu-img create -f raw test.raw 1g
    Formatting 'test.raw', fmt=raw size=1073741824

    $ ls -lhs test.raw
    4.0K -rw-r--r--. 1 nsoffer nsoffer 1.0G Aug 16 23:48 test.raw

And converting the image requires additional cluster:

    $ ./qemu-img measure -f raw -O qcow2 test.raw
    required size: 458752
    fully allocated size: 1074135040

I did quick performance test for copying disks with qemu-img convert to
new raw target image to Gluster storage with sector size of 512 bytes:

    for i in $(seq 10); do
        rm -f dst.raw
        sleep 10
        time ./qemu-img convert -f raw -O raw -t none -T none src.raw dst.raw
    done

Here is a table comparing the total time spent:

Type    Before(s)   After(s)    Diff(%)
---------------------------------------
real      530.028    469.123      -11.4
user       17.204     10.768      -37.4
sys        17.881      7.011      -60.7

We can see very clear improvement in CPU usage.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 block/file-posix.c                            | 43 +++++++++++++++++++
 tests/qemu-iotests/{150.out => 150.out.qcow2} |  0
 tests/qemu-iotests/150.out.raw                | 12 ++++++
 tests/qemu-iotests/175                        | 19 +++++---
 tests/qemu-iotests/175.out                    |  8 ++--
 tests/qemu-iotests/178.out.qcow2              |  4 +-
 tests/qemu-iotests/221.out                    | 12 ++++--
 tests/qemu-iotests/253.out                    | 12 ++++--
 8 files changed, 90 insertions(+), 20 deletions(-)
 rename tests/qemu-iotests/{150.out => 150.out.qcow2} (100%)
 create mode 100644 tests/qemu-iotests/150.out.raw

diff --git a/block/file-posix.c b/block/file-posix.c
index fbeb0068db..51688ae3fc 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1749,6 +1749,39 @@ static int handle_aiocb_discard(void *opaque)
     return ret;
 }
 
+/*
+ * Help alignment probing by allocating the first block.
+ *
+ * When reading with direct I/O from unallocated area on Gluster backed by XFS,
+ * reading succeeds regardless of request length. In this case we fallback to
+ * safe alignment which is not optimal. Allocating the first block avoids this
+ * fallback.
+ *
+ * fd may be opened with O_DIRECT, but we don't know the buffer alignment or
+ * request alignment, so we use safe values.
+ *
+ * Returns: 0 on success, -errno on failure. Since this is an optimization,
+ * caller may ignore failures.
+ */
+static int allocate_first_block(int fd, size_t max_size)
+{
+    size_t write_size = MIN(MAX_BLOCKSIZE, max_size);
+    size_t max_align = MAX(MAX_BLOCKSIZE, getpagesize());
+    void *buf;
+    ssize_t n;
+
+    buf = qemu_memalign(max_align, write_size);
+    memset(buf, 0, write_size);
+
+    do {
+        n = pwrite(fd, buf, write_size, 0);
+    } while (n == -1 && errno == EINTR);
+
+    qemu_vfree(buf);
+
+    return (n == -1) ? -errno : 0;
+}
+
 static int handle_aiocb_truncate(void *opaque)
 {
     RawPosixAIOData *aiocb = opaque;
@@ -1788,6 +1821,13 @@ static int handle_aiocb_truncate(void *opaque)
                 /* posix_fallocate() doesn't set errno. */
                 error_setg_errno(errp, -result,
                                  "Could not preallocate new data");
+            } else if (current_length == 0) {
+                /*
+                 * Needed only if posix_fallocate() used fallocate(), but we
+                 * don't have a way to detect that. Optimize future alignment
+                 * probing; ignore failures.
+                 */
+                allocate_first_block(fd, offset);
             }
         } else {
             result = 0;
@@ -1849,6 +1889,9 @@ static int handle_aiocb_truncate(void *opaque)
         if (ftruncate(fd, offset) != 0) {
             result = -errno;
             error_setg_errno(errp, -result, "Could not resize file");
+        } else if (current_length == 0 && offset > current_length) {
+            /* Optimize future alignment probing; ignore failures. */
+            allocate_first_block(fd, offset);
         }
         return result;
     default:
diff --git a/tests/qemu-iotests/150.out b/tests/qemu-iotests/150.out.qcow2
similarity index 100%
rename from tests/qemu-iotests/150.out
rename to tests/qemu-iotests/150.out.qcow2
diff --git a/tests/qemu-iotests/150.out.raw b/tests/qemu-iotests/150.out.raw
new file mode 100644
index 0000000000..3cdc7727a5
--- /dev/null
+++ b/tests/qemu-iotests/150.out.raw
@@ -0,0 +1,12 @@
+QA output created by 150
+
+=== Mapping sparse conversion ===
+
+Offset          Length          File
+0               0x1000          TEST_DIR/t.IMGFMT
+
+=== Mapping non-sparse conversion ===
+
+Offset          Length          File
+0               0x100000        TEST_DIR/t.IMGFMT
+*** done
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index 51e62c8276..d54cb43c39 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -37,14 +37,16 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # the file size.  This function hides the resulting difference in the
 # stat -c '%b' output.
 # Parameter 1: Number of blocks an empty file occupies
-# Parameter 2: Image size in bytes
+# Parameter 2: Minimal number of blocks in an image
+# Parameter 3: Image size in bytes
 _filter_blocks()
 {
     extra_blocks=$1
-    img_size=$2
+    min_blocks=$2
+    img_size=$3
 
-    sed -e "s/blocks=$extra_blocks\\(\$\\|[^0-9]\\)/nothing allocated/" \
-        -e "s/blocks=$((extra_blocks + img_size / 512))\\(\$\\|[^0-9]\\)/everything allocated/"
+    sed -e "s/blocks=$((min_blocks))\\(\$\\|[^0-9]\\)/min allocation/" \
+        -e "s/blocks=$((extra_blocks + img_size / 512))\\(\$\\|[^0-9]\\)/max allocation/"
 }
 
 # get standard environment, filters and checks
@@ -60,16 +62,21 @@ size=$((1 * 1024 * 1024))
 touch "$TEST_DIR/empty"
 extra_blocks=$(stat -c '%b' "$TEST_DIR/empty")
 
+# We always write the first byte; check how many blocks this filesystem
+# allocates to match empty image alloation.
+printf "\0" > "$TEST_DIR/empty"
+min_blocks=$(stat -c '%b' "$TEST_DIR/empty")
+
 echo
 echo "== creating image with default preallocation =="
 _make_test_img $size | _filter_imgfmt
-stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks $size
+stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks $min_blocks $size
 
 for mode in off full falloc; do
     echo
     echo "== creating image with preallocation $mode =="
     IMGOPTS=preallocation=$mode _make_test_img $size | _filter_imgfmt
-    stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks $size
+    stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks $min_blocks $size
 done
 
 # success, all done
diff --git a/tests/qemu-iotests/175.out b/tests/qemu-iotests/175.out
index 6d9a5ed84e..263e521262 100644
--- a/tests/qemu-iotests/175.out
+++ b/tests/qemu-iotests/175.out
@@ -2,17 +2,17 @@ QA output created by 175
 
 == creating image with default preallocation ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
-size=1048576, nothing allocated
+size=1048576, min allocation
 
 == creating image with preallocation off ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=off
-size=1048576, nothing allocated
+size=1048576, min allocation
 
 == creating image with preallocation full ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=full
-size=1048576, everything allocated
+size=1048576, max allocation
 
 == creating image with preallocation falloc ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=falloc
-size=1048576, everything allocated
+size=1048576, max allocation
  *** done
diff --git a/tests/qemu-iotests/178.out.qcow2 b/tests/qemu-iotests/178.out.qcow2
index 55a8dc926f..9e7d8c44df 100644
--- a/tests/qemu-iotests/178.out.qcow2
+++ b/tests/qemu-iotests/178.out.qcow2
@@ -101,7 +101,7 @@ converted image file size in bytes: 196608
 == raw input image with data (human) ==
 
 Formatting 'TEST_DIR/t.qcow2', fmt=IMGFMT size=1073741824
-required size: 393216
+required size: 458752
 fully allocated size: 1074135040
 wrote 512/512 bytes at offset 512
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -257,7 +257,7 @@ converted image file size in bytes: 196608
 
 Formatting 'TEST_DIR/t.qcow2', fmt=IMGFMT size=1073741824
 {
-    "required": 393216,
+    "required": 458752,
     "fully-allocated": 1074135040
 }
 wrote 512/512 bytes at offset 512
diff --git a/tests/qemu-iotests/221.out b/tests/qemu-iotests/221.out
index 9f9dd52bb0..dca024a0c3 100644
--- a/tests/qemu-iotests/221.out
+++ b/tests/qemu-iotests/221.out
@@ -3,14 +3,18 @@ QA output created by 221
 === Check mapping of unaligned raw image ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65537
-[{ "start": 0, "length": 66048, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
-[{ "start": 0, "length": 66048, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 4096, "length": 61952, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 4096, "length": 61952, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
 wrote 1/1 bytes at offset 65536
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 65536, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 4096, "length": 61440, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
 { "start": 65536, "length": 1, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 65537, "length": 511, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
-[{ "start": 0, "length": 65536, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 4096, "length": 61440, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
 { "start": 65536, "length": 1, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 65537, "length": 511, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
 *** done
diff --git a/tests/qemu-iotests/253.out b/tests/qemu-iotests/253.out
index 607c0baa0b..3d08b305d7 100644
--- a/tests/qemu-iotests/253.out
+++ b/tests/qemu-iotests/253.out
@@ -3,12 +3,16 @@ QA output created by 253
 === Check mapping of unaligned raw image ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048575
-[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
-[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 4096, "length": 1044480, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 4096, "length": 1044480, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
 wrote 65535/65535 bytes at offset 983040
 63.999 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 983040, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 4096, "length": 978944, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
 { "start": 983040, "length": 65536, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
-[{ "start": 0, "length": 983040, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 4096, "length": 978944, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
 { "start": 983040, "length": 65536, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
 *** done
-- 
2.20.1


