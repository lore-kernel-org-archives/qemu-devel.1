Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE65C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7690206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7690206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igpox-0005ZH-1P
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 07:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1igpjR-0006kg-4m
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:44:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1igpjN-0006w2-T1
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:44:12 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:57763 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1igpjN-0006vC-Mf
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:44:09 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id DAF121A20EF;
 Mon, 16 Dec 2019 13:43:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id AD72A1A20DF;
 Mon, 16 Dec 2019 13:43:01 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] hw/mips: Deprecate the r4k machine
Date: Mon, 16 Dec 2019 13:42:47 +0100
Message-Id: <1576500172-11264-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576500172-11264-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1576500172-11264-1-git-send-email-aleksandar.markovic@rt-rk.com>
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

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The r4k machine was introduced in 2005 (6af0bf9c7) and its last
logical change was in 2005 (9542611a6). After that, one can
count 164 maintenance commits (QEMU API changes) with the
exception of 1 fix in 2015 (memory leak, commit 3ad9fd5a).

This machine was introduced as a proof of concept to run a MIPS
CPU. Two years later, the Malta machine was added (commit
5856de80), modeling a real platform.

Note also this machine has no specification except 5 lines in
the header of this file:

 * emulates a simple machine with ISA-like bus.
 * ISA IO space mapped to the 0x14000000 (PHYS) and
 * ISA memory at the 0x10000000 (PHYS, 16Mb in size).
 * All peripherial devices are attached to this "bus" with
 * the standard PC ISA addresses.

The Linux kernel support for this machine has been dropped more
than 10 years ago in commit 302922e5.

It is time to deprecate this obsolete machine. Users are
recommended to use the Malta board, and its hardware is well
documented.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Acked-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20191125104103.28962-1-philmd@redhat.com>
---
 MAINTAINERS          | 2 +-
 hw/mips/mips_r4k.c   | 1 +
 qemu-deprecated.texi | 5 +++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e5e3e5..3b3a88e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -972,7 +972,7 @@ F: hw/net/mipsnet.c
 R4000
 M: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
-S: Maintained
+S: Obsolete
 F: hw/mips/mips_r4k.c
=20
 Fulong 2E
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index d1f5d6b..3891be6 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -307,6 +307,7 @@ void mips_r4k_init(MachineState *machine)
=20
 static void mips_machine_init(MachineClass *mc)
 {
+    mc->deprecation_reason =3D "use malta machine type instead";
     mc->desc =3D "mips r4k platform";
     mc->init =3D mips_r4k_init;
     mc->block_default_type =3D IF_IDE;
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 8471eef..f909be5 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -261,6 +261,11 @@ The 'scsi-disk' device is deprecated. Users should u=
se 'scsi-hd' or
=20
 @section System emulator machines
=20
+@subsection mips r4k platform (since 4.2)
+
+This machine type is very old and unmaintained. Users should use the 'ma=
lta'
+machine type instead.
+
 @subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)
=20
 These machine types are very old and likely can not be used for live mig=
ration
--=20
2.7.4


