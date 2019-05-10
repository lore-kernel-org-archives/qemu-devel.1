Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49550C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3622182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hn0kJtcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3622182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35094 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuPG-0004mn-3a
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:33:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHm-0006Jw-M2
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHl-0001AH-JG
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:18 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHl-00017d-AA
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:17 -0400
Received: by mail-pg1-x542.google.com with SMTP id t187so2111125pgb.13
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=tONOpjcj0FxXSSZHZXrkhjP/KybbzntorN3yULUFX+s=;
	b=Hn0kJtcIGSs8sY/Top0YETZFmIkr6AZJr+Zvn08N4c6b5XAl4b4BnZZfYg5XNg8dvF
	gKMWFE+0Gq/JvtQMhoqehkIs5hzmdPKk0ri28OhD7aAz+1PFj558c/COZwSCz3ZiLRCi
	yllE1d0a7prfOdDO3sdIF97vHAv82Is8K4Mf3G5ciDV7pt6HtMY78jotQ/lHrD5xmgOO
	Mx4QDoXPSC/cSGdgHsERuJyhuwx8OkeQOjQ24ikgu6VwFLb7jGhXUcoIsxe1wBAV7x/D
	5f3ogj3Gr3SfEb/6TclFLRuqgz1FYXgYmWeMeomc5gVOFA09WiW/+I9KBoscYIOA41uL
	iriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=tONOpjcj0FxXSSZHZXrkhjP/KybbzntorN3yULUFX+s=;
	b=FNBuqsCzC2/vY0gyq2MlgXiYlcXwcV9fSNmc5SanoUPNff2eLWcrgH3WGlakA10PMD
	Oqp98E1SwILPDOlvXp5GjWr0nHmFsymcJVPjADhYDm9/QVkKU8b1dvSilM6k+0miiqC6
	TrDEfDBtxmreuVZTRDiXq9E9yLirBM1l5VCIV5fw8elvwdCQhCPMhncO6B8TeAWApCTP
	Foigmm3f6+qBzzSlBX9Vlye0bZITniJ7Fv0REX2/59ZQlpmdCVpLLq1Lmnn2yipuT67E
	/DMS5vF2XKsmg8nvbaEITqzn0PJty0ALlPcHZfDaP6jHorDO3ZPx1LDEmFz6f7d3+lm2
	uHeg==
X-Gm-Message-State: APjAAAU4Jc+7C8p+/DvVstpuhTjD9+kS3I7xdjgIr0wo2kbJERCQ0px3
	f7Wayw6zZe3Z8ATKSIysftG5eplQfUs=
X-Google-Smtp-Source: APXvYqyFKqILXT+HKZhBox+TO8tier+RJmZZTm53UO3kKRFCwBwKSFALVrdbLFeKvfYvXs7qca7gFg==
X-Received: by 2002:a62:6497:: with SMTP id y145mr9981088pfb.255.1557451516085;
	Thu, 09 May 2019 18:25:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:47 -0700
Message-Id: <20190510012458.22706-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v5 13/24] linux-user: Call qcrypto_init if not
 using -seed
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 7e704845c0..e455bff1b7 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -39,6 +39,7 @@
 #include "trace/control.h"
 #include "target_elf.h"
 #include "cpu_loop-common.h"
+#include "crypto/init.h"
 
 char *exec_path;
 
@@ -688,17 +689,27 @@ int main(int argc, char **argv, char **envp)
     if (seed_optarg == NULL) {
         seed_optarg = getenv("QEMU_RAND_SEED");
     }
-    if (seed_optarg != NULL) {
-        unsigned long long seed;
+    {
+        Error *err = NULL;
+        if (seed_optarg != NULL) {
+            unsigned long long seed;
 
-        /* This will go away with the last user of rand(). */
-        if (parse_uint_full(seed_optarg, &seed, 0) != 0) {
-            fprintf(stderr, "Invalid seed number: %s\n", seed_optarg);
-            exit(EXIT_FAILURE);
+            /* This will go away with the last user of rand(). */
+            if (parse_uint_full(seed_optarg, &seed, 0) != 0) {
+                fprintf(stderr, "Invalid seed number: %s\n", seed_optarg);
+                exit(EXIT_FAILURE);
+            }
+            srand(seed);
+
+            qemu_guest_random_seed_main(seed_optarg, &err);
+        } else {
+            /* ??? Assumes qcrypto is only used by qemu_guest_getrandom.  */
+            qcrypto_init(&err);
+        }
+        if (err) {
+            error_reportf_err(err, "cannot initialize crypto: ");
+            exit(1);
         }
-        srand(seed);
-
-        qemu_guest_random_seed_main(seed_optarg, &error_fatal);
     }
 
     target_environ = envlist_to_environ(envlist, NULL);
-- 
2.17.1


