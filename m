Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85186C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E27206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPaNkLQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E27206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0BEl-0004wh-By
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 18:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k0B98-0007qb-RD; Mon, 27 Jul 2020 17:58:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:35322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k0B96-0004Kz-Sj; Mon, 27 Jul 2020 17:58:58 -0400
Received: by mail-wm1-x331.google.com with SMTP id 184so16199759wmb.0;
 Mon, 27 Jul 2020 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U6hr5AyADbn9Pq4va0Kp0ppxdlnRLsEkuw/N630unvk=;
 b=OPaNkLQImNPB91Xp65msKF4wh53iVS+JJA/S/v6Qe9vUxLe0+sRogE/zG/HAVoOkZv
 1Uw80DAMMUBejNzQ0X4OlbheuZCu1WlCtdUZuoEKl+UzQisNcD5gPpWTD+nr1TR5/8Ud
 ecR+SR8n0bgUHGIU+dM6PirRn53GpObJGwpB/f2KCXFzNgf+ojCWqkdh9LWt4X1fpBAo
 fprhy7JfGUgsbfi2eMvexiOfiS/1en39C6fuZ8djOaGzB8iKzAZSJFJFiPyW6FmFZdET
 Kz7W38N15/lNBfg8WzR5z33Ba0tmdr+4aNh9nBVP+d8D6d66+bmRBqXfI9kzIL0PikvD
 1NWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U6hr5AyADbn9Pq4va0Kp0ppxdlnRLsEkuw/N630unvk=;
 b=C8JxF82hvLD3i+OSBdY06vYvHnLYOGOvs2I0EF+/Ura9DpQ8kRITt1UeAXG8N8pZJX
 qCLB7X4CUrWgzLmRjGU4tn6hRrqYebV2apOvHnwXs8GD87w3ArL1isRw9QjOspvR5XU1
 YLabnheRQCmbFqfLrM9hgkjUDNyQHlcukgoXncLYE9ziRyhZjcFJrsx6Cz8dxybW20F1
 /RnkpqYZHaTpojea7a9QSRPPE8nhLqiV09He+H7agBkrthTPJ7vYX0Fa1IJJ/lyRCF8t
 pEqeYzP2e/3YFWU0uMnW4ZCcQnm1uKjTvEJYE6IbVwTcVd09p+slWh9gH4s/qmT8eWUN
 6+xQ==
X-Gm-Message-State: AOAM530wObNlS8hCRbFmAOQz3ld7SkiLQG5ZQkweD9hbBVOrjYBcgA/T
 ZAzQd+gcD8yxPRmLaK4+g/Lg8mN9H7M=
X-Google-Smtp-Source: ABdhPJzzJkOiNiH2updFBSao9M9jdWD8scJP1ywieRsTYM7lhECGDK7vfX8wML8mWPHGt/bGTxrXbg==
X-Received: by 2002:a05:600c:230e:: with SMTP id
 14mr1019957wmo.3.1595887133959; 
 Mon, 27 Jul 2020 14:58:53 -0700 (PDT)
Received: from localhost.localdomain (109-186-134-209.bb.netvision.net.il.
 [109.186.134.209])
 by smtp.gmail.com with ESMTPSA id p14sm14492940wrx.90.2020.07.27.14.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 14:58:53 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v2 2/4] iotests: Make qemu_nbd_popen() a contextmanager
Date: Tue, 28 Jul 2020 00:58:44 +0300
Message-Id: <20200727215846.395443-3-nsoffer@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200727215846.395443-1-nsoffer@redhat.com>
References: <20200727215846.395443-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of duplicating the code to wait until the server is ready and
remember to terminate the server and wait for it, make it possible to
use like this:

    with qemu_nbd_popen('-k', sock, image):
        # Access image via qemu-nbd socket...

Only test 264 used this helper, but I had to modify the output since it
did not consistently when starting and stopping qemu-nbd.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 tests/qemu-iotests/264        | 76 +++++++++++++----------------------
 tests/qemu-iotests/264.out    |  2 +
 tests/qemu-iotests/iotests.py | 28 ++++++++++++-
 3 files changed, 56 insertions(+), 50 deletions(-)

diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
index 304a7443d7..666f164ed8 100755
--- a/tests/qemu-iotests/264
+++ b/tests/qemu-iotests/264
@@ -36,48 +36,32 @@ wait_step = 0.2
 
 qemu_img_create('-f', iotests.imgfmt, disk_a, str(size))
 qemu_img_create('-f', iotests.imgfmt, disk_b, str(size))
-srv = qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
 
