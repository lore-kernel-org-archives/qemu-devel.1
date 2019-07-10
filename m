Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC80BC73C63
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916FB2064B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916FB2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl1Eq-000747-QE
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 21:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49790)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hl14K-0000u6-F4
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hl146-0004wr-LB
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:06:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49020)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hl13j-0004LS-39; Tue, 09 Jul 2019 21:06:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 35CC23086220;
 Wed, 10 Jul 2019 01:06:09 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 517E71001B1B;
 Wed, 10 Jul 2019 01:06:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 21:05:56 -0400
Message-Id: <20190710010556.32365-9-jsnow@redhat.com>
In-Reply-To: <20190710010556.32365-1-jsnow@redhat.com>
References: <20190710010556.32365-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 10 Jul 2019 01:06:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 8/8] iotests/257: test traditional sync modes
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/257     |   31 +
 tests/qemu-iotests/257.out | 3089 ++++++++++++++++++++++++++++++++++++
 2 files changed, 3120 insertions(+)

diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index de8707cb19..8de1c4da19 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -288,6 +288,12 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bitma=
p', failure=3DNone):
                       Bitmaps are always synchronized, regardless of fai=
lure.
                       (Partial images must be kept.)
=20
+    :param msync_mode: The mirror sync mode to use for the first backup.
+                       Can be any one of:
+        - bitmap: Backups based on bitmap manifest.
+        - full:   Full backups.
+        - top:    Full backups of the top layer only.
+
     :param failure: Is the (optional) failure mode, and can be any of:
         - None:         No failure. Test the normative path. Default.
         - simulated:    Cancel the job right before it completes.
@@ -410,6 +416,11 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bitma=
p', failure=3DNone):
         if bsync_mode =3D=3D 'always' and failure =3D=3D 'intermediate':
             # We manage to copy one sector (one bit) before the error.
             ebitmap.clear_bit(ebitmap.first_bit)
+            if msync_mode in ('full', 'top'):
+                # These modes return all bits set except what was copied=
/skipped
+                fail_bit =3D ebitmap.first_bit
+                ebitmap.clear()
+                ebitmap.dirty_bits(range(fail_bit, SIZE // GRANULARITY))
         ebitmap.compare(get_bitmap(bitmaps, drive0.device, 'bitmap0'))
=20
         # 2 - Writes and Reference Backup
@@ -501,6 +512,21 @@ def test_backup_api():
                 'bitmap404': ['on-success', 'always', 'never', None],
                 'bitmap0':   [None],
             },
+            'full': {
+                None:        ['on-success', 'always', 'never'],
+                'bitmap404': ['on-success', 'always', 'never', None],
+                'bitmap0':   ['never', None],
+            },
+            'top': {
+                None:        ['on-success', 'always', 'never'],
+                'bitmap404': ['on-success', 'always', 'never', None],
+                'bitmap0':   ['never', None],
+            },
+            'none': {
+                None:        ['on-success', 'always', 'never'],
+                'bitmap404': ['on-success', 'always', 'never', None],
+                'bitmap0':   ['on-success', 'always', 'never', None],
+            }
         }
=20
         for sync_mode, config in error_cases.items():
@@ -522,6 +548,11 @@ def main():
         for failure in ("simulated", "intermediate", None):
             test_bitmap_sync(bsync_mode, "bitmap", failure)
=20
+    for sync_mode in ('full', 'top'):
+        for bsync_mode in ('on-success', 'always'):
+            for failure in ('simulated', 'intermediate', None):
+                test_bitmap_sync(bsync_mode, sync_mode, failure)
+
     test_backup_api()
=20
 if __name__ =3D=3D '__main__':
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
index 43f2e0f9c9..304e33ab73 100644
--- a/tests/qemu-iotests/257.out
+++ b/tests/qemu-iotests/257.out
@@ -2246,6 +2246,3002 @@ qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR=
/PID-fbackup2" =3D=3D> Identical, OK
 qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
