Return-Path: <SRS0=x6dg=A6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5051C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 12:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58EE822B48
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 12:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMEL3JKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EE822B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jx87T-0003YJ-Ht
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 08:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jx86b-000336-9O
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 08:07:45 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:33220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jx86Y-0004jn-9Q
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 08:07:44 -0400
Received: by mail-ot1-x32a.google.com with SMTP id h13so10152918otr.0
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2020 05:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=1UtheJcOPhjvx4Gl7tWKM3LKltupTVa8E1zigSYDmY8=;
 b=VMEL3JKZLYKBbEJVh+Ck2pm74oxMVWHse486qeq/cZbUnztddxVZd4M0R61YiTj5zC
 Gyl6D/lsi5e3UybGOgBSgeRoLYUSaWsrShgqltq843dUmKF5+J7Gpt/hssqQrbnY4Wpm
 xPKK7xg7sNMd9Q4a+Xat6SP4caPgO7UmlhmQrKv3fZH7/CH/0UjH40cak/Cpedf7eJnI
 9MchKfLbwxIGPoyk61Yd8VJsZkYfSXmhXGIyeWm31xGytbFpZf3nQBvx9gbeybykQ1Iq
 heTfx3xiBvvghWjEnSQS3KpXhG4X9p8YVB9kbzTzaafdQM3WrvF6A1B2hwKHR83q8xNv
 jn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=1UtheJcOPhjvx4Gl7tWKM3LKltupTVa8E1zigSYDmY8=;
 b=kIbVGX1MOVjLovUuTbE9HXA/NBuPV2ZUPaF+qDlgdb8B7EGpcsBQYmedsxEpaR6Y6P
 O0ctQUtJmeV4pe0LAxKBdm3Bmckm8fnmaH6/pmRtN18BpPVHVqnnNl3kG4VQLIcqlSYV
 tUWRyLVVao4vTOZHSdM4Jfr6ezq7n+fIK1JikEnnfRyv412GBm3ckguWfpRHiXp3fwol
 33LgTUjyz0uQFqDSwuebHk0WDAgqc47Dovx1a2NHZFQf7evG+81aYi9f8VfP4DAK3uOP
 D6VHtTdcug5g3R5Am19DlZewiEC+xW5p6nI32DinXraWbZvgVY5Vlf+bGAs5RrvnkIJB
 DULA==
X-Gm-Message-State: AOAM531HEQFZYfHHBDN4c8f17B78rqb4Cb6K4aD4lgyOebL9wqH1yKVV
 GFbFqGjScBO8TNvEOE6LyrA5yHZAGmlkZzNQoj/EWhGzTro=
X-Google-Smtp-Source: ABdhPJwU4tKKknU1CvXzYLQrIEPKrdZmWSQ9w+JrjZGXyOZxbWPTqfTkbhH+oKPCOcd1AvbNCFVsL8EPki+AT4azJuE=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr15280058otk.221.1595160460340; 
 Sun, 19 Jul 2020 05:07:40 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 19 Jul 2020 13:07:29 +0100
Message-ID: <CAFEAcA_dEBT1jNLWeThhmKisFNwbaSUe+vAEEbv5bnVVb+=bjA@mail.gmail.com>
Subject: various iotests failures apparently due to overly optimistic timeout
 settings
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I just had a bunch of iotests fail on a freebsd VM test run.
I think the machine the VM runs on is sometimes a bit heavily
loaded for I/O, which means the VM can run slowly. This causes
various over-optimistic timeouts in the iotest testsuite to
spuriously fail. I also saw the 030 failure on the netbsd VM.

Can we try to avoid timing-sensitive tests where we can,
and make timeouts longer than 3 seconds where we can't, please?
This kind of intermittent failure makes my mergetests flaky.

Relevant bits of the log below, there are several different
flavours of failure.


  TEST    iotest-qcow2: 030 [fail]
QEMU          --
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
-nodefaults -display none -machine virt -accel qtest
QEMU_IMG      --
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-io"
--cache writeback --aio threads -f qcow2
QEMU_NBD      --
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- FreeBSD/amd64 freebsd 12.1-RELEASE
TEST_DIR      -- /home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.JFidXl5N
SOCKET_SCM_HELPER --

