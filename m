Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8FFC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995F52190F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995F52190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS3KT-0007lg-Hg
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 13:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS3Ip-0005p4-9r
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS3Io-0004fM-6v
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:39 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:44091)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iS3In-0004eW-To
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:38 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MadC8-1hvSNJ37dK-00cBkp; Tue, 05 Nov 2019 19:11:35 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 13/13] linux-user/alpha: Set r20 secondary return value
Date: Tue,  5 Nov 2019 19:11:19 +0100
Message-Id: <20191105181119.26779-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105181119.26779-1-laurent@vivier.eu>
References: <20191105181119.26779-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:G5Qvq9AUwF43EHf2Ts0+hSE4/ieC4dEfMCGuVPb0+S4cAhx+CkS
 Bviyb1VDatREu20ezQcBca1qCqm+S4F76Q/14raGATNDrE+++zvwwhb00BNbd0nxN+5X/zw
 irnXI5HaYSCC6644dJmIRXuCX51+eC6EfPvdKQ4vonEaPTsZvPIz9nZvq4P/c3zs9ykTNdn
 aA6jVitt8v6p9G+0qrddA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GzKNXf/4V7U=:VYgqIR3/Si08vGcYzOt/oS
 nPOzcPW3TikWKAZ/GBGmgObmfZzI3O0Y0age/3tcH9AVSX3IUgK1jih+Ym8pGVItS6fusDUjQ
 QLFinTukIidQ2aMYwX9oXOxqhybI07gg2XO/SPDZHNDrQ1miphRFQRcQK0GHgJ0+6aUaGwG2d
 aZWOSgZogbWtcNmM4XkgU3X9bDha4T5C77fA3OpfuEP/y9kQR7IXsVvgNq2gvWDgZXqZE8WV9
 juU7jCLbopWgLF8nxQF+sIfQb7JIP1oejokRIaeth0an28OZM3F67yqWsddgBChf+NKmnFJLA
 8lwEFrN0U7Dz1Ad6dN8gpCrYUQyDkJXt5TCiCUe35X4ThDOvwzCJxwNmZMT1Ii8x/XJ23SPmb
 MHTBNJesUZwWbpq6TSp7QF6JljPRa/KZVzmP5cRLUDxp0TOV51OnVBFBt+YNdm36GpDLlHah+
 4oPPoHIDb87n1WdA2N1c19SpjpAYVAxGqqOITZvCyYOTw1mJPAzzRU1oH7qxA5usUxTWkI+S1
 z9fy96sH8K6B2rKWoh/2/YrOamFeeM3bytn4knGwIyMzkqWXmcA7VbBQ8PQg6Rob2nIZ9n9l8
 SuRdxE3aqqLKbzj+Jbe7MGubdUmusi/Jdm7z5mmmvE4l799ABKyry73IP98gt0Ob5H7EuM3sl
 4uCYfQIZoAp2VLdt/V9rxk1j/HAzZgqMbQv2mViMoWxE2kdrb02nl0vvduylRFh8qkZTlSk7v
 s6LPxqaoan5wnPl6xP4xYsdPQQPDFXmDsLmapDPSmev5TlrnYlbbOwEq6va61dLJA3MP4tAJz
 ddgoQR8lHbGlITYQd0uJddY+/d6iO0xhg5kf7lNdGXr8eKhTD3N+ZLFjlOEATXaR601pqCeEi
 kPIvH5X7V/KOitiC2ThQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This value is not, as far as I know, used by any linux software,
but it is set by the kernel and is part of the ABI.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191025113921.9412-13-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/alpha/target_cpu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
index dd25e18f47fb..ad408ab5cc8e 100644
--- a/linux-user/alpha/target_cpu.h
+++ b/linux-user/alpha/target_cpu.h
@@ -27,10 +27,19 @@ static inline void cpu_clone_regs_child(CPUAlphaState *env, target_ulong newsp,
     }
     env->ir[IR_V0] = 0;
     env->ir[IR_A3] = 0;
+    env->ir[IR_A4] = 1;  /* OSF/1 secondary return: child */
 }
 
 static inline void cpu_clone_regs_parent(CPUAlphaState *env, unsigned flags)
 {
+    /*
+     * OSF/1 secondary return: parent
+     * Note that the kernel does not do this if SETTLS, because the
+     * settls argument register is still live after copy_thread.
+     */
+    if (!(flags & CLONE_SETTLS)) {
+        env->ir[IR_A4] = 0;
+    }
 }
 
 static inline void cpu_set_tls(CPUAlphaState *env, target_ulong newtls)
-- 
2.21.0


