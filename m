Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985ADC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F6120700
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSMlUMSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F6120700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igofh-0000iX-6t
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFt-000856-JD
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFs-00009U-IE
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:37 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36299)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFs-00008D-CI
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:36 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so6225475wma.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UiJZOf8roQyIB6kTmOAd2zer7SLUCnDoCQmZEmstycM=;
 b=LSMlUMSNd/2Z+DmESGWmkX1tYN2sN6tECm2Wto+Tho4ikqxA1utBxJ0YTnll1V2NDg
 sZ1As89tU3gbRsOZ/8jz0TBdu9Zg4AuY6JATm9ei54s2w0WzRWszR6sQsmY3tig1ZUTP
 waHsoDEC6Bn93JFClY14ZkgQmWYExKJaRp0rqmoWctU8I5Y9ONO5vT7Hin+75tTY6pWc
 WE+HxruOBkWZRiUI8yHWfoLhiLD0y+w/tgcYGebfGMMr0fjPGm1U3xaVU00LYJqkazo2
 QBqtoncnVVJDkP4pdeK59Jit4/V8kxAoIwsLUm05678ceHt8jdqE0bEH3mcASu0zR1C0
 5DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UiJZOf8roQyIB6kTmOAd2zer7SLUCnDoCQmZEmstycM=;
 b=k/KkAa6RgVCjQ7CMkbC+2IjUlwV9eDt4vOKJ9bW+qWPPLq0wIGbhMc0mYwIt9Cu3cw
 4QG+XfxOT9sWwngv15gJFgec7cgO+Q3a+lG84OBXmQ6fwv3eS0Gr2DbziIPaG8bhaltL
 etVMPMOaeNQV2EiXkSJ6229Jr+EAphe3AInIB/JyeAvGLsFA8jPaly+kdmUTgAKSYvyo
 ssioxftoKceWcmtG3meb8KRSmi/qY8LxsSe+fwcSbOMoHNlG+4N0W68MnUhice3NFyWZ
 FZjy8mt2rUHrnLe0k+na8+aIV7SKmdx+Ob8Lp74npVtQ2YNYM3EPq1bNuHM4pyqlEwyE
 NLYg==
X-Gm-Message-State: APjAAAWs78uszMkqnDs+5AiLd32HiKSR8Po+yE2/RdptLuSXewtRzCk0
 GkjeS+NYFhx68XFT8ieShZ2QsN9uySsbiw==
X-Google-Smtp-Source: APXvYqxHPm0YkIiAZNnuTVExV87nJGdbEXhwkKc0BrtdlJ5ekPWiMB4CYxQKzf92GujjTMKDdTDDDQ==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr31471321wme.125.1576494575148; 
 Mon, 16 Dec 2019 03:09:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/34] tcg: cputlb: Add probe_read
Date: Mon, 16 Dec 2019 11:08:56 +0000
Message-Id: <20191216110904.30815-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

From: Beata Michalska <beata.michalska@linaro.org>

Add probe_read alongside the write probing equivalent.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191121000843.24844-2-beata.michalska@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/exec-all.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index d85e610e85b..350c4b451be 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -339,6 +339,12 @@ static inline void *probe_write(CPUArchState *env, target_ulong addr, int size,
     return probe_access(env, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
 }
 
+static inline void *probe_read(CPUArchState *env, target_ulong addr, int size,
+                               int mmu_idx, uintptr_t retaddr)
+{
+    return probe_access(env, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
+}
+
 #define CODE_GEN_ALIGN           16 /* must be >= of the size of a icache line */
 
 /* Estimated block size for TB allocation.  */
-- 
2.20.1


