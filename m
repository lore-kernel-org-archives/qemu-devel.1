Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36C6C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0832208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZmHeP/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0832208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59962 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYnL-0000Sf-Tt
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 05:53:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk7-0006EX-OU
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk5-00006e-PJ
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:02 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYk5-0008WM-2B
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:01 -0400
Received: by mail-wr1-x42b.google.com with SMTP id x4so357116wrt.6
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=WaPXaKJ84KPnf9Vac7fR8yciWXTzgsdE11wI7irhktI=;
	b=WZmHeP/+ejRZURE+yRjhCqwLn9ZB6wcW+5BLNBCUOsGmgoa6Iii0bvzPPxtqb5ECgu
	8jGw0c3TVWU/4XKxtBL3Hy1myCe/oQ59r/glro1BSivgQQNb0g9P99U3AnaDHR9YaklU
	xiGR33uMLQzwPioJTACmFYLaQSl9iXS+WpcmE2i7XI9XB7BdfJ88wcN72yY09AHAgAHI
	C76nGKksMldgGoaJqBhNZaWF+bmwQ7Gtb3sBjAA0y3bw0tsaz7w0JHd0PpQkuXgmyVYq
	rkjLcCn/An3jFbBDxW7n2rJIrkkiiYjbaBiE8QyCkj/yq0V/rGNtDWU19dXPBUfab4eB
	skdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=WaPXaKJ84KPnf9Vac7fR8yciWXTzgsdE11wI7irhktI=;
	b=MrIb5henlwN/6jt1pJt77NmZZYBfCcgTPFpzx0/Zhc9sASxfnbCFScrQ/1Xjs0VerK
	p354CP6Dyh+eKz/IqhJ9/r+bH3CdV1g0Q39WAJxGWv1d8C3pUtFWPFqpVXqyeIvLtPij
	0MprEvx2D95ZT7xMT7uieWaM0wz7kAV7hk/7m3WJBtyvm8N8QSO8nSd3B+6AhCcmlUd/
	UQQ7503CxrDIB1ntQPWb1lXvHBdls/HzLgKv5f5b3bZkMogN2+bhcoXJuiYhwqKOdAEe
	FU+Z2pYC7yjbDzb/LOsKBiQDupNV5a0RUmKzn4MHkFYUTeepBu9oOTLfg3ydJGf3j/h+
	lIAQ==
X-Gm-Message-State: APjAAAXo7QiMnKdY4NbBE54lOWmVOqh4IlEjBVBhuMJ7mQE5KMeR7uk8
	JN3/xQAxVKts1ERn0fkWycLAeQ==
X-Google-Smtp-Source: APXvYqxJ9+hw5wpsa0m54Thl26suBb6OzcBWwzEzmdej/xhIMqNaL2m/DkaBUJH8JZ4FsUO0+9zetA==
X-Received: by 2002:adf:df87:: with SMTP id z7mr16559399wrl.8.1559036999970;
	Tue, 28 May 2019 02:49:59 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id w2sm7298995wru.16.2019.05.28.02.49.55
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:49:56 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 16BC41FF96;
	Tue, 28 May 2019 10:49:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:32 +0100
Message-Id: <20190528094953.14898-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PULL 07/28] target/arm: add LOG_UNIMP messages to
 arm-semi
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, "open list:ARM" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clean-up our unimplemented bits with a proper message.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 384b01124e1..86e6ec48c2f 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -28,6 +28,7 @@
 #include "cpu.h"
 #include "hw/semihosting/semihost.h"
 #include "hw/semihosting/console.h"
+#include "qemu/log.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 
@@ -363,7 +364,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return len - ret;
         }
     case TARGET_SYS_READC:
-       /* XXX: Read from debug console. Not implemented.  */
+        qemu_log_mask(LOG_UNIMP, "%s: SYS_READC not implemented", __func__);
         return 0;
     case TARGET_SYS_ISTTY:
         GET_ARG(0);
@@ -397,7 +398,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
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


