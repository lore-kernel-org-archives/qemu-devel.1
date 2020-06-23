Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80318C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3977D2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6m/dvRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3977D2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jniTh-0005Li-Cp
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jniSw-0004pT-LE
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:55:54 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jniSt-000871-7n
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:55:54 -0400
Received: by mail-ot1-x343.google.com with SMTP id u23so16436167otq.10
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 05:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lI3WMczlwpnkyDwPwW7xqVLd7xeN0gYLvIscJCYO4NA=;
 b=i6m/dvRXheyG+t9FUrLjQ+K2zXuvA3aH7DZ4It7Ri/zkAgLXGKuIwBXtpXQB824IOU
 rdlMIiPx0B3kDNRqI2NJscO2jJdZe015uWrnQsnwSCY3S5DFQK0t3Jks9Ab77S/aA9Re
 qgz+MK7XP4k6O+HGmN03ENPVweu8u/siHPLcd34HhWXR6EpS4srQRPGelkvhGSIfgwpl
 nRWctNfUp3prPpfbKdDrDa+Tr2gU69880qbVPcEYK2bod/bvhFMjwdi6/yZc6cRGEzzG
 i8zJ4ISPqsb7M/QGjmQqqEhmmT+5LRP/fbASNJ86qTdRo7HvbmocoJtq354uRvu+tjZ8
 ZU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lI3WMczlwpnkyDwPwW7xqVLd7xeN0gYLvIscJCYO4NA=;
 b=KF5Dl8yjdmqtPhSqs6vZICPG1PTUH3KhDaMyYdz/YTxAG/19bQfmIe5PcfypJ1x7Qo
 jBwAHG0UFMUatbTEXqj0gplpCy3i24xV6CFYJLh2WlGu9uDl4vHZLzFXpnYRs+wRBba7
 359wlpDRYiwzFFZWN6m5C2ZOjZV+4ZuX1LSq0yobGWLC2Ki2MMi1e/3MY8sm8sEnUDY8
 XjEosHVUANaGTETiQT3SWkx/En6kPRI9CrpApZP0+M1vzP/quTTZkW0XywQxWHepBoO9
 ShJvpLHpk/hEf/VFl1lb8VXqPc/2UqVX/RQcrKzLHzYwqZRC0CJA998pfeqLr/tD0q8V
 lDMg==
X-Gm-Message-State: AOAM533LC7wf/TP0XC1x26DXAaNkA6TNg0bqwOHZTmm2JQm1vabDCffz
 Ps1KYAuSGt9hdvU4jFLNzZ68rvwZ2jZI7DaPm+5NBw==
X-Google-Smtp-Source: ABdhPJwE9mpkacoRpK/XkNEnV4JGYrzyOrVYmSJPYGJj/seJr+14AHllDLj/q3SVbCZUfqRaoWLfbsad5VS3lXj/W1U=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr4032783oth.135.1592916949526; 
 Tue, 23 Jun 2020 05:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200622151059.921191-1-mreitz@redhat.com>
In-Reply-To: <20200622151059.921191-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2020 13:55:38 +0100
Message-ID: <CAFEAcA-QDYBf4COqrLmeO_v-gt6rq_J3rs6YexHGjCGTokVvDQ@mail.gmail.com>
Subject: Re: [PULL 00/18] Block patches
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jun 2020 at 16:11, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit bae31bfa48b9caecee25da3d5333901a126a06b4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20200619-pull-request' into staging (2020-06-19 22:56:59 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2020-06-22
>
> for you to fetch changes up to 74c55e4142a7bb835c38d3770c74210cbb1e4fab:
>
>   iotests: don't test qcow2.py inside 291 (2020-06-22 16:05:23 +0200)
>
> ----------------------------------------------------------------
> Block patches:
> - Support modifying a LUKS-encrypted image's keyslots
> - iotest fixes
>
> ----------------------------------------------------------------

Hi; I see various iotest failures, different things on
PPC64 Linux, OpenBSD and FreeBSD, and on an AArch32 build
that happens to not have optional crypto libs installed.

On PPC64 Linux, lots of iotests fail like this:

  TEST    iotest-qcow2: 001 [fail]
QEMU          --
"/home/pm215/qemu/build/all/tests/qemu-iotests/../../ppc64-softmmu/qemu-system-ppc64"
-nodefaults -display none -accel qtest
QEMU_IMG      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-io"  --cache
writeback --aio threads -f qcow2
QEMU_NBD      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/ppc64 gcc1-power7 3.10.0-862.14.4.el7.ppc64
TEST_DIR      -- /home/pm215/qemu/build/all/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.vvBdnkatyZ
SOCKET_SCM_HELPER --
/home/pm215/qemu/build/all/tests/qemu-iotests/socket_scm_helper

