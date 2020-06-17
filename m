Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A495BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 04:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7210A2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 04:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J1Wq3Lkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7210A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlPr0-000854-O9
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 00:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlPpu-0006ml-GG
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 00:38:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlPps-0001TK-PC
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 00:38:06 -0400
Received: by mail-pg1-x541.google.com with SMTP id s135so666286pgs.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 21:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kaW8P+svDRMLkdL4p/i5g0Y7teIr71hNo2cIxCcePk4=;
 b=J1Wq3Lkmyr8GkiYUSAzwY17jqQdCsba1fHo/hT4atUgo177CYGxQx0ExSOYcZ4j63L
 e6ZrVPSCR5PrJtneZ+kE+GdCKeaHnPPJgTlsqTw0fFuMFsgwE18zp3aL+LCLykw2yjJ0
 kvNWdU6ujbM6ZXxKfqI7ilbXg2ULH/axFtnZLms8VsNoMgkpkigvGWQk89iwxFfPTDEQ
 bSmVFvJno3amnO1mZ/BX28WYtH1NJRpTW1ptk/BK0aP+JlMn3B9KsM8syD6KKGCbG3/h
 KwISR/A8FSu0CckjFezySDxd75WRAvOMjToWYLyY7/zu/nPUwn/yVQfjCTuSqppEddn0
 +A8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kaW8P+svDRMLkdL4p/i5g0Y7teIr71hNo2cIxCcePk4=;
 b=H3XVVWG0eZdb6MonTY94zuhHXSr13Tct0CbAZ2v3uzCv13ykp6wrDA8SdxzbkmmaiX
 14mDzN3HGrZdAmM6lcHJV4y+WKsC/hmIulKRANDqMH7Y+0sYTGIjzbJwSe3GVWG2Ac5F
 Ib5AnjvWq+fZs7i+HBt5xtKQ984chmbWN/v+s5CqIoSdaIQ9EpRLcrEWPKB5p6JR5LZy
 ED1XX9wTZsohKgvrs69okJpSlS2oStb2FJo1mD+6Ms+Hp6A9r9AIOapriotWA4XJMuOD
 3sQYysntjXidqzV6y+IjHruS29D9cuvfbpG93M6SiEZQt7al0uCaHYM5038M/qxGQkR9
 jtRg==
X-Gm-Message-State: AOAM532f0x4Fh5r7fFbq54Y0dRPaF9BIfC8Xdyw8yE+7tC1G45J73A+f
 y5xobnrtQy42w9EuTTcWkRSt+6ytGGQ=
X-Google-Smtp-Source: ABdhPJyelP3N+IuzHzQ8rhrAbamMe9dR4nlPiumqhwOSsKD+UCPsCDiWNKqSKhNo0mVn70ZwK0COyA==
X-Received: by 2002:a62:7f58:: with SMTP id a85mr5185003pfd.89.1592368682954; 
 Tue, 16 Jun 2020 21:38:02 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x3sm18585808pfi.57.2020.06.16.21.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 21:38:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/5] configure: Clean up warning flag lists
Date: Tue, 16 Jun 2020 21:37:55 -0700
Message-Id: <20200617043757.1623337-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617043757.1623337-1-richard.henderson@linaro.org>
References: <20200617043757.1623337-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use a helper function to tidy the assembly of gcc_flags.
Separate flags that disable warnings from those that enable,
and sort the disable warnings to the end.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index b01b5e3bed..a8bef95282 100755
--- a/configure
+++ b/configure
@@ -97,6 +97,11 @@ do_cxx() {
     do_compiler "$cxx" "$@"
 }
 
+# Append $2 to the variable named $1, with space separation
+add_to() {
+    eval $1=\${$1:+\"\$$1 \"}\$2
+}
+
 update_cxxflags() {
     # Set QEMU_CXXFLAGS from QEMU_CFLAGS by filtering out those
     # options which some versions of GCC's C++ compiler complain about
@@ -2024,16 +2029,33 @@ if ! compile_prog "" "" ; then
     error_exit "You need at least GCC v4.8 or Clang v3.4 (or XCode Clang v5.1)"
 fi
 
-gcc_flags="-Wold-style-declaration -Wold-style-definition -Wtype-limits"
-gcc_flags="-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers $gcc_flags"
-gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
-gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
-gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
-gcc_flags="-Wno-string-plus-int -Wno-typedef-redefinition $gcc_flags"
-# Note that we do not add -Werror to gcc_flags here, because that would
-# enable it for all configure tests. If a configure test failed due
-# to -Werror this would just silently disable some features,
-# so it's too error prone.
+# Accumulate -Wfoo and -Wno-bar separately.
+# We will list all of the enable flags first, and the disable flags second.
+# Note that we do not add -Werror, because that would enable it for all
+# configure tests. If a configure test failed due to -Werror this would
+# just silently disable some features, so it's too error prone.
+
+warn_flags=
+add_to warn_flags -Wold-style-declaration
+add_to warn_flags -Wold-style-definition
+add_to warn_flags -Wtype-limits
+add_to warn_flags -Wformat-security
+add_to warn_flags -Wformat-y2k
+add_to warn_flags -Winit-self
+add_to warn_flags -Wignored-qualifiers
+add_to warn_flags -Wempty-body
+add_to warn_flags -Wnested-externs
+add_to warn_flags -Wendif-labels
+add_to warn_flags -Wexpansion-to-defined
+
+nowarn_flags=
+add_to nowarn_flags -Wno-initializer-overrides
+add_to nowarn_flags -Wno-missing-include-dirs
+add_to nowarn_flags -Wno-shift-negative-value
+add_to nowarn_flags -Wno-string-plus-int
+add_to nowarn_flags -Wno-typedef-redefinition
+
+gcc_flags="$warn_flags $nowarn_flags"
 
 cc_has_warning_flag() {
     write_c_skeleton;
-- 
2.25.1


