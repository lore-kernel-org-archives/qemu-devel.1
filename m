Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B30FC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF21920872
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF21920872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGKBV-0000aJ-NH
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kGKA9-0006uG-AP
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:50:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:57694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kGKA6-0005RF-6A
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:50:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kGKA3-000245-Kj
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 10:50:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 83E842E80DC
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 10:50:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2020 10:41:12 -0000
From: Yonggang Luo <1895122@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: luoyonggang
X-Launchpad-Bug-Reporter: Yonggang Luo (luoyonggang)
X-Launchpad-Bug-Modifier: Yonggang Luo (luoyonggang)
Message-Id: <159973447247.11849.9583651644725576217.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1895122] [NEW] qemu on wsl tests failed,
 this configured with debug
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="90a5703803d95539bdb5c0b289b1675630569e1e"; Instance="production"
X-Launchpad-Hash: f262d234f7785095c007c616b4bebf887923f7e7
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 06:50:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1895122 <1895122@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:


../configure --enable-debug-info --enable-debug

**
ERROR:../tests/test-util-filemonitor.c:704:test_file_monitor_events: assert=
ion failed: (err =3D=3D 0)
Aborted (core dumped)


  TEST    iotest-qcow2: 271 [fail]
QEMU          -- "/home/lygstate/work/qemu/build/tests/qemu-iotests/../../q=
emu-system-x86_64" -nodefaults -display none -accel qtest
QEMU_IMG      -- "/home/lygstate/work/qemu/build/tests/qemu-iotests/../../q=
emu-img" =

QEMU_IO       -- "/home/lygstate/work/qemu/build/tests/qemu-iotests/../../q=
emu-io"  --cache writeback --aio threads -f qcow2
QEMU_NBD      -- "/home/lygstate/work/qemu/build/tests/qemu-iotests/../../q=
emu-nbd" =

IMGFMT        -- qcow2 (compat=3D1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 DESKTOP-BLLJ03T 4.4.0-19041-Microsoft
TEST_DIR      -- /home/lygstate/work/qemu/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.eyVcw8nLNQ
SOCKET_SCM_HELPER -- /home/lygstate/work/qemu/build/tests/qemu-iotests/sock=
et_scm_helper

--- /home/lygstate/work/qemu/tests/qemu-iotests/271.out	2020-09-10 15:00:58=
.190763400 +0800
+++ /home/lygstate/work/qemu/build/tests/qemu-iotests/271.out.bad	2020-09-1=
0 18:38:25.625090800 +0800
@@ -37,6 +37,7 @@
 write -q -P PATTERN 0 64k
 L2 entry #0: 0x8000000000050000 00000000ffffffff
 discard -q 0 64k
+Content mismatch at offset 0!
 L2 entry #0: 0x0000000000000000 ffffffff00000000
 write -q -c -P PATTERN 0 64k
 L2 entry #0: 0x4000000000050000 0000000000000000
@@ -79,6 +80,7 @@
 write -q -P PATTERN 0 64k
 L2 entry #0: 0x8000000000050000 00000000ffffffff
 discard -q 0 64k
+Content mismatch at offset 0!
 L2 entry #0: 0x0000000000000000 ffffffff00000000
 write -q -c -P PATTERN 0 64k
 L2 entry #0: 0x4000000000050000 0000000000000000
  TEST    iotest-qcow2: 283
  TEST    iotest-qcow2: 287
  TEST    iotest-qcow2: 290
  TEST    iotest-qcow2: 292
  TEST    iotest-qcow2: 299
Not run: 060 181 220 259
Failures: 271
Failed 1 of 118 iotests
make: [/home/lygstate/work/qemu/tests/Makefile.include:144: check-block] Er=
ror 1 (ignored)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1895122

Title:
  qemu on wsl tests failed, this configured with debug

Status in QEMU:
  New

Bug description:
  =

  ../configure --enable-debug-info --enable-debug

  **
  ERROR:../tests/test-util-filemonitor.c:704:test_file_monitor_events: asse=
rtion failed: (err =3D=3D 0)
  Aborted (core dumped)

  =

    TEST    iotest-qcow2: 271 [fail]
  QEMU          -- "/home/lygstate/work/qemu/build/tests/qemu-iotests/../..=
/qemu-system-x86_64" -nodefaults -display none -accel qtest
  QEMU_IMG      -- "/home/lygstate/work/qemu/build/tests/qemu-iotests/../..=
/qemu-img" =

  QEMU_IO       -- "/home/lygstate/work/qemu/build/tests/qemu-iotests/../..=
/qemu-io"  --cache writeback --aio threads -f qcow2
  QEMU_NBD      -- "/home/lygstate/work/qemu/build/tests/qemu-iotests/../..=
/qemu-nbd" =

  IMGFMT        -- qcow2 (compat=3D1.1)
  IMGPROTO      -- file
  PLATFORM      -- Linux/x86_64 DESKTOP-BLLJ03T 4.4.0-19041-Microsoft
  TEST_DIR      -- /home/lygstate/work/qemu/build/tests/qemu-iotests/scratch
  SOCK_DIR      -- /tmp/tmp.eyVcw8nLNQ
  SOCKET_SCM_HELPER -- /home/lygstate/work/qemu/build/tests/qemu-iotests/so=
cket_scm_helper

  --- /home/lygstate/work/qemu/tests/qemu-iotests/271.out	2020-09-10 15:00:=
58.190763400 +0800
  +++ /home/lygstate/work/qemu/build/tests/qemu-iotests/271.out.bad	2020-09=
-10 18:38:25.625090800 +0800
  @@ -37,6 +37,7 @@
   write -q -P PATTERN 0 64k
   L2 entry #0: 0x8000000000050000 00000000ffffffff
   discard -q 0 64k
  +Content mismatch at offset 0!
   L2 entry #0: 0x0000000000000000 ffffffff00000000
   write -q -c -P PATTERN 0 64k
   L2 entry #0: 0x4000000000050000 0000000000000000
  @@ -79,6 +80,7 @@
   write -q -P PATTERN 0 64k
   L2 entry #0: 0x8000000000050000 00000000ffffffff
   discard -q 0 64k
  +Content mismatch at offset 0!
   L2 entry #0: 0x0000000000000000 ffffffff00000000
   write -q -c -P PATTERN 0 64k
   L2 entry #0: 0x4000000000050000 0000000000000000
    TEST    iotest-qcow2: 283
    TEST    iotest-qcow2: 287
    TEST    iotest-qcow2: 290
    TEST    iotest-qcow2: 292
    TEST    iotest-qcow2: 299
  Not run: 060 181 220 259
  Failures: 271
  Failed 1 of 118 iotests
  make: [/home/lygstate/work/qemu/tests/Makefile.include:144: check-block] =
Error 1 (ignored)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1895122/+subscriptions

