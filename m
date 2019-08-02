Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2478DC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 15:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9EE320665
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 15:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EE320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htZdm-00024V-AK
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 11:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53563)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1htZcG-0008Cu-Vy
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 11:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1htZcG-0000RB-0E
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 11:37:12 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58623 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1htZcF-0008QM-QF
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 11:37:11 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 249EF1A220C;
 Fri,  2 Aug 2019 17:36:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 0656A1A21F4;
 Fri,  2 Aug 2019 17:36:08 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 17:35:58 +0200
Message-Id: <1564760158-27536-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564760158-27536-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1564760158-27536-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 2/2] tests/acceptance: Add new test cases in
 linux_ssh_mips_malta.py
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
Cc: ehabkost@redhat.com, cohuck@redhat.com, f4bug@amsat.org, crosa@redhat.com,
 amarkovic@wavecomp.com, ccarrara@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add 15 new tests cases. They all rely on simple commands used for
detecting hardware configuration information.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/acceptance/linux_ssh_mips_malta.py | 45 ++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
index 8368e1f..c153c41 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -155,6 +155,51 @@ class LinuxSSH(Test):
 
     def run_common_commands(self):
         self.ssh_command_output_contains(
+            'cat /proc/cpuinfo',
+            '24Kc')
+        self.ssh_command_output_contains(
+            'uname -m',
+            'mips')
+        self.ssh_command_output_contains(
+            'uname -r',
+            '3.2.0-4-4kc-malta')
+        self.ssh_command_output_contains(
+            'cat /proc/interrupts',
+            'timer')
+        self.ssh_command_output_contains(
+            'cat /proc/interrupts',
+            'i8042')
+        self.ssh_command_output_contains(
+            'cat /proc/interrupts',
+            'serial')
+        self.ssh_command_output_contains(
+            'cat /proc/interrupts',
+            'ata_piix')
+        self.ssh_command_output_contains(
+            'cat /proc/interrupts',
+            'eth0')
+        self.ssh_command_output_contains(
+            'cat /proc/interrupts',
+            'eth0')
+        self.ssh_command_output_contains(
+            'cat /proc/devices',
+            'input')
+        self.ssh_command_output_contains(
+            'cat /proc/devices',
+            'usb')
+        self.ssh_command_output_contains(
+            'cat /proc/devices',
+            'fb')
+        self.ssh_command_output_contains(
+            'cat /proc/ioports',
+            'serial')
+        self.ssh_command_output_contains(
+            'cat /proc/ioports',
+            'ata_piix')
+        self.ssh_command_output_contains(
+            'cat /proc/ioports',
+            'piix4_smbus')
+        self.ssh_command_output_contains(
             'lspci -d 11ab:4620',
             'GT-64120')
         self.ssh_command_output_contains(
-- 
2.7.4


