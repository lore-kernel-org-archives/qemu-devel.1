Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD134C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA9620760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoXPw1Lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA9620760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhi2-0002EH-Qb
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQW-0003Tb-BR
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:50453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQT-0001YD-3o
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id 13so1846208wmf.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ApdyWpu0LjE2KogCc5CTk3qwN9V54L+6oyQ3jiCzQL0=;
 b=uoXPw1LwKRWdDussy/HD7gqwebq3WMXCadfgNqsc/woTHA9+o5XJQUcURt2Q/oP5CM
 r6RuobCSrzfEpeezSsZK4EdCq26Id50NBaDtEiFjg46vRonR6Qswlx68otxHRoGEjvDc
 LVPK3Ca6wZONrSqyRbfU7QqBMd9POMoGA5vdmHTBv03nbW88aDxyYfjai5LzTq+KINvv
 z2EuP0qOE5Kv1cpgmWf5JPCR+hGpTNVivXhrOfLYN0uCwgjVars6ED2KCZwZadYVd4r2
 d4Pt/Q0nf0NuQ+V2jcVDOiBhBRnifm0kU53zr/t/X1VmMJUm/yMloC7H52WzJhLaXeLu
 1ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ApdyWpu0LjE2KogCc5CTk3qwN9V54L+6oyQ3jiCzQL0=;
 b=fhdjE3mVyeEA7xasc63GqSXlrvSfMPk5H4RemAXHoOA4LkokoewY+mlu0zC9mCYt2n
 fEMfm+x4fzg0gCcIru+Q5yTLjn+ebXdmReRJTccIx1LghQ3XPKVtwW/pDG13KBmdhiK6
 blE0STlaUiftFKTL13cqlJdnzoqws0mvcv3aiZxjQat8S6hnKoNz+uozkAEgiouWKb9j
 JhADV463YE76jHaCY/9q/4F63bSnrE5mVFhqojoBCswtzi8XQqRvliUvpaOw3ad3RwCB
 i2KXQsfuVUQ9wME6CsLBsFd1YO3PB30fA7KbLLg4I+Tp0cmP80JbSuWC5b9GfUC5f3Uf
 4jVw==
X-Gm-Message-State: AOAM5318jRb31DwOmsROjcAQI6DFEOVLg4nYK0uH/+eaNttJOawxMLFr
 ZF/rWNieoCLVgWkpIdySi7RnzU0S8aM=
X-Google-Smtp-Source: ABdhPJzYMC4aEgjyhKHGAB8ObKqqH05ENW0CA4tZU5ziOp7R0MzIROPJ8gwtX7gw64r2a9YvlpAZsQ==
X-Received: by 2002:a1c:2394:: with SMTP id j142mr3118986wmj.3.1601969419351; 
 Tue, 06 Oct 2020 00:30:19 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/37] tests/acceptance: add reverse debugging test
Date: Tue,  6 Oct 2020 09:29:47 +0200
Message-Id: <20201006072947.487729-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Willian Rampazzo <willianr@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>

This is a test for GDB reverse debugging commands: reverse step and reverse continue.
Every test in this suite consists of two phases: record and replay.
Recording saves the execution of some instructions and makes an initial
VM snapshot to allow reverse execution.
Replay saves the order of the first instructions and then checks that they
are executed backwards in the correct order.
After that the execution is replayed to the end, and reverse continue
command is checked by setting several breakpoints, and asserting
that the execution is stopped at the last of them.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Willian Rampazzo <willianr@redhat.com>

--

v5:
 - disabled (as some other tests) when running on gitlab
   due to the unidentified timeout problem
Message-Id: <160174524678.12451.13258942849173670277.stgit@pasha-ThinkPad-X280>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                           |   1 +
 tests/acceptance/reverse_debugging.py | 208 ++++++++++++++++++++++++++
 2 files changed, 209 insertions(+)
 create mode 100644 tests/acceptance/reverse_debugging.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 417fca5f57..e9d85cc873 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2696,6 +2696,7 @@ F: include/sysemu/replay.h
 F: docs/replay.txt
 F: stubs/replay.c
 F: tests/acceptance/replay_kernel.py
