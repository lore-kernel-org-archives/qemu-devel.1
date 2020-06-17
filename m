Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29011C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F3321532
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nEHHWw3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F3321532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jleT3-0000ll-6E
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 16:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jleQy-0005jT-9N
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:13:20 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:41742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jleQw-0000IJ-Cj
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:13:19 -0400
Received: by mail-pf1-x434.google.com with SMTP id 10so1670908pfx.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4r5DXyEg7egNkGt1Nf25Vhx3ygxyImevDYCxFLgjPzU=;
 b=nEHHWw3oibbmDoeUs+w54bTWDfuirqvZX9ZTZbPvYL13/GJskcUo2gN3f1TtE1fCkd
 HAe9L6kJtrghT5PJiDYAxg9ImPeBrLPmAPtOLW/m1hwocJ39ovvXqLgugnMNYaVNpNxl
 +HUzdxxfPGjIPrtbNZNSWKH0wDD7Sqbv9DJmAOVRXBch827VTDol7o1QaAC7iGHOqfcw
 oifQK6nfO+YVOM2JEc5KBuJ3dGfVFRZgPUL7MALJoBN22evHlkyvpMONuEdIYHp7ZBFx
 fcC5wLezqK3Lz1Dt2vpvtmoXR/Uc2d+GISRiuOsYbVCT8wjGrD1xRApMGP/GDHw4GZz9
 B+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4r5DXyEg7egNkGt1Nf25Vhx3ygxyImevDYCxFLgjPzU=;
 b=MNkdxI52w2TdAfHIQ0QL/JZYoJEbQuM0IsTn4ddFIRurylgWaPP0d0g772n8/wG4bG
 n46HwtOgOqXlTK5kacn9FCzqAuWxLNWRMC+6yn0XnStCCFoBseQ47OcuZ6q7bbCH3rdx
 EDllaOibXTJPjLr9AdZHEquvSpr/v9wKNE8T7HqUrcn6qxa8DlLdujT55De7toM945kK
 S9nX/WfUqxQSanf9+WeGMZRRKrUTpmeZrOS3tDbnzVI94aM32J2y5A2bqFTKR4pUMhoP
 qJoHw9ARAg9qpzWCROBNDKYsQ1wMnspQFNR/0BwV5dB7p4NOkXRHB4jhYOXykTSlQQ4v
 PqYw==
X-Gm-Message-State: AOAM533PBCrEz3kn7PhsaOMq7M0QRyZXYJLp8lFFn6LBLjPztwsDGQQ5
 kSnIpZsf4LBwMqSI/6hHeViI7wW6E7I=
X-Google-Smtp-Source: ABdhPJwtORdKW9O/mKQ/goUvzPs5YXNQVM1j68Kg15hYWKdFo/xr3xTlqDdEUnoRdNcU9UXt7OgDDA==
X-Received: by 2002:a62:a510:: with SMTP id v16mr455570pfm.154.1592424796560; 
 Wed, 17 Jun 2020 13:13:16 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h9sm659259pfe.32.2020.06.17.13.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 13:13:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/6] configure: Clean up warning flag lists
Date: Wed, 17 Jun 2020 13:13:06 -0700
Message-Id: <20200617201309.1640952-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617201309.1640952-1-richard.henderson@linaro.org>
References: <20200617201309.1640952-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
Cc: philmd@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use a helper function to tidy the assembly of gcc_flags.
Separate flags that disable warnings from those that enable,
and sort the disable warnings to the end.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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


