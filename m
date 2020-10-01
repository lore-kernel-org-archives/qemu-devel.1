Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8070BC47420
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0FCE20897
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELPRRGRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FCE20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1kV-0004td-Qe
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO1g4-0000DC-V3
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:43:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO1g3-0006EW-F5
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:43:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id w2so3612209wmi.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x6kGxn4MIKwxLSY1d8I1BClrthzon31d/eVho3rjiZ8=;
 b=ELPRRGRbY7jF8iKPppxzJ2VWwa9q8WcGGkVjdYjcC0dlecF+4CTwdjvkhyhIcoTWOD
 lPedZtfDzWDGy6q2GRfeBDaNu0KgPDF8ymxFIFnRQFu9uGprn3rfj6u/dLVBBzpCf0ey
 OOtaFz4ZLCSVikI/DHFnvJM+u0KCM9RnPbYvR189hSbyyJD4BHmy1nWrQ13kA6Xn1sRF
 wwT+6pKSbt+2rjrvDqIiOtbNjs7p1EYzMgSJusCbnJdND55XOidN+SMF3vxVatLylTMh
 0ezFQ4amWpk/JTp5LZ6MrCLvP606Js439iDCXQI5PcXFKrcK/24DWnUOBC00eLV99XwU
 OOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=x6kGxn4MIKwxLSY1d8I1BClrthzon31d/eVho3rjiZ8=;
 b=AFoB4q9Fuq1st7llW7LwvgL7oQ8nTxzac4CfI+ywuCf5sdPJJ7vxxW7+becf3naGbJ
 T1tWb9ecqwoNn+lt09uPc5H2EhGKRVx9R+uwjKv4cT256sho9k5sDFbIwxJ4w95v9t8h
 i+Y0BFKSF9eJmkc6FHK1gTgNRWJr+mvqH+bUxt+6qkRt6ze2RWUl9MDNy3W6YA6GfAwx
 Nz9lG0FSpoLo8fUZGOMJyqgRmw/pCRB4QT3DKXKaag4feT+f2MWptWajIa4muOrSmAQk
 ySTIlVbzvSTFB+ZE+Wvnk7Rf0yICHzz4PjDfB5/l0cHLhJCvpa2xrPZv/09MHydoX2SM
 oAFA==
X-Gm-Message-State: AOAM5316eWT4XIGbwNk6eChtxqF6zlo/uDV7crrixIxg2Co4YTVM51Lv
 Ba/pfVOJk/oIp90TEqFuYHyY6SEHP9M=
X-Google-Smtp-Source: ABdhPJzUKjYZ43UDfU3PfSgZBmfvr7oaaVYiChY6anQdEbmd5PfZ9Gz/Sg4pAiJvwmNfXpWHiIdEdw==
X-Received: by 2002:a05:600c:414a:: with SMTP id
 h10mr919597wmm.79.1601570609879; 
 Thu, 01 Oct 2020 09:43:29 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id h3sm10733059wrq.0.2020.10.01.09.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 09:43:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] hw/qdev-clock: Display error hint when clock is
 missing from device
Date: Thu,  1 Oct 2020 18:43:22 +0200
Message-Id: <20201001164322.1585392-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001164322.1585392-1-f4bug@amsat.org>
References: <20201001164322.1585392-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Tyrone Ting <kfting@nuvoton.com>, Damien Hedde <damien.hedde@greensocs.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of directly aborting, display a hint to help the developer
figure out the problem (likely trying to connect a clock to a device
pre-dating the Clock API, thus not expecting clocks).

Reviewed-by: Luc Michel <luc@lmichel.fr>
Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/qdev-clock.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 47ecb5b4fa..33bd4a9d52 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-core.h"
 #include "qapi/error.h"
@@ -153,6 +154,11 @@ Clock *qdev_get_clock_in(DeviceState *dev, const char *name)
     assert(name);
 
     ncl = qdev_get_clocklist(dev, name);
+    if (!ncl) {
+        error_report("can not find clock-in '%s' for device type '%s'",
+                     name, object_get_typename(OBJECT(dev)));
+        abort();
+    }
     assert(!ncl->output);
 
     return ncl->clock;
@@ -165,6 +171,11 @@ Clock *qdev_get_clock_out(DeviceState *dev, const char *name)
     assert(name);
 
     ncl = qdev_get_clocklist(dev, name);
+    if (!ncl) {
+        error_report("can not find clock-out '%s' for device type '%s'",
+                     name, object_get_typename(OBJECT(dev)));
+        abort();
+    }
     assert(ncl->output);
 
     return ncl->clock;
-- 
2.26.2


