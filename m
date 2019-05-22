Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1264EC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E7420862
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvoJpqts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E7420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWXH-00007W-Tt
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:04:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOp-0008Ln-6q
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWCJ-00086w-TM
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:45 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:38879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWCJ-00086K-P4
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:43 -0400
Received: by mail-yb1-xb41.google.com with SMTP id x7so1256969ybg.5
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=XXhAPtYvtMlhkNiiH6cZEQQTlmdpOKHdKg1FRFOG4Is=;
	b=dvoJpqtsvIHw/G5jCKu4zDmr94LIm25PGcgVGME+GVWJJwUFHZbmE0WZVi5vWE2hJr
	bJMpWvPhU+X1OBBmyx4dL0/kONrpGaHE4IpoQDC5DzVAB8Q7MVOOXRSPLNUtIGoPIS9x
	2TdKAdFxIFt2hySoIodgi3W5s+3ce3tb5GZJhXAz2eQG9+l6VPzF07sFnzxpZUC9TVQx
	upow7mqruQfrvfcO/+DEfUEvxSJTjNbsFQV5r3+uZFvLSM2cgWWwmdiwt46bvXHDByeY
	zEd6WRFBcig6J/8REHZ6ksDHji0r/8aiKS5ZQuVkfNi9uNXRvThGIyAxhHe4oqv/Hmsg
	r1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=XXhAPtYvtMlhkNiiH6cZEQQTlmdpOKHdKg1FRFOG4Is=;
	b=D4eoxiDKNauOcUyDouDupJ9Us3rtzaCeJTYvqG0BIRwjFFl4hMMMijhRQC9yfsWJ7M
	OwYncX+aCroE2P2fMcxTJmF+OcMcP8nnUb8FV8/GTsiLDHLqM036G4veiPuxJIwFZSOq
	leanezmPvnIBauqJfkTL0yBmwRHTaMaEniQBw1yYmSIOyKFLg8niZwenI2JmkG95e65S
	OhQFlkTXM4OkOAWEqdQUtRjNnuWlNb3ZTIbkTWcOC2xRwiEDHwsn3BJL6kMTuKZPH3sp
	m+wYnbPZHQ/+DkuOHEKsiWTpstosTmgV5SfmXyLt3cdpBQn1/LeoFi+uLhYWZFkfYoCZ
	AxDg==
X-Gm-Message-State: APjAAAUQIv8gaZf10lUpC3wZljasMqxYVVRKOyHqPHsRwk7awAPhX+o/
	6jKCXhG/lfblyPTh1W1/EtEW0SNDOj8=
X-Google-Smtp-Source: APXvYqwDnvVQ8bYX3BVr59Ijkh8x2sBt36x4cnLkMHSGWkueUq+OcZJhjIqmLpRq1c3a2UOTk82HyQ==
X-Received: by 2002:a25:8109:: with SMTP id o9mr11702248ybk.132.1558550562385; 
	Wed, 22 May 2019 11:42:42 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:14 -0400
Message-Id: <20190522184226.17871-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [PULL 13/25] linux-user: Call qcrypto_init if not
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When not using -seed, we will use the crypto subsystem
for random numbers.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 7e704845c0..66c909a1a6 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -39,6 +39,7 @@
 #include "trace/control.h"
 #include "target_elf.h"
 #include "cpu_loop-common.h"
+#include "crypto/init.h"
 
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