--- /home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/030.out
2020-07-19 09:29:05.000000000 +0000
+++ /home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/030.out.bad
 2020-07-19 09:52:04.256005000 +0000
@@ -1,5 +1,57 @@
-...........................
+WARNING:qemu.machine:qemu received signal 9; command:
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64
-display none -vga none -chardev
socket,id=mon,path=/tmp/tmp.JFidXl5N/qemu-24906-monitor.sock -mon
chardev=mon,mode=control -qtest
unix:path=/tmp/tmp.JFidXl5N/qemu-24906-qtest.sock -accel qtest
-nodefaults -display none -machine virt -accel qtest -drive
if=virtio,id=drive0,file=blkdebug::/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/scratch/test.img,format=qcow2,cache=writeback,aio=threads"
+WARNING:qemu.machine:qemu received signal 9; command:
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64
-display none -vga none -chardev
socket,id=mon,path=/tmp/tmp.JFidXl5N/qemu-24906-monitor.sock -mon
chardev=mon,mode=control -qtest
unix:path=/tmp/tmp.JFidXl5N/qemu-24906-qtest.sock -accel qtest
-nodefaults -display none -machine virt -accel qtest -drive
if=virtio,id=drive0,file=blkdebug::/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/scratch/test.img,format=qcow2,cache=writeback,aio=threads,backing.node-name=mid,backing.backing.node-name=base"
+...............E......E....
+======================================================================
+ERROR: test_set_speed (__main__.TestSetSpeed)
 ----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
line 436, in _do_shutdown
+    self._soft_shutdown(has_quit, timeout)
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
line 419, in _soft_shutdown
+    self._popen.wait(timeout=timeout)
+  File "/usr/local/lib/python3.7/subprocess.py", line 1019, in wait
+    return self._wait(timeout=timeout)
+  File "/usr/local/lib/python3.7/subprocess.py", line 1645, in _wait
+    raise TimeoutExpired(self.args, timeout)
+subprocess.TimeoutExpired: Command
'['/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64',
'-display', 'none', '-vga', 'none', '-chardev',
'socket,id=mon,path=/tmp/tmp.JFidXl5N/qemu-24906-monitor.sock',
'-mon', 'chardev=mon,mode=control', '-qtest',
'unix:path=/tmp/tmp.JFidXl5N/qemu-24906-qtest.sock', '-accel',
'qtest', '-nodefaults', '-display', 'none', '-machine', 'virt',
'-accel', 'qtest', '-drive',
'if=virtio,id=drive0,file=blkdebug::/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/scratch/test.img,format=qcow2,cache=writeback,aio=threads']'
timed out after 3 seconds
+
+The above exception was the direct cause of the following exception:
+
+Traceback (most recent call last):
+  File "030", line 900, in tearDown
+    self.vm.shutdown()
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
line 466, in shutdown
+    self._do_shutdown(has_quit, timeout=timeout)
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
line 440, in _do_shutdown
+    from exc
+qemu.machine.AbnormalShutdown: Could not perform graceful shutdown
+
+======================================================================
+ERROR: test_stream_no_op (__main__.TestSingleDrive)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
line 436, in _do_shutdown
+    self._soft_shutdown(has_quit, timeout)
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
line 419, in _soft_shutdown
+    self._popen.wait(timeout=timeout)
+  File "/usr/local/lib/python3.7/subprocess.py", line 1019, in wait
+    return self._wait(timeout=timeout)
+  File "/usr/local/lib/python3.7/subprocess.py", line 1645, in _wait
+    raise TimeoutExpired(self.args, timeout)
+subprocess.TimeoutExpired: Command
'['/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64',
'-display', 'none', '-vga', 'none', '-chardev',
'socket,id=mon,path=/tmp/tmp.JFidXl5N/qemu-24906-monitor.sock',
'-mon', 'chardev=mon,mode=control', '-qtest',
'unix:path=/tmp/tmp.JFidXl5N/qemu-24906-qtest.sock', '-accel',
'qtest', '-nodefaults', '-display', 'none', '-machine', 'virt',
'-accel', 'qtest', '-drive',
'if=virtio,id=drive0,file=blkdebug::/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/scratch/test.img,format=qcow2,cache=writeback,aio=threads,backing.node-name=mid,backing.backing.node-name=base']'
timed out after 3 seconds
+
+The above exception was the direct cause of the following exception:
+
+Traceback (most recent call last):
+  File "030", line 131, in test_stream_no_op
+    self.vm.shutdown()
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
line 466, in shutdown
+    self._do_shutdown(has_quit, timeout=timeout)
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
line 440, in _do_shutdown
+    from exc
+qemu.machine.AbnormalShutdown: Could not perform graceful shutdown
+
+----------------------------------------------------------------------
 Ran 27 tests

