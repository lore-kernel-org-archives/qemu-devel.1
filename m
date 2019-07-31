Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD8EC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC603205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTtbi57v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC603205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrR0-0007Ny-7L
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45176)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPm-0004yB-9B
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPl-0000Ll-4K
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrPk-0000L4-Ty
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2so60370227wmg.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ebMkUd6CcShKU9UYDJ7SLcVLe6tn+eNZsn2v2BV3RF0=;
 b=jTtbi57v2A9AIQS1kwDrZxUWLHa+PX9hwXrvh4s268kWwUsfpsNbiMl45yfQMKqrok
 lPBsP97ihEjpbR/Gxog0y3J9lEAZoLauEmy+XMFlVaOfjtVn4FkOBU1WITQbClPiHl1D
 mxdN2cPJiOeVO4izcsP7GcOpNaMySkn3U8Vsydl8EWaZGRYe2XtWVdwItsTYMJ32wP8I
 J2v6MwtmynyNHNFti3JV3Jv4M8vVy9XDXGynwiF2kZm+VZWPwFVanrH9eh1u1XTEKsEe
 /8y2I99gqfm1tjEyGij+0HgbrQVA7aV282Nc2W3wE16G1xU0hBUZF7jRE2Ap7gt/LXdh
 64Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ebMkUd6CcShKU9UYDJ7SLcVLe6tn+eNZsn2v2BV3RF0=;
 b=O8/OI2xBv+UMe/qEMhd3H02/wc/nR85f5Uq478sVVCXBk1CJAFsi6bPlsKjD8QrCpd
 sl4SU6T91gp1lH0/eXUXkyheC/Ydk3E9GJOD34ZKHmkRTejtYcBEKBEI8FZ75dtIh/R6
 ZUoiH89rOejz3kugn0DtJtlR7FjCADlNT3+gp6KDEZeXy1iRF5OmyXw/2y/cskdvC6fa
 QMVPLjKbdPFyF92OXf6ZeseAsxTNpON2+ExSDstf/JTN5dDSeJX1q3m5O4d4ibL/pMwQ
 uPUQ4pU6TrzeA1U6Ix4roRHjFvyqNHO9poCaI0G1WAgeejDy0BBChrc18qGdCgDZAkht
 h44g==
X-Gm-Message-State: APjAAAW4QBMDZsQXnTsCvHqYDq4JHYIPPVI75D5eHOgoFOcR+ss1ji41
 N93EDeUCaiuwlZTJ4lJpg7DD+g==
X-Google-Smtp-Source: APXvYqza7P4XH/IdvKaXaY1OkCjWG8fNN1Y9IdGKi5c8CeKLzp9hvYuwFTGfFyHjEExmV8uxTqERLQ==
X-Received: by 2002:a1c:345:: with SMTP id 66mr113107626wmd.8.1564590319865;
 Wed, 31 Jul 2019 09:25:19 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v15sm65510695wrt.25.2019.07.31.09.25.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:25:16 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EFE1A1FFAE;
 Wed, 31 Jul 2019 17:07:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:51 +0100
Message-Id: <20190731160719.11396-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH  v4 26/54] *-user: notify plugin of exit
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, aaron@os.amperecomputing.com,
 cota@braap.org, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 bsd-user/syscall.c | 3 +++
 linux-user/exit.c  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
index 1ee6195d9ff..84a983a9a12 100644
--- a/bsd-user/syscall.c
+++ b/bsd-user/syscall.c
@@ -332,6 +332,7 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        qemu_plugin_atexit_cb();
         /* XXX: should free thread stack and CPU env */
         _exit(arg1);
         ret = 0; /* avoid warning */
@@ -430,6 +431,7 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, abi_long arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        qemu_plugin_atexit_cb();
         /* XXX: should free thread stack and CPU env */
         _exit(arg1);
         ret = 0; /* avoid warning */
@@ -505,6 +507,7 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, abi_long arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        qemu_plugin_atexit_cb();
         /* XXX: should free thread stack and CPU env */
         _exit(arg1);
         ret = 0; /* avoid warning */
diff --git a/linux-user/exit.c b/linux-user/exit.c
index bdda7205532..a362ef67d2c 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -35,4 +35,5 @@ void preexit_cleanup(CPUArchState *env, int code)
         __gcov_dump();
 #endif
         gdb_exit(env, code);
+        qemu_plugin_atexit_cb();
 }
-- 
2.20.1


