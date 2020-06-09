Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5C0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C5820734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dFCKCDTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C5820734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihCR-0003aw-47
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jih3u-0000FP-11
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:25:18 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:43400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jih3t-0000UZ-0W
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:25:17 -0400
Received: by mail-pf1-x430.google.com with SMTP id 23so9395783pfw.10
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hsQjYBDuR7uMW5e0uYusrSNyQMrEa5twml8sjwRrMW8=;
 b=dFCKCDTm8UMbyZA0Ej7XhjyhSNQQsDQ6n3IpD3GsbgIQwjbpsV6V7f8YVdxsYKY35H
 xMAcGZjMiXhpspl6tpQyPEcEXcsx8egp4LtW4wUkrc2M0v/YPWwObJ85yKCnX5+1fcmH
 U1ZKqsGPcosaNE1SdKNirZemqudhMy2UtsQtNJ9UK59hzlqfKcqzzvhMtGd9OfpR5Kz/
 l7WNNC6ejp25v+tXJcnM+4u7VNP2R/bSXCi3DfMDgtSRKVpmchfOzYlGejDBRNOxSqNt
 bfslRxa2AqMEBRSKlJRdJ0v7wK4DkIzfaFYDP2dX2xkf0Hu/AYRn/vupbZKcoHBV6C2C
 rq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hsQjYBDuR7uMW5e0uYusrSNyQMrEa5twml8sjwRrMW8=;
 b=Yc+F3W0ekdjLT5ysadN4/Ljoaa4szLUdHVHdlG9oLcWZL5Kj1jbrdmOvUHLXM9xXSR
 k92afFF9/inSw54Ty6Ya5ukFLdYPLPJzHsB2NlSFsz3TgbLzKQBaXFNxnwTbPnGGujD0
 qCH1619gyvxsQzLtQL+4XDMfM1FsnsxQXidxt5/aLQw8OUb1FfOM4cLUBj1juhPhrdyx
 F4wiDgOTUYvYK/su0qedzGREuvRw8SsT1/8hXFUOzeB14Zl+rK2U+sxRCiaZ9GvPrIVa
 jKpBy9pekhEpWCTu9lKjX60u7vzRl101Z97l0OOHv7HTL/cWdcABzXfCnc2dmYjqd4cK
 k3dQ==
X-Gm-Message-State: AOAM531z5C4eaxMRVW+Wu2IIrIoo5EPaDE1sdmqA8VZ/jJ8ipYlphar4
 uAMe7fxllmCLeIYEuibGPp2FxGxN88I=
X-Google-Smtp-Source: ABdhPJx2yESCsk2IMRgwuOUViUo88AOmtyvigBD+agdkz5ASfkJFbtuLs0+Llrbqfmzv4pIzFJ0afQ==
X-Received: by 2002:a62:5c03:: with SMTP id q3mr4823594pfb.58.1591719915179;
 Tue, 09 Jun 2020 09:25:15 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s188sm7580101pfb.118.2020.06.09.09.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:25:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] tests/decode: Test non-overlapping groups
Date: Tue,  9 Jun 2020 09:25:02 -0700
Message-Id: <20200609162504.780080-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609162504.780080-1-richard.henderson@linaro.org>
References: <20200609162504.780080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


