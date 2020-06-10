Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA14C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A50E204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWdiry0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A50E204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj7Xb-0005ZN-Fc
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jj7Vt-0003Sz-4S
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:39:57 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:36774)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jj7Vs-0007hC-0k
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:39:56 -0400
Received: by mail-pg1-x533.google.com with SMTP id t7so1504980pgt.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u1sk/YIU6t6fS+f6iDKix7y1NRK6wPD2A6SC61UJXGE=;
 b=QWdiry0JryBfLnFEa0ekOd2vxhlMwgTy6YsT8PomYJETDLv0RanM7JovtKNPpdn9+0
 8bYdcIUGwkgsd2BSZO05zCpvVIG57bRUtryKcZUdFnzvQefmvcAOopXLGiehHkzkmVhw
 eJeRI18lLK3wdmEJ/WxlqhdRQNfT+ckyiCdhu5nDoUFeUkAfZQcDQXtOcBmC1jEA8hO8
 Zm71IEtHyB2zS1Cr5UOz7XjZen15BoNWyWtTlSMoi9EKLQUSJipKv+nBF3rbxW65VOPv
 QPNaZhraFX0J9rloHlPj3eA2djbGnBEJPk49phu67un8ALFxOz8iI+7K32vsPJ/xvEZ7
 VfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u1sk/YIU6t6fS+f6iDKix7y1NRK6wPD2A6SC61UJXGE=;
 b=n8eiP7uuB35NhXxf0/2sg4RsY8kZQBFLoWw0p2I9lOIKRF16gQSavc7EqgtWuEU/jL
 pv4aG+1Bw6zGLN6o3kHHSXuaCfNOWnLI/q+nj627y5h/gxcCAmmrGUnJtKaJ8WnKKX5E
 zTolixgj5dv/TZK6GDOY5UehUH6dWpDKenn58cnnvE1awJZlU/CR44k+bqtub9UMkxMr
 GR/XoAbEMHbsbhR8Uhv3oSTdHD0CXdmI+qA25s9Eo+R4XBx7hFoQ8LPjbmakEPto4USI
 pW1SjYoWor8DZ7IisIQX+3tS6xU9ogkPhlPrUfcYARpjc1FkuK8uxUP04MZvpO6UsuL5
 /0hw==
X-Gm-Message-State: AOAM532pTljHw+RoydYZZdDSF7nnrg8KdKC9kdGus+bo1LglABOJ2mPg
 K6tnFc0IYB+srDbYxtKKv4cIE1Lacik=
X-Google-Smtp-Source: ABdhPJydId79Xe6+7zkqyZfyKsajbpbAxEVgw0gYOg94jr06HDLTTmqnZPxzjrAAxuQ1ltMl7qTZQA==
X-Received: by 2002:aa7:96b0:: with SMTP id g16mr4357312pfk.126.1591821587967; 
 Wed, 10 Jun 2020 13:39:47 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id g6sm740648pfb.164.2020.06.10.13.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 13:39:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] configure: Clean up warning flag lists
Date: Wed, 10 Jun 2020 13:39:40 -0700
Message-Id: <20200610203942.887374-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200610203942.887374-1-richard.henderson@linaro.org>
References: <20200610203942.887374-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use a helper function to tidy the assembly of gcc_flags.
Separate flags that disable warnings from those that enable,
and sort the disable warnings to the end.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index 597e909b53..464202e375 100755
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
@@ -2007,16 +2012,31 @@ if ! compile_prog "" "" ; then
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
+add_to warn_flags -Wno-initializer-overrides
+add_to warn_flags -Wexpansion-to-defined
+
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


