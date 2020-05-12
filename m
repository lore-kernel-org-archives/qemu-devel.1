Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AD6C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF23620736
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCH+FWx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF23620736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYPgl-0003Mj-St
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 03:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYPeK-00007r-Sw; Tue, 12 May 2020 03:48:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYPeK-0002qv-1z; Tue, 12 May 2020 03:48:24 -0400
Received: by mail-wr1-x441.google.com with SMTP id h17so5192807wrc.8;
 Tue, 12 May 2020 00:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9+HPWfi6hB2pKPErn5CtXaV2y+G6fIj46U87L3EGk9I=;
 b=NCH+FWx/bgOA/G53S0IB6rTD2XBw3Od7DLlx/agjhBGCfL8N7pnZFXs/MvFEbIFZfC
 lIdbXSDZxlVpFLvo+yaMoM/cLbfbEeyPNfyT7zdcSEuQuYPzSh8gIrLIIVbgbou7RQQf
 OcLVcPMhO7xefC7Xa9ZPPVJLIebhYCTN2kkPLWtYTk7QmAHD7jqoNNZ5GJQ+wNnzo5xV
 KOyOZIKsSXm4VtOsT/ECatvujb7ut+RKfKtZyfzPBOx/Ky8dVOTHvc+Rn9QJG+MVucSB
 4ctM/kanl2j/CY/jq+EgolQu2G8t4brmhclm0QFQhEMfs/EejRNA49pNwRITIjoFiob6
 GF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9+HPWfi6hB2pKPErn5CtXaV2y+G6fIj46U87L3EGk9I=;
 b=moRN58MwuKsGH3iYTfDvBt3UlJqPSO9vWUC16f4aEsdCPa8ieojGN9lgG0seSoAMob
 PKfu84CpD4Dg3f4DpkkaKroC1gWHw7nhjvJjvRyOf4rQrs2dIsvORJXOWQRSl53TBNIU
 +dLDWQdibarqIW+ee/TJTa3Eq33a1MRI8gVd6zECI35fqLzuwtWeiTStTG0stgyjyLsC
 SSQUqJc11H85NQ6LuJn1ewic8RZaPCYnWvBka2x40wgx2IOL14aQ5oPf4GtQQ6CkzGvj
 WFB44ztVkV+U/8E9xwNSwNf+oDKoGqtd+XRdVqPMH0aSWyqA2Y7lQByj0MF09L9JOQyo
 Lwkg==
X-Gm-Message-State: AGi0PuanpByaI8GkAZrU73MgdwF0OVINg2WzGJ5yvBnbqiaWYbrZbrhq
 1SkwG0fdVflSHk/KDl4uOkUjqsG90IE=
X-Google-Smtp-Source: APiQypKkiNw8fkb0TPe0cxQGwb02CaORIWkDEN3FLgHhW8Pup6YHsTQk8RRrz3bviGdDv0C7yKVfqQ==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr24475859wru.188.1589269701741; 
 Tue, 12 May 2020 00:48:21 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id c7sm7783754wro.80.2020.05.12.00.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 00:48:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] hw/openrisc/pic_cpu: Use qdev gpio rather than
 qemu_allocate_irqs()
Date: Tue, 12 May 2020 09:48:13 +0200
Message-Id: <20200512074813.29992-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200512074813.29992-1-f4bug@amsat.org>
References: <20200512074813.29992-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stafford Horne <shorne@gmail.com>, John Snow <jsnow@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity points out (CID 1421934) that we are leaking the
memory returned by qemu_allocate_irqs(). We can avoid this
leak by switching to using qdev_init_gpio_in(); the base
class finalize will free the irqs that this allocates under
the hood.

Patch created mechanically using spatch with this script
inspired from commit d6ef883d9d7:

  @@
  typedef qemu_irq;
  identifier irqs, handler;
  expression opaque, count, i;
  @@
  -   qemu_irq *irqs;
      ...
  -   irqs = qemu_allocate_irqs(handler, opaque, count);
  +   qdev_init_gpio_in(DEVICE(opaque), handler, count);
      <+...
  -   irqs[i]
  +   qdev_get_gpio_in(DEVICE(opaque), i)
      ...+>
  ?-  g_free(irqs);

Fixes: Coverity CID 1421934 RESOURCE_LEAK
Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/openrisc/pic_cpu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/openrisc/pic_cpu.c b/hw/openrisc/pic_cpu.c
index 36f9350830..4b0c92f842 100644
--- a/hw/openrisc/pic_cpu.c
+++ b/hw/openrisc/pic_cpu.c
@@ -52,10 +52,9 @@ static void openrisc_pic_cpu_handler(void *opaque, int irq, int level)
 void cpu_openrisc_pic_init(OpenRISCCPU *cpu)
 {
     int i;
-    qemu_irq *qi;
-    qi = qemu_allocate_irqs(openrisc_pic_cpu_handler, cpu, NR_IRQS);
+    qdev_init_gpio_in(DEVICE(cpu), openrisc_pic_cpu_handler, NR_IRQS);
 
     for (i = 0; i < NR_IRQS; i++) {
-        cpu->env.irq[i] = qi[i];
+        cpu->env.irq[i] = qdev_get_gpio_in(DEVICE(cpu), i);
     }
 }
-- 
2.21.3