-OK
+FAILED (errors=2)
  TEST    iotest-qcow2: 031
  TEST    iotest-qcow2: 032
  TEST    iotest-qcow2: 033
  TEST    iotest-qcow2: 034 [not run]
  TEST    iotest-qcow2: 035
  TEST    iotest-qcow2: 036
  TEST    iotest-qcow2: 037
  TEST    iotest-qcow2: 038 [not run]
  TEST    iotest-qcow2: 039 [not run]
  TEST    iotest-qcow2: 040 [fail]
QEMU          --
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
-nodefaults -display none -machine virt -accel qtest
QEMU_IMG      --
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-io"
--cache writeback --aio threads -f qcow2
QEMU_NBD      --
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- FreeBSD/amd64 freebsd 12.1-RELEASE
TEST_DIR      -- /home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.JFidXl5N
SOCKET_SCM_HELPER --

--- /home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/040.out
2020-07-19 09:29:05.000000000 +0000
+++ /home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/040.out.bad
 2020-07-19 09:55:10.837942000 +0000
@@ -1,5 +1,31 @@
-...........................................................
+WARNING:qemu.machine:qemu received signal 9; command:
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64
-display none -vga none -chardev
socket,id=mon,path=/tmp/tmp.JFidXl5N/qemu-27241-monitor.sock -mon
chardev=mon,mode=control -qtest
unix:path=/tmp/tmp.JFidXl5N/qemu-27241-qtest.sock -accel qtest
-nodefaults -display none -machine virt -accel qtest"
+...........................E...............................
+======================================================================
+ERROR: testIntermediateReadErrorStop (__main__.TestErrorHandling)
 ----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
line 436, in _do_shutdown
+    self._soft_shutdown(has_quit, timeout)
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
line 419, in _soft_shutdown
+    self._popen.wait(timeout=timeout)
+  File "/usr/local/lib/python3.7/subprocess.py", line 1019, in wait
+    return self._wait(timeout=timeout)
+  File "/usr/local/lib/python3.7/subprocess.py", line 1645, in _wait
+    raise TimeoutExpired(self.args, timeout)
+subprocess.TimeoutExpired: Command
'['/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64',
'-display', 'none', '-vga', 'none', '-chardev',
'socket,id=mon,path=/tmp/tmp.JFidXl5N/qemu-27241-monitor.sock',
'-mon', 'chardev=mon,mode=control', '-qtest',
'unix:path=/tmp/tmp.JFidXl5N/qemu-27241-qtest.sock', '-accel',
'qtest', '-nodefaults', '-display', 'none', '-machine', 'virt',
'-accel', 'qtest']' timed out after 3 seconds
+
+The above exception was the direct cause of the following exception:
+
+Traceback (most recent call last):
+  File "040", line 687, in testIntermediateReadErrorStop
+    self.vm.shutdown()
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
line 466, in shutdown
+    self._do_shutdown(has_quit, timeout=timeout)
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
line 440, in _do_shutdown
+    from exc
+qemu.machine.AbnormalShutdown: Could not perform graceful shutdown
+
+----------------------------------------------------------------------
 Ran 59 tests

-OK
+FAILED (errors=1)
  TEST    iotest-qcow2: 041 [fail]
QEMU          --
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
-nodefaults -disp
lay none -machine virt -accel qtest
QEMU_IMG      --
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-io"
--cache writeback --aio threads -f qcow2
QEMU_NBD      --
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- FreeBSD/amd64 freebsd 12.1-RELEASE
TEST_DIR      -- /home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.JFidXl5N
SOCKET_SCM_HELPER --

