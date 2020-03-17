Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3A5C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 13:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8687220738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 13:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8687220738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEBvl-00077O-Lf
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 09:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1jEBuk-0005Yq-Sr
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1jEBui-0007II-Ry
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:05:46 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60519 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1jEBui-00067J-Gu
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:05:44 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 2A61D1A2185;
 Tue, 17 Mar 2020 14:04:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 1083D1A2198;
 Tue, 17 Mar 2020 14:04:40 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] MAINTAINERS: Adjust maintainer's email
Date: Tue, 17 Mar 2020 14:04:28 +0100
Message-Id: <1584450269-26897-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584450269-26897-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1584450269-26897-1-git-send-email-aleksandar.markovic@rt-rk.com>
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

From: Aleksandar Markovic <amarkovic@wavecomp.com>

For some longish time I've been using multiple email addresses
for mailing list communication, and would like to consolidate it
into a single email address that is the most convenient to me.
My other emails, from rt-rk.com and wavecomp.com domains remain
active and I will respond from them too, if needed, but I would
like to manage almost all communication using gmail.com account.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <1584061252-16635-3-git-send-email-aleksandar.markovic@rt-rk.=
com>
---
 .mailmap    |  5 +++--
 MAINTAINERS | 16 ++++++++--------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/.mailmap b/.mailmap
index 76154c7..6412067 100644
--- a/.mailmap
+++ b/.mailmap
@@ -39,8 +39,9 @@ Julia Suvorova <jusual@mail.ru> Julia Suvorova via Qemu=
-devel <qemu-devel@nongnu
 Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-dev=
el <qemu-devel@nongnu.org>
=20
 # Next, replace old addresses by a more recent one.
-Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@mips.c=
om>
-Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@imgtec=
.com>
+Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markov=
ic@mips.com>
+Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markov=
ic@imgtec.com>
+Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecom=
p.com>
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
 Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm=
.com>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 4fba8b8..682032c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -209,7 +209,7 @@ F: hw/microblaze/
 F: disas/microblaze.c
=20
 MIPS TCG CPUs
-M: Aleksandar Markovic <amarkovic@wavecomp.com>
+M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
 S: Maintained
@@ -367,7 +367,7 @@ S: Maintained
 F: target/arm/kvm.c
=20
 MIPS KVM CPUs
-M: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
+M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 S: Odd Fixes
 F: target/mips/kvm.c
=20
@@ -1016,7 +1016,7 @@ F: hw/display/jazz_led.c
 F: hw/dma/rc4030.c
=20
 Malta
-M: Aleksandar Markovic <amarkovic@wavecomp.com>
+M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
 R: Aurelien Jarno <aurelien@aurel32.net>
 S: Maintained
@@ -1029,14 +1029,14 @@ F: tests/acceptance/linux_ssh_mips_malta.py
 F: tests/acceptance/machine_mips_malta.py
=20
 Mipssim
-M: Aleksandar Markovic <amarkovic@wavecomp.com>
+M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
 S: Odd Fixes
 F: hw/mips/mips_mipssim.c
 F: hw/net/mipsnet.c
=20
 R4000
-M: Aleksandar Markovic <amarkovic@wavecomp.com>
+M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
 S: Obsolete
@@ -1044,7 +1044,7 @@ F: hw/mips/mips_r4k.c
=20
 Fulong 2E
 M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
-M: Aleksandar Markovic <amarkovic@wavecomp.com>
+M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
 F: hw/isa/vt82c686.c
@@ -2508,7 +2508,7 @@ F: tcg/i386/
 F: disas/i386.c
=20
 MIPS TCG target
-M: Aleksandar Markovic <amarkovic@wavecomp.com>
+M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
 S: Maintained
@@ -2837,7 +2837,7 @@ S: Odd Fixes
 F: scripts/git-submodule.sh
=20
 UI translations
-M: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
+M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 F: po/*.po
=20
 Sphinx documentation configuration and build machinery
--=20
2.7.4


