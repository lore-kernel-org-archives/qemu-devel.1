Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50164C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D092085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QrqjMzK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D092085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50255 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZq0-000246-9Q
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 11:59:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZjq-0004nI-HP
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZjp-0006HR-90
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQZjp-0006EF-2N
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:09 -0400
Received: by mail-wm1-x341.google.com with SMTP id 7so3349126wmo.2
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=uRA15QcYpp84VA9k9wsWlnaKx7a1xt3gupbkmncewJA=;
	b=QrqjMzK05AStmW3oCrlklHRx6CfYVHGsp13bG9cRguuv9tbuIa/0+nEU4Wty82SXVm
	vjABYWIxmyMSqI4vNNqm9pzZQ/l+qrK7nFBscmVe8vMrrAgU2QdMdJrBX4sLr3T8M+WI
	sC7/HbYny2VpQoNgJC2ONGjdgYd5NabnX2W9msnuj8xqxvJ+SSuC+Mqi1Tnc/8PUwmUL
	nqZiwOtHvCTtNDUO/K1CWh9BdMMvhtv3B5nJDCV6v7qiOl7oF+JMVP8frg5xD2F+lJrj
	wWvriOy4rKg58n4Rjs41XcyiB0V9/aygEC6TIb2bCAS+k7n8M94cL4h78XfKW2Nl5i7B
	rcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=uRA15QcYpp84VA9k9wsWlnaKx7a1xt3gupbkmncewJA=;
	b=R234V+2bAz5cLZx06W0ZGgzLBMY2NErTQPUEfzhskndzZMLPBRGeUN7J+M3yZzFN0l
	qIoAuH9kL+hJCzCqIa+NP72EH8Vur/RAa8lewrEkMuvYvW7Bx0N36d6EJEV5GDJlEyw2
	iBk1gEwSM4IgykSt8cnpTYqxHgvI4SduuM3pLWGUGBDi5hg7GBpxMTphu0tOzs6Hcydu
	aJBEFJ3nX1RrFKuiIvBv5LT89yyluSPe2HCo2qy88kK/8LxkNA/cejMGkRrT2n5hMoL8
	apU8TM6R7Qsgh/1/Fp4KPkzWXcCOo31vARr2tMfjsvDcTbWiEeTWPeuvH8sEswKbeLR0
	0scg==
X-Gm-Message-State: APjAAAWiid5h5kgJW0qkwKNi4essITxAKRGkoV1dZxjFK9bGJMkJrTcV
	kEdsqVOkFsRikZUHmPPHvXxTaA==
X-Google-Smtp-Source: APXvYqzIMfGZkEMzGA1aZWBJfPDCNfjg+5fgth0KdQXAgPy3VHWlgyWrh9u/4RTITIZn0eeexIfoJw==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr19995002wma.130.1557849188006; 
	Tue, 14 May 2019 08:53:08 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	w18sm7054926wru.15.2019.05.14.08.53.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 14 May 2019 08:53:05 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A38941FF96;
	Tue, 14 May 2019 16:53:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 16:52:57 +0100
Message-Id: <20190514155301.16123-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514155301.16123-1-alex.bennee@linaro.org>
References: <20190514155301.16123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [RFC PATCH 07/11] target/arm: add LOG_UNIMP messages
 to arm-semi
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clean-up our unimplemented bits with a proper message.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/arm-semi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 253c66b172a..a3bbef18ef7 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -28,6 +28,7 @@
 #include "cpu.h"
 #include "hw/semihosting/semihost.h"
 #include "hw/semihosting/console.h"
+#include "qemu/log.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 
@@ -366,7 +367,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return len - ret;
         }
     case TARGET_SYS_READC:
-       /* XXX: Read from debug console. Not implemented.  */
+        qemu_log_mask(LOG_UNIMP, "%s: SYS_READC not implemented", __func__);
         return 0;
     case TARGET_SYS_ISTTY:
         GET_ARG(0);
@@ -400,7 +401,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return buf.st_size;
         }
     case TARGET_SYS_TMPNAM:
-        /* XXX: Not implemented.  */
+        qemu_log_mask(LOG_UNIMP, "%s: SYS_TMPNAM not implemented", __func__);
         return -1;
     case TARGET_SYS_REMOVE:
         GET_ARG(0);
-- 
2.20.1


