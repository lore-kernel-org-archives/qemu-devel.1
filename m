Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B70CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A30121D81
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A30121D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO2qQ-0001qC-Gw
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iO2ij-0005AN-H1
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iO2ii-0002MK-4k
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:49 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34473 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iO2ih-0002Ez-PC
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:47 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 366B81A21CC;
 Fri, 25 Oct 2019 18:44:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 0877B1A22A6;
 Fri, 25 Oct 2019 18:44:30 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/20] tests/ssh_linux_malta: Remove duplicated test
Date: Fri, 25 Oct 2019 18:44:19 +0200
Message-Id: <1572021862-28273-18-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572021862-28273-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1572021862-28273-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Remove duplicated test (probably copy/paste error in
commit 9090d3332cdcc).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20191019153437.9820-9-f4bug@amsat.org>
---
 tests/acceptance/linux_ssh_mips_malta.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/=
linux_ssh_mips_malta.py
index 6ecf335..007bcdb 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -153,9 +153,6 @@ class LinuxSSH(Test):
             'cat /proc/interrupts',
             'eth0')
         self.ssh_command_output_contains(
-            'cat /proc/interrupts',
-            'eth0')
-        self.ssh_command_output_contains(
             'cat /proc/devices',
             'input')
         self.ssh_command_output_contains(
--=20
2.7.4


