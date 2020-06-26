Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883BBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 523D3207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2bc0kBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523D3207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqHV-0000yJ-Ii
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3q-0001up-Uz
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:38 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36083)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3m-0006Ci-JI
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:38 -0400
Received: by mail-wm1-x343.google.com with SMTP id 17so9709478wmo.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5NNpdAjIha1dM9ij9yn8AmBkK2T4lQIQisubYegz+24=;
 b=z2bc0kBn8qni+TYpmNR47RCxvOKOtjs6XldAc2gchth767mtaVYZxHWTdCRv/CQpJS
 99uuZmBzZYEj71m8qr3fCK5tWZqYe5HsDuYIO3I830t4j8iV/z4ztzQFx3vQTYmPhle2
 pDOedvlfT8bXDfhEKIDQhLVP7CFuCpuQcuBQ8nztLl7YzML8iiiGMUqPLJItxD41Y0PD
 93Fb2r7beiFMuGnmtxyjmLG6wNegtnFT3no66mOB+MFGEHZJ6HrLyhsWK/LNLkLkCEP+
 RO4NWCQC9d8p4UA1fsuGxSG5O2M2mZWI8qe9P0668tntzprmbpszZAAKFf9jRkO+lI14
 cxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5NNpdAjIha1dM9ij9yn8AmBkK2T4lQIQisubYegz+24=;
 b=a/OwhZNWQcH1437kl4J62c3CCRddiP0kTCMxTEhQ1jWv5vPrRJyQ5/3S73fb80c4Q9
 lW3xR5NitIWgVIM12a0viGDkdz8CMdMh62mLaWS2F5nB+dAdt1T84J7srFWgq9nj3A95
 3EVOAfvlVyYEsV2iYCj9AG9fwNVe96Enzmbc/OY96zxeW+UrDAW5YoOt/C26P40CGVNI
 ChWketdxL+U6QxAQVYg6abEh42+CXGgskDrBSG9z5JcXsUs1rzm8LrTz0/j5UH7HIP7t
 uRMVM+jWkxL8Qa3010/O4GEKZsNuULcAv7/NrTYuKcVCp7iPm+idiMpqTY5LWmK+6J0P
 EL4A==
X-Gm-Message-State: AOAM5323xKMWsby/MVR4xup2oP/SsIN6lktgb3BSI9aZVBpY/6yu1zDp
 yzTsY0E4OBvZQCYoAWasL16fsRef8ZKxpA==
X-Google-Smtp-Source: ABdhPJzWjJJZN8A3jeQ/Yhmhn1W6jelt7U5K6bfSV8eggKX0JD1xiocNLROw0Ct4pCTkqSc5wh+k5g==
X-Received: by 2002:a7b:ca52:: with SMTP id m18mr3918676wml.92.1593184471473; 
 Fri, 26 Jun 2020 08:14:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/57] hw/i2c/core: Add i2c_try_create_slave() and
 i2c_realize_and_unref()
Date: Fri, 26 Jun 2020 16:13:31 +0100
Message-Id: <20200626151424.30117-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Extract i2c_try_create_slave() and i2c_realize_and_unref()
from i2c_create_slave().
We can now set properties on a I2CSlave before it is realized.

This is in line with the recent qdev/QOM changes merged
in commit 6675a653d2e.

Reviewed-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20200623072723.6324-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/i2c/i2c.h |  2 ++
 hw/i2c/core.c        | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 41172115652..d6e3d85faf0 100644
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
index 1aac457a2a0..acf34a12d6d 100644
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
2.20.1


