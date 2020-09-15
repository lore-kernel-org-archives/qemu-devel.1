Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E29C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5335E21D1B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WljUSDX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5335E21D1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBGY-0002Q0-4m
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIBF2-0000h7-Jf
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:43:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIBF1-00049I-09
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:43:28 -0400
Received: by mail-wm1-x343.google.com with SMTP id q9so3436878wmj.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 06:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KBlvHSw6hGCAYiixlo7FslOVcrTqSM4OUcC4XrvpXtI=;
 b=WljUSDX3uwozmjvq8IuhoiPAGxt9TQMQYNT1OIANmhri9SHICZi55GmDdtD9yfME8k
 Rb16qmjR77B6psbfilCyCnU/RtWInJLBNASNSbazjLjpdK6Z4xQTvkMp0xE5hlcuio4r
 jrCkdZ/NBkxWUR+iNTkSITqXu1D3e6YO4/3Au2PtJW8XaLz+JMzXpMqOahqozI1ty/DJ
 ehJIGyTCukWRB+YxpRc+esc4iRwfOacteasR4AUYCs6yY9oBSZhxDVeIk3VJHUE8M9zd
 sp+l08fx22BQFt1gppcBxmd3TNONAtbxwUD3cFjyOI2PLkUsph1CRn26LaulkbDzvYJv
 RsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KBlvHSw6hGCAYiixlo7FslOVcrTqSM4OUcC4XrvpXtI=;
 b=Ab9oZ1T5lSm6T1feDYffGPA9/WpH1LK8k78jV47VqAJ14GlPKXqrPyn9rWTic06rof
 Ew26wvoC9wkB6i+uHJBTc89kslBXoKr7iJs+3BSR/Ob1vF+fRhuGxq6QyaLP6NeTgPBZ
 Bg8ezbx3S/D4bMgF7OvdZS86tA5cI/IP2m9v+CYueWwLLCOWGTRMa7UBXktSYBuOxgQz
 cK4pxBUlD1OaASeJa2DHV38sSnZXp5P3CjhWgV5inzqiPuShfJVor8YJLYJ8/UqxNt2Y
 OZUyyTHBg4Wfsd1jtHv/Zi37zr9d0t1y0/sggiafTYekgfnFGR3m5i0PP8vQ1Zxdy+4P
 0Y9w==
X-Gm-Message-State: AOAM533YYqRl+mLynYhPRllNAunaBto+A1Zv+QvLuOVnAvyi+lePrLAW
 LcRC7GpeUefd6Jet51mb3k4n/NnsRKem4Q==
X-Google-Smtp-Source: ABdhPJwBqOn/+ZY+l53MTmFOJ6jySY44NP3KU+obYc3CIdZt8/acKZC9HBWBTE+b8rS5gHb6K+MjkQ==
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr4841830wml.6.1600177405690;
 Tue, 15 Sep 2020 06:43:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a13sm14172325wme.26.2020.09.15.06.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 06:43:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 807081FF90;
 Tue, 15 Sep 2020 14:43:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/8] configure: also skip deprecated targets with
 target-list-exclude
Date: Tue, 15 Sep 2020 14:43:13 +0100
Message-Id: <20200915134317.11110-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200915134317.11110-1-alex.bennee@linaro.org>
References: <20200915134317.11110-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now the user has to make an even more deliberate decision to
enable a deprecated target rather than getting it as a side effect of
using --target-exclude-list.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 51d03a8d340f..f5fe48d6dd7b 100755
--- a/configure
+++ b/configure
@@ -1729,9 +1729,14 @@ if [ "$bsd_user" = "yes" ]; then
     mak_wilds="${mak_wilds} $source_path/default-configs/*-bsd-user.mak"
 fi
 
-if test -z "$target_list_exclude" -a -z "$target_list"; then
-    # if the user doesn't specify anything lets skip deprecating stuff
-    target_list_exclude=$deprecated_targets_list
+# If the user doesn't explicitly specify a deprecated target we will
+# skip it.
+if test -z "$target_list"; then
+    if test -z "$target_list_exclude"; then
+        target_list_exclude="$deprecated_targets_list"
+    else
+        target_list_exclude="$target_list_exclude,$deprecated_targets_list"
+    fi
 fi
 
 exclude_list=$(echo "$target_list_exclude" | sed -e 's/,/ /g')
-- 
2.20.1


