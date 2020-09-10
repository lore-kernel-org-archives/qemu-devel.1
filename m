Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D79C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 05:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B1920756
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 05:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwyX5MPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B1920756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGFPq-0001wZ-Bk
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 01:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGFOb-00015J-V5
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 01:45:22 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGFOa-0001Ih-Fn
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 01:45:21 -0400
Received: by mail-wm1-x341.google.com with SMTP id z9so4485075wmk.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 22:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I2mpH3a28E/4m3VDu/0JcxdGeH4E4ukkA5+4cHaQoXk=;
 b=nwyX5MPwxdFKGCHk7uaKZrNWBwKqeWx3PGSqdUvb/4TV/Mptx5S/sNSaLD3WuOk9M5
 /PZIgBwlPN7ij3KK5Yo8peM93rQR7CqFX79wmxnNshyaqSdQqqT2XU1t2W4FzCdJ4ynb
 LpN6+IA+Szk8s3oI5KhDIOQ2QeT+BHQj4QWdwX2242jQGz9pxcLOdi5wY+rd7upLfAL7
 QTGlYxRl08sSh/S4QMG4JUqy6tnSB9FuaHBHi5BaQMbrRfnynbz/bQiN5yPb4e3RrwDB
 DwDisPdg+IPbR/KyPaPPRj4JBbo4YKiW5wNDCJdnlMt/lMydsO9eh7wiJPFJ6zRppaAg
 f3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=I2mpH3a28E/4m3VDu/0JcxdGeH4E4ukkA5+4cHaQoXk=;
 b=QwpeYheAjtbyCUDWp/qYTbJmilKOA4sP+WNPcBsT1bxMjrnDEb0HKRrOoLzM4pBXyK
 j4QLt2TmhFPCOlAuJdFhNyCAdf0MGE2bQMmyV4S5mPVHfK3BHKULAdOYvHGGDxvIef82
 i8BEOpLr5q0sd4t9IBP7vftRdhl6T9oae6+rGXGFH5q8GQ6oxVROqKALsGVgdM9XAF2J
 fPOsPLHvJicfKf/G4Ou0FLA/sLtWuCokNpy+Uj3UlYX2k4FdgtHK9i+cZAgxlPP9JBpn
 lK8MrPuznO0jsHGZt+cphnQSOXMZQJYjfYFI+Ib5B22LU4AzkP6qdQ0BtqV5fIdA+cRY
 22rg==
X-Gm-Message-State: AOAM530I6Wjvl16UU541sjClyrr01PhLTTPmRcVDRGkuBCfvf3uJIyBD
 R8jDqCYSlgxpMjpKmz7+OlnvBALQavw=
X-Google-Smtp-Source: ABdhPJxnALdRVUB9iAWu1D30dKHTksHDqMH/hlI2bCTtvOeQBWAR+3t6F4iYKipKnmHxi76XT2vN2A==
X-Received: by 2002:a1c:bbd7:: with SMTP id l206mr7121853wmf.185.1599716718573; 
 Wed, 09 Sep 2020 22:45:18 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id c205sm1857508wmd.33.2020.09.09.22.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 22:45:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] configure: Do not intent to build WHPX on 32-bit host
Date: Thu, 10 Sep 2020 07:45:16 +0200
Message-Id: <20200910054516.405777-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hyper-V is available on 64-bit versions of Windows,
do not try to build its support on 32-bit versions.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since v1: Handle MinGW automatic detection (Thomas, Stefan)
---
 configure | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 4231d56bcc0..91c5d781845 100755
--- a/configure
+++ b/configure
@@ -2980,7 +2980,10 @@ fi
 
 ##########################################
 # Windows Hypervisor Platform accelerator (WHPX) check
-if test "$whpx" != "no" ; then
+if test "$whpx" = "yes" && test "$ARCH" != "x86_64"; then
+  error_exit "WHPX requires 64-bit host"
+fi
+if test "$whpx" != "no" && test "$ARCH" = "x86_64"; then
     if check_include "WinHvPlatform.h" && check_include "WinHvEmulation.h"; then
         whpx="yes"
     else
-- 
2.26.2


