Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE291C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7FA217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7FA217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSLA4-0001Mc-I8
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:15:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSL01-0003gU-0q
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSKzz-00031y-UP
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:24 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:33041)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSKzz-00031L-L4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:23 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N79q8-1hrtHN2L2y-017Vs9; Wed, 06 Nov 2019 14:05:09 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 04/13] target/sparc: Define an enumeration for accessing
 env->regwptr
Date: Wed,  6 Nov 2019 14:04:47 +0100
Message-Id: <20191106130456.6176-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106130456.6176-1-laurent@vivier.eu>
References: <20191106130456.6176-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fmn0GkGUhoRW+ItSR4J23aKZ1sR0YtmytPGBgNf7xAzK4yFXa3p
 5UblQzAHRRnL//CV610/dtH43eQwIPJLamHeW8aJXywGApX62L8uFzUVe2jgxwhFlxUoDtF
 pSJjDSMq6LTzdJ+sXbCxkRhJVhq6t+qmsPEzlvRsX7bkfpLXYOI2dEVLVvfEuFN4oe3//uz
 RKrBcx2X98cavm59/C9iQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JUoqpHlXQuQ=:rjrtQuBSYNvnkj/P7s2r3l
 i7pBr2tCdwVRcq1j0R0n1aiH3QNL1fzM/rIwS/5Jlw9qKnDtC5qviX6QkEft3Eq/zHgzRhIia
 9coCvqN9FtP/ybNIc/f8qdkLno+yRZX8oBirUpXRi4NSdBV1yioM/VvsJyQSKFiMBe4dsBVE7
 4ckgu/8dTZCLZzEtumf5hhxZkkXwmNAsIW9jCz/rA+1ufEqL9nwsuEEuZ8cnT+DfuyXAGI3Dk
 r4Cw6uG5tk+twr9y2vhIAnnax7ZtelayCwXFYAzuBAO98W4QTzoNUbnATwAjBBLh3xoSpdOAi
 Sh5ZdbcbhZxl7DFw+uh4Ui9knRAC3KGpr9M4EfM1UD06ZQCmgS53H+pLiXoFTrgntMW2rAqt/
 dQg04MpZPXCp5w7Vq+Wpe42UZuuggBmUPqZtOa8cWj52gfeXnC8po5iqm+8h1PVVA8udfe/Pf
 Zfg8XUq1kWNIdARC1hUmYVy7T2pBC80KIldLPvK2bptyu0ekvkevuPdG+Q5k11adurS4Oe9+4
 rBHihqZ8217cEPZGk50phRuNPyNtYQavQRRSpopDDD4FcOvH9djz2VCgnMDZa3HbKEXW+ah4O
 6VeGH6/qNgSsI24AQey2RQdlOXG8nAj7aE1YorEPsiv8Ik/imXBoY4EuMrlganAjdZ9YWnSIg
 Pgd5GNzRLMJYRQiT91xyxQ762ikLYe9O1d5p45vugGAxQL/dSBdNo9JBrelTzA2lxS2RyjhYm
 wCrcmNw9uLutRSNRB3GXCVZQ+/Jep6gp1kmkR7f8MH/xG8lsHiL9rKS1DnxWShjcbyTGOEEtU
 erqUdk3AHwfA533SloPqQMRZbTg6AslhmH3eHy0U8kQI6dWjb5WOiPayDXrnO0hCvKVUqGgo1
 ZED3QtbUeecPaA/uCX/Q==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.187
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191106113318.10226-4-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/sparc/cpu.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 778aa8e073c7..ae97c7d9f799 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -13,6 +13,39 @@
 
 /*#define EXCP_INTERRUPT 0x100*/
 
+/* Windowed register indexes.  */
+enum {
+    WREG_O0,
+    WREG_O1,
+    WREG_O2,
+    WREG_O3,
+    WREG_O4,
+    WREG_O5,
+    WREG_O6,
+    WREG_O7,
+
+    WREG_L0,
+    WREG_L1,
+    WREG_L2,
+    WREG_L3,
+    WREG_L4,
+    WREG_L5,
+    WREG_L6,
+    WREG_L7,
+
+    WREG_I0,
+    WREG_I1,
+    WREG_I2,
+    WREG_I3,
+    WREG_I4,
+    WREG_I5,
+    WREG_I6,
+    WREG_I7,
+
+    WREG_SP = WREG_O6,
+    WREG_FP = WREG_I6,
+};
+
 /* trap definitions */
 #ifndef TARGET_SPARC64
 #define TT_TFAULT   0x01
-- 
2.21.0


