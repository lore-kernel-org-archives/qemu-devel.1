Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4C0FA3730
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6296021835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvC+Ifn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6296021835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL2T2-0004pW-Ge
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 05:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL2Rq-00045q-1R
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL2Ro-0005RQ-Cp
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:51:57 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:42904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL2Ro-0005Qp-6y
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:51:56 -0400
Received: by mail-oi1-x231.google.com with SMTP id i185so1597313oif.9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 02:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=2DZMTNhuY6bZVod6dcL5n/43rTrIL7Z2A8hzh+el0Ww=;
 b=QvC+Ifn199XeRdGQO3UktqcNkfbSZY42d1XEmLXa+gqpemSaI9LnLQjcB5fsCOTpmF
 L+eEYWVXXj+asjFhBqo2IDmRNXy2B33yg4pXs9mzBCT4SeUgSnf5A+1R2m9gOjHEALaC
 upHKL6Kd3vC6T6CUcECzq2iiL5Sjh8JG6vnq6niPjw12+KWmAxtNjwzSB3p33KwK9mdr
 gp+W48T+Et8UHBRX2h3llKY1KSbwg4n8TGaphudBJuIoPdAlkvrgpBPxTGmx3MVmXrPx
 Udk8Uz+Q+llA0wlM2VoGaLlT4C4rhCHPV7UiM+MMvu05016Q4Po2yl5hVndoim30Rkn/
 Wm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=2DZMTNhuY6bZVod6dcL5n/43rTrIL7Z2A8hzh+el0Ww=;
 b=FaupPV7hcQwuuh7lvdataWYwBIIy8kYxgON/YCvein8/93291nheors/F4wYF/K4lX
 8cGliejlLBh8ztBhFeTnF0ILBQsVF1pO2cGGXESA+FZnDYdjpWQ6e79NYIwjIbGI3qus
 N5Kbi8hR9xpFTJn7RUtBirlgbiG7iK0EOj/tStCY1Ml6NHrrvQL02HByyp0iRG3Gu9WT
 D2zqD9z1C+Mff6f907rEKSY//Q8khKZzSBvxk6Nj9SlT0p7f1UKyNX/GFH93F8IIsr1E
 ma9LbsPcBRHPpvmcn6fZuBb+F+2M7eHM1bAlkstcA0BiTBq7fXVZGUspKM9/7coHtYc0
 HDGg==
X-Gm-Message-State: APjAAAXpNofyJYS/FLP1geTILnd/cABDtP6ejvpTvD1JqIbHrGOUNjbF
 Fy0yVUTQm2GyCckGjnvMt62qS7XpKO2LbQtD4VQ2/A==
X-Google-Smtp-Source: APXvYqyyT2KAO5HWl+Wb0E/N/VLvFGGhZdqwEbV5EP2K7gcop24sOL7F5cRLBbJj1P+pv53DZb52B2E5ShJxfySVVtw=
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr2424622oic.98.1571305914975; 
 Thu, 17 Oct 2019 02:51:54 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 10:51:43 +0100
Message-ID: <CAFEAcA-jutAw2KFBDX9v=Q7LQ8_Mj0AHB79wi74hoW6J81fbhw@mail.gmail.com>
Subject: iotest 260 failure (linux host): "OSError: AF_UNIX path too long"
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I just got this iotest 260 failure processing an
unrelated merge on my x86-64 Ubuntu box. I assume
it's an intermittent (have just kicked off a retry) but
post the backtrace in case it's of interest:


  TEST    iotest-qcow2: 260 [fail]
QEMU          --
"/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64"
-nodefaults -display none -machine accel=qtest
QEMU_IMG      --
"/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../qemu-io"
 --cache writeback -f qcow2
QEMU_NBD      --
"/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 e104462 4.15.0-60-generic
TEST_DIR      --
/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/scratch
SOCKET_SCM_HELPER --
/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/socket_scm_helper

--- /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/260.out
 2019-10-15 19:38:40.208504628 +0100
+++ /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/260.out.bad
  2019-10-15 20:01:22.658839136 +0100
@@ -1,52 +1,19 @@

 Testcase non-persistent without restart

