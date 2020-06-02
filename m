Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C28CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 23:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A3C206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 23:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="thnHkZYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A3C206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgGou-0006ah-By
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 19:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgGnw-0004wn-Ls
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 19:58:48 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:41832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgGnv-00025A-RQ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 19:58:48 -0400
Received: by mail-pg1-x52c.google.com with SMTP id r10so414083pgv.8
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 16:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hZUxt2iE/yogniLtrjMplHAnQGgnoAhQivH1x/eLkRU=;
 b=thnHkZYUyTsgH4VeONOgCqaOPgHyKSzn6jOF4SbpleztaoPD/RPz+0vF/USxTlyCYl
 /zq3PCMSH41vEooRJDHzs14Fojg6UFvAFgWWowX6NpqHPbkuLc+T7c3ka2kmiLJcejhC
 Z3egmH6hdMFo7/MRUuCY1RL3X+sLgVTjVBAIlX8fb61sblAQ7+//DdTqrx5noXqfSm4y
 DM0ug7jYEJQrCnIkDxJoWMsR4Vu1E+68MngXLUIimSi2QH62ZvTycp7gXgTquD0DDSxn
 AkWYSULGctYuAjRmM+4OJmMklzDreZzA5nDSvyJ4RHMPDfPGX3F1G3UdCkdmnNNYCq/a
 XLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hZUxt2iE/yogniLtrjMplHAnQGgnoAhQivH1x/eLkRU=;
 b=iyNPOS7Um3DpndIJXXHL6jhzjD+GpSM0Gnx9hkTH7jEhyX60mopQr4ExtFKBcmfUBQ
 qyLwWq9Wt8erjGxnYPHSrnvXJo6qgjYzzSz21Ow1xtR+KhIxP50cKVurlJyccg/4xPPz
 NXEARqzJrBHMDuPYbnpRWIIVrlKWTY8xbPkXyt5fVZTT8u/90bzqzsSjLNt68AmHM6wX
 qogR+6dDC+vBLoLvUy/zOXm301L9M4txYM11w7YCKj4o/FLaN/kvHarljaYuJN2Ni4jK
 yniCRWwdX4ztBZ7Me3XP5Jxss8r21z9fXOl/J51qYWHq6TkDQje99UdUZYgj296H0mnB
 0sfg==
X-Gm-Message-State: AOAM530mJZD1kg5lPPXzfTPEIJCi4taRuLNW/cBsE9dpEON8xQrw8OYi
 MWeydNfekWhGHDvMaKcOz4QHkMg+RU0=
X-Google-Smtp-Source: ABdhPJyDfMWAepu4I6xb2O1iVojSfSbcZyMReroFw2efzwX+kZY5ZY+AMQ3EBZvBwJigHnrAUhN1Uw==
X-Received: by 2002:a63:3ec4:: with SMTP id
 l187mr26254673pga.358.1591142326108; 
 Tue, 02 Jun 2020 16:58:46 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id k101sm182201pjb.26.2020.06.02.16.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 16:58:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/8] tests/decode: Test non-overlapping groups
Date: Tue,  2 Jun 2020 16:58:33 -0700
Message-Id: <20200602235834.470345-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602235834.470345-1-richard.henderson@linaro.org>
References: <20200602235834.470345-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/decode/err_pattern_group_nest1.decode  | 14 ++++++++++++++
 tests/decode/err_pattern_group_nest2.decode  |  6 ++++++
 tests/decode/err_pattern_group_nest3.decode  | 14 ++++++++++++++
 tests/decode/succ_pattern_group_nest3.decode | 11 +++++++++++
 4 files changed, 45 insertions(+)
 create mode 100644 tests/decode/err_pattern_group_nest1.decode
 create mode 100644 tests/decode/err_pattern_group_nest2.decode
 create mode 100644 tests/decode/err_pattern_group_nest3.decode
 create mode 100644 tests/decode/succ_pattern_group_nest3.decode

diff --git a/tests/decode/err_pattern_group_nest1.decode b/tests/decode/err_pattern_group_nest1.decode
new file mode 100644
index 0000000000..7d09891a1c
--- /dev/null
+++ b/tests/decode/err_pattern_group_nest1.decode
@@ -0,0 +1,14 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+%sub1 0:8
+%sub2 8:8
+
+# Make sure braces are matched
+{
+  top        00000000 00000000 00000000 00000000
+  [
+    sub1     00000000 00000000 00000000 ........ %sub1
+    sub2     00000000 00000000 ........ ........ %sub1 %sub2
+  }
+}
diff --git a/tests/decode/err_pattern_group_nest2.decode b/tests/decode/err_pattern_group_nest2.decode
new file mode 100644
index 0000000000..c172239e9b
--- /dev/null
+++ b/tests/decode/err_pattern_group_nest2.decode
@@ -0,0 +1,6 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+# Make sure braces are matched
+{
+  [
diff --git a/tests/decode/err_pattern_group_nest3.decode b/tests/decode/err_pattern_group_nest3.decode
new file mode 100644
index 0000000000..b085d01410
--- /dev/null
+++ b/tests/decode/err_pattern_group_nest3.decode
@@ -0,0 +1,14 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+%sub1 0:8
+%sub2 8:8
+
+# The exclusive group should error for overlap.
+{
+  top        00000000 00000000 00000000 00000000
+  [
+    sub1     00000000 00000000 00000000 ........ %sub1
+    sub2     00000000 00000000 ........ ........ %sub1 %sub2
+  ]
+}
diff --git a/tests/decode/succ_pattern_group_nest3.decode b/tests/decode/succ_pattern_group_nest3.decode
new file mode 100644
index 0000000000..156249f090
--- /dev/null
+++ b/tests/decode/succ_pattern_group_nest3.decode
@@ -0,0 +1,11 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+{
+  [
+    sub1  00000000 a:8 b:8 c:8
+    sub2  00000001 a:8 b:8 c:8
+    sub3  00000010 a:8 b:8 c:8
+  ]
+  sub4    000000 d:2 a:8 b:8 c:8
+}
-- 
2.25.1


