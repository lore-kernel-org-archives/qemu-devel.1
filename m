Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEBAC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 14:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D5B207D4
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 14:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6mAo2vI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D5B207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juGRZ-0001qq-5Y
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 10:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juGQc-0000c3-3o
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 10:24:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juGQa-0003uq-3b
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 10:24:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id g75so8915032wme.5
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 07:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kolLNOF8HbmShs7MFqOPOeHyZEKPtyACOZco1qtAgjA=;
 b=T6mAo2vIRplaYfgeGCLB5L9J2BiLpudNUDgUa9hF6DUzmJ5xDioQ3vUToKHZNcjcXF
 23dSyXKklCPiAqUPiomqaIOMq+BVb1yTAjTOcUij5GGc+x26tJpcaAm6nPcnCYB7XX8g
 OaLAolqoQ8m3pX7uY9jVquB1ZyLbnCDVd30OKOUfOh2g11a/OJJsepzdcsyRTR+coNas
 gW6drFlV96U3tKSGjWocvGyMlditXg35UZUGHoXIvjN4vNRLIx0ZN8WIGla4mDc8OX7H
 cJKs0YOY9SY5Hl0ilTNMO9Y3NilwA7h/814/+zWJmBTq/9Zu3ZTGMPbu1rMWvd3AQqnr
 ocmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kolLNOF8HbmShs7MFqOPOeHyZEKPtyACOZco1qtAgjA=;
 b=seaHJOYjX4fggp/4t7iZZjYl6o9vBLjl0Xtr4hUrFwRLGOp6qjfjhggSBzWXkTdA4f
 4AfXzG/Gdad8S3LjFvzW4YopuRV2niUqvqz9S/C/4kFVhDrvSV53ggzQv+M+GZtzndn2
 0p13SCnwNuON9FDrQDHv2i2P3fa3m4PgweblHsEpm8IgWuHHCgi6li9Q02XhzkINInZE
 c0gnWimqJk2xfKUl+K9QXMtB8ic3ew1vU4LGd1VuBbBqUwumdOeS/grKwZ31WQ0wy73x
 9yyHydZmAtBuAhVaSfYRlT31f0F8l/BHxAz+jogoBnDPHZ5SPO9e6yw6qaHigK4kXIZQ
 UqpQ==
X-Gm-Message-State: AOAM532owi/cHFG4QWPrPsxzlgPWF/60wAIYzZItBFXH6TsmzxiA1f40
 DJV3XOjOFQv7W6PHc1gImQgj5j1xskMc+g==
X-Google-Smtp-Source: ABdhPJzf22tmT/drucjzOpYgvFUFfniEipb8rGnIw+mpmVg6xerTHGKga2v8ZZsfVWmFPJdLjMLQYA==
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr9873663wme.46.1594477470515; 
 Sat, 11 Jul 2020 07:24:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u10sm13448525wml.29.2020.07.11.07.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 07:24:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 2/3] qdev: Document qdev_unrealize()
Date: Sat, 11 Jul 2020 15:24:24 +0100
Message-Id: <20200711142425.16283-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711142425.16283-1-peter.maydell@linaro.org>
References: <20200711142425.16283-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a doc comment for qdev_unrealize(), to go with the new
documentation for the realize part of the qdev lifecycle.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/qdev-core.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 2d441d1fb2e..1d2bf5f37da 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -381,6 +381,25 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
  * would be incorrect. For that use case you want qdev_realize().
  */
 bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
+/**
+ * qdev_unrealize: Unrealize a device
+ * @dev: device to unrealize
+ *
+ * This function will "unrealize" a device, which is the first phase
+ * of correctly destroying a device that has been realized. It will:
+ *
+ *  - unrealize any child buses by calling qbus_unrealize()
+ *    (this will recursively unrealize any devices on those buses)
+ *  - call the the unrealize method of @dev
+ *
+ * The device can then be freed by causing its reference count to go
+ * to zero.
+ *
+ * Warning: most devices in QEMU do not expect to be unrealized.  Only
+ * devices which are hot-unpluggable should be unrealized (as part of
+ * the unplugging process); all other devices are expected to last for
+ * the life of the simulation and should not be unrealized and freed.
+ */
 void qdev_unrealize(DeviceState *dev);
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version);
-- 
2.20.1


