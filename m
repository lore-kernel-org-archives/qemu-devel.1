Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A616CC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:16:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B032168B
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPQwt2Vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B032168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLJi-0001MT-1O
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFS-0004VW-Ka
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:11:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFR-0004mB-LH
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:11:54 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLFR-0004i9-Fj
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:11:53 -0500
Received: by mail-pj1-x1043.google.com with SMTP id d5so6297786pjz.5
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mulTmRahmIOLlqTACfJOIL2mZII2b44d4f9C0tQdiJE=;
 b=TPQwt2Vvx3SSIAK2JA60vrqNfb86Otue8pde5Iawhbs7zu3ufUU4hTJOUb4hQC6l2h
 3bGxU2j/k90ns2SLmWytaXrSPDMbtNMLC5AVlEHsYhubFfzKAza2iJMb3RPaqzQfHnJg
 DSdEp/viMDEfx7k8u+bc+a48G9lYmqzI4VHfBc2WP8jNwlZIAQVyCKTZVKRBO7qOpP10
 KwMFNucW2Z7Xipx5vysgKHpscx1SquIf0ljHpcCNBl1ekID1AGpRdSC/eUNIZKv3SpGK
 4msIJZ4+wtJOG0aAZSEgJ3WGYwiaVstKDIO8T0MGqWjfMiZvKqAJ6ViEaR7xCtXS/7n0
 UFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mulTmRahmIOLlqTACfJOIL2mZII2b44d4f9C0tQdiJE=;
 b=h/FkaFq7fWHJH7KUor3UV79Xp2pH2xgf9JFGRA3kyzPj/Duuc6/q4adQ3rCI6m7oAc
 ChX3x7fKmAnwaThpos27fRfcsXsgsp/SUWEEg1OI2N9swJwtnVJKSEDQtab+NPNFelxE
 bq2IERCHos7+FxRhZEOGcr2JBqYVydfoplm7pQa6pxT4Hfj9YUzm8AZijJM237mT/NH4
 EKpLgskLzLUMl4zMy7gnhucXKTbL5DeZFdn+bu3rsJL1rzo1z/Ts/tz/JVjXe7xnxuhZ
 ziCgLxVq3mPhPtfgJpfd0jMe/l+uuCTpc6h+CC4soaE1Lf2XnZcT6/NiRwC9tekhrAPi
 eKyQ==
X-Gm-Message-State: APjAAAXdJDX5ZBNUAbqMw8u29pGeWH7inE9v15eodqC1oiWJmFUUbgMc
 lDxfXt2W9xRLBAjrzUwKXgURckpQYiw=
X-Google-Smtp-Source: APXvYqyReW7Gpebh49Wq2RQu79O6dvv5HaYstFMGb6Eyi4MbR0YMIdKAdfx4f1vynzCnRhBRzuYkDQ==
X-Received: by 2002:a17:902:7d94:: with SMTP id
 a20mr55561476plm.26.1577574712167; 
 Sat, 28 Dec 2019 15:11:52 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:11:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/29] accel/tcg: Include tcg.h in tcg-runtime.c
Date: Sun, 29 Dec 2019 10:11:01 +1100
Message-Id: <20191228231124.18307-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code movement in an upcoming patch will show that this file
was implicitly depending on tcg.h being included indirectly.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 8a1e408e31..4ab2cf7f75 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -30,6 +30,7 @@
 #include "exec/tb-lookup.h"
 #include "disas/disas.h"
 #include "exec/log.h"
+#include "tcg.h"
 
 /* 32-bit helpers */
 
-- 
2.20.1


