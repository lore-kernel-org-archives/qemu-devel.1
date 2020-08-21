Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD30C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18CF020702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdBV2wva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18CF020702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Aw5-0001t0-CC
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Ar6-0001IA-8o; Fri, 21 Aug 2020 13:29:32 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Ar4-0001AU-I5; Fri, 21 Aug 2020 13:29:31 -0400
Received: by mail-wm1-x344.google.com with SMTP id k8so2576007wma.2;
 Fri, 21 Aug 2020 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T3HxLggQDXKqoaLt6TAzlir0cuy+gHIPYF6cAJuIjDs=;
 b=PdBV2wvaScYeh72kjjasn+X9vauoXQeDUGSWRXQOa8x8VmbDlTu4yVSaWyKi2U4Aov
 9W78o93CNRKvrS64s7/qKjuWJT00VWL1tn3TQyPaHC9qltUC2zYWiA+qw06c3HvdlQZ5
 0JLei/B/4Ap9h9AX3fLZSl7sOKXLfNzNzIEHdEU0q51sJ4NR9gAovBXVia2ZfcmUkPTC
 uE1feC8BvX2zpAzFMFKl/uu91DiQEzTQXrNjkKOS1i4ZJVkUCHzmfhhN0WOGGuF4NjnY
 omo7eozIODPHSYYYvmL96iEquGBGbtJE1AHkog9RRVfAav0+SjzH0r4WwiVPzLgXK88M
 VjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=T3HxLggQDXKqoaLt6TAzlir0cuy+gHIPYF6cAJuIjDs=;
 b=XX99aslR+IQEwKCJEp13HWgSjLTi6wam4LkBIMbCootz2Wu+a2vZCzy13UGRBpOiqY
 rGYb8fNhzypX+j7z2O4Jb+uta978viw24SkAqfWJuaGz0oibtrnfpC1rj6M/f7ownkUD
 cs3kc0krlrPbT45Mkko734ELFxDChn5rXNP7yjNrLCYxNRASOtvubAb24IUYSTHFmH7L
 QLWcZ7GSbf9KuocCtBCDCm8faZyD9q4RoO5XODlUygCKc0GrrEV8oMK+UHLGniS5XYCq
 zLF2v7hz2fbWCjlD9r248kMnxEmNkJFXpQVr3pZKqKFg1LckZ3AiSKxAsZKPX/bzOeh1
 YvZw==
X-Gm-Message-State: AOAM5319Z3fbOMgy7u3XsqRIDAAhTmhxpd1K+E+gr2hKB/ZEeSWjBZfc
 URq3VtHVxGrTC8rVKM62ua7G1ZGsk/I=
X-Google-Smtp-Source: ABdhPJwjnzclAwNYU6gSN/1XclNOHTnwD+kEm/fz5ODyaIe6BKsypblGgmoaPD5B0ZyTAJ6Nb2nOiw==
X-Received: by 2002:a1c:80c3:: with SMTP id b186mr4180819wmd.10.1598030968201; 
 Fri, 21 Aug 2020 10:29:28 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm5315471wrn.86.2020.08.21.10.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:29:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/23] hw/sd/pl181: Replace fprintf(stderr,
 "*\n") with error_report()
Date: Fri, 21 Aug 2020 19:28:59 +0200
Message-Id: <20200821172916.1260954-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821172916.1260954-1-f4bug@amsat.org>
References: <20200821172916.1260954-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Alistair Francis <alistair.francis@xilinx.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@xilinx.com>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Message-Id: <488ba8d4c562ea44119de8ea0f385a898bd8fa1e.1513790495.git.alistair.francis@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/pl181.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 2b3776a6a0f..649386ec3d1 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -15,6 +15,7 @@
 #include "hw/sd/sd.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 
 //#define DEBUG_PL181 1
@@ -148,7 +149,7 @@ static void pl181_fifo_push(PL181State *s, uint32_t value)
     int n;
 
     if (s->fifo_len == PL181_FIFO_LEN) {
-        fprintf(stderr, "pl181: FIFO overflow\n");
+        error_report("%s: FIFO overflow", __func__);
         return;
     }
     n = (s->fifo_pos + s->fifo_len) & (PL181_FIFO_LEN - 1);
@@ -162,7 +163,7 @@ static uint32_t pl181_fifo_pop(PL181State *s)
     uint32_t value;
 
     if (s->fifo_len == 0) {
-        fprintf(stderr, "pl181: FIFO underflow\n");
+        error_report("%s: FIFO underflow", __func__);
         return 0;
     }
     value = s->fifo[s->fifo_pos];
-- 
2.26.2


