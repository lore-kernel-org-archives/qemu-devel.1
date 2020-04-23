Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57505C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EFBA2077D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFa2/kcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFBA2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRbDW-0004o7-7z
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 08:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRbCE-000408-N1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRbCA-0002Zn-BE
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:43:14 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRbC9-0002Vb-Vi; Thu, 23 Apr 2020 08:43:10 -0400
Received: by mail-wr1-x444.google.com with SMTP id i10so6662130wrv.10;
 Thu, 23 Apr 2020 05:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KK+Nru4yuP4c3n7CVPB6G+i75WbREygftS8BvjsDaZA=;
 b=mFa2/kcytoQTyA9h5UsMfwVNyGqcIdNtWKhXXkoSUktly7/Q8/mjdWvesfEtG8XczB
 3G0C4o9MCCG5rpGRRK04Wf3aNUkxWQ1C3g+P108Q3t8nI+TTnpwafqg0Zhw82scLJxjd
 q2Rvbp9wTyE8nFustspGUMpbLs8JgHDBGwbHSXb0bQtWy5YUI6ojfDmBBP1fOKfbqFGA
 TBugD8LXTvO5Q0DzEn95C9KWFP/jfkEDsJeNQvECK0tVBnf0GWSkgRk+OnKfrAYOI5PO
 AZsKoUYLY6ve/jBcd8UgQ7BvwTN4aLqi/i+EgGzsQrNbBdB0brXmvrwtudFAH7EofHy5
 ZUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=KK+Nru4yuP4c3n7CVPB6G+i75WbREygftS8BvjsDaZA=;
 b=mFnMOVxwNGsJFlLn3p4yO8b2eUzYJ+Qc9wV064BwhvZxzOv+aWhZPCNJLz+KJnPFjX
 p/j/G/OedPWHgMa8lBT/FdbLJgHvoJQA8EdXImb/p9kaT3nP11b6BYQxhk20oZSgFhAJ
 exOw+GTlQL3kVGzeb/5XJLohxpFt34ayOH/XkO8SxyNEhX0SXrPXbbA5YoTXtzld7HLj
 vfGNIr9TtQi2oPrwI5OvzGJbSpV2Qn/sC5HKfZym4J3C7frg4R3Sr+QfNEL5vhg+wU41
 y5/qkfofy7zvDTEX3QF8Ou1SY1U3caK1gg/zSLUwX9okfXIP48KFb/5QxkeM+wHjjKry
 XBSA==
X-Gm-Message-State: AGi0Pua/yPzIbAi56oiqlrgUHU7s9LZyQBCh31jsYRqFue2JObR+Vgm4
 b1h6Sl2GS0GWoqR4j6yzHOFUtbEV
X-Google-Smtp-Source: APiQypJK4aYJW8vBdVEYsayxeCYOA1I3z+bQWaTPbQM7J4OylanN8uM9TVnb5rIudHrUqN5n0waoIQ==
X-Received: by 2002:a5d:4ac6:: with SMTP id y6mr4725903wrs.212.1587645788041; 
 Thu, 23 Apr 2020 05:43:08 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id j11sm3580921wrr.62.2020.04.23.05.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 05:43:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Use correct variable for setting 'max' cpu's
 MIDR_EL1
Date: Thu, 23 Apr 2020 14:43:05 +0200
Message-Id: <20200423124305.14718-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MIDR_EL1 is a 32-bit register.

This fixes when compiling with -Werror=conversion:

  target/arm/cpu64.c: In function ‘aarch64_max_initfn’:
  target/arm/cpu64.c:628:21: error: conversion from ‘uint64_t’ {aka ‘long unsigned int’} to ‘uint32_t’ {aka ‘unsigned int’} may change value [-Werror=conversion]
    628 |         cpu->midr = t;
        |                     ^

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/arm/cpu64.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 95d0c8c101..4eb0a9030e 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -620,12 +620,12 @@ static void aarch64_max_initfn(Object *obj)
          * code needs to distinguish this QEMU CPU from other software
          * implementations, though this shouldn't be needed.
          */
-        t = FIELD_DP64(0, MIDR_EL1, IMPLEMENTER, 0);
-        t = FIELD_DP64(t, MIDR_EL1, ARCHITECTURE, 0xf);
-        t = FIELD_DP64(t, MIDR_EL1, PARTNUM, 'Q');
-        t = FIELD_DP64(t, MIDR_EL1, VARIANT, 0);
-        t = FIELD_DP64(t, MIDR_EL1, REVISION, 0);
-        cpu->midr = t;
+        u = FIELD_DP32(0, MIDR_EL1, IMPLEMENTER, 0);
+        u = FIELD_DP32(u, MIDR_EL1, ARCHITECTURE, 0xf);
+        u = FIELD_DP32(u, MIDR_EL1, PARTNUM, 'Q');
+        u = FIELD_DP32(u, MIDR_EL1, VARIANT, 0);
+        u = FIELD_DP32(u, MIDR_EL1, REVISION, 0);
+        cpu->midr = u;
 
         t = cpu->isar.id_aa64isar0;
         t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2); /* AES + PMULL */
-- 
2.21.1


