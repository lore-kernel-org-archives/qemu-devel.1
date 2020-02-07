Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45077C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102C6214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCzqjVQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102C6214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05AH-0003Vd-7Y
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iM-0001bz-DB
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iL-0003hd-AQ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:38 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04iL-0003g9-4A
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:37 -0500
Received: by mail-wr1-x435.google.com with SMTP id z3so2977071wru.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UCTgH8+JIicTcdeMwWbA7Fm/8BcoGqpf7BduEhNp0D4=;
 b=CCzqjVQc8rRlDBbpCApRo2A5ieyiXwCmKzZ/BGTnZDIyvtwTtGek6Zh5eLbmayo2s/
 iM4PnzSQTkZDzxagoMlKmjRUnvXzOGCfjKzhAMmwlWZWAlqLUKq40CXu0dCbQTCsACqX
 /ljvKwuOGueL9q9zlNZuWuvQVIXtoGMvp5oVMKYAoB2fSpoh5Dt1HbWtqvamAn2jnGDh
 5L96lSydfQsJXVLBR40T3FwEnI7qAUE+OnlaDr/DUWwy6x6QCt8f6WV1vtcGLNNL8oas
 N98hrkzplVMqK9bAhuJ4o7DC/8ntAxOFKKNkVtQBLHB3D9NSSJXKNffRky5sJNIcmIMb
 OT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UCTgH8+JIicTcdeMwWbA7Fm/8BcoGqpf7BduEhNp0D4=;
 b=cu71lDJqgkcb0Qf8B/0MZLFfMiVqjrzUHo1fQevROyM+oaNMAFh63BTqnaFJLnnFLg
 9ppNX90fLecClSiexXwS1c00VxaIgobJpP15tS366rCA2tIgjsYZ7eZ81c43wwc+0dct
 2rwdsGRphBUHKkLkzNEVGZsrZP3oj1FIkSZv8PZ29KZfijLybFJh+D1+54/b4GmPZhyi
 rkzw6PjRCqs0lY7PTHQgFT++L9FB2bnE8GE/BDE8Tz/YLCTLIInaCUfF3TnadS9Q+v0Q
 NAZ1T9drtFZv+Upq7bqvmmyuzgFesrZmuOo/YIJivhuU+Gg3US4h44Yy7+dL+FGlrpcs
 9CUQ==
X-Gm-Message-State: APjAAAVo6eO2fGvu3aGWZWh7Dg636KZ7qtM301w9s2JS0+5vm7qHRQK+
 w/AQKaEo2iLkdxl5ZpZvoOFBkVyN96I=
X-Google-Smtp-Source: APXvYqyLN30NEzqyXqmVE9laItkjptCrsW0Xa5YAU5yPfxJOnn9WQsuyiOPoqDYWXtshcBft7puaEw==
X-Received: by 2002:adf:ab14:: with SMTP id q20mr4965372wrc.274.1581086075868; 
 Fri, 07 Feb 2020 06:34:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/48] stm32f2xx_timer: delay timer_new to avoid memleaks
Date: Fri,  7 Feb 2020 14:33:42 +0000
Message-Id: <20200207143343.30322-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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

From: Pan Nengyuan <pannengyuan@huawei.com>

There is a memory leak when we call 'device_list_properties' with typename = stm32f2xx_timer. It's easy to reproduce as follow:

    virsh qemu-monitor-command vm1 --pretty '{"execute": "device-list-properties", "arguments": {"typename": "stm32f2xx_timer"}}'

This patch delay timer_new to fix this memleaks.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200205070659.22488-3-pannengyuan@huawei.com
Cc: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/stm32f2xx_timer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index fb370ce0f05..06ec8a02c25 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -314,7 +314,11 @@ static void stm32f2xx_timer_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &stm32f2xx_timer_ops, s,
                           "stm32f2xx_timer", 0x400);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
 
+static void stm32f2xx_timer_realize(DeviceState *dev, Error **errp)
+{
+    STM32F2XXTimerState *s = STM32F2XXTIMER(dev);
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, stm32f2xx_timer_interrupt, s);
 }
 
@@ -325,6 +329,7 @@ static void stm32f2xx_timer_class_init(ObjectClass *klass, void *data)
     dc->reset = stm32f2xx_timer_reset;
     device_class_set_props(dc, stm32f2xx_timer_properties);
     dc->vmsd = &vmstate_stm32f2xx_timer;
+    dc->realize = stm32f2xx_timer_realize;
 }
 
 static const TypeInfo stm32f2xx_timer_info = {
-- 
2.20.1


