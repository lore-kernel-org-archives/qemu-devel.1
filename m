Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC40C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994422072B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pzLdvcUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994422072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igykZ-00008z-Ce
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybH-00059C-Sr
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igybG-0007Ce-UT
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:23 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igybG-0007C5-PI
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:22 -0500
Received: by mail-pl1-x642.google.com with SMTP id c23so5122115plz.4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=r5qvsiX5IA+LOMSB6fEkOOIthLDhI8Op7OL9OEMu7no=;
 b=pzLdvcUsbhr7Gxdt6usq66C11c4ZSJHY+1CXqlvtXmuEIN1xo3nGy2DpysGwd1mASU
 ySXVXWvCrQO2pQ6hSFH0tQeh30lo3FyPSFV2gvIKfY0X3vmohH3iG2su8d+aKnS1/SLZ
 snM5VD5SrLI5aelTaxw7z0W1bYfMokv4bbw3H8eEFIOQP94SRmAEHYBYidVnsGyC4R8I
 b3vUwKDho8XrxkLIkbc9bujEj8LVLV7K592lkWgcaSaOWd9J2ug8KxxukUEW5CPy4wO1
 8qpvAV/p5rexM6SFPlxHS+rvOHsObF0bhiLMqfp2sgmwJsD47B3uomqB5XlOHn2Nmi4y
 yrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r5qvsiX5IA+LOMSB6fEkOOIthLDhI8Op7OL9OEMu7no=;
 b=Ih79kdkifnJwzPTGRAIiGWIrgpRYOuaJfPaNb/GCeZc6XW3ccTOIGCYYP2ON4iInca
 /HXvBFpK4zanc0cT0Wg5sKU648lezBJ3v+od512otDDvdPDdDC8DCqaxW1I5+l3PQf7Y
 2VI3stRamVkJyyGttqEOXKWQqyrZrDlxGGVlOlmZd3hlAHn21NaZSCxeAEEPnIUQlqPA
 Rt5aww3HFYYrl2PxWnr3H+rby2QTD+l+uX/E0AcbZHbWRgfRF+jX+2pjhdJTmA1Xzyib
 1eHiamWZo6qifa70fzUuvHzmBAnXrKuC/QdyZhfX7n/u6j2qyWCNqDwMqbUsO4cK1AhO
 Mlbw==
X-Gm-Message-State: APjAAAVrQso+9a3qCsnjzsGe/pC5RAqfbaXLOEsExo3ZqF0Kcj42O9Eo
 Ih0wGOqZdJUdXYr8g8oIRnO9xFA0PNw=
X-Google-Smtp-Source: APXvYqyZ06T1Ml/kpEetub8XzCqxeo/nu4OQk3ro7wdlkA1rMnyZsKNn6GbzbQY/SFUMdb3sMpCwMw==
X-Received: by 2002:a17:902:d708:: with SMTP id
 w8mr18959857ply.280.1576534341524; 
 Mon, 16 Dec 2019 14:12:21 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/28] linux-user: Include trace-root.h in syscall-trace.h
Date: Mon, 16 Dec 2019 12:11:43 -1000
Message-Id: <20191216221158.29572-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code movement in an upcoming patch will show that this file
was implicitly depending on trace-root.h being included beforehand.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/syscall-trace.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
index 9e60473643..79fd3e5aa9 100644
--- a/include/user/syscall-trace.h
+++ b/include/user/syscall-trace.h
@@ -10,6 +10,8 @@
 #ifndef _SYSCALL_TRACE_H_
 #define _SYSCALL_TRACE_H_
 
+#include "trace-root.h"
+
 /*
  * These helpers just provide a common place for the various
  * subsystems that want to track syscalls to put their hooks in. We
-- 
2.20.1


