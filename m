Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5072EC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D177022281
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DHk2RCuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D177022281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLqU-0003c5-NJ
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLlg-0006qB-Jf
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:40453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLle-0000RD-Me
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id k18so765925wmj.5
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 02:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lQMst0vXtb4Gg0mYZJn8zq4jVmArpnP9j0CDdQR53Fo=;
 b=DHk2RCujppzlQ7+fcFFxRrGca+ff9nXNQeeQl3B7PwBG+2NLPV1DNLu+XIPo/AAjiX
 TvX2dsBxOcG4TbBwLFknXXYCbpTEVAUgp8uUdf1Yrz2LDbkIQFm2cxt5ZgAaphsJYmG7
 OZyybFNsNLV2Yx5MPGjQVxbmWw5zbn7kN3KH4MjTMdR+tFKsR0asZpQWBmGAKBFbxfoA
 44o3KIKFyF2664ojEmzZ308b5BVwj0E1Bfu3DHBiPxBtrGrHzkyqS+fuQZD54zTek6O3
 YvjLr9+kQqBWHsef0myuwBklGAu3/v2CN88CPf1/XCtnxNv0EU93GETET0rdTXPw/Vgd
 XG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lQMst0vXtb4Gg0mYZJn8zq4jVmArpnP9j0CDdQR53Fo=;
 b=Q2F9kHHjvZrj8ylmMIlzRHKk51DhoBeJkSKnEMJ6tFPZSIXcESPrlQkZE/DJw0qk0H
 PYpV4GBIvur103hgiK12dCpFcqYoPwmk6nItD7NwywDFUzenQrsiSO3obVAkYhKq2BJo
 aSekXt5Lw3E/8g5iGKqpNJ2TxfC1/DqYvjw8Y+GYF8KlGv6cH/YZf8czfCZnl+LeqZ1a
 emRG3POD74yaQEdrU90IbbpetuCSukFFPVwhrnRiLpMbwyv9+tg3kKbPIgTjQw0sE6x6
 l/7+5a4oyfB9NoGGjcOuCPr/UoxV11m/ldTOYrKU7l8WSOHpP9uYDwOc3udTee3jyW/3
 N9Sg==
X-Gm-Message-State: AOAM5336aBvQ+Jrna/9P/+kG5Buj9QMSLFIVqQGdslRUdaYDLAHnFM71
 XHQftJcA5yPRw1FAddmqG6gjIy4odp7vkg==
X-Google-Smtp-Source: ABdhPJx0frd3m/iZNyQrrBVl1v/ShXDknJ7npPZnZfW9LfiimbHmWyAuzw/goenPLcK7tMbd9+4iDQ==
X-Received: by 2002:a7b:c04a:: with SMTP id u10mr1899209wmc.83.1603792789383; 
 Tue, 27 Oct 2020 02:59:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n5sm1311022wrm.2.2020.10.27.02.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 02:59:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4EFBA1FF92;
 Tue, 27 Oct 2020 09:59:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 6/8] tests/acceptance: pick a random gdb port for reverse
 debugging
Date: Tue, 27 Oct 2020 09:59:36 +0000
Message-Id: <20201027095938.28673-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027095938.28673-1-alex.bennee@linaro.org>
References: <20201027095938.28673-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the test randomly fails if you are using a shared machine
due to contention on the well known port 1234. We can ameliorate this
a bit by picking a random non-ephemeral port although it doesn't
totally avoid the problem. While we could use a totally unique socket
address for debugging it is fiddly to probe for gdb support. While gdb
socket debugging is not yet ubiquitous this a sub-optimal but workable
option.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201021163136.27324-7-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/acceptance/reverse_debugging.py b/tests/acceptance/reverse_debugging.py
index b72fdf6cdc..be01aca217 100644
--- a/tests/acceptance/reverse_debugging.py
+++ b/tests/acceptance/reverse_debugging.py
@@ -14,6 +14,7 @@ from avocado import skipIf
 from avocado_qemu import BUILD_DIR
 from avocado.utils import gdb
 from avocado.utils import process
+from avocado.utils.network.ports import find_free_port
 from avocado.utils.path import find_command
 from boot_linux_console import LinuxKernelTest
 
@@ -33,7 +34,7 @@ class ReverseDebugging(LinuxKernelTest):
     STEPS = 10
     endian_is_le = True
 
-    def run_vm(self, record, shift, args, replay_path, image_path):
+    def run_vm(self, record, shift, args, replay_path, image_path, port):
         logger = logging.getLogger('replay')
         vm = self.get_vm()
         vm.set_console()
@@ -43,7 +44,7 @@ class ReverseDebugging(LinuxKernelTest):
         else:
             logger.info('replaying the execution...')
             mode = 'replay'
-            vm.add_args('-s', '-S')
+            vm.add_args('-gdb', 'tcp::%d' % port, '-S')
         vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s,rrsnapshot=init' %
                     (shift, mode, replay_path),
                     '-net', 'none')
@@ -109,9 +110,10 @@ class ReverseDebugging(LinuxKernelTest):
         process.run(cmd)
 
         replay_path = os.path.join(self.workdir, 'replay.bin')
+        port = find_free_port()
 
         # record the log
-        vm = self.run_vm(True, shift, args, replay_path, image_path)
+        vm = self.run_vm(True, shift, args, replay_path, image_path, port)
         while self.vm_get_icount(vm) <= self.STEPS:
             pass
         last_icount = self.vm_get_icount(vm)
@@ -120,9 +122,9 @@ class ReverseDebugging(LinuxKernelTest):
         logger.info("recorded log with %s+ steps" % last_icount)
 
         # replay and run debug commands
-        vm = self.run_vm(False, shift, args, replay_path, image_path)
+        vm = self.run_vm(False, shift, args, replay_path, image_path, port)
         logger.info('connecting to gdbstub')
-        g = gdb.GDBRemote('127.0.0.1', 1234, False, False)
+        g = gdb.GDBRemote('127.0.0.1', port, False, False)
         g.connect()
         r = g.cmd(b'qSupported')
         if b'qXfer:features:read+' in r:
-- 
2.20.1


