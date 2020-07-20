Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92549C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61039207FC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qBsI2Ra4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61039207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxVQa-0002Zc-E0
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 09:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLO-0002P6-MU
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:53617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLM-0007JD-Tp
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id j18so22172187wmi.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 05:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=10LO/QCoMpR7jIRc6OlNm9WJ8aeWJRb66wCBW65n2ZM=;
 b=qBsI2Ra42VlwXp7Kl2gFxtX2bIeSOIuL0xgUxvSkhbKPu9BjvUUAp1JYL2yIGO6ys5
 sjQlpiPSJZp03F/LoViTNm5gToBlaK8P8zWqaZ9RiW7kVBSIJon7AIdthIC81DAL8L8u
 0x4gNzEwuSkYEx1bVgE0vxLdwFWDGpCmIYdl/zUqIaeu9GazyvLPh3I9WZh8Q3ZTndJ5
 aiU4Kdr8kG3xpVkotYfW8tJdz2OTexWA3VP9Cb06Fq2mBWjppH7QW3VNcnRm6aUV6VJ4
 jTkQlSrO+z2f95VQQmp3D3V4oA0jcXjPdYvSltatfJwI4lKU4dtMMVvrDSBe/pBQl2rm
 blUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=10LO/QCoMpR7jIRc6OlNm9WJ8aeWJRb66wCBW65n2ZM=;
 b=fv7Axyg6ZU322gBzqqTlkxxsKtzs7EIksvD/bmjPsLJyu+ckO530S1fHc/rZxAcwyl
 x3MRum5CmS2FoJAhe0pO1Jy3hpr/1WeIcboHH23DhCjnvvCfFvE4nxOQeRVzU9Rahr9b
 AtTeQcs3gmdl1p4hEIawc8VyCGH/GMFkjn0TUaAH5wl20ysDyj2LUN009+Qd6luUAhhS
 aUoyjILci5oB2t2U0k83fRyCY6GAmLjTPQCDIZwk0Z5w2vxO6nEhQZ+okEdtn87b13W9
 ZKw/Pb6QAYMd3LcFqQW0hawh9NFEcNwOuAma/dXIqF+UFjo5SwxNcB2StdoS6wDwksiJ
 2DTQ==
X-Gm-Message-State: AOAM531S2O3pqhe2OQxsx4lt0cs4D2k3BQkFf2NU58QNq0Kt0h5ax6D5
 y4uZrTrSH+GlKCCjiPrnFB4mP/xe49mywg==
X-Google-Smtp-Source: ABdhPJx4sxD/jRp3i20+IEuQAsXn7R4814Nuv1qyi9DFsMlaaZJ1IjEkMzhir6pFooD7b9V/qUd4DQ==
X-Received: by 2002:a05:600c:249:: with SMTP id
 9mr20186415wmj.80.1595249791240; 
 Mon, 20 Jul 2020 05:56:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p29sm34025403wmi.43.2020.07.20.05.56.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 05:56:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/12] qdev: Document qdev_unrealize()
Date: Mon, 20 Jul 2020 13:56:15 +0100
Message-Id: <20200720125621.13460-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200720125621.13460-1-peter.maydell@linaro.org>
References: <20200720125621.13460-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a doc comment for qdev_unrealize(), to go with the new
documentation for the realize part of the qdev lifecycle.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200711142425.16283-3-peter.maydell@linaro.org
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


