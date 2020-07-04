Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC27C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BB5206B6
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BB5206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrl0a-0007dB-4H
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzI-00052r-KZ
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:00 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:36099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzF-0002NX-Uy
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:00 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MPXlM-1kEOTD2cFe-00Mbtr; Sat, 04 Jul 2020 18:25:53 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/12] target/sparc: Translate flushw opcode
Date: Sat,  4 Jul 2020 18:25:34 +0200
Message-Id: <20200704162545.311133-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704162545.311133-1-laurent@vivier.eu>
References: <20200704162545.311133-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zJMSMPD1WCs2H/7T1KaIqqNDXh4awHcxaW3nmKyDH0rv+EUv9xx
 G88TlDnAcjdphBJcwk1Icj299tS5X61pBIaDFUMqHr8p7oB4Z4RL9U8gEGKBOINW09YIY9d
 KiCWRl5UZkU9iiplnFa8QItDyGjSW+MQxi7xttDhiINbMIOrf4dNuI6hoAtbrBy+iJGEsVm
 nEA7a9lJxbjyeHNlNEyXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:20r6uQB412g=:qONXXoXnJ+VoT+YBMvr5R9
 SecnkV9lLrXKO8m4n0ENqQW14OAXPQ4gkIPI1sYvA0Ojnw0AZVvyF4nVhzSJ21jdTqzel+Y/t
 c3S2lfUPVzYQja2bydWQZTl+RPkrlnZMKG81Il3P8Q8Ai9KwJlWZ5lUoNbI0lTM7i2oqV1Jy9
 I5oy+fcFtLiw3jxtngXsCuyiSR+1SGJQnBa9nGDd7n/EWUtYCsDyKUHNr4vVIj1tXyw7yLVyg
 YTbZLTxVX0vhElwHX/hmCGwEwnfysWb2AMFMo/PoT5OA2LOTfuzXszmg25Ads+6hes/zY7CDe
 H43AbnFVwvzNaDbSpVndmu7pR95ceh39HASy+utnDV1ws5u1bSczTsIla1XjLotjqc/9YQf5H
 ohW+3NQWhWOU3kWomANsswSSAnfZmDezhmJ/02/tPVCtftS69B2nXMKheigUUOUKU1WZi0gHL
 v704e32nISjgygk8J9dBB7Xx2KDqAewvgH0nUpHJKVQnbaLnMKfEh/r48+nuIezw7Vamm5F5b
 Js0KqnBQZDFJUyZT5FrSP/G7PA66nrwee5Vab1pkdtI6yeT0gfxz9WxospALkqDTFO9hupcKk
 XnMIAeIwGKpvcnHQ0NHnEqX8wPhG360KAPAAguhCwxAwvPBWbOrBnysZmuCOEXuAcf+2sratw
 LrvWHAdAkV6QiHqhHql05NtrYkwI31nQ5V49JrqtRIQ1hvJed+2EQTatVhQFxqiSu4DUZu53x
 pXzTwHupe49AVIDZUiNbrUBauvN6yMOaCJkkA9UEw7Cz5nUoQCyMKKolSIoMYkxHrpV7uH+Sb
 UE2R5JR429d08JKHZo5nqaYQ1Sdo2uwJMIIAhPbpyFfg9gFkzE=
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 12:25:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Giuseppe Musacchio <thatlemon@gmail.com>

The ifdef logic should unconditionally compile in the `xop == 0x2b` case
when targeting sparc64.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200625091204.3186186-2-laurent@vivier.eu>
---
 target/sparc/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9416a551cf46..1a4efd4ed665 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3663,6 +3663,8 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
 #endif
                 gen_store_gpr(dc, rd, cpu_tmp0);
                 break;
+#endif
+#if defined(TARGET_SPARC64) || !defined(CONFIG_USER_ONLY)
             } else if (xop == 0x2b) { /* rdtbr / V9 flushw */
 #ifdef TARGET_SPARC64
                 gen_helper_flushw(cpu_env);
-- 
2.26.2


