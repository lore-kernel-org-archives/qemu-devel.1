Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF08FC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC4D72474B
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENRdqPba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4D72474B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmmSt-0002WB-Uz
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 18:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmRx-0000cD-Nw; Sat, 20 Jun 2020 18:59:01 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmRw-0000xN-1w; Sat, 20 Jun 2020 18:59:01 -0400
Received: by mail-wm1-x342.google.com with SMTP id r15so12410857wmh.5;
 Sat, 20 Jun 2020 15:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1EmMkDGz40VvlDmmAJ5wSvoG7UtZ6Z1IC3NHjnyHGEo=;
 b=ENRdqPbaVtszO5tfxJeAKt6Jq3Y++A+x2/Qj2DHV1wtYqOnJzPUltJwiN5tKKhQhjY
 TLjdEmyQfouGIqnDbAOXb+xfMjIapMHPGBXLBq5KN4eTqreih6xFvMaBBUF8gjcgiaqz
 HMTrWRs4BZDFJh/DO47Dafz7xQXS6BubHG8gTYBWEEoc32tEpSQ0Ar745qq/O2GMlUvf
 fRLLrAGUzMavHYHXL4HT+AvHGCIirHot2xAzbWJN+nYNjO7t5spFE4ivQXlYe2SC8zZf
 QdTw0HOH3KhcweO0MsAlbzVGJEa9hJZlp1ar7mc/3/pDzFRyMD5i8Zc5D8OWqHkDg5J+
 c+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1EmMkDGz40VvlDmmAJ5wSvoG7UtZ6Z1IC3NHjnyHGEo=;
 b=q9Hke66ha5Cn8H4GQNMwYRsnpfxSHLe1hUOwIqSk+KGnTIuHTQOQ3Av+h0jxpg3o24
 2kdq1dLhKcN5pP+dPK6rVNmE92FRDFO3sGvd4iSUvJoiE/1zUCwpWCQFaCVYUgFcj5Hi
 3yM5mI4F3adv1huBCbONHSRUQaWcqCuXcFZKpj5J+WXr8763DSWaB6zGsKURUYWW2VPB
 MXIY5WoQklQGR/J4z5HwTVINZUP2NxOyi02s8SaezYApMRv73pf3i+CA5n+LuqaZfy88
 hsBxJrzgdmWfweppCUZPg3TSvMH/COQDMPGrmbkJ09QJuTYAP5roHBB2wdwNKZMQwdvK
 dZ/g==
X-Gm-Message-State: AOAM531d0GGS87T+VWC1a+KZxFWu4LFQSaB7Ik2+KIky3d0t2pz3w3ev
 3tMTJ6ZBAGZyRBkTpm5XEyJIrSIu
X-Google-Smtp-Source: ABdhPJx67n+3C2GLRa7WwFED4lcPxjdddr8AhxTuV0wtFG42AfceuUew4Q0jOlWaOvNmHxUpq55sPg==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr11114667wmd.55.1592693938041; 
 Sat, 20 Jun 2020 15:58:58 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x18sm11147127wmi.35.2020.06.20.15.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 15:58:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/8] hw/i2c/core: Add i2c_try_create_slave() and
 i2c_realize_and_unref()
Date: Sun, 21 Jun 2020 00:58:47 +0200
Message-Id: <20200620225854.31160-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200620225854.31160-1-f4bug@amsat.org>
References: <20200620225854.31160-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract i2c_try_create_slave() and i2c_realize_and_unref()
from i2c_create_slave().
We can now set properties on a I2CSlave before it is realized.

This is in line with the recent qdev/QOM changes merged
in commit 6675a653d2e.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i2c/i2c.h |  2 ++
 hw/i2c/core.c        | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 4117211565..d6e3d85faf 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -80,6 +80,8 @@ int i2c_send(I2CBus *bus, uint8_t data);
 uint8_t i2c_recv(I2CBus *bus);
 
 DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
+DeviceState *i2c_try_create_slave(const char *name, uint8_t addr);
+bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp);
 
 /* lm832x.c */
 void lm832x_key_event(DeviceState *dev, int key, int state);
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 1aac457a2a..acf34a12d6 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -267,13 +267,27 @@ const VMStateDescription vmstate_i2c_slave = {
     }
 };
 
-DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
+DeviceState *i2c_try_create_slave(const char *name, uint8_t addr)
 {
     DeviceState *dev;
 
     dev = qdev_new(name);
     qdev_prop_set_uint8(dev, "address", addr);
-    qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
+    return dev;
+}
+
+bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp)
+{
+    return qdev_realize_and_unref(dev, &bus->qbus, errp);
+}
+
+DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
+{
+    DeviceState *dev;
+
+    dev = i2c_try_create_slave(name, addr);
+    i2c_realize_and_unref(dev, bus, &error_fatal);
+
     return dev;
 }
 
-- 
2.21.3


