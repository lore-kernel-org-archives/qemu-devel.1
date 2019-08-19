Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC787C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68D120851
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSi+7gsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68D120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhC7-0007js-6s
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgbG-000385-Iq
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgbE-0007Eb-CL
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:26 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:39382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hzgbE-0007B3-3o
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:24 -0400
Received: by mail-wr1-x42d.google.com with SMTP id t16so8481996wra.6
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 05:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5KWGpM2yFitmukAYRZPxrR2ZBIZTL/Or6P8Yp0GX2SU=;
 b=sSi+7gsKqtKPpyTyOFyo8hmsuPAruLqIR+noqR8QEaYN4LSeq8GhoVlEfebZ77AHO6
 NjI3W+comt9NigoZffxDP31PPok368ujseNULyvvy5GBKY5XH6rb4QCU5D9mDDJgIajc
 atEM07UgjUYlP0q5q0diPh6qI0QA+tNodGTaCe6JrxZc+tBeeMHvPjxG8ZHrsNqQ929O
 /jfl0Atn7C38oeIITbb6m6qwAm97+Wqpy0GyRkFkpv/E5ZGHrXiHd2htXex4Jb39Y5SJ
 K/r5GOo6R9MStPgt4AwlkzQfRgIxV9Wt8bSv5iXPTTKSZkxTNz5IMPeHW7QWgHqnakGy
 c9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5KWGpM2yFitmukAYRZPxrR2ZBIZTL/Or6P8Yp0GX2SU=;
 b=BlFRJukn54fuAoFi0Oi4ytOou7uvUUv+5MEjUQkN30HR034eRZobUu3p3qgRcHkXzR
 xQvi9e+6pKWhaBtG8J45K3ZwRFyIVi5xQrTLK2RaQi7tqN2wRwsiBBr6R6zEt1L6lpjZ
 cFouFkyQld0z5Tyu3tmVHEN3x+TKLn7+D4Q6PJYr9OLembet0Gbdr92F2K6pvqAt5L84
 vEa6yQpaV3KtXR2DHBzo9UW0Bo9mjAbWepd6dl4RCklcryOPp3l7Ma+H3TST0YDgm5j2
 HDywVPmpaXKFTWfroViJ7aze1PtolxsEiRVaTn7Wejiev+kHUZLFjk0VYB+7HnTgPrR/
 yEcw==
X-Gm-Message-State: APjAAAUMvpGu6iYxTCN7FcII8Giv/51aPzzUDS1OQGQNgC4e6lR8sJd7
 g1SM4o2GflVYyj20KOjOFjn0Tw==
X-Google-Smtp-Source: APXvYqwEy7hadn4nFPQBjIACGWP7GLdFGRt5iUGa5E6Eeg6xe+c8cfVHSfRnAiFteYih+XAW6xV4vg==
X-Received: by 2002:adf:d187:: with SMTP id v7mr17120942wrc.33.1566217038428; 
 Mon, 19 Aug 2019 05:17:18 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t13sm15361389wrr.0.2019.08.19.05.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 05:17:15 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DE19B1FF9B;
 Mon, 19 Aug 2019 13:17:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 19 Aug 2019 13:17:08 +0100
Message-Id: <20190819121709.31597-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190819121709.31597-1-alex.bennee@linaro.org>
References: <20190819121709.31597-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PULL 11/12] target/riscv: rationalise softfloat
 includes
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should avoid including the whole of softfloat headers in cpu.h and
explicitly include it only where we will be calling softfloat
functions. We can use the -types.h and -helpers.h in cpu.h for the few
bits that are global.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Palmer Dabbelt <palmer@sifive.com>

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f8d07bd20ad..6d52f97d7c3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -27,6 +27,7 @@
 #include "qemu/error-report.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "fpu/softfloat-helpers.h"
 
 /* RISC-V CPU definitions */
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0adb307f329..240b31e2ebb 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -22,7 +22,7 @@
 
 #include "qom/cpu.h"
 #include "exec/cpu-defs.h"
-#include "fpu/softfloat.h"
+#include "fpu/softfloat-types.h"
 
 #define TCG_GUEST_DEFAULT_MO 0
 
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index b4f818a6465..0b79562a690 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "fpu/softfloat.h"
 
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
 {
-- 
2.20.1


