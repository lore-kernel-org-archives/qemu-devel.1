Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752C7C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4324B20673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B04W/QfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4324B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipYnW-0006VQ-VY
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeZ-0001C4-9Q
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeY-0006Kl-2n
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:15 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:54059)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipYeX-0006GE-QI
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:13 -0500
Received: by mail-wm1-x32b.google.com with SMTP id m24so3103382wmc.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 06:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CD2eDWwKcpYYageTmXBZy3Owg02ZhfIpklxfonEbVFg=;
 b=B04W/QfSEe4R8Ue/zKLnU3ErylYxnDd3xkpbi0xc6qX0QqqG6cMlUYuYKHBNPPiz1b
 f5OUuUQmVg8c1FQj1ue7io1oXS+D6ILzbyE5fn7LvoK21uSqo/l0iJB9nEOE/B8SFkGZ
 1CBi+vgQn7Ql+rTRLCtWnlE/V86Y2zxxUz8HY43g/mGotgrWDEU9BgFbRLTLaKrA7Oul
 bJdXVV7mkjcbZXXKd72EzQd2chYDlyF2AMLSQZWuXaTy55GhIYomrhhfcgcWU9v59Zx8
 B6GEl72jxfCXg0ayBzSUaNSvMmkg4XtJf5PNcj+qFcf7XmcLNRJBPLh7l5QBn4VjsX6c
 CrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CD2eDWwKcpYYageTmXBZy3Owg02ZhfIpklxfonEbVFg=;
 b=gUhSbryeb/xihifUWnd0qvcbBQUBkj1KbltJZA6/58QdH7d7/Ru+4+omWPm1iRFxgL
 JkSnhpVWOdMJZx8niplKoDqgl4jHK/r8j+D/QdWcPPnbHFKm65M3w4SMp+aJchA8YoV9
 NcORPjK2ezJpN4PDbfA3orJyx6DzGCteecJ7rBXtPbB26Yhhsc2yi2cvW+QDZgmVJH04
 RolZXVeFP4KL1HhShDqu7MvXM3V7nV33PaMKccH0xclmTRthvdz9jR/fx/SLKR5JZLlw
 dbBoMNw3pg0S4gSddFVoMJIrZhXkIUPV3Hi0acqDm4nPDk73HNQJxqYH686LDiuMKd/L
 40cg==
X-Gm-Message-State: APjAAAV005OwSGvS3oiFB3gREQZed+t7nX5/iRf+TJMGcHOUXN/gyQbW
 U4rrDmkL0Udo8aPQtIFaIioNCw==
X-Google-Smtp-Source: APXvYqxdL2oaLtAtF3cu1WlYxjR27lcN1HTvZW0y/Pkq1P9pNbTWlwz7O3nZQUBUH+wIf1wKUaJiew==
X-Received: by 2002:a05:600c:294:: with SMTP id
 20mr5100079wmk.97.1578579552531; 
 Thu, 09 Jan 2020 06:19:12 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f1sm8888555wrp.93.2020.01.09.06.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 06:19:06 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B92F91FF99;
 Thu,  9 Jan 2020 14:18:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 09/14] target/arm: remove unused EXCP_SEMIHOST leg
Date: Thu,  9 Jan 2020 14:18:53 +0000
Message-Id: <20200109141858.14376-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109141858.14376-1-alex.bennee@linaro.org>
References: <20200109141858.14376-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
 Keith Packard <keithp@keithp.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All semihosting exceptions are dealt with earlier in the common code
so we should never get here.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Keith Packard <keithp@keithp.com>
Tested-by: Keith Packard <keithp@keithp.com>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b6bec42f48e..da22c198006 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8566,12 +8566,6 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     case EXCP_VFIQ:
         addr += 0x100;
         break;
-    case EXCP_SEMIHOST:
-        qemu_log_mask(CPU_LOG_INT,
-                      "...handling as semihosting call 0x%" PRIx64 "\n",
-                      env->xregs[0]);
-        env->xregs[0] = do_arm_semihosting(env);
-        return;
     default:
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
     }
-- 
2.20.1


