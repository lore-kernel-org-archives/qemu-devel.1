Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC5CC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0967217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0967217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSL5h-0002C2-JI
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSKzx-0003Yr-Cx
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSKzs-0002wO-8b
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:21 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:59479)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSKzr-0002vV-Vv
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:16 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1McpW6-1hsSHT3VCs-00ZwPn; Wed, 06 Nov 2019 14:05:14 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/13] linux-user/sparc64: Fix target_signal_frame
Date: Wed,  6 Nov 2019 14:04:52 +0100
Message-Id: <20191106130456.6176-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106130456.6176-1-laurent@vivier.eu>
References: <20191106130456.6176-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jGMMA1r2VMxaPACeECkS6P/IgU0zBlIlnzfV6a8cXosdPtWUyQg
 x4N/+z1UmJKOW+9Ih48yCw89ez/P55xgQOo/pMISXowX7QrRIesal/Np5jqR1b+VSVM2emn
 ZFdaPwNiIe5vSqZGcV+7rVaUZCHXVg3KG0AHbj/+TLIA0iCm9jv1zA2R40I3Sxoe+Gmcut8
 GlLp/a9VjNpdcXLF5RzTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E5EdphPDIO8=:6KRUEnGVIV54DmFbbhVujy
 alMHql5ziQlqAl2XrPtQ1Civ+4NkSlfoqRTEifEsPpMltDpNpDEuZy44cugLP0HZAN1ggTEfE
 7VCvThP7jyWFcr17JLK32BbOGVotybSK3PBlduGcazkX7cgcSz0aueV6TSPYR8wJ4XFMiksDG
 lgPueqB85cyyHsyij7ntdJOI7E9zJFTqEGSRJg1Uy9dw5LARHwYt8IneyzFReisEeAUkOh/Rn
 aLs8AcAT2349uPRogGmtAGlgaj8drBCOOGiEpUFSj4jGQJ8cXtbwAzEP648wgW++XE5EIVs/F
 Qc3QY2ogeEBHVXe3UK84NYBbq6PYq6qDJHXDlQKAufUuEeK03r8tEo6A9rMb5F7K5hsr3Nu4l
 3akdXVmzjXlH5YPhTL6N6+CNj75OnebngUCx6PQAoRUxQ/c3DAH6z45w3ekaBolOZz6AhEngu
 FLR5aBlv8YiF81Ji8Cj00W4HzIEHCSns/r/cLF8duDUXt1tD4sEg7eXq0+vX8uQmquEApMyVc
 PLQxxt9SnVmkMmzaajj46z4q9icgaCtnrDkrrKuTygZ5ihWQuP22MaHoZES9W9YClrHMP+LSj
 HhKpr1gOKrEFKaE73tnUoALcZeu+B36BxO5oX4vLmWS3sFo6478hXV0/q6o8cZwI0JoOhXO+N
 6nK0x8fNTQWa/w/MydExi7y7JKB24feaKLW4zEuPYytfb6BLwPiE/6mFgFamVbg1GLr/lsHbk
 DC/XbulzsTQn6KPHdiDmnrH+KoyqYD5Q+ozCdDogLKJC3gQBj54nM3g2x3mqf47gnxE5KxCCT
 JrV29VSJUtOmpP22lt1Zr3u/YmvPbSv89H8xH2qRqL3P8KHBljpsuadVVjBgZkWmoqYP+eQw/
 STNlKHryzgQiZ4VvCf/w==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Instructions are always 4 bytes; use uint32_t not abi_ulong.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191106113318.10226-9-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sparc/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index 238d0ba00c89..d796f50f665b 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -87,7 +87,7 @@ struct target_signal_frame {
     struct sparc_stackf ss;
     __siginfo_t         info;
     abi_ulong           fpu_save;
-    abi_ulong           insns[2] __attribute__ ((aligned (8)));
+    uint32_t            insns[2] QEMU_ALIGNED(8);
     abi_ulong           extramask[TARGET_NSIG_WORDS - 1];
     abi_ulong           extra_size; /* Should be 0 */
     qemu_siginfo_fpu_t fpu_state;
@@ -98,7 +98,7 @@ struct target_rt_signal_frame {
     abi_ulong           regs[20];
     sigset_t            mask;
     abi_ulong           fpu_save;
-    unsigned int        insns[2];
+    uint32_t            insns[2];
     stack_t             stack;
     unsigned int        extra_size; /* Should be 0 */
     qemu_siginfo_fpu_t  fpu_state;
-- 
2.21.0


