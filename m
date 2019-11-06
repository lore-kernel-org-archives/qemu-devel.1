Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5727C5DF66
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DE52187F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DE52187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSL2a-0006KK-Jg
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSKzt-0003RI-0I
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSKzr-0002w2-W8
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:16 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:51249)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSKzr-0002vJ-MU
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:15 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MN5W9-1iC2X609bh-00J61A; Wed, 06 Nov 2019 14:05:13 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 08/13] linux-user/sparc: Fix WREG usage in setup_frame
Date: Wed,  6 Nov 2019 14:04:51 +0100
Message-Id: <20191106130456.6176-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106130456.6176-1-laurent@vivier.eu>
References: <20191106130456.6176-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5CWl4CeXq73bml5Cudzed/f+InEB0sO39/04UZjbit9IkB9Wz4N
 3/ZwMpqv5qhLHOJ+PMxGuQNTiNBg6MPuA0cn0+gEXB/ttWTQgfiIi/MLYMC1EO5BKv0VYI5
 whk74Js2hdkRhB1onb5HkBvBFJHwIC4dwV0JxUncKoq3k5sNQRDUzFsaC6hE8wgLHgMnhGZ
 lzq+SfcihrYsWSAD9/jMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HGfjWumgTG0=:BhHS6X4HZSHpmw4nV6bSvZ
 dHZWFiYj7os4E4iIkAyLvARZSEjg5Y6Nv4qlg/b+UqnjPv3ndoXLe+TTGGkfuAOm8v2hy2kzT
 /H4wWC5Pem5Rkn9h9JQEu2mxdzDQBf87JondP0ZodXEXqTPyj03jeymk+T2Zlhkox9YznznhR
 IOpqE9QxlEbIYX4pcA5tXBxC30US5ADKYuQq8qgYxggfPI0h0l/TyL7gXTNZhsTBz8H+i1+Nb
 JoCae/gPhiG5O1fqBmbPdEVvTOR6Tm7ElzKnOsHwVZIf3j0cTNOPVZCyzz88AP3WPmfh8cwZM
 Q7/2P19cRpB3doCjIOXfFjFTVB828oLXVW+IVd2CoKwgjiGOlQi2U6Zi6k/phgxw4/kTMzher
 2aPEyERY2l7/rVbq1ZrWZE3j4nK36r7RgDkGcTSbNdrKV7Z4nEPFtTq2JlWR3R2e0SJTS9yFw
 v1+D5TGnm4uQN0b2oRohAZJvQs0d7W4N/qNsWZWouGTAuECP6+mE5HEheEJo4WPdSqukaIT3x
 IxhbfprcDmsL3PBaU0FXngdh19YYxD4hNky9OvTsOCNBV26JEYcwcQNZwA8m5+A2/ftUPFku6
 UliUNAboWbIgP4T8QQsrhGE2ArzIHHiTxzuxvFBYB7y+Ayf9rQ8c27kB6kjmxOMm7Pp9pxGH/
 OHnPVO/4PURXrLmA4e0wpC30SCJVIjp8iDFy66w6rVx6ufThD9slLrhPN7UBipRGwGKmamnqq
 2EmX35PUw2RY5j0VuScGWE8c76EJjK7udwUZ8krQTjq43q0peAQf1v+Ad8pv7iXE6WgkpV0zY
 eOV5/28EokUVbR1JCy/UX54wvAnhjRDjSzpbiMDnwFu2HXg6QV1fsQPWGlvRPd1epBWStVIxQ
 Ocqad7sznpRCRRCH0I4w==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

Use WREG_I0 not WREG_O0 in order to properly save the "ins".
The "outs" were saved separately in setup___siginfo.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191106113318.10226-8-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sparc/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index e05693f20432..238d0ba00c89 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -192,7 +192,7 @@ void setup_frame(int sig, struct target_sigaction *ka,
         __put_user(env->regwptr[i + WREG_L0], &sf->ss.locals[i]);
     }
     for (i = 0; i < 8; i++) {
-        __put_user(env->regwptr[i + WREG_O0], &sf->ss.ins[i]);
+        __put_user(env->regwptr[i + WREG_I0], &sf->ss.ins[i]);
     }
     if (err)
         goto sigsegv;
-- 
2.21.0


