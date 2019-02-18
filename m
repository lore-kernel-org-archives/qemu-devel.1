Received: from eggs.gnu.org ([209.51.188.92]:33025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvlWr-0001Su-Ij
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:12:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvlWq-0007Ak-Al
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:12:25 -0500
Date: Mon, 18 Feb 2019 17:12:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190218161207.GD5303@dhcp-200-176.str.redhat.com>
References: <1549638368-530182-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1549638368-530182-4-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549638368-530182-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v14 3/3] qcow2: list of bitmaps new test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net, mreitz@redhat.com, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Am 08.02.2019 um 16:06 hat Andrey Shinkevich geschrieben:
> A new test file 242 added to the qemu-iotests set. It checks
> the format of qcow2 specific information for the new added
> section that lists details of bitmaps.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

This doesn't seem to be Python 3 compatible.

Kevin


242                [17:09:27] [17:09:29] [failed, exit status 1] - output mismatch (see 242.out.bad)
--- /home/kwolf/source/qemu/tests/qemu-iotests/242.out  2019-02-13 12:59:38.748262364 +0100
+++ /home/kwolf/source/qemu/tests/qemu-iotests/242.out.bad      2019-02-18 17:09:29.314637597 +0100
@@ -143,24 +143,9 @@
 {"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "granularity": 16384, "name": "bitmap-0", "node": "drive0", "persistent": true}}
 {"return": {}}
 Write an unknown bitmap flag '0x4' into a new QCOW2 image at offset 327695
-qemu-img: Could not open 'TEST_IMG': Bitmap 'bitmap-0' doesn't satisfy the constraints
-
-Unset the unknown bitmap flag '0x4' in the bitmap directory entry:
-
-image: TEST_IMG
-file format: IMGFMT
-virtual size: 1.0M (1048576 bytes)
-cluster_size: 65536
-Format specific information:
-    compat: 1.1
-    lazy refcounts: false
-    bitmaps:
-        [0]:
-            flags:
-                [0]: auto
-            name: bitmap-0
-            granularity: 16384
-    refcount bits: 16
-    corrupt: false
-
-Test complete
+Traceback (most recent call last):
+  File "242", line 98, in <module>
+    toggle_flag(flag_offset)
+  File "242", line 70, in toggle_flag
+    f.write(toggled)
+TypeError: a bytes-like object is required, not 'str'
Failures: 242
Failed 1 of 1 tests
