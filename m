Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37C1C04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4E52082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BOI75hOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4E52082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40330 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRT1y-0001Mu-Th
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:55:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmi-0005ZP-Eq
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmh-00029f-G0
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:48 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmh-00028J-9m
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:47 -0400
Received: by mail-pl1-x641.google.com with SMTP id p15so2593311pll.4
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=XXhAPtYvtMlhkNiiH6cZEQQTlmdpOKHdKg1FRFOG4Is=;
	b=BOI75hOI83mVaTjYBpQtAbt3623e2cofIbGotRblCWZrlCjxOpL4XAZKDsGmmMjCk4
	/7loniEAECRCxYjo+MxOBjoOLoxFmQ1RhbCn/VcDfIULdSt1p4q9rRX5clctwd2W0Xlm
	GbOsacI8rL4W3CQlX/oRJZXqJ128f25OnJdAf0o1rpof/B/yHSB7Ss9PQAVvqST2BiXA
	Gp31AoIosmyOD9j4HcXS23VJORSl3/isaRMBcrb+hY0N2i5CGgw/0mQPGMXrthDvTXNZ
	rusrVuMoYqO78sKafYCmuQ13idsS/yB0hpmoQFC4cEZTYipp4zwfQ/jrEvsBbuCtCGox
	mWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=XXhAPtYvtMlhkNiiH6cZEQQTlmdpOKHdKg1FRFOG4Is=;
	b=BVy5bvYFYXBe70pPAPLg7Jy+yd9VPrszIS6INn2Fnf55Nau24heg4JmTckHGNENBUx
	lglWOlLWbrUNRcnoBttu25AN3tD9K/QrcIo97uGBbfNFDABgZlrOOfmfNLGiWvZwTBda
	wOs69Jv/3XrAFwpfkLlxSDoOwqJ92JvpQiS2mkMnKjuP8jVe83wpErrvBpNv2oNabikN
	SO+nuhqQdij7HgXif7j0dJ4DClvp1uiIIHEuCMiUB9nQC4klkxHf2iseFunRjejXbHKn
	sCoUhxkQgSEV3Bj4jcilfT4Dg0olneYckwK47omSkIEr0ScnRwLEsPbeEO4DtRXyyeYd
	wcZQ==
X-Gm-Message-State: APjAAAVbcRUhmx29NLD2nWLZDe1Z1iHKiYRQNU+sYwYx8YopZnkNEOO5
	db7C53IHsDZitL45M33GgKtB9r8Rk9s=
X-Google-Smtp-Source: APXvYqwgt4G/sX24+JtM4U+vMw7NJ3mUPdMleas3Nb7q1TLcGm9FpmEGbg3Oei84uh711tunawAfVg==
X-Received: by 2002:a17:902:bf07:: with SMTP id
	bi7mr16030211plb.248.1558060783066; 
	Thu, 16 May 2019 19:39:43 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:12 -0700
Message-Id: <20190517023924.1686-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v8 13/25] linux-user: Call qcrypto_init if not
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
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


