Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D059C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8199207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWDy33sz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8199207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxrl-000579-Uk
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxr2-0004CD-6P
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:20:28 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxr0-0007OG-8d
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:20:27 -0400
Received: by mail-wr1-x441.google.com with SMTP id x13so9740767wrv.4
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=D40zoiead8lsyko8FiDG1lzYWUlFTmKK0lit1iLvge8=;
 b=MWDy33sz60/XRFHf5scz4NdjbD20cbd/C1izl3Dfn9cbBnclu3DKAzNAO8jZsVr3Gd
 4TiNs43sMPbgLT5zStRErVARVyh3MPD9veMu4HpZwb2V4a1TFMblmOROHzerFEev8SQN
 4i7ViWvSGtoiduTF5//MHT6Xg2Mh/7/J7DrymzciauB3gRwUVTn9NDR91zVYvf/5yOQv
 eRufdYp4P0EqcI8rauXMFwfdSZHbLO23NWK0qSQJfEDrJhJZOjDh9402KbOLECRwEpO9
 +28Fqh4GbUoPGpwWXIQpNysO0YFxcklCnrsX98WaUC3CgDztVqy5sIXJSaaTdMxP7Roq
 /uRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=D40zoiead8lsyko8FiDG1lzYWUlFTmKK0lit1iLvge8=;
 b=SAeZ7fIwEwX+YQnayghF34XP90znGD6uHXBO6CpyfTu7/mFBy+0/RB8UIwu5q8415A
 VTfXyAo/ph/PLCnF1EGVT6MAFLty5X6maNKRVcVr5rcbW2wBP1MPi1Kk+WNf9A5Nboiq
 z24ciAoY3xOMSchQ+r+ceMX91u06yOJbwBL1YgwJpJfGlK6aSy+7tNuAYKhNwAQG36hZ
 oVPu97Kbwf0i6VclgqoxXDH28UUvzulVaTWq1/P4RVyGR44+gXx6sbbbFoHGKiccZZx5
 SjrfDtQWlyV5Uz1ZXh1xL59xMpbbVdQ1jSSQqVSVlXtAYaQip8XrH0fu0UuGUr5wByrO
 uzyg==
X-Gm-Message-State: AOAM533X81qZnSXhN0EA1oYrABk30htprmYzSOLJBYLpTA2FVYfiZPKf
 ob92XuL6lWaQepZIheYMu/s8Bw==
X-Google-Smtp-Source: ABdhPJzMstQyrR9/u4xBiQaJKczEVrnhsxhWUGNq+7n8dPWWH1FK720MAv+EG+3B5g4qybxfIS7qmw==
X-Received: by 2002:a5d:4008:: with SMTP id n8mr24708811wrp.82.1590592824364; 
 Wed, 27 May 2020 08:20:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e5sm3143976wrw.19.2020.05.27.08.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 08:20:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0D74E1FF7E;
 Wed, 27 May 2020 16:20:22 +0100 (BST)
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057545565.16818.10615781697342502198.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
Subject: Re: [PATCH v2 03/11] tests/acceptance: add base class record/replay
 kernel tests
In-reply-to: <159057545565.16818.10615781697342502198.stgit@pasha-ThinkPad-X280>
Date: Wed, 27 May 2020 16:20:22 +0100
Message-ID: <87y2pd5rrd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: wrampazz@redhat.com, qemu-devel@nongnu.org, dovgaluk@ispras.ru,
 pavel.dovgaluk@ispras.ru, crosa@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com> writes:

> This patch adds a base for testing kernel boot recording and replaying.
> Each test has the phase of recording and phase of replaying.
> Virtual machines just boot the kernel and do not interact with
> the network.
> Structure and image links for the tests are borrowed from boot_linux_cons=
ole.py
> Testing controls the message pattern at the end of the kernel
> boot for both record and replay modes. In replay mode QEMU is also
> intended to finish the execution automatically.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

diff --git a/MAINTAINERS b/MAINTAINERS
index 47ef3139e6..e9a9ce4f66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2497,6 +2497,7 @@ F: net/filter-replay.c
 F: include/sysemu/replay.h
 F: docs/replay.txt
 F: stubs/replay.c
+F: tests/acceptance/replay_kernel.py
=20
 IOVA Tree
 M: Peter Xu <peterx@redhat.com>
diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_ke=
rnel.py
new file mode 100644
index 0000000000..b8b277ad2f
--- /dev/null
+++ b/tests/acceptance/replay_kernel.py
@@ -0,0 +1,57 @@
+# Record/replay test that boots a Linux kernel
+#
+# Copyright (c) 2020 ISP RAS
+#
+# Author:
+#  Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+import gzip

Do we actually use gzip in this test?

+
+from avocado_qemu import wait_for_console_pattern
+from avocado.utils import process
+from avocado.utils import archive
+from boot_linux_console import LinuxKernelUtils
+
+class ReplayKernel(LinuxKernelUtils):
+    """
+    Boots a Linux kernel in record mode and checks that the console
+    is operational and the kernel command line is properly passed
+    from QEMU to the kernel.
+    Then replays the same scenario and verifies, that QEMU correctly
+    terminates.

Shouldn't we be doing more to verify the replay behaved the same as the
recorded session? What happens if things go wrong? Does QEMU barf out or
just deviate from the previous run?

+    """
+
+    timeout =3D 90
+
+    def run_vm(self, kernel_path, kernel_command_line, console_pattern,
+               record, shift, args):
+        vm =3D self.get_vm()
+        vm.set_console()
+        if record:
+            mode =3D 'record'
+        else:
+            mode =3D 'replay'
+        vm.add_args('-icount', 'shift=3D%s,rr=3D%s,rrfile=3D%s' %
+                    (shift, mode, os.path.join(self.workdir, 'replay.bin')=
),
+                    '-kernel', kernel_path,
+                    '-append', kernel_command_line,
+                    '-net', 'none')
+        if args:
+            vm.add_args(*args)
+        vm.launch()
+        self.wait_for_console_pattern(console_pattern, vm)
+        if record:
+            vm.shutdown()
+        else:
+            vm.wait()
+
+    def run_rr(self, kernel_path, kernel_command_line, console_pattern,
+        shift=3D7, args=3DNone):
+        self.run_vm(kernel_path, kernel_command_line, console_pattern,
+                    True, shift, args)
+        self.run_vm(kernel_path, kernel_command_line, console_pattern,
+                    False, shift, args)



--=20
Alex Benn=C3=A9e

