Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54139C4BA2D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E6724656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E6724656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JIV-0008FE-DN
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1j7JE0-0001iv-9k
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1j7JDz-0005nO-Di
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:29:12 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:39858 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1j7JDz-0004Wa-6z
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:29:11 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 0115B1A20D2;
 Thu, 27 Feb 2020 14:28:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id CC2761A20A0;
 Thu, 27 Feb 2020 14:28:07 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] hw/mips/mips_int: Simplify cpu_mips_irq_init_cpu()
Date: Thu, 27 Feb 2020 14:27:34 +0100
Message-Id: <1582810056-22646-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582810056-22646-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1582810056-22646-1-git-send-email-aleksandar.markovic@rt-rk.com>
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Since commit d8ed887bdc, the cpu_mips_irq_request handler takes
a pointer to MIPSCPU in its opaque argument.  Directly pass the
cpu pointer.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20200221162011.26383-1-philmd@redhat.com>
---
 hw/mips/mips_int.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 863ed45..796730b 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -77,7 +77,7 @@ void cpu_mips_irq_init_cpu(MIPSCPU *cpu)
     qemu_irq *qi;
     int i;
=20
-    qi =3D qemu_allocate_irqs(cpu_mips_irq_request, env_archcpu(env), 8)=
;
+    qi =3D qemu_allocate_irqs(cpu_mips_irq_request, cpu, 8);
     for (i =3D 0; i < 8; i++) {
         env->irq[i] =3D qi[i];
     }
--=20
2.7.4