--- /home/pm215/qemu/tests/qemu-iotests/001.out 2015-04-08
18:43:24.908449234 +0000
+++ /home/pm215/qemu/build/all/tests/qemu-iotests/001.out.bad
2020-06-23 10:42:29.262626202 +0000
@@ -1,5 +1,6 @@
 QA output created by 001
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+./common.filter: line 128: readarray: -d: invalid option
+readarray: usage: readarray [-n count] [-O origin] [-s count] [-t]
[-u fd] [-C callback] [-c quantum] [array]

 == reading whole image ==
 read 134217728/134217728 bytes at offset 0
  TEST    iotest-qcow2: 002 [fail]
QEMU          --
"/home/pm215/qemu/build/all/tests/qemu-iotests/../../ppc64-softmmu/qemu-system-ppc64"
-nodefaults -display none -accel qtest
QEMU_IMG      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-io"  --cache
writeback --aio threads -f qcow2
QEMU_NBD      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/ppc64 gcc1-power7 3.10.0-862.14.4.el7.ppc64
TEST_DIR      -- /home/pm215/qemu/build/all/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.vvBdnkatyZ
SOCKET_SCM_HELPER --
/home/pm215/qemu/build/all/tests/qemu-iotests/socket_scm_helper

Looks like you're trying to use a readarray option that doesn't
exist (maybe only exists in newer shells?)

iotests failures on aarch32 which happens to not have some
optional crypto lib dependency installed I guess; these
iotests ought to be made to skip if the functionality they're
testing isn't compiled into this QEMU:

  TEST    iotest-qcow2: 293 [fail]
QEMU          --
"/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
-nodefaults -display none -machine virt -accel qtest
QEMU_IMG      --
"/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../qemu-io"
 --cache writeback --aio threads -f qcow2
QEMU_NBD      --
"/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/aarch64 mustang-maydell 4.15.0-101-generic
TEST_DIR      --
/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.tjBWiNDvED
SOCKET_SCM_HELPER --
/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/socket_scm_helper

--- /home/peter.maydell/qemu/tests/qemu-iotests/293.out 2020-06-23
10:38:50.091867725 +0000
+++ /home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/293.out.bad
      2020-06-23 10:59:09.027627162 +0000
@@ -1,5 +1,6 @@
 QA output created by 293
 == creating a test image ==
+qemu-img: TEST_DIR/t.IMGFMT: No crypto library supporting PBKDF in
this build: Function not implemented
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432

 == test that key 0 opens the image ==
@@ -7,10 +8,15 @@
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

 == adding a password to slot 4 ==
+qemu-img: Can't amend encryption options - encryption not present
 == adding a password to slot 1 ==
+qemu-img: Can't amend encryption options - encryption not present
 == adding a password to slot 3 ==
+qemu-img: Can't amend encryption options - encryption not present
 == adding a password to slot 2 ==
+qemu-img: Can't amend encryption options - encryption not present
 == erase slot 4 ==
+qemu-img: Can't amend encryption options - encryption not present

 == all secrets should work ==
 read 4096/4096 bytes at offset 0
@@ -23,19 +29,29 @@
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

 == erase slot 0 and try it ==
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-img: Can't amend encryption options - encryption not present
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
[etc]


On OpenBSD: iotest 293 fails trying to use "seq" when it doesn't exist:
  TEST    iotest-qcow2: 293 [fail]
QEMU          --
"/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
-nodef
aults -display none -machine virt -accel qtest
QEMU_IMG      --
"/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../qemu-io"
--cache writeback --aio threads -
f qcow2
QEMU_NBD      --
"/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- OpenBSD/amd64 openbsd 6.6
TEST_DIR      -- /home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.o4s3SCLIsx
SOCKET_SCM_HELPER --

--- /home/qemu/qemu-test.DyTmtb/src/tests/qemu-iotests/293.out  Tue
Jun 23 10:38:33 2020
+++ /home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/293.out.bad
 Tue Jun 23 11:06:19 2020
@@ -1,6 +1,6 @@
 QA output created by 293
 == creating a test image ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432
+Formatting 'TEST_DIR/t.IMGFMT'x0IMGFMT encrypt.format=luks
encrypt.key-secret=sec0 encrypt.iter-time=10 cluster_size=65
536 compression_type=zlib size=33554432 compat=1.1 lazy_refcounts=off
refcount_bits=16

 == test that key 0 opens the image ==
 read 4096/4096 bytes at offset 0
@@ -29,25 +29,26 @@
 qemu-io: can't open: Invalid password, cannot unlock any keyslot

 == filling  4 slots with secret 2 ==
+./293: line 111: seq: command not found

 == adding secret 0 ==

 == adding secret 3 (last slot) ==

 == trying to add another slot (should fail) ==
-qemu-img: Can't add a keyslot - all keyslots are in use
+qemu-img: Could not open
'driver=qcow2,file.filename=/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/scratch/t.qco
w2,encrypt.key-secret=sec2': Invalid password, cannot unlock any keyslot

 == all secrets should work again ==
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

 == erase all keys of secret 2==
+qemu-img: No keyslots match given (old) password for erase operation
 == erase all keys of secret 1==
 == erase all keys of secret 0==
 == erasing secret3 will fail now since it is the only secret (in 3 slots) ==

Also OpenBSD, iotest 295 failed because the QEMU dumped core:
  TEST    iotest-qcow2: 295 [fail]
