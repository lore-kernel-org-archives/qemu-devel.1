Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA4DC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C0321527
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSKII8Qh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C0321527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVw9L-0008D0-Ke
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVw6J-00067l-GZ; Fri, 23 Oct 2020 08:23:19 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVw6F-0001WZ-BS; Fri, 23 Oct 2020 08:23:19 -0400
Received: by mail-pf1-x442.google.com with SMTP id e15so1098223pfh.6;
 Fri, 23 Oct 2020 05:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NDFBUZpID606vkJ6iBUsxOcJOuTJC8GXb8skxlH3lt0=;
 b=mSKII8QhO3yGRdtyObWw8rrdTNcvjAMVEeeJa4/jKNbx4rM6w8kjZMBky0L9YYtmBw
 dbYiDSgqxBi2ohtBLihIdhepTpfhuNt6sNmc8iji+GcYhyyGD+7FrK5pcCrvyMKPDvcp
 gmhD1Gx+0kDQYik0bLgHb9guVsblQkhkiO6kf357Ca8uls6iZokZXz/NLVsTV102hyMp
 SDDPgMT9LD3CnG9CCZ4DJ+av1ektcCsc0Grt/tWl/rvzZu2jVTxFxCyAoLJzu9cqyQJN
 UrJPRBn4uwiOJmTVFYw0u+l8ygLBoewp3kyPHf2zq8BbOeE1MnIJB+09PHkWtJjCpNYv
 kSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NDFBUZpID606vkJ6iBUsxOcJOuTJC8GXb8skxlH3lt0=;
 b=hfiKWJ7gMkhNgI+d45p1DLJ/i1ijgs+aS5XCIXykSVKc/aR7hfhwp0B6UX2feMudNT
 YL6UBM4dCNHaS1sMyyEkUhAOaAUOzsH2PKQ5tM3zRr8Kr1y4PCgRZjosUuutENeJ8etC
 Xn5B/O5zlpIQUCZ0Z14K+ES7Mp41fRVms5DjHv8zhMV+Os1N9XiPR08tvVUWgfIozmkx
 QL2oavo0fcbr/A/zU+4rfB7m8iLFQ/obgruv51gjt6OSI6SnVTUzqR+PNRGpm/jUQb0z
 H9mFUquU+D3OWkiT+eXNmMWD40U9zvD+Sp9zfyJgHwFqTHNakZfdXCdiBIl9+e7EjPvt
 nakg==
X-Gm-Message-State: AOAM532ID0IVogbzw8oNwePe1gPcAR5rHsJrvQrbxCYXGP7KhXHwN+U3
 iwN0USJIYpmgAWYZp/5YUJX5wKhG77GqcINo
X-Google-Smtp-Source: ABdhPJwSGwlaXhBasu3p/tzaoDlz4ONmlfDd+JAstCNntD5z6zKwWDnHd7JJ+lNpdL0lXR3LBr4XIA==
X-Received: by 2002:a63:531d:: with SMTP id h29mr1636405pgb.301.1603455791019; 
 Fri, 23 Oct 2020 05:23:11 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id s23sm1815877pgl.47.2020.10.23.05.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:23:10 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 13/30] tricore tcg cpus: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:21:57 +0000
Message-Id: <20201023122157.19321-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=chetan4windows@gmail.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 hw/tricore/tricore_testboard.c | 2 +-
 target/tricore/gdbstub.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 8ec2b5b..12ea149 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/tricore/gdbstub.c b/target/tricore/gdbstub.c
index 0f4e612..3ce55ab 100644
--- a/target/tricore/gdbstub.c
+++ b/target/tricore/gdbstub.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.17.1


