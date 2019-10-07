Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8EEC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3304720679
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0q31hCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3304720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVGL-0001kZ-9D
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwQ-0002hX-DG
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwO-0005Dg-It
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45038)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHUwO-0005DN-CW
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id z9so15800534wrl.11
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lS//Prbb20uTZPpM5BoU1FCIVJv7TIfQwriRsFwYsbE=;
 b=q0q31hCko5BcR1wSoNcIg+oEK5ZdP4by+oAwyhQ1opGwPP+tRPHA/bp50prwOF+XzA
 LxxzrhX/oscbPobeYONsmDfx0x4jjaDeR2eeL6khvsX5o0ji+/VQomBPbU/NTpiXTdES
 MmHlPIm9R5bG6oJU3Qp42NAoo+wOBYTJuiZcm8qiM1KjwJLcaIkMlMi/FjzDPl1ZjI48
 vBjWI9S/l9F7FwO9a8Dof9lPNbJz1P/kdfUIgeGUIiciq0ZaQpe8LW/pomSMwvXliRxt
 URFM9Z25VVP4g+6nX503jgVuA28slLaSVHV/ckv7d0n2nH1V0HrD4AJzoDWm7dd4JXXb
 PKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lS//Prbb20uTZPpM5BoU1FCIVJv7TIfQwriRsFwYsbE=;
 b=LU35IoZKPeSwJDs6rGitLir2U0zW3POasSfCc42I8fkzCUWAjJRqOnM3KT1lhEygRa
 kYrpgAPSwwCVMVdfS7BqsmZrdvcGyt2pJPIMgPf+2CwlzRRYMG+R0u7UKMgBQeHvxf3E
 z/LIhNTjxrqvjP3rSaJMp8L2ZjoMvxqfFkjbuLIaVJZLqASfaj9pUv5GZptFP67Ug1yF
 1f15gDaCO7yyLQpuA+aSzt+cytz8bocoJ9Fqe2edFx0TCCgxAALLr9KjlzD4CH4puUon
 PvYA4kOSHsfW230QjUUwf4VLkd2pPSZ9IcOlCtRZUkoqJknakMfA24ShBBBnv6wWdrP0
 EG8A==
X-Gm-Message-State: APjAAAW/rMXS779+jdAC54GwQF/wz7VNk3435wr4p/1uYI9caBc2PQgN
 59wxQL0NUn43S9LGYZMdtlFvmA==
X-Google-Smtp-Source: APXvYqwCeLYyFo3D5ZihBHqxy6O+9wto4CWEVlEZrRBLnzNCuwttcRzXAg9sw2gj9PHJ42QbWXKPuw==
X-Received: by 2002:a5d:5111:: with SMTP id s17mr21137961wrt.59.1570462131347; 
 Mon, 07 Oct 2019 08:28:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w5sm16461634wrs.34.2019.10.07.08.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 08:28:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B197A1FF9C;
 Mon,  7 Oct 2019 16:28:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 13/13] configure: remove the final bits of --profiler
 support
Date: Mon,  7 Oct 2019 16:28:39 +0100
Message-Id: <20191007152839.30804-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191007152839.30804-1-alex.bennee@linaro.org>
References: <20191007152839.30804-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/configure b/configure
index eedeb9016e..dfd0f67170 100755
--- a/configure
+++ b/configure
@@ -419,7 +419,6 @@ oss_lib=""
 bsd="no"
 linux="no"
 solaris="no"
-profiler="no"
 cocoa="no"
 softmmu="yes"
 linux_user="no"
@@ -1192,8 +1191,6 @@ for opt do
   ;;
   --enable-libnfs) libnfs="yes"
   ;;
-  --enable-profiler) profiler="yes"
-  ;;
   --disable-cocoa) cocoa="no"
   ;;
   --enable-cocoa)
@@ -1702,7 +1699,6 @@ Advanced options (experts only):
   --with-win-sdk=SDK-path  path to Windows Platform SDK (to build VSS .tlb)
   --tls-priority           default TLS protocol/cipher priority string
   --enable-gprof           QEMU profiling with gprof
-  --enable-profiler        profiler support
   --enable-debug-stack-usage
                            track the maximum stack usage of stacks created by qemu_alloc_stack
 
@@ -6307,7 +6303,6 @@ echo "target list       $target_list"
 echo "gprof enabled     $gprof"
 echo "sparse enabled    $sparse"
 echo "strip binaries    $strip_opt"
-echo "profiler          $profiler"
 echo "static build      $static"
 if test "$darwin" = "yes" ; then
     echo "Cocoa support     $cocoa"
-- 
2.20.1