=20
=20
+=3D=3D=3D Mode full; Bitmap Sync on-success with simulated failure =3D=3D=
=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "full", "target": "backup_target_1"}}
+{"return": {}}
+
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      },
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "frozen"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+=3D Checking Bitmap (anonymous) =3D
+expecting 7 dirty sectors; have 7. OK!
+
+{"execute": "job-cancel", "arguments": {"id": "backup_1"}}
+{"return": {}}
+{"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 10 dirty sectors; have 10. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 15 dirty sectors; have 15. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
+{"return": {}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode full; Bitmap Sync on-success with intermediate failure =3D=
=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID=
-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately":=
 false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_dis=
k", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "s=
tate": 2}]}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+{"return": ""}
+
+--- Test Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "full", "target": "backup_target_1"}}
+{"return": {}}
+{"data": {"action": "report", "device": "backup_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
+{"data": {"device": "backup_1", "error": "Input/output error", "len": 67=
108864, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_=
JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}=
}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 917504,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 14 dirty sectors; have 14. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
+{"return": {}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode full; Bitmap Sync on-success without failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "full", "target": "backup_target_1"}}
+{"return": {}}
+
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      },
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "frozen"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+=3D Checking Bitmap (anonymous) =3D
+expecting 7 dirty sectors; have 7. OK!
+
+{"execute": "job-finalize", "arguments": {"id": "backup_1"}}
+{"return": {}}
+{"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 7 dirty sectors; have 7. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 786432,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 12 dirty sectors; have 12. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
+{"return": {}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode full; Bitmap Sync always with simulated failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "full", "target": "backup_target_1"}}
+{"return": {}}
+
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      },
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "frozen"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+=3D Checking Bitmap (anonymous) =3D
+expecting 7 dirty sectors; have 7. OK!
+
+{"execute": "job-cancel", "arguments": {"id": "backup_1"}}
+{"return": {}}
+{"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 7 dirty sectors; have 7. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 786432,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 12 dirty sectors; have 12. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
+{"return": {}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode full; Bitmap Sync always with intermediate failure =3D=3D=
=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID=
-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately":=
 false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_dis=
k", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "s=
tate": 2}]}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+{"return": ""}
+
+--- Test Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "full", "target": "backup_target_1"}}
+{"return": {}}
+{"data": {"action": "report", "device": "backup_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
+{"data": {"device": "backup_1", "error": "Input/output error", "len": 67=
108864, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_=
JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}=
}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 66125824,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 1009 dirty sectors; have 1009. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 66453504,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 1014 dirty sectors; have 1014. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
+{"return": {}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode full; Bitmap Sync always without failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "full", "target": "backup_target_1"}}
+{"return": {}}
+
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      },
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "frozen"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+=3D Checking Bitmap (anonymous) =3D
+expecting 7 dirty sectors; have 7. OK!
+
+{"execute": "job-finalize", "arguments": {"id": "backup_1"}}
+{"return": {}}
+{"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 7 dirty sectors; have 7. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 786432,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 12 dirty sectors; have 12. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
+{"return": {}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode top; Bitmap Sync on-success with simulated failure =3D=3D=
=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "top", "target": "backup_target_1"}}
+{"return": {}}
+
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      },
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "frozen"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+=3D Checking Bitmap (anonymous) =3D
+expecting 7 dirty sectors; have 7. OK!
+
+{"execute": "job-cancel", "arguments": {"id": "backup_1"}}
+{"return": {}}
+{"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 10 dirty sectors; have 10. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 15 dirty sectors; have 15. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
+{"return": {}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode top; Bitmap Sync on-success with intermediate failure =3D=
=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID=
-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately":=
 false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_dis=
k", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "s=
tate": 2}]}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+{"return": ""}
+
+--- Test Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "top", "target": "backup_target_1"}}
+{"return": {}}
+{"data": {"action": "report", "device": "backup_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
+{"data": {"device": "backup_1", "error": "Input/output error", "len": 67=
108864, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_=
JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}=
}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 917504,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 14 dirty sectors; have 14. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
+{"return": {}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode top; Bitmap Sync on-success without failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "top", "target": "backup_target_1"}}
+{"return": {}}
+
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      },
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "frozen"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+=3D Checking Bitmap (anonymous) =3D
+expecting 7 dirty sectors; have 7. OK!
+
+{"execute": "job-finalize", "arguments": {"id": "backup_1"}}
+{"return": {}}
+{"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 7 dirty sectors; have 7. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 786432,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 12 dirty sectors; have 12. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
+{"return": {}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode top; Bitmap Sync always with simulated failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "top", "target": "backup_target_1"}}
+{"return": {}}
+
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      },
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "frozen"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+=3D Checking Bitmap (anonymous) =3D
+expecting 7 dirty sectors; have 7. OK!
+
+{"execute": "job-cancel", "arguments": {"id": "backup_1"}}
+{"return": {}}
+{"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 7 dirty sectors; have 7. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 786432,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 12 dirty sectors; have 12. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
+{"return": {}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode top; Bitmap Sync always with intermediate failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID=
-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately":=
 false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_dis=
k", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "s=
tate": 2}]}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+{"return": ""}
+
+--- Test Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "top", "target": "backup_target_1"}}
+{"return": {}}
+{"data": {"action": "report", "device": "backup_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
+{"data": {"device": "backup_1", "error": "Input/output error", "len": 67=
108864, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_=
JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}=
}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 66125824,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 1009 dirty sectors; have 1009. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 66453504,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 1014 dirty sectors; have 1014. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
+{"return": {}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode top; Bitmap Sync always without failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "top", "target": "backup_target_1"}}
+{"return": {}}
+
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": false,
+        "status": "disabled"
+      },
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "frozen"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+=3D Checking Bitmap (anonymous) =3D
+expecting 7 dirty sectors; have 7. OK!
+
+{"execute": "job-finalize", "arguments": {"id": "backup_1"}}
+{"return": {}}
+{"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 7 dirty sectors; have 7. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 786432,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 12 dirty sectors; have 12. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
+{"return": {}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
 =3D=3D=3D API failure tests =3D=3D=3D
=20
 --- Preparing image & VM ---
@@ -2330,3 +5326,96 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-=
fbackup2" =3D=3D> Identical, OK!
 {"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "job-id": "api_job", "sync": "bitmap", "target": "backup_ta=
rget"}}
 {"error": {"class": "GenericError", "desc": "Bitmap sync mode must be gi=
ven when providing a bitmap"}}
=20
+-- Sync mode full tests --
+
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "job-id": "api_job", "sync": "full", "target": "bac=
kup_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify Bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "job-id": "api_job", "sync": "full", "target": "backup_=
target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify Bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "job-id": "api_job", "sync": "full", "target": "backup_t=
arget"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify Bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync":=
 "full", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "fu=
ll", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "ful=
l", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "job-id": "api_job", "sync": "full", "target": "backup_ta=
rget"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "full"=
, "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap sync mode 'never' ha=
s no meaningful effect when combined with sync mode 'full'"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "job-id": "api_job", "sync": "full", "target": "backup_targ=
et"}}
+{"error": {"class": "GenericError", "desc": "Bitmap sync mode must be gi=
ven when providing a bitmap"}}
+
+-- Sync mode top tests --
+
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "job-id": "api_job", "sync": "top", "target": "back=
up_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify Bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "job-id": "api_job", "sync": "top", "target": "backup_t=
arget"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify Bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "job-id": "api_job", "sync": "top", "target": "backup_ta=
rget"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify Bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync":=
 "top", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "to=
p", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "top=
", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "job-id": "api_job", "sync": "top", "target": "backup_tar=
get"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "top",=
 "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap sync mode 'never' ha=
s no meaningful effect when combined with sync mode 'top'"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "job-id": "api_job", "sync": "top", "target": "backup_targe=
t"}}
+{"error": {"class": "GenericError", "desc": "Bitmap sync mode must be gi=
ven when providing a bitmap"}}
+
+-- Sync mode none tests --
+
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "job-id": "api_job", "sync": "none", "target": "bac=
kup_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify Bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_=
target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify Bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_t=
arget"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify Bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync":=
 "none", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "no=
ne", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "non=
e", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_ta=
rget"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap404' could no=
t be found"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "on-success", "device": "drive0", "job-id": "api_job", "sync": "=
none", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "sync mode 'none' does not p=
roduce meaningful bitmap outputs"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "always", "device": "drive0", "job-id": "api_job", "sync": "none=
", "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "sync mode 'none' does not p=
roduce meaningful bitmap outputs"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "job-id": "api_job", "sync": "none"=
, "target": "backup_target"}}
+{"error": {"class": "GenericError", "desc": "sync mode 'none' does not p=
roduce meaningful bitmap outputs"}}
+
+{"execute": "blockdev-backup", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "job-id": "api_job", "sync": "none", "target": "backup_targ=
et"}}
+{"error": {"class": "GenericError", "desc": "Bitmap sync mode must be gi=
ven when providing a bitmap"}}
+
--=20
2.21.0


