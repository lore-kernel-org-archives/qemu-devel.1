Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B98CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D8B21655
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbMyW7bK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D8B21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNf7Q-0001gS-BQ
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdjA-0008Cw-0c
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdj8-0007rf-Ie
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:35 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:43856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdj8-0007qe-Bs
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:34 -0400
Received: by mail-wr1-x434.google.com with SMTP id c2so21003643wrr.10
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xgA/nfPYbU/wnzE4LWtTg2UNcRZThw4UJ6slzE0LxoU=;
 b=LbMyW7bKdslaII83GV1xbLROtaD+ZotfiirSUVD6vJceeKbss9ykHyWY76DHQkzb0v
 XA0+h3YzwhginXpGBGSbXJ/uCeBUpnrJ9POhoYIbdSqavtLxq/ZJ5SELoRziAnASR9QF
 IWnMcLUyhFgML4IdiMhUXT50eyUApRgvr3C8VzV76BAi9ICNSdXAzLaCN+H/fq1+mu9E
 K6JwA0OrJfvC5ZJ0Gd/3J8rPd5gtPedWe1z4nE/WGayU0KC+AsC8K35yrb8HuDcGMNEZ
 imclijIqlHfgCsKaMkOSokWftwCOyxUcbr6lwcoWu5tvmgseo/tVh7zPAYxdU7zwhW2f
 QgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xgA/nfPYbU/wnzE4LWtTg2UNcRZThw4UJ6slzE0LxoU=;
 b=AYHqkkS31fVG71YoFJl3Fgnn0lmXzH9aOSM+gAnE9DL4+27ZOw+XCm7Zy44iwIm8t4
 k8JRtv9Rp+uZ37Epujq3s0XtU55KqDnM5uJhGU0eqq0nYsLOB576RJdE35q1Kjnw2tqu
 Ll6tcOIxh26JS5ISqZiZSZ89NoL5nRgKp/5bspIUunnMfq027ZnlSjqAk/Fzid5q30Of
 jZ2BD51BJBZzalwGbt5a4ooAJrn1GrPnwNygANX0GELE1qiMYCDJB5Zws8RF63db5+VY
 Qa5QvpP1FLdD90Z9XSrP56wUQKfX2Hcmm1z4YlaERxD+1ZuUh2sfDZgXnwKTx5pf1P9x
 MVJg==
X-Gm-Message-State: APjAAAXgieRbzd/3Hsm7u2kKfv4n7nUjwUgOtMTba3mWDYPKJSiQI5kJ
 xqS4Omrq/fLK0zAVNx3lbEsvfwyU
X-Google-Smtp-Source: APXvYqzjj66oYe4cundTg3pmDCwXXDMiAMALKxgoMd1F72ypDGL6L/VT1cbtB0gzBcp5SgsZMSscag==
X-Received: by 2002:a05:6000:11cd:: with SMTP id
 i13mr3899820wrx.197.1571925872989; 
 Thu, 24 Oct 2019 07:04:32 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/39] mc146818rtc: Move RTC_ISA_IRQ definition
Date: Thu, 24 Oct 2019 16:03:48 +0200
Message-Id: <1571925835-31930-33-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The ISA default number for the RTC devices is not related to its
registers neither. Move this definition to "hw/timer/mc146818rtc.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191018133547.10936-3-philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/timer/mc146818rtc.h      | 2 ++
 include/hw/timer/mc146818rtc_regs.h | 2 --
 tests/rtc-test.c                    | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/timer/mc146818rtc.h b/include/hw/timer/mc146818rtc.h
index 0f1c886..17761cf 100644
--- a/include/hw/timer/mc146818rtc.h
+++ b/include/hw/timer/mc146818rtc.h
@@ -39,6 +39,8 @@ typedef struct RTCState {
     QLIST_ENTRY(RTCState) link;
 } RTCState;
 
+#define RTC_ISA_IRQ 8
+
 ISADevice *mc146818_rtc_init(ISABus *bus, int base_year,
                              qemu_irq intercept_irq);
 void rtc_set_memory(ISADevice *dev, int addr, int val);
diff --git a/include/hw/timer/mc146818rtc_regs.h b/include/hw/timer/mc146818rtc_regs.h
index bfbb57e..631f71c 100644
--- a/include/hw/timer/mc146818rtc_regs.h
+++ b/include/hw/timer/mc146818rtc_regs.h
@@ -27,8 +27,6 @@
 
 #include "qemu/timer.h"
 
-#define RTC_ISA_IRQ 8
-
 #define RTC_SECONDS             0
 #define RTC_SECONDS_ALARM       1
 #define RTC_MINUTES             2
diff --git a/tests/rtc-test.c b/tests/rtc-test.c
index 6309b0e..18f8956 100644
--- a/tests/rtc-test.c
+++ b/tests/rtc-test.c
@@ -15,6 +15,7 @@
 
 #include "libqtest-single.h"
 #include "qemu/timer.h"
+#include "hw/timer/mc146818rtc.h"
 #include "hw/timer/mc146818rtc_regs.h"
 
 #define UIP_HOLD_LENGTH           (8 * NANOSECONDS_PER_SECOND / 32768)
-- 
1.8.3.1