-{"execute": "block-dirty-bitmap-add", "arguments": {"name":
"bitmap0", "node": "drive0", "persistent": false}}
-{"return": {}}
-initial bitmap: name=bitmap0 dirty-clusters=1
-{"execute": "blockdev-snapshot-sync", "arguments": {"device":
"drive0", "format": "qcow2", "snapshot-file": "TEST_DIR/PID-top"}}
-{"return": {}}
-check that no bitmaps are in snapshot: not found
-{"execute": "block-commit", "arguments": {"device": "drive0", "top":
"TEST_DIR/PID-top"}}
-{"return": {}}
-{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed":
0, "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp":
{"microseconds": "USECS", "seconds": "SECS"}}
-{"execute": "block-job-complete", "arguments": {"device": "drive0"}}
-{"return": {}}
-{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed":
0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp":
{"microseconds": "USECS", "seconds": "SECS"}}
-check bitmap after commit: name=bitmap0 dirty-clusters=2
-check updated bitmap: name=bitmap0 dirty-clusters=3
-
-Testcase persistent without restart
-
-{"execute": "block-dirty-bitmap-add", "arguments": {"name":
"bitmap0", "node": "drive0", "persistent": true}}
-{"return": {}}
-initial bitmap: name=bitmap0 dirty-clusters=1
-{"execute": "blockdev-snapshot-sync", "arguments": {"device":
"drive0", "format": "qcow2", "snapshot-file": "TEST_DIR/PID-top"}}
-{"return": {}}
-check that no bitmaps are in snapshot: not found
-{"execute": "block-commit", "arguments": {"device": "drive0", "top":
"TEST_DIR/PID-top"}}
-{"return": {}}
-{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed":
0, "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp":
{"microseconds": "USECS", "seconds": "SECS"}}
-{"execute": "block-job-complete", "arguments": {"device": "drive0"}}
-{"return": {}}
-{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed":
0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp":
{"microseconds": "USECS", "seconds": "SECS"}}
-check bitmap after commit: name=bitmap0 dirty-clusters=2
-check updated bitmap: name=bitmap0 dirty-clusters=3
-
-Testcase persistent with restart
-
-{"execute": "block-dirty-bitmap-add", "arguments": {"name":
"bitmap0", "node": "drive0", "persistent": true}}
-{"return": {}}
-initial bitmap: name=bitmap0 dirty-clusters=1
-{"execute": "blockdev-snapshot-sync", "arguments": {"device":
"drive0", "format": "qcow2", "snapshot-file": "TEST_DIR/PID-top"}}
-{"return": {}}
-check that no bitmaps are in snapshot: not found
-... Restart ...
-{"execute": "block-commit", "arguments": {"device": "drive0", "top":
"TEST_DIR/PID-top"}}
-{"return": {}}
-{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed":
0, "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp":
{"microseconds": "USECS", "seconds": "SECS"}}
-{"execute": "block-job-complete", "arguments": {"device": "drive0"}}
-{"return": {}}
-{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed":
0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp":
{"microseconds": "USECS", "seconds": "SECS"}}
-check bitmap after commit: name=bitmap0 dirty-clusters=2
-check updated bitmap: name=bitmap0 dirty-clusters=3
+Traceback (most recent call last):
+  File "260", line 87, in <module>
+    test(persistent=False, restart=False)
+  File "260", line 48, in test
+    vm.launch()
+  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/../../python/qemu/machine.py",
line 294, in launch
+    self._launch()
+  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/../../python/qemu/machine.py",
line 311, in _launch
+    self._pre_launch()
+  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/../../python/qemu/qtest.py",
line 103, in _pre_launch
+    super(QEMUQtestMachine, self)._pre_launch()
+  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/../../python/qemu/machine.py",
line 262, in _pre_launch
+    server=True)
+  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/../../python/qemu/qmp.py",
line 60, in __init__
+    self.__sock.bind(self.__address)
+OSError: AF_UNIX path too long
  TEST    iotest-qcow2: 265
  TEST    iotest-qcow2: 267
  TEST    iotest-qcow2: 268
Not run: 220
Failures: 260
Failed 1 of 109 iotests



thanks
-- PMM

