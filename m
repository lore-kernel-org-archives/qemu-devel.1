Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04991C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A2F20674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMDCIDMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A2F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytJ8-0001CG-WF
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jytIX-0000hS-Ev; Fri, 24 Jul 2020 04:43:21 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jytIW-0008Kt-0V; Fri, 24 Jul 2020 04:43:21 -0400
Received: by mail-wr1-x42d.google.com with SMTP id f7so7569111wrw.1;
 Fri, 24 Jul 2020 01:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zZXxeH9LiRYphyBXoI9cVQm3f1Uq4vEVIj/fRYMSqH4=;
 b=dMDCIDMrVfKmLBy257IMaaYi/ECoq3yRRwVIv29EGORmrAtRRLo1LkLA84GCywlUzL
 jocc7kj5ODJZnue0e6YZjvhibL5RHt2UHPtJ7rJId598TGRW2FGLnXer9TwkNrCLc4g7
 j3ibTniA8puJUQZRLLSWw993Hw3KcVnZ5hXoBkjRo5l/VsRV0yazhgqL6Hmqvl2DMlEG
 WWn0hrtMO8z9+vRX+sxdAae4kb++ydeFyP7Czv40L8owZeuODPoZzxl7XOWlVszeVxU3
 Vjtre47gVkAedqOmqTkygqOvzwcMIp7/jwrnvxOE6/iFpI2BbeRRELecsOWhiMfiEWT+
 obwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=zZXxeH9LiRYphyBXoI9cVQm3f1Uq4vEVIj/fRYMSqH4=;
 b=fiFs2e5k3QVnDykPz3XY6FhlioivPIuP05figqdbHRgGMPbKxjOO38g9lcEhcJfQuH
 iCRCwebCcU6m/zpfu5mF9ibI9kV6P5hZ7X1VJB/zIaC+vcJmxnfHkAYdLjearjblk0KP
 AgNIRw2AO66mw+kJtkPVDd433n70G9+7ukS0G/Uroy6vDCJQbuUsf7Tj8tlWxR3uHI99
 22pE3WNszETJ1NJvO2DxgPD2sTQkKWopPw6c1tRvyOpEMpdwtbHAt5LXuWiUTzCaI+zi
 Xsv73M7YYMIE7qKVU9j9IJBVyCNNSBCy/jcXA8JG8a5hf/4OaRD7+gtOuCQnRu+Cnqmy
 x+Lg==
X-Gm-Message-State: AOAM531cWRpQNx+p1jhHOrl0tMr3QucbrkGPJlBypiD2KJMbLnYMwxQR
 0wr9EmKjt+n30UVk7yFTq22gwnv6Lgg=
X-Google-Smtp-Source: ABdhPJzj9hmGq8f5Qfq+MpwLVMc7JKE+OHrIs1OU8yGG2dErcX1PMAVGBir8+cm+vKWXEByYcO0unQ==
X-Received: by 2002:a05:6000:4e:: with SMTP id
 k14mr7427144wrx.303.1595580197475; 
 Fri, 24 Jul 2020 01:43:17 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id z12sm508941wrp.20.2020.07.24.01.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 01:43:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] stubs/cmos: Use correct include
Date: Fri, 24 Jul 2020 10:43:15 +0200
Message-Id: <20200724084315.1606-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cmos_get_fd_drive_type() is declared in "hw/block/fdc.h".
This currently works because "hw/i386/pc.h" happens to
include it. Simplify including the correct header.

Fixes: 2055dbc1c9 ("acpi: move aml builder code for floppy device")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 stubs/cmos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/stubs/cmos.c b/stubs/cmos.c
index 416cbe4055..3fdbae2c69 100644
--- a/stubs/cmos.c
+++ b/stubs/cmos.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "hw/i386/pc.h"
+#include "hw/block/fdc.h"
 
 int cmos_get_fd_drive_type(FloppyDriveType fd0)
 {
-- 
2.21.3