+F: tests/acceptance/reverse_debugging.py
 F: qapi/replay.json
 
 IOVA Tree
diff --git a/tests/acceptance/reverse_debugging.py b/tests/acceptance/reverse_debugging.py
new file mode 100644
index 0000000000..b72fdf6cdc
--- /dev/null
+++ b/tests/acceptance/reverse_debugging.py
@@ -0,0 +1,208 @@
+# Reverse debugging test
+#
+# Copyright (c) 2020 ISP RAS
+#
+# Author:
+#  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+import os
+import logging
+
+from avocado import skipIf
+from avocado_qemu import BUILD_DIR
+from avocado.utils import gdb
+from avocado.utils import process
+from avocado.utils.path import find_command
+from boot_linux_console import LinuxKernelTest
+
+class ReverseDebugging(LinuxKernelTest):
+    """
+    Test GDB reverse debugging commands: reverse step and reverse continue.
+    Recording saves the execution of some instructions and makes an initial
+    VM snapshot to allow reverse execution.
+    Replay saves the order of the first instructions and then checks that they
+    are executed backwards in the correct order.
+    After that the execution is replayed to the end, and reverse continue
+    command is checked by setting several breakpoints, and asserting
+    that the execution is stopped at the last of them.
+    """
+
+    timeout = 10
+    STEPS = 10
+    endian_is_le = True
+
+    def run_vm(self, record, shift, args, replay_path, image_path):
+        logger = logging.getLogger('replay')
+        vm = self.get_vm()
+        vm.set_console()
+        if record:
+            logger.info('recording the execution...')
+            mode = 'record'
+        else:
+            logger.info('replaying the execution...')
+            mode = 'replay'
+            vm.add_args('-s', '-S')
+        vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s,rrsnapshot=init' %
+                    (shift, mode, replay_path),
+                    '-net', 'none')
+        vm.add_args('-drive', 'file=%s,if=none' % image_path)
+        if args:
+            vm.add_args(*args)
+        vm.launch()
+        return vm
+
+    @staticmethod
+    def get_reg_le(g, reg):
+        res = g.cmd(b'p%x' % reg)
+        num = 0
+        for i in range(len(res))[-2::-2]:
+            num = 0x100 * num + int(res[i:i + 2], 16)
+        return num
+
+    @staticmethod
+    def get_reg_be(g, reg):
+        res = g.cmd(b'p%x' % reg)
+        return int(res, 16)
+
+    def get_reg(self, g, reg):
+        # value may be encoded in BE or LE order
+        if self.endian_is_le:
+            return self.get_reg_le(g, reg)
+        else:
+            return self.get_reg_be(g, reg)
+
+    def get_pc(self, g):
+        return self.get_reg(g, self.REG_PC)
+
+    def check_pc(self, g, addr):
+        pc = self.get_pc(g)
+        if pc != addr:
+            self.fail('Invalid PC (read %x instead of %x)' % (pc, addr))
+
+    @staticmethod
+    def gdb_step(g):
+        g.cmd(b's', b'T05thread:01;')
+
+    @staticmethod
+    def gdb_bstep(g):
+        g.cmd(b'bs', b'T05thread:01;')
+
+    @staticmethod
+    def vm_get_icount(vm):
+        return vm.qmp('query-replay')['return']['icount']
+
+    def reverse_debugging(self, shift=7, args=None):
+        logger = logging.getLogger('replay')
+
+        # create qcow2 for snapshots
+        logger.info('creating qcow2 image for VM snapshots')
+        image_path = os.path.join(self.workdir, 'disk.qcow2')
+        qemu_img = os.path.join(BUILD_DIR, 'qemu-img')
+        if not os.path.exists(qemu_img):
+            qemu_img = find_command('qemu-img', False)
+        if qemu_img is False:
+            self.cancel('Could not find "qemu-img", which is required to '
+                        'create the temporary qcow2 image')
+        cmd = '%s create -f qcow2 %s 128M' % (qemu_img, image_path)
+        process.run(cmd)
+
+        replay_path = os.path.join(self.workdir, 'replay.bin')
+
+        # record the log
+        vm = self.run_vm(True, shift, args, replay_path, image_path)
+        while self.vm_get_icount(vm) <= self.STEPS:
+            pass
+        last_icount = self.vm_get_icount(vm)
+        vm.shutdown()
+
+        logger.info("recorded log with %s+ steps" % last_icount)
+
+        # replay and run debug commands
+        vm = self.run_vm(False, shift, args, replay_path, image_path)
+        logger.info('connecting to gdbstub')
+        g = gdb.GDBRemote('127.0.0.1', 1234, False, False)
+        g.connect()
+        r = g.cmd(b'qSupported')
+        if b'qXfer:features:read+' in r:
+            g.cmd(b'qXfer:features:read:target.xml:0,ffb')
+        if b'ReverseStep+' not in r:
+            self.fail('Reverse step is not supported by QEMU')
+        if b'ReverseContinue+' not in r:
+            self.fail('Reverse continue is not supported by QEMU')
+
+        logger.info('stepping forward')
+        steps = []
+        # record first instruction addresses
+        for _ in range(self.STEPS):
+            pc = self.get_pc(g)
+            logger.info('saving position %x' % pc)
+            steps.append(pc)
+            self.gdb_step(g)
+
+        # visit the recorded instruction in reverse order
+        logger.info('stepping backward')
+        for addr in steps[::-1]:
+            self.gdb_bstep(g)
+            self.check_pc(g, addr)
+            logger.info('found position %x' % addr)
+
+        logger.info('seeking to the end (icount %s)' % (last_icount - 1))
+        vm.qmp('replay-break', icount=last_icount - 1)
+        # continue - will return after pausing
+        g.cmd(b'c', b'T02thread:01;')
+
+        logger.info('setting breakpoints')
+        for addr in steps:
+            # hardware breakpoint at addr with len=1
+            g.cmd(b'Z1,%x,1' % addr, b'OK')
+
+        logger.info('running reverse continue to reach %x' % steps[-1])
+        # reverse continue - will return after stopping at the breakpoint
+        g.cmd(b'bc', b'T05thread:01;')
+
+        # assume that none of the first instructions is executed again
+        # breaking the order of the breakpoints
+        self.check_pc(g, steps[-1])
+        logger.info('successfully reached %x' % steps[-1])
+
+        logger.info('exitting gdb and qemu')
+        vm.shutdown()
+
+class ReverseDebugging_X86_64(ReverseDebugging):
+    REG_PC = 0x10
+    REG_CS = 0x12
+    def get_pc(self, g):
+        return self.get_reg_le(g, self.REG_PC) \
+            + self.get_reg_le(g, self.REG_CS) * 0x10
+
+    # unidentified gitlab timeout problem
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    def test_x86_64_pc(self):
+        """
+        :avocado: tags=arch:x86_64
+        :avocado: tags=machine:pc
+        """
+        # start with BIOS only
+        self.reverse_debugging()
+
+class ReverseDebugging_AArch64(ReverseDebugging):
+    REG_PC = 32
+
+    # unidentified gitlab timeout problem
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    def test_aarch64_virt(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:virt
+        :avocado: tags=cpu:cortex-a53
+        """
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
+                      '/linux/releases/29/Everything/aarch64/os/images/pxeboot'
+                      '/vmlinuz')
+        kernel_hash = '8c73e469fc6ea06a58dc83a628fc695b693b8493'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        self.reverse_debugging(
+            args=('-kernel', kernel_path, '-cpu', 'cortex-a53'))
-- 
2.26.2


