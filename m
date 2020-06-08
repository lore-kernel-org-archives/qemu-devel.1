Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E907C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F7772063A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQWSWvru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7772063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiMpQ-00015w-EY
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 14:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiMdu-0007d2-SW
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:37:06 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiMdt-0001WO-Tn
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:37:06 -0400
Received: by mail-pl1-x641.google.com with SMTP id t16so6987027plo.7
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 11:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hsQjYBDuR7uMW5e0uYusrSNyQMrEa5twml8sjwRrMW8=;
 b=tQWSWvruC9DHjJ1mhYPjbU56Q1AgO4LsNeCNgcLf0to8ntNwY3td7CAVWCY9ZrDnfr
 ji4+D8iiSRTjm4Wacgp+jcke2Aljwqf18rAzzx1+DymwiQ4Cw89z58+8kRQq5U7eNXQE
 XL8nlWUBtBUxgYKZEOysmBoZJ/0xRLRjeD+1DwwI3uHNnVkvNBhYRgKYtxWbi82kpptp
 SkQDoyuLYUC9mulEly3rzRY0vEv8J4/xTpt8pX3L0hfiBsXwXrpyJDj1P4YF2lu29OKy
 EVHgK7M1EJCwE64CL4AdAXlqTliGsgADtWb7oQlOs+2KQCtGyqmefqbw6GEHGUu7MjRH
 i+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hsQjYBDuR7uMW5e0uYusrSNyQMrEa5twml8sjwRrMW8=;
 b=ujutuGy7v7mICr3VZ9iW5Yk8h0cyVvufv2Tcl0XZc+tFbTOYuRxaqRZJmI0TD8aa+t
 OaKJ6gC7VxZgPt24mS6KJsAdLgpjCPFTduv0vNipDcE93Kuk405jpTUPypvQWJxcXBG/
 SNM8fmVPuUJ1+nKaRUx6a7eYtnPt79fh5iLDNmF9wVp4ng5I0E9SEalplTomdUcdencL
 dHyST4BtqmFPdK5Scnu+77ponHXrlgle5V5UgBvwGFJuilppkx15nmt0JU/oQxHMDFrY
 r4vqPJ5VPlTmdq6teUKrlqg9iMerTjM1Ju9kCiqdIU8vFLSNm0br4djKePMna7mDlp11
 qlrQ==
X-Gm-Message-State: AOAM5323kNxopTD8qUuyJLdtA2AG/O28qryKr9MreAPpfRNgmElI8LwR
 pBCdufx1tfCg6F/X1H7x/5cck/NCf7Q=
X-Google-Smtp-Source: ABdhPJylANPaRBx6tpgP+9QtjzpuIFuA/id7+ocV2eB8rd/zKAo6AYDbygX4lS7TnVZoHwAXRQhOdw==
X-Received: by 2002:a17:902:bccc:: with SMTP id
 o12mr137921pls.29.1591641424140; 
 Mon, 08 Jun 2020 11:37:04 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i22sm7854235pfo.92.2020.06.08.11.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 11:37:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/9] tests/decode: Test non-overlapping groups
Date: Mon,  8 Jun 2020 11:36:50 -0700
Message-Id: <20200608183652.661386-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608183652.661386-1-richard.henderson@linaro.org>
References: <20200608183652.661386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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


