Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1EFC5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E123206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tblbu+7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E123206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8HK-0002hr-UY
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59401)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4bD-00072Y-JF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4bA-0004PX-Ey
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:16:35 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:52959)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4bA-0004PA-6i
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:16:32 -0400
Received: by mail-wm1-f42.google.com with SMTP id s3so989036wms.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=o6tJonaWbPJQHk+WHfPFs3EZy62SAe8H5ByWEfMlaXA=;
 b=tblbu+7+WjY/sWIznRy9L6qiQm6ggh5fhapgt8YDfHwMnH89VrGcDX4D8SE3DuoOFr
 +UZS/YcLYBUlIf+XRIycQs8GrOny6kbT1LxeSUw2ttMB4lXMGYvZW9ewHdZyPflsxcP5
 rqNCbjx/ZKraKqNclNzjji1wvE08Nmh6Qi3gH7qz7zjkWqBxytwViXQUl/pqZCtUHrSI
 uCPTS/Rz7McuQjXJP+VMlc3wOIsi/0Z7IRvBygE91NqNcTHPuc2vZqy12anBhxvZW520
 fAOv7y7nH/9boG6DoQLBjx2uyJnxxQN03xNdJW+h5d8RM3FtWzD2OaUOSdZIRLBX+Qet
 XBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o6tJonaWbPJQHk+WHfPFs3EZy62SAe8H5ByWEfMlaXA=;
 b=FQuy2LCpoHNX/gOrwTTDLNs8847cEdmvF2ZXeD6OGa4HdAaC1pRHNArL68Pnzzm4fB
 zcbTTxZ0vbuH5Bvm9UdiEf+l1s2AsVnbzQiXVsbQXhSDZGjy/mTOu5CGuy1eNsgqoeNj
 XUDW43u620m2upMZ5wFHzkq4I+IV1Kw5+knm5vsnuXY4/IiE1c6Z5QZbdm/gt0VAuK4O
 2n7kMCFVO6L8I5Va02vWom4JeYcgdiJAs0vPA8Uc7YxERlu2KduAKH+Mc3nkLfPCudFf
 QZ8hz54XX126/Eyo/8M9MNkiW94YWf9TbAiMUg9vVRwe3pHqQ0fUBXwuqDE+QIhc6DlR
 iikg==
X-Gm-Message-State: APjAAAV/phqmywlOjoX3NsjZ6rl1wR4O5pPfoTdDTU9NtHaQzWuBDzuC
 cFiKv8x/bUOEMXAgX1jtN5OXPIdXLAR0lA==
X-Google-Smtp-Source: APXvYqyv6hfpyPdsLIIGcrshTcrztKBKx8Z+zZR8OHmB40GDIGwnPOnBY1jpWWw7Q62ptGP1ACNI4Q==
X-Received: by 2002:a1c:7a01:: with SMTP id v1mr155044wmc.10.1561999220910;
 Mon, 01 Jul 2019 09:40:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:30 +0100
Message-Id: <20190701163943.22313-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.42
Subject: [Qemu-devel] [PULL 33/46] target/arm/helper: Remove unused include
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701132516.26392-7-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d3f3cb57d5f..ca4d4a57bff 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -14,7 +14,6 @@
 #include "exec/gdbstub.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
-#include "sysemu/arch_init.h"
 #include "sysemu/sysemu.h"
 #include "qemu/bitops.h"
 #include "qemu/crc32c.h"
@@ -26,7 +25,6 @@
 #include "hw/semihosting/semihost.h"
 #include "sysemu/cpus.h"
 #include "sysemu/kvm.h"
-#include "fpu/softfloat.h"
 #include "qemu/range.h"
 #include "qapi/qapi-commands-target.h"
 #include "qapi/error.h"
-- 
2.20.1