QEMU          --
"/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
-nodef
aults -display none -machine virt -accel qtest
QEMU_IMG      --
"/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../qemu-io"
--cache writeback --aio threads -
f qcow2
QEMU_NBD      --
"/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- OpenBSD/amd64 openbsd 6.6
TEST_DIR      -- /home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.o4s3SCLIsx
SOCKET_SCM_HELPER --

--- /home/qemu/qemu-test.DyTmtb/src/tests/qemu-iotests/295.out  Tue
Jun 23 10:38:33 2020
+++ /home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/295.out.bad
 Tue Jun 23 11:09:01 2020
@@ -4,19 +4,11 @@
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
 {"return": {}}
+WARNING:qemu.machine:qemu received signal 9:
/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64
-display none -vga none -chardev
socket,id=mon,path=/tmp/tmp.o4s3SCLIsx/qemu-36824-monitor.sock -mon
chardev=mon,mode=control -qtest
unix:path=/tmp/tmp.o4s3SCLIsx/qemu-36824-qtest.sock -accel qtest
-nodefaults -display none -machine virt -accel qtest
 {"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
 {"return": {}}
-{"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
-{"return": {}}
-Job failed: Invalid password, cannot unlock any keyslot
 {"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
 {"return": {}}
-{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
-{"return": {}}
-{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
-{"return": {}}
-{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
-{"return": {}}
 Job failed: Refusing to overwrite active keyslot 2 - please erase it first
 {"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
 {"return": {}}
@@ -33,8 +25,37 @@
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
 {"return": {}}
-...
+.E.
+======================================================================
+ERROR: testOldPassword (__main__.EncryptionSetupTestCase)
 ----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/home/qemu/qemu-test.DyTmtb/src/tests/qemu-iotests/../../python/qemu/qmp.py",
line 139, in __get_events
+    ret = self.__json_read(only_event=True)
+  File "/home/qemu/qemu-test.DyTmtb/src/tests/qemu-iotests/../../python/qemu/qmp.py",
line 99, in __json_read
+    data = self.__sockfile.readline()
+  File "/usr/local/lib/python3.7/socket.py", line 589, in readinto
+    return self._sock.recv_into(b)
+socket.timeout: timed out
+
+During handling of the above exception, another exception occurred:
+
+Traceback (most recent call last):
+  File "295", line 234, in testOldPassword
+    self.addKeyQmp("testdev", new_secret = self.secrets[1])
+  File "295", line 164, in addKeyQmp
+    self.vm.run_job('job_add_key')
+  File "/home/qemu/qemu-test.DyTmtb/src/tests/qemu-iotests/iotests.py",
line 648, in run_job
+    ev = filter_qmp_event(self.events_wait(events, timeout=wait))
+  File "/home/qemu/qemu-test.DyTmtb/src/tests/qemu-iotests/../../python/qemu/machine.py",
line 518, in events_wait
+    event = self._qmp.pull_event(wait=timeout)
+  File "/home/qemu/qemu-test.DyTmtb/src/tests/qemu-iotests/../../python/qemu/qmp.py",
line 254, in pull_event
+    self.__get_events(wait)
+  File "/home/qemu/qemu-test.DyTmtb/src/tests/qemu-iotests/../../python/qemu/qmp.py",
line 141, in __get_events
+    raise QMPTimeoutError("Timeout waiting for event")
+qemu.qmp.QMPTimeoutError: Timeout waiting for event
+
+----------------------------------------------------------------------
 Ran 3 tests

-OK
+FAILED (errors=1)

FreeBSD: lots of iotest failures, looks like some sed or other
command trying to sanitize output is broken on this host OS
(assuming gnu sed or whatever, maybe?)

  TEST    iotest-qcow2: 001 [fail]
QEMU          --
"/home/qemu/qemu-test.RNYtim/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
-nodefaults -display none -machine virt -accel qtest
QEMU_IMG      --
"/home/qemu/qemu-test.RNYtim/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/qemu/qemu-test.RNYtim/build/tests/qemu-iotests/../../qemu-io"
--cache writeback --aio threads -f qcow2
QEMU_NBD      --
"/home/qemu/qemu-test.RNYtim/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- FreeBSD/amd64 freebsd 12.1-RELEASE
TEST_DIR      -- /home/qemu/qemu-test.RNYtim/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.l5ksaQ9N
SOCKET_SCM_HELPER --

--- /home/qemu/qemu-test.RNYtim/src/tests/qemu-iotests/001.out
2020-06-23 10:38:33.000000000 +0000
+++ /home/qemu/qemu-test.RNYtim/build/tests/qemu-iotests/001.out.bad
 2020-06-23 10:56:47.833020000 +0000
@@ -1,5 +1,5 @@
 QA output created by 001
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Formatting 'TEST_DIR/t.IMGFMT'x0IMGFMT cluster_size=65536
compression_type=zlib size=134217728 compat=1.1 lazy_refcounts=off
refcount_bits=16

 == reading whole image ==
 read 134217728/134217728 bytes at offset 0


thanks
-- PMM

