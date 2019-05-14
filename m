Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F75C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C6720879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVQFqmA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C6720879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54041 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQeWu-0000cM-RO
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 17:00:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeUz-0007pr-OZ
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeIW-0007Fc-36
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:17 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:35271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hQeIV-0007Bz-Fg
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:16 -0400
Received: by mail-lf1-x144.google.com with SMTP id c17so261317lfi.2
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 13:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=6XuVQs+UbdqBAxCFcAT1em7q9SaDATzG83gL/sJvK+Y=;
	b=HVQFqmA4xlQXaLzwLSp4bPZD8cQeF+msCahRfoJdaD/Qi+IvYwqtEqOOiYD5ZQgESE
	QGKdzrLN/uISL9pvNrE96nbdlbrJk8BjccYjtsQDzKLyMOdMStVhPUzzSjORQXNaP6sk
	xwqXi9+bzgt6p3M++O0+75YUjzPXqZGOTV2PCzqayDaw6uhDbRXfLaKf+xpXwWqpLEjV
	PvbWHJmP9Kh93mF8B1SGnteJbVEhnGoEPWTCdsZvnS5rja+JtnkLRrzygeecsTDvlOlQ
	OUfqHnYCisK5x63ak6Sz+6bTIiL+gehccJBhzlk2j3IZT9TjSdajnfDQTyear29Oncx3
	p5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=6XuVQs+UbdqBAxCFcAT1em7q9SaDATzG83gL/sJvK+Y=;
	b=cxe3WCf0S0sxEDBYkoagcR1gZP6w0wzEkJnWPfFoeAZykC9PAQSqpx8GoHOjSqpOeo
	f4hHxAWJLHsVeC5lcGZeVBQFXQpkwEx8ZIHLW9ytZTEJik0l+qMAFZ3plRV95lLnhNq2
	1Rl7M1S92iCzT6C9O9RIEwegkIk+2Gm9PYJgyyIHWNezI98OVRP4wqcqCP1i9Kqk7/55
	kG3mP9i0yUFi3w014AWTT8Tjk8ku1GhKFRvG+oFtD8y6d+0ku3uVO3oBkzv2Pih+427m
	zXThDfQm4lTNyXINOD644b4foSEbf0HhKA1viTmibOH1bw5+01CV7qyBD8OZGl+ScyvG
	uRFg==
X-Gm-Message-State: APjAAAVeBT5XQ1CeHfzk1I8SBDuV6gZp5X9FTspsSpk/HUkbLe1W53sE
	XuFbAHRuhUSTiMBOw4+rMFhtExO/6RQ=
X-Google-Smtp-Source: APXvYqwgaB+XP3GWIHAopJCdjUY/U1ovWNM0GiU3jbX/UUmfdjvKPPQxcjv+D4xWGzqWMlPoKMssgA==
X-Received: by 2002:ac2:41da:: with SMTP id d26mr17719241lfi.34.1557866714106; 
	Tue, 14 May 2019 13:45:14 -0700 (PDT)
Received: from octofox.cadence.com
	(jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
	by smtp.gmail.com with ESMTPSA id 78sm4011lje.81.2019.05.14.13.45.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 13:45:13 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 13:44:41 -0700
Message-Id: <20190514204447.17486-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190514204447.17486-1-jcmvbkbc@gmail.com>
References: <20190514204447.17486-1-jcmvbkbc@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: [Qemu-devel] [PATCH 3/9] target/xtensa: define IDMA and
 gather/scatter IRQ types
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

IDMA and scatter/gather features introduced new IRQ types that
overlay_tool.h need to initialize Xtensa configuration.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h          | 3 +++
 target/xtensa/overlay_tool.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 502d41688365..d4258fcc6199 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -298,6 +298,9 @@ typedef enum {
     INTTYPE_DEBUG,
     INTTYPE_WRITE_ERR,
     INTTYPE_PROFILING,
+    INTTYPE_IDMA_DONE,
+    INTTYPE_IDMA_ERR,
+    INTTYPE_GS_ERR,
     INTTYPE_MAX
 } interrupt_type;
 
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index ea07576bc921..8b380ce5e329 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -200,6 +200,9 @@
 #define XTHAL_INTTYPE_TBD2 INTTYPE_WRITE_ERR
 #define XTHAL_INTTYPE_WRITE_ERROR INTTYPE_WRITE_ERR
 #define XTHAL_INTTYPE_PROFILING INTTYPE_PROFILING
+#define XTHAL_INTTYPE_IDMA_DONE INTTYPE_IDMA_DONE
+#define XTHAL_INTTYPE_IDMA_ERR INTTYPE_IDMA_ERR
+#define XTHAL_INTTYPE_GS_ERR INTTYPE_GS_ERR
 
 
 #define INTERRUPT(i) { \
-- 
2.11.0