-# Wait for NBD server availability
-t = 0
-ok = False
-while t < wait_limit:
-    ok = qemu_io_silent_check('-f', 'raw', '-c', 'read 0 512', nbd_uri)
-    if ok:
-        break
-    time.sleep(wait_step)
-    t += wait_step
+with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b):
+    vm = iotests.VM().add_drive(disk_a)
+    vm.launch()
+    vm.hmp_qemu_io('drive0', 'write 0 {}'.format(size))
+
+    vm.qmp_log('blockdev-add', filters=[iotests.filter_qmp_testfiles],
+               **{'node_name': 'backup0',
+                  'driver': 'raw',
+                  'file': {'driver': 'nbd',
+                           'server': {'type': 'unix', 'path': nbd_sock},
+                           'reconnect-delay': 10}})
+    vm.qmp_log('blockdev-backup', device='drive0', sync='full', target='backup0',
+               speed=(1 * 1024 * 1024))
+
+    # Wait for some progress
+    t = 0
+    while t < wait_limit:
+        jobs = vm.qmp('query-block-jobs')['return']
+        if jobs and jobs[0]['offset'] > 0:
+            break
+        time.sleep(wait_step)
+        t += wait_step
 
-assert ok
-
-vm = iotests.VM().add_drive(disk_a)
-vm.launch()
-vm.hmp_qemu_io('drive0', 'write 0 {}'.format(size))
-
-vm.qmp_log('blockdev-add', filters=[iotests.filter_qmp_testfiles],
-           **{'node_name': 'backup0',
-              'driver': 'raw',
-              'file': {'driver': 'nbd',
-                       'server': {'type': 'unix', 'path': nbd_sock},
-                       'reconnect-delay': 10}})
-vm.qmp_log('blockdev-backup', device='drive0', sync='full', target='backup0',
-           speed=(1 * 1024 * 1024))
-
-# Wait for some progress
-t = 0
-while t < wait_limit:
-    jobs = vm.qmp('query-block-jobs')['return']
     if jobs and jobs[0]['offset'] > 0:
-        break
-    time.sleep(wait_step)
-    t += wait_step
-
-if jobs and jobs[0]['offset'] > 0:
-    log('Backup job is started')
-
-log('Kill NBD server')
-srv.kill()
-srv.wait()
+        log('Backup job is started')
 
 jobs = vm.qmp('query-block-jobs')['return']
 if jobs and jobs[0]['offset'] < jobs[0]['len']:
@@ -88,12 +72,8 @@ vm.qmp_log('block-job-set-speed', device='drive0', speed=0)
 # Emulate server down time for 1 second
 time.sleep(1)
 
-log('Start NBD server')
-srv = qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
-
-e = vm.event_wait('BLOCK_JOB_COMPLETED')
-log('Backup completed: {}'.format(e['data']['offset']))
-
-vm.qmp_log('blockdev-del', node_name='backup0')
-srv.kill()
-vm.shutdown()
+with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b):
+    e = vm.event_wait('BLOCK_JOB_COMPLETED')
+    log('Backup completed: {}'.format(e['data']['offset']))
+    vm.qmp_log('blockdev-del', node_name='backup0')
+    vm.shutdown()
diff --git a/tests/qemu-iotests/264.out b/tests/qemu-iotests/264.out
index 3000944b09..c45b1e81ef 100644
--- a/tests/qemu-iotests/264.out
+++ b/tests/qemu-iotests/264.out
@@ -1,3 +1,4 @@
+Start NBD server
 {"execute": "blockdev-add", "arguments": {"driver": "raw", "file": {"driver": "nbd", "reconnect-delay": 10, "server": {"path": "TEST_DIR/PID-nbd-sock", "type": "unix"}}, "node-name": "backup0"}}
 {"return": {}}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "speed": 1048576, "sync": "full", "target": "backup0"}}
@@ -11,3 +12,4 @@ Start NBD server
 Backup completed: 5242880
 {"execute": "blockdev-del", "arguments": {"node-name": "backup0"}}
 {"return": {}}
+Kill NBD server
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 3590ed78a0..8f79668435 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -28,10 +28,13 @@ import signal
 import struct
 import subprocess
 import sys
+import time
 from typing import (Any, Callable, Dict, Iterable,
                     List, Optional, Sequence, Tuple, TypeVar)
 import unittest
 
+from contextlib import contextmanager
+
 # pylint: disable=import-error, wrong-import-position
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
 from qemu import qtest
@@ -270,9 +273,30 @@ def qemu_nbd_early_pipe(*args):
 
     return subp.returncode, output if subp.returncode else ''
 
+@contextmanager
 def qemu_nbd_popen(*args):
-    '''Run qemu-nbd in daemon mode and return the parent's exit code'''
-    return subprocess.Popen(qemu_nbd_args + ['--persistent'] + list(args))
+    '''Context manager running qemu-nbd within the context'''
+    pid_file = file_path("pid")
+
+    cmd = list(qemu_nbd_args)
+    cmd.extend(('--persistent', '--pid-file', pid_file))
+    cmd.extend(args)
+
+    log('Start NBD server')
+    p = subprocess.Popen(cmd)
+    try:
+        while not os.path.exists(pid_file):
+            if p.poll() is not None:
+                raise RuntimeError(
+                    "qemu-nbd terminated with exit code {}: {}"
+                    .format(p.returncode, ' '.join(cmd)))
+
+            time.sleep(0.01)
+        yield
+    finally:
+        log('Kill NBD server')
+        p.kill()
+        p.wait()
 
 def compare_images(img1, img2, fmt1=imgfmt, fmt2=imgfmt):
     '''Return True if two image files are identical'''
-- 
2.25.4


