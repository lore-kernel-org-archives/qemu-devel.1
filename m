Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CA6C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94865204EC
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMo5t55+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94865204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYIR-0003iQ-QE
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEf-0006Cc-8p
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:45 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEc-0004iT-UX
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id h5so14036496wrc.7
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 07:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QBXoGJBUT/9dmeWjNdX79gBYw0pAnLWbE1PUY4IQSc0=;
 b=iMo5t55+4F4OvsAwf+NZr4I3HQ5EJT+4mTkRLhlg4vMhwksCp2gMDFQehcZGVEuNwL
 Tf78xRpUoouBIk23RzaTJ+8A7qrKo/FG/qOGHHPYac7/6tHXFZ3GejUV4r6ws5H/doeC
 V5r62HrDaXHhZYS9iCkV/2EQXPLvnlzhdeEUYxDiSNv4MovoDl2MPTqsaoND1UUFbIG2
 T2BVecRmILD7rbfgR39gED96juHnqhMMXTAy2Bj+GBaziDokOsqIPTsqVbrbE+E4Z1sR
 KgznzNhR5RqRJnAYZrJuqKX8Fz0Tr3n9pLHVYo9nJ8mO92BuiaaqbcY/ztHZc1i2/SZC
 PxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QBXoGJBUT/9dmeWjNdX79gBYw0pAnLWbE1PUY4IQSc0=;
 b=TBxiZ42iP4EpLz+aAxKemGEFICWvlflhwuI7zKCbLSzOF2u0xy+Mc3cDzS6v5VrWgq
 RKxgt+U47rXHc4iodszv2QxI0VCHteHvXBx/zghSDHlFF+OX+LzXc/FCubmeJXlK52mm
 L9LdQ5qxyZfBUWQNjAXzIrm1ky4b7Vbp0EqohXa98NDLP7C+SKGj5bvxWlhpO069VWHm
 eKyZE9NwMdh6CUwLvnKIW0G+Op0sNoIr0SdB5AMpfYSeC/e7fyT6iWKdVI3Dqsc46KVm
 bJofyY2eU3bR219+bwI9tAtAmAyE/RYmtxvPzo/mo6fFAv5DxsZhJVupAxr98D9eQjY3
 /Sxw==
X-Gm-Message-State: AOAM5303gxuFbb+8ARtlYnhBWfR0mdxSSZnZP2h0RXd4A4rXMnu8V6fl
 HYgvM2Sz+1f77iA0VHS9URmOnw==
X-Google-Smtp-Source: ABdhPJw+4Mi1tYM3roze4/qfv/RnW61oMkQqbxyuLVz73qDxW03glVP+LZ/U27LvZJDG5T7b4VufcQ==
X-Received: by 2002:a5d:5549:: with SMTP id g9mr13803422wrw.419.1593354281655; 
 Sun, 28 Jun 2020 07:24:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h13sm5321555wml.42.2020.06.28.07.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 07:24:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 08/17] ssi: Add ssi_realize_and_unref()
Date: Sun, 28 Jun 2020 15:24:20 +0100
Message-Id: <20200628142429.17111-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200628142429.17111-1-peter.maydell@linaro.org>
References: <20200628142429.17111-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an ssi_realize_and_unref(), for the benefit of callers
who want to be able to create an SSI device, set QOM properties
on it, and then do the realize-and-unref afterwards.

The API works on the same principle as the recently added
qdev_realize_and_undef(), sysbus_realize_and_undef(), etc.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/ssi/ssi.h | 26 ++++++++++++++++++++++++++
 hw/ssi/ssi.c         |  7 ++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
index 93f2b8b0beb..4be5325e654 100644
--- a/include/hw/ssi/ssi.h
+++ b/include/hw/ssi/ssi.h
@@ -79,6 +79,32 @@ extern const VMStateDescription vmstate_ssi_slave;
 }
 
 DeviceState *ssi_create_slave(SSIBus *bus, const char *name);
+/**
+ * ssi_realize_and_unref: realize and unref an SSI slave device
+ * @dev: SSI slave device to realize
+ * @bus: SSI bus to put it on
+ * @errp: error pointer
+ *
+ * Call 'realize' on @dev, put it on the specified @bus, and drop the
+ * reference to it. Errors are reported via @errp and by returning
+ * false.
+ *
+ * This function is useful if you have created @dev via qdev_new()
+ * (which takes a reference to the device it returns to you), so that
+ * you can set properties on it before realizing it. If you don't need
+ * to set properties then ssi_create_slave() is probably better (as it
+ * does the create, init and realize in one step).
+ *
+ * If you are embedding the SSI slave into another QOM device and
+ * initialized it via some variant on object_initialize_child() then
+ * do not use this function, because that family of functions arrange
+ * for the only reference to the child device to be held by the parent
+ * via the child<> property, and so the reference-count-drop done here
+ * would be incorrect.  (Instead you would want ssi_realize(), which
+ * doesn't currently exist but would be trivial to create if we had
+ * any code that wanted it.)
+ */
+bool ssi_realize_and_unref(DeviceState *dev, SSIBus *bus, Error **errp);
 
 /* Master interface.  */
 SSIBus *ssi_create_bus(DeviceState *parent, const char *name);
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index 67b48c31cd6..a35d7ebb266 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -90,11 +90,16 @@ static const TypeInfo ssi_slave_info = {
     .abstract = true,
 };
 
+bool ssi_realize_and_unref(DeviceState *dev, SSIBus *bus, Error **errp)
+{
+    return qdev_realize_and_unref(dev, &bus->parent_obj, errp);
+}
+
 DeviceState *ssi_create_slave(SSIBus *bus, const char *name)
 {
     DeviceState *dev = qdev_new(name);
 
-    qdev_realize_and_unref(dev, &bus->parent_obj, &error_fatal);
+    ssi_realize_and_unref(dev, bus, &error_fatal);
     return dev;
 }
 
-- 
2.20.1


