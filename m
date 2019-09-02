Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8165CC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AEEF217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZhsEyGI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEEF217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4jUS-0005x8-Th
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 06:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSh-0004dE-2M
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSf-0004FN-U3
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:26 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i4jSf-0004EW-MG
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:25 -0400
Received: by mail-wm1-x335.google.com with SMTP id k2so12496633wmj.4
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LerAiTk+RHTNAwomwqqVsvMK0Yfd9IxxuCZGECaCdYo=;
 b=ZhsEyGI5NhReaA1qVILVR1iil7nhfx2NSzpzTnimcgJbrMQ3dBEYnv4wvbwZPzLEXk
 zywro4zM2eDoYUpJiVMAoKFEMKrUoebOeVdMBPwQKfZqfFtpWkPD+Ktqb21bUO2sbbR6
 /i2EXF87BjwuEMqHUognfBb8dhBRTs1tdUC9dseQqPxc9GWzVHLb39gyVJQzOdFNP5SU
 6Q7gWf+M743d521hiQdRzbkY6oL+6zvNvJDxGQaQtUDGVr29szniDqU9d5ZwDa3B7TCi
 1jJFUZIihX8xKR1V3SYR2vlAIM1cKSrQv9Qzcp859/FZife1MECgHy7bTs1TtZgKhD17
 jZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LerAiTk+RHTNAwomwqqVsvMK0Yfd9IxxuCZGECaCdYo=;
 b=g9D01JYIeoME3O2p5fQRA9czDN4JFQb5nO+043TMYPUaGDKhgwIfx04DOa30Eo8keM
 ud2BErHV+e1TjN7Lx1Rr9kFK5CC/Un2unM5C2jdE3F+CM5fIYSM7XOZXpadIvVXB0VZX
 zhWTV6P3+g/FCdVKRWhOYlEqmCq6fZEY2LvaLrKOdQpe0oZVSVCFL3JiRwaDFHo2rLPk
 3o9M4Mbl3MJ9kmftYVp1SEghbng/ld4qWRORYhHn1Utzfnkdxq7/gjrysyPXWuVnOTMZ
 luWEUUj4g2KkkrQaArv0/ePLo9rmE5hNOwzEGPIGQIa+ggt6Id/0Xjw2npEYLpcvRH/k
 WgMA==
X-Gm-Message-State: APjAAAXkrwycsB5SqrQEMVD6q/S64spCxLmRRHpAPFkk6+FUtukyeEQ7
 o81CcOwA3Td8BNafNUVfNS6z/CBVkyw=
X-Google-Smtp-Source: APXvYqwwg3+ZxalXXOvfCpUhLXGm7l0g4LPVyoDewMelomOeMsmhgDXcreECmz+D1Epu6hoQ2F6bfQ==
X-Received: by 2002:a1c:6a0b:: with SMTP id f11mr32436446wmc.87.1567419683475; 
 Mon, 02 Sep 2019 03:21:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g26sm11849821wmh.32.2019.09.02.03.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 03:21:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 51E271FF8C;
 Mon,  2 Sep 2019 11:21:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon,  2 Sep 2019 11:21:11 +0100
Message-Id: <20190902102122.1128-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902102122.1128-1-alex.bennee@linaro.org>
References: <20190902102122.1128-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: [Qemu-devel] [PULL 01/12] gdbstub: Fix handling of '!' packet with
 new infra
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Ramiro Polla <ramiro.polla@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ramiro Polla <ramiro.polla@gmail.com>

Since the '!' packet is not handled by the new infrastructure,
gdb_handle_packet() would call run_cmd_parser() with a NULL cmd_parser
value, which would lead to an unsupported packet ("$#00") being sent,
which could confuse the gdb client.

This also has a side-effect of speeding up the initial connection with
gdb.

Fixes: 3e2c12615b52 ("gdbstub: Implement deatch (D pkt) with new infra")
Signed-off-by: Ramiro Polla <ramiro.polla@gmail.com>
Message-Id: <20190805190901.14072-1-ramiro.polla@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub.c b/gdbstub.c
index b92ba59e4df..5c067594bae 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2588,7 +2588,9 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         break;
     }
 
-    run_cmd_parser(s, line_buf, cmd_parser);
+    if (cmd_parser) {
+        run_cmd_parser(s, line_buf, cmd_parser);
+    }
 
     return RS_IDLE;
 }
-- 
2.20.1


