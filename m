Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039C6C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7BDC20675
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="spOuULvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BDC20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53092 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSXO-0001Jo-0Q
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:36:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSI0-0005gT-PR
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSHy-0007Zc-Q8
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:12 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSHw-0007Vz-RC
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:10 -0400
Received: by mail-pl1-x644.google.com with SMTP id y3so5725575plp.0
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=EslukgOgrXKOg9aqYU0CsDWXr7O+egog9zUh9mSRURk=;
	b=spOuULvmqJdWnGZ+oymBAv8/exyZU1Oz1CqCtk0l1Cjv6ARICQX/FmE+lISMPzTh3T
	GdWzVEKu1aXWInJrjsUqCrYoVAsCDUWn1w8zcjlexDk64VYnAmpUzMWd7PplXPbAYzi8
	EX+CjtHpjMlj36tsdNrtMQcUwn3T1HIT09g6cG0SqabZdyZ75qRBbC2ZolhkSLcniiyP
	jpALldhlfXNOc8yFWpFka4vwYRlo5LZcmVSnScAYOCXZz5QL/EAl370pUg4eHFfq4+Re
	qpVfr8NMFKvY77B4Dieib+Tx0Alk68+Lk53+KV50PBHaP9BjlMpS/fsb3Zihi+Jb/Sq6
	ZaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=EslukgOgrXKOg9aqYU0CsDWXr7O+egog9zUh9mSRURk=;
	b=GTAxNTmnSZwgWRrOEZNy+HmrHLTj202N2ZFVUEe2Dv+8j0fi8KHIupGgGV74NJPwBr
	fsaM7sQTJmt+7nXCr7dUT2pLwtw3rBqlbNvEfkJgutSC08/U/tv2OZoKKnOGkb5LHEM2
	7jmUvBG3tImqrZUrwzYeTklDtRl6I1hiQ4OBz8SX1rT4A7PKnrjK20z95MMKLv+c5eN/
	xJNbn/EBfC99NTSoIRCRzoQkAlGKfgWmoslrx0uABS9uAKUrQ7DKaag7CG34vWlxM93q
	/MPc6VvvOpVOwa1Cadaal9Iiq1HyqThzEVJvVRYy5dZuTHahaT9OEEH3DgMIk78uc79V
	CKAw==
X-Gm-Message-State: APjAAAVu+Sjla2CSQz1+JCOfj0ZSoGtUA/CdA4ftixD6KybCr6zrU4ue
	/aKUEvwbGwSmmXya8MUENtnAWPhqGp0=
X-Google-Smtp-Source: APXvYqxTN5bWSUnvvpcTnivRh7ZWJWJ4vbwtJIVtvJ8Vg1ruiplEbRnWE5msBXSSzQZp4fcnNulEBw==
X-Received: by 2002:a17:902:8609:: with SMTP id
	f9mr15303251plo.252.1558297207346; 
	Sun, 19 May 2019 13:20:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	e14sm18166264pff.60.2019.05.19.13.20.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:20:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:19:49 -0700
Message-Id: <20190519201953.20161-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519201953.20161-1-richard.henderson@linaro.org>
References: <20190519201953.20161-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 09/13] linux-user/sparc: Flush register windows
 before clone/fork/vfork
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As seen as the very first instruction of sys_clone in the kernel.

Ideally this would be done in or before cpu_copy, and not with a
separate explicit test vs the syscall number, but this is a more
minimal solution.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/cpu_loop.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 9e357229c0..0816da6fa1 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -169,6 +169,18 @@ void cpu_loop (CPUSPARCState *env)
         case 0x110:
         case 0x16d:
 #endif
+            /*
+             * Before copying/adjusting registers for parent/child,
+             * flush the register windows to the stack.
+             */
+            switch (env->gregs[1]) {
+            case TARGET_NR_fork:
+            case TARGET_NR_vfork:
+            case TARGET_NR_clone:
+                flush_windows(env);
+                break;
+            }
+
             ret = do_syscall (env, env->gregs[1],
                               env->regwptr[0], env->regwptr[1],
                               env->regwptr[2], env->regwptr[3],
-- 
2.17.1


