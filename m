Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889F6C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D63D2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D63D2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhbD-0006DL-II
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jGhYg-0002GF-KE
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jGhYd-0007Ls-Hp
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:17:22 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53075)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jGhYb-0007L7-RN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:17:19 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mz9lL-1jTzTW1qjb-00wDIK; Tue, 24 Mar 2020 12:17:05 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 1/5] target/i386: Renumber EXCP_SYSCALL
Date: Tue, 24 Mar 2020 12:16:56 +0100
Message-Id: <20200324111700.595531-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324111700.595531-1-laurent@vivier.eu>
References: <20200324111700.595531-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:g2Fxb0GuhkTYvAajYGpmLlPs4e+ymKt2URFzBGmu2d6DmhoH3Ol
 daC9J+Tw1v2vob3eQU0EAe5MGgfbuuO//uwUcETQb28GQbLDapznh8dInZpBSMzBjtdV0t0
 Rjp32akl6j4Te5M8FDRkVHX/KLS9mWfEIMXTenFeY+1EQfGT+59hF2omCIRqYvimmwKfjuW
 Nom86Jvsc9zgTdX6RY0xA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+vbHFAJH61I=:MqwAeJqI+2YJRqL2X7N2Z7
 4oc73e1VLASG3Lx9IrYIaY/N/KXFXtJ+pW6Q8fM7nWqrHmypi7H1R5VW5/GZ9imxr7ZPqsJ/b
 QWY9ePriHVFNIolM8GpI0n4EFt2yQxpfKowYKP8ncJXZWwOFDmt3z01QVnIqn4p9lcQC7sE5p
 offlu6PlisXXl2eytbhU/OyA5A26rP24OokMQvGBvnMKtMO1wmIrTrUWDob2LvvW2P07ayrPI
 2AoBQTvEypWYMhQ+Ho1ydCRIOwmkkHEXB6+9l0A3WNVcVBMoV6nuJewByno8+3y6KerBVJ3Zs
 pyFh8kmoNQaeS1MkF4lgeXfZYR8YGxtuou5mxaXDg3wMT0sVf2TA5FqXoYI6k6hwKK28duN2G
 p/q+9yNk/maHdceX2ciI6q1T4E7jw1bg/QGwrITA+/sfarRjX/E1JGIC7Hy2Y3zEAwmYbr+ud
 g2dziIKhlBwG7vl3LLmVeoJFXWjVDoqv02r8xgheJgaZLctxcWg3P/0oID9iE+vCTA8ic0q7x
 PpbXIbUgjeH+KlhXjDNE62tpWagdT3A/4X3lJZm+I5Ky7I2AdUayc6ms/CX9oMrIxjyPV1Y7n
 W0ojlKgcl+hE2im1sV7HOlrDiNyUPT2kdUgMABLo/f0O0+WHT0RACvrQ9OgvKrrAp5CDIyqRn
 QkcA7AhFLeg394XIWkkXBezdSf92amGt6639mJBCc927Kj2zCIBE0A/0VyG6SYEjXqNuYeupZ
 Gs2478S2wqOhkq1HLOLsFrznym3/u4WR10MCeMBXixuIgE1Paug0v8cLSeBja+mXyjfYN8B1/
 lvJteJV2QfNrH8ShrChUgXSdYfQwSa/X2Y+3Hl7lGvpGQqOMi9cVtCiLVyuXd+v3XSMP1Xp
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We are not short of numbers for EXCP_*.  There is no need to confuse things
by having EXCP_VMEXIT and EXCP_SYSCALL overlap, even though the former is
only used for system mode and the latter is only used for user mode.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200213032223.14643-2-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/i386/cpu.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 60d797d5941f..49ecc23104c9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1001,9 +1001,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define EXCP11_ALGN	17
 #define EXCP12_MCHK	18
 
-#define EXCP_SYSCALL    0x100 /* only happens in user only emulation
-                                 for syscall instruction */
-#define EXCP_VMEXIT     0x100
+#define EXCP_VMEXIT     0x100 /* only for system emulation */
+#define EXCP_SYSCALL    0x101 /* only for user emulation */
 
 /* i386-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
-- 
2.25.1


