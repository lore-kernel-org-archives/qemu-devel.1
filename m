Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE301C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 22:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55792082E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 22:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55792082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37805 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRP3X-000135-Th
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 18:40:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hROyR-0005rL-72
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hROyQ-00027z-7x
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:39 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35831)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hROyP-000266-VN
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:38 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MDyoU-1hZ3w2264a-009wzn; Fri, 17 May 2019 00:35:34 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 00:35:17 +0200
Message-Id: <20190516223519.7520-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516223519.7520-1-laurent@vivier.eu>
References: <20190516223519.7520-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t6xbcCRqlBXLLgFEtDHIjD+d+Co3Crkf2Lk71z3qivNe8UdrVTC
	r3lt0cucuCNmBoIfw4MmUkw/AktHrOuEwx1joPdqo6rAyCfYOgzWN6wL8k0k84MjnaF74a/
	k43fA0rBIgf8gLk8CeE3bOhXxv3tmcdIy3+xY5I6UIKYQqlAIn6oJxBpG6Wz4qAREPAgKSn
	6zdyf320NshIlG7rdlnwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KEikezzreuM=:khSt6VG6gV7c9hu2PwnXYl
	8v4I4WPxHPotL6mHvZgtzmdcAtKSnrT2odZo15BRJ+xb2BeDCUq/NcKWDmo2XYBVPrC+8Ik1X
	S3s2lgsqFHgD+p9eRZl61yhEx6ADPZXyXEN/sPBYn0uFsB0sUXA7wz7RLnPzK1QT0Ud+0gMaF
	3MLRRyRH6qZfrWyd+t+WbeZi7GjJprUIi6wBkQdJsgz7OaSeEWY9fZ4GARNL+c/IEOEz0mUZa
	LYN1AGw/yxKJiwHjt5q1fXS/qsJ78uEaA+H+PARhaA/dJDYgzV0JaDNlaPhoYqWTXl5Ghxn2M
	4PmqliO8JiTRR8VawfYxK9iOBHJo5OqUiSQ93st7KYDvj79aa+vNFw+rhjF7YcME+7f41fJUa
	j9zq/qS02v88N0L66xvgVq6GrhDuBmOyrAsFna6dUBoy6MDMM7XDiGe1zIMTdb2MLano4IU4S
	7a48lLBJW6tpqUcHpHzc2bsg/qgbMfN/g1kQmu59WeSt5G6EukrSnRgF2r97YmGICFdtXPKbV
	SHMl7XkVPRdWo2fzXbBsRJbBYqBuU35/xQnHkosAb+gQXCE0wxGgoLfZZPIHL6ezg7GZc9FKN
	wp+sL3KGZO+mzANRseHv/5hX26CMdaveYB60k/ESHrNhJX36Zscq52zH46CpVc9k6Kkg/Qi76
	AdIOXzbVeM3tPI7XN91VREItbWUGREKwyOpzX28ZlCa+qfQ2nTVUU3JN213FbMK/E03XKRJ7w
	YGKM0TyWQGw+P7mRqm1cQUsN77IeGktPbMLwP+fHQYznHIZwUO5ED5M1nPY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PULL 4/6] target/m68k: Reduce the l1 TCGLabel scope
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <huth@tuxfamily.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190310003428.11723-2-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 58596278c2..176c5d966c 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -3020,7 +3020,6 @@ DISAS_INSN(branch)
     int32_t offset;
     uint32_t base;
     int op;
-    TCGLabel *l1;
 
     base = s->pc;
     op = (insn >> 8) & 0xf;
@@ -3036,7 +3035,7 @@ DISAS_INSN(branch)
     }
     if (op > 1) {
         /* Bcc */
-        l1 = gen_new_label();
+        TCGLabel *l1 = gen_new_label();
         gen_jmpcc(s, ((insn >> 8) & 0xf) ^ 1, l1);
         gen_jmp_tb(s, 1, base + offset);
         gen_set_label(l1);
-- 
2.20.1


