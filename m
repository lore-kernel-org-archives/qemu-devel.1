Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C163C388F3
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0E5207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZvPCVkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0E5207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDu9O-0000kV-QC
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDtH8-0005m0-4q
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 12:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDtH5-0000IB-H0
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 12:39:20 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:40117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDtH5-0000Dx-8f
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 12:39:19 -0400
Received: by mail-ot1-x332.google.com with SMTP id y39so2778585ota.7
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=maylhMjMsY287T0CuM/Xyn0hXV/ttd9CRUOm27mGBGA=;
 b=JZvPCVkfyok0wcpl2GwSY8nGNLZe6j/wk7KFurTPjp7eKiIHgJdcic3I1+AdZIXJMo
 rOKNZ5Mogblc57WMb1P2qRdAR8n2wJfRcYKY7kEOeburSrOI/hgB03s2FC2TAmYVoWCv
 ZVY1L5C6Y1KUUa2Cj3N//9ddBRvYPLET8AzEZtN32UrM1D/xF70tY8yHxW/zuBm7dED0
 MWCMW64iQYKTpfym8Ay5RU+9GYUeH+Zca+wJWa46FIM0iP1DUdfvCtNPJf8gaUHDW8uv
 lMGMq0TeeU/Nr8ZjK+xGNQcMShGl0M5PRItLfZDIdLS0R/RmqK5o4hyvmFQTJrzo5ZId
 YutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=maylhMjMsY287T0CuM/Xyn0hXV/ttd9CRUOm27mGBGA=;
 b=LkkNbrF7/GSlKhxqf9TAB0iUfVsbDRqQ5ISTEXtKSp5xNNaN8ds0uQWLI1XNomvrCl
 uD8be+wZL35E1mTFCAuCAtznp9I4aAJQNqrWGEMY7S55EtigjcGa/fOBu5pL/Y1gpHoK
 MrQMjXyGzW0AZM/9gagPP96H7muj3uoFtQN3DQk0d+EenlaZId4iMKZ+H0ZKMpzeyeIW
 mD7VT8guQ/3Bj1/x2g8z5P2ZtnvJoS8AystNv7/Iao1wzrMW1j1nRY3kPDCtQcTo+5UR
 1m0Eqlekk9EN3fVPEsVJNLP9WyH0R8tw6el52GptdB7DrYFAg2i+1ZIO1oQaakmdLeWf
 ZbqA==
X-Gm-Message-State: APjAAAUCRI2CjZjNs9DhSRdf0b+afZSxvKB6gn7e6oBYdilynHxzH0+n
 poPXAY3P+uGPPtagxjQ/yxLjTeBYQFMFgVZpiogM98aK5n8=
X-Google-Smtp-Source: APXvYqzqKrwuZcImD6uJrm//omOaBhu5+zlQNSZCztuc5rBkV72m7N6dJ+dfRw9ykCQU7n7rQ91GvSMZeNMy3wE+NgY=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr4026661oti.135.1569602358121; 
 Fri, 27 Sep 2019 09:39:18 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2019 17:39:07 +0100
Message-ID: <CAFEAcA8fwM03PXzkMvLdOWAL0R1Mq8hLmt8O-+NFSri6oHun1w@mail.gmail.com>
Subject: iotest failure -- test possibly not using sufficiently unique temp
 filename?
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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

Hi; I just saw this iotest failure (on an s390x box, as it happens):

  TEST    iotest-qcow2: 130 [fail]
QEMU          --
"/home/linux1/qemu/build/all/tests/qemu-iotests/../../s390x-softmmu/qemu-system-s390x"
-nodefaults -display none -machine accel=qtest
QEMU_IMG      -- "/home/linux1/qemu/build/all/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/linux1/qemu/build/all/tests/qemu-iotests/../../qemu-io"
--cache writeback -f qcow2
QEMU_NBD      -- "/home/linux1/qemu/build/all/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/s390x lxub05 4.15.0-58-generic
TEST_DIR      -- /home/linux1/qemu/build/all/tests/qemu-iotests/scratch
SOCKET_SCM_HELPER --
/home/linux1/qemu/build/all/tests/qemu-iotests/socket_scm_helper

--- /home/linux1/qemu/tests/qemu-iotests/130.out        2019-05-10
12:27:16.948075733 -0400
+++ /home/linux1/qemu/build/all/tests/qemu-iotests/130.out.bad
2019-09-27 12:01:23.649722655 -0400
@@ -18,20 +18,22 @@
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) commit testdisk
 (qemu)
-image: TEST_DIR/t.IMGFMT
-file format: IMGFMT
-virtual size: 64 MiB (67108864 bytes)
-backing file: TEST_DIR/t.IMGFMT.orig
-backing file format: raw
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Failed to get shared "write" lock
+Is another process using the image [TEST_DIR/t.IMGFMT]?

 === Marking image dirty (lazy refcounts) ===

+qemu-img: TEST_DIR/t.IMGFMT: Failed to get "write" lock
+Is another process using the image [TEST_DIR/t.IMGFMT]?
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-io: can't open device
/home/linux1/qemu/build/all/tests/qemu-iotests/scratch/t.qcow2: Failed
to get "write" lock
+Is another process using the image
[/home/linux1/qemu/build/all/tests/qemu-iotests/scratch/t.qcow2]?
+no file open, try 'help open'
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
+backing file: TEST_DIR/t.IMGFMT.orig
+backing file format: raw
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
backing_file=TEST_DIR/t.IMGFMT.orig backing_fmt=raw
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)



This looks suspiciously like the test isn't using a unique
filename for its disk image: "qemu-iotests/scratch/t.qcow2"
in the build directory, and so perhaps it has collided with
another iotest ?

If we run 'make check' with a -j<something> option do the
iotests all get run serially anyway, or do they run in
parallel against each other ?

thanks
-- PMM

