Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25E7C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E22F214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iM/3c60l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E22F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j053I-0007iD-QC
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iN-0001cF-9n
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iM-0003lF-82
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:39 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:35755)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04iM-0003iC-0k
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:38 -0500
Received: by mail-wr1-x430.google.com with SMTP id w12so2982041wrt.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=3x9Z8puf4FRlU9RT4Z9Jd/7VFhB0H6I8GPKb1zE750U=;
 b=iM/3c60lBVmQEbfGjobU2RPNpveMyGL02AR10OpVrIaEfwlnnmSOZlzOO2YGedDALb
 EdnPcpK5PoY2f2CDOIzFJI3h2O+Th904x9KFf/mLXDyvtBZg4T6wAc7NYatTwFpR6d0g
 f3VDYdZGiO2K8qo1l9dvLg4ulz2pcPDfSxo7SgWMQkKqch4QKxUyNe+ezN9lxLp1a7yE
 b01RvlDggxhu5ZXtPA4no1U4Z5h9PGH65NkJKUxel5ZV5WEJ854/dUe5+it32pgPUk5+
 m3jIR3pBUT9jot17IkPerMX1zXmhuXvy0WCJnJZtOJREYHpip3lkjL3fAvWADL+0agj9
 Nv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3x9Z8puf4FRlU9RT4Z9Jd/7VFhB0H6I8GPKb1zE750U=;
 b=FktNStPiCnB18mBCTBOLwqH0tBpj1gZdcabVBkTJbpDon02oblXV/Y8NrD08pmdU/o
 Mqgxm+WcIXvka9FdAOf9nFz8qJmYtFxhx4wB75tXF00yKhUBF6Ot/Xq8uLBdSXhrOJDm
 V4m1bUZz5XIG435VUYo9XUvvhmDQt9/S69xJXhhclC4b/VGst211kVhAxjM9b3/TMOq0
 zA+HW4qY6DsVHPWsiNyc9ZwRaobocF5WFc9kL+dGPbwfkkircYYgZFfgsMQ25c7y1EPj
 iX7dUldcYgAT6ZdoZ5S2bVxlUOMHie674BqCbXslT6lDnNrlwDYNYqBRdxu/rtNtkL6D
 scCg==
X-Gm-Message-State: APjAAAWKMdwKZuwbk6Kdk7Be9PvYKAa3Mxn/XBEo7UZcG/y0HqElNNRU
 LwkvvGGT8bNhsN423SDfb7UiRlkkHm0=
X-Google-Smtp-Source: APXvYqxWU6i+6hDcTAUOI7rAdAfg1u9I2FrGdPbODoczca4vziKRdxvSMpo5Yy+zPRyavrDeyWjLWQ==
X-Received: by 2002:adf:f803:: with SMTP id s3mr4965911wrp.7.1581086076818;
 Fri, 07 Feb 2020 06:34:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/48] stellaris: delay timer_new to avoid memleaks
Date: Fri,  7 Feb 2020 14:33:43 +0000
Message-Id: <20200207143343.30322-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

There is a memory leak when we call 'device_list_properties' with typename = stellaris-gptm. It's easy to reproduce as follow:

  virsh qemu-monitor-command vm1 --pretty '{"execute": "device-list-properties", "arguments": {"typename": "stellaris-gptm"}}'

This patch delay timer_new in realize to fix it.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200205070659.22488-4-pannengyuan@huawei.com
Cc: qemu-arm@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index bb025e0bd0d..221a78674e3 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -347,11 +347,15 @@ static void stellaris_gptm_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 
     s->opaque[0] = s->opaque[1] = s;
+}
+
+static void stellaris_gptm_realize(DeviceState *dev, Error **errp)
+{
+    gptm_state *s = STELLARIS_GPTM(dev);
     s->timer[0] = timer_new_ns(QEMU_CLOCK_VIRTUAL, gptm_tick, &s->opaque[0]);
     s->timer[1] = timer_new_ns(QEMU_CLOCK_VIRTUAL, gptm_tick, &s->opaque[1]);
 }
 
-
 /* System controller.  */
 
 typedef struct {
@@ -1536,6 +1540,7 @@ static void stellaris_gptm_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_stellaris_gptm;
+    dc->realize = stellaris_gptm_realize;
 }
 
 static const TypeInfo stellaris_gptm_info = {
-- 
2.20.1


