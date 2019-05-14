Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA48C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4617020873
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IlFGJF3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4617020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53004 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQd39-0000Wz-E3
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:25:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvJ-0002Wz-Lw
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvI-0006tu-Oz
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:13 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcvI-0006t6-JG
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:12 -0400
Received: by mail-pl1-x643.google.com with SMTP id r18so59356pls.13
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=bfHw/AF++9CIdfuqFxIkDwoY841o6ilZtdRCC2o4SUw=;
	b=IlFGJF3SuvPZpd2kbuEV+UtXwl1IWbTNWyUv62+k/g3kkbM8ML1HEH2MD+7xuqElPH
	oNsASmfjTCPtVn+MXD1Iy+HDwUmhX5L2KY45qXgpgIob+HXKTyU9vIpao1LUWWrPwBTQ
	M6TFz63lEed/f5qop86lfiU+7H9azglnYhguYOknSS7LuOSWKUZnEK61dkRhCK/ZY/XF
	AB11SKS8UhSA4HMAl9bZyTb3hS/P2AJBEWW4cdOSaMMvj6bneq/NyThIVoDnPipUv7rq
	xwUrfsMoFEBaFFourdIXkw6vdGFk8/NNQmIgqtsDEX9s4RXKJoHkrEDGiZjz/eWCZRGB
	4tTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=bfHw/AF++9CIdfuqFxIkDwoY841o6ilZtdRCC2o4SUw=;
	b=VYmOCn+dvu4AqYEbvEwf1+FSWcRM+0uVoc1qjJOmGQVMCXmPNBiA7bD6ze1HjGE8bi
	IbtL/jjxCME2qnE27J+QZ2apk7zxLQCLxCWbXYr2CxFCTo9kRuMchjWVdBdbOTh1cEqz
	dpl4TODq0QjdS6/MFsa6G7ysDpKuB218pzI/noqJdb4nkxendP0KKlTBNMyBso1mm/gE
	iUoKoeDTfMvViFym4WYpBSWYqkuvi5faVDEkiCqUJPMRDDs/Qncs6Q9E2ESwvUfWGoDQ
	1FEakH434qeiitdO5xGS8Y1FiCqaFbn5ivUukCgA0c+iWERVxSjDc3dulWPi6nvWsSRI
	XguQ==
X-Gm-Message-State: APjAAAU5zCyA0oIgYAOHdl1XNNPa/pII5g+dzwB1+4rgIL1v86XmHWup
	/APU2UcFCgn/YY3aIB6UacAJX4pKnWg=
X-Google-Smtp-Source: APXvYqzPnCA6ZpPQSOTWE2yiVVL7QRt3TzeWNdAuH10EN7apkeHAchfOT4C/r+kSP8WceXOQNSTHsg==
X-Received: by 2002:a17:902:1ea:: with SMTP id
	b97mr13615843plb.317.1557861431367; 
	Tue, 14 May 2019 12:17:11 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.17.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:17:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:41 -0700
Message-Id: <20190514191653.31488-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v7 12/24] linux-user: Call qcrypto_random_init
 if not using -seed
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When not using -seed, we will use the random part of the crypto
subsystem.  For softmmu, we initialize the full qcrypto_init,
because we use crypto for reasons other than random numbers.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 7e704845c0..4c72f07555 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -39,6 +39,7 @@
 #include "trace/control.h"
 #include "target_elf.h"
 #include "cpu_loop-common.h"
+#include "crypto/random.h"
 
 char *exec_path;
 
@@ -688,17 +689,26 @@ int main(int argc, char **argv, char **envp)
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
+            qcrypto_random_init(&err);
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