--- /home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/041.out
2020-07-19 09:29:05.000000000 +0000
+++ /home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/041.out.bad
 2020-07-19 10:05:09.812434000 +0000
@@ -1,5 +1,29 @@
-........................................................................................................
+...........................................................................E............................
+======================================================================
+ERROR: test_pause (__main__.TestSingleDrive)
 ----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "041", line 109, in test_pause
+    self.pause_job('drive0')
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/iotests.py",
line 978, in pause_job
+    return self.pause_wait(job_id)
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/iotests.py",
line 964, in pause_wait
+    result = self.vm.qmp('query-block-jobs')
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/machine.py",
line 511, in qmp
+    return self._qmp.cmd(cmd, args=qmp_args)
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/qmp.py",
line 266, in cmd
+    return self.cmd_obj(qmp_cmd)
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/qmp.py",
line 247, in cmd_obj
+    resp = self.__json_read()
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/../../python/qemu/qmp.py",
line 137, in __json_read
+    data = self.__sockfile.readline()
+  File "/usr/local/lib/python3.7/socket.py", line 589, in readinto
+    return self._sock.recv_into(b)
+  File "/usr/home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/iotests.py",
line 416, in timeout
+    raise Exception(self.errmsg)
+Exception: Timeout waiting for job to pause
+
+----------------------------------------------------------------------
 Ran 104 tests

-OK
+FAILED (errors=1)

[...]
  TEST    iotest-qcow2: 156 [fail]
QEMU          --
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
-nodefaults -disp
lay none -machine virt -accel qtest
QEMU_IMG      --
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-io"
--cache writeback --aio threads -f qcow2
QEMU_NBD      --
"/home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- FreeBSD/amd64 freebsd 12.1-RELEASE
TEST_DIR      -- /home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.JFidXl5N
SOCKET_SCM_HELPER --

--- /home/qemu/qemu-test.oJwuyW/src/tests/qemu-iotests/156.out
2020-07-19 09:29:05.000000000 +0000
+++ /home/qemu/qemu-test.oJwuyW/build/tests/qemu-iotests/156.out.bad
 2020-07-19 10:14:48.438647000 +0000
@@ -19,48 +19,4 @@
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id":
"source"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id":
"source"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id":
"source"}}
-{"timestamp": {fcntl(): Bad file descriptor
"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event":
"BLOCK_JOB_READY", "data": {"device": "source", "len": 131072,
"offset": 131072, "speed": 0, "type": "mirror"}}
-{ 'execute': 'human-monitor-command', 'arguments': { 'command-line':
'qemu-io source "write -P 4 192k 64k"' } }
-wrote 65536/65536 bytes at offset 196608
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-{ 'execute': 'block-job-complete', 'arguments': { 'device': 'source' } }
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id":
"source"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id":
"source"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "BLOCK_JOB_COMPLETED", "data": {"device": "source", "len":
196608, "offset": 196608, "speed": 0, "type": "mirror"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id":
"source"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id":
"source"}}
-
-{ 'execute': 'human-monitor-command', 'arguments': { 'command-line':
'qemu-io source "read -P 1 0k 64k"' } }
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-{ 'execute': 'human-monitor-command', 'arguments': { 'command-line':
'qemu-io source "read -P 2 64k 64k"' } }
-read 65536/65536 bytes at offset 65536
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-{ 'execute': 'human-monitor-command', 'arguments': { 'command-line':
'qemu-io source "read -P 3 128k 64k"' } }
-read 65536/65536 bytes at offset 131072
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-{ 'execute': 'human-monitor-command', 'arguments': { 'command-line':
'qemu-io source "read -P 4 192k 64k"' } }
-read 65536/65536 bytes at offset 196608
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-
-{ 'execute': 'quit' }
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "SHUTDOWN", "data": {"guest": false, "reason":
"host-qmp-quit"}}
-
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 65536
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 131072
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 196608
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-*** done
+Timeout waiting for BLOCK_JOB_READY on handle 0
  TEST    iotest-qcow2: 158


thanks
-- PMM

