Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A400EECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7F820673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPEc75TG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7F820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyYb-0001cO-Bn
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyBl-0007hr-7t
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyBk-0007Ci-3z
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:06:57 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42025)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJyBj-0007BK-U5
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:06:56 -0400
Received: by mail-wr1-x444.google.com with SMTP id n14so19163319wrw.9
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 04:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uTKqy+wnCWVLTWShRSYu/D5n/xFvdeK0I9HBQnZtYcw=;
 b=bPEc75TGH5H05SVrt3SlZHujeshZlKXmrmtKV2XMOml93zAQRqqq7Pjs7VW2Pq6Ob7
 MHJZrFRPfHH8chx9Mf7udbaZ369grO8GEXGX02q2SAtlCBXf7i+F/InICx784eCydmmu
 4SyMNTTfWuAONG1ioPmoxCOTghjRdsyFsTgmc9gAnZh60A4MM/NcNdDVmLlDjqJG2bWL
 wmoJ13EpZZesnIswfn1bb4/38wIHn5q2r4Fbfo4ye5Ezpb6YpT2Z5esSc5PMYpA3urFV
 /dZNk1jbxpOFNX4wEXVHywJHxG41zhYCZoRWI3ErA3JdZN2c0ZrKjVh18hYJu/wGGDza
 BcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uTKqy+wnCWVLTWShRSYu/D5n/xFvdeK0I9HBQnZtYcw=;
 b=Asmnj8kpHK3lqu9U9Jw64HwLRBZ8V2hITk9pPoKLAYWZD2u7OP2GYv8WjSxoNbtkl3
 H8MBLRw4/EpFb3BvWl0gbn8D4tBb3bkUrIY2SidRMeJJto1ustyl0eWJA2E1qruTcQuU
 hSGSK3Nfiv8Mc5xOad0IxtHZk90dWHLVRDXI8SsjL6tWCB/Zvj6bIE9PzMbtXZ61Psj/
 semUccUDB0gifs9k9jxC7/r92WM0s14a6bB0fd6raRnHQULyd+LBR+bHCl7YMwjFQLjY
 R9g7+WBao3FI2vkOTLDegxt7+7yG5xiuAv1hG6LVx9xv/fgpNLtLyvuyvpVUjmZ7oTpL
 ju0Q==
X-Gm-Message-State: APjAAAWYjF7P/7PUiG6IkSF0wIrjNTfzOs5MtAyXaJS5NT5Ye9QIkH+b
 rFsFpFvVVOapDMYDHB85QS8kRg==
X-Google-Smtp-Source: APXvYqxPKa9e7/Hp9L02uJucDnn/n4sfQQZWDAP4sbUnDSP2dtPbDX/t+UK9sWAj7GFJQK3pIgGNcg==
X-Received: by 2002:adf:ec84:: with SMTP id z4mr25286908wrn.254.1571051214828; 
 Mon, 14 Oct 2019 04:06:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z189sm32394786wmc.25.2019.10.14.04.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 04:06:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A44511FF90;
 Mon, 14 Oct 2019 11:49:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 19/55] *-user: notify plugin of exit
Date: Mon, 14 Oct 2019 11:49:12 +0100
Message-Id: <20191014104948.4291-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: robert.foley@futurewei.com, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
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
index 1ee6195d9f..84a983a9a1 100644
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
index bdda720553..a362ef67d2 100644
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


