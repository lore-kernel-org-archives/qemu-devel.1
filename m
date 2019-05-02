Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96970C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A182075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJUKcMzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A182075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48265 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM84P-00027p-KX
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 05:32:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hM83F-0001eA-Q4
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hM82u-0002CA-LJ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:30:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hM82j-0008MA-FG
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:30:22 -0400
Received: by mail-wr1-x441.google.com with SMTP id e28so2362489wra.0
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 02:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=T90yMf4Uw+rh8WoiHNWPGToWmRXp8q4oIT22E4IxyoI=;
	b=QJUKcMzPI4tzAprkmXxKCd5wXIro8pLxip7gP4BUh2qSOBiCBf+ZGgGtLcAapooHPp
	FV9yHuvMwY005oqqbUQBwy0n53RkNiHM6VuS2SlKF0cErvp4JZlhTGOhaC4T63izWiaT
	vY8UzQIDFa5O1aC3VrWiMhnbfjLSIFU7qZceV+j+6AjLVOfRoDRPD8I2Uy08Sj0KadJF
	Q9wWX1GGiYnh6CRybE8NOdpPp/OOwksfjA8c5N04l7fMP8RaD7eqPOhB9TU9YCBjb/KT
	rI3wwvtzDm5E6mim3J+Bn9Lsr2vSnasB6qWmkPsnUU+EsVHsPFmjac5wYigSLCnbB6bP
	T3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=T90yMf4Uw+rh8WoiHNWPGToWmRXp8q4oIT22E4IxyoI=;
	b=qa8KrS6/n/LNVUmU/Anv1Msp1+ZYv9tyt0iJ+Q/s3Af5AyX7v6gbI7x2xzoUf+Nnta
	AQAXVB6xsvLvNJEVwZqDfVkAeRBLMr2iAvfhfEqwGoa7JYXoQDWH/hKhcbDWh1MPIy7E
	PhWEjPdZcywMBZUJV4KJCLizvhcObtlvN02HQALdaN73uVXnjGpTNX7duQThSGDbm9we
	b0IYcHzDqRzTTh29T6FqZL/i/hWt070h0jd+1waU+34Ft3wBezWioCoQzaq5yBCdatWH
	EBZQ4piVBp5ioUPb0jCvCuntZgHHAPBrDKyuUviEyhm5pCAnZqkclc7/KmJYsL/nsO+7
	oWTA==
X-Gm-Message-State: APjAAAVNh7cRvH30/wFA4bMjIRGjLUszh5i3wyU/71w1gxVCy3QKERYa
	yjiiB4iGQHosa98zwmWOmJKRpw==
X-Google-Smtp-Source: APXvYqwEduqQAgCVK/WF0MS9Xg7boud+hcW1vIyisoEuvablFTottNHjOeni6ruXRvolqBeSOrp0Qg==
X-Received: by 2002:a5d:480e:: with SMTP id l14mr1996758wrq.301.1556789266653; 
	Thu, 02 May 2019 02:27:46 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	v17sm5795164wmc.30.2019.05.02.02.27.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 02:27:46 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A3CB21FF87;
	Thu,  2 May 2019 10:27:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:27:28 +0100
Message-Id: <20190502092728.32727-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH] linux-user: fix GPROF build failure
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502092728.iNRad-lXHZ48Kp5VznPIT4XxVy8CYaunHe7Xp35vpk8@z>

When linux-user/exit was introduced we failed to move the gprof
include at the same time. The CI didn't notice because it only builds
system emulation. Fix it for those that still find gprof useful.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/exit.c    | 3 +++
 linux-user/syscall.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/exit.c b/linux-user/exit.c
index 14e94e28fa..bdda720553 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -18,6 +18,9 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
+#ifdef TARGET_GPROF
+#include <sys/gmon.h>
+#endif
 
 #ifdef CONFIG_GCOV
 extern void __gcov_dump(void);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 96cd4bf86d..f2d9883aef 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -59,9 +59,6 @@
 #ifdef CONFIG_TIMERFD
 #include <sys/timerfd.h>
 #endif
-#ifdef TARGET_GPROF
-#include <sys/gmon.h>
-#endif
 #ifdef CONFIG_EVENTFD
 #include <sys/eventfd.h>
 #endif
-- 
2.20.1


