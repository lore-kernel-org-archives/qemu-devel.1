Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3E1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9DBA255C6
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3n15UdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DBA255C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpxpw-0004ED-2f
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 13:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpxjo-0005zF-5K; Mon, 29 Jun 2020 13:38:36 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:33100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpxjm-0000Je-5l; Mon, 29 Jun 2020 13:38:35 -0400
Received: by mail-ed1-x544.google.com with SMTP id h28so13590538edz.0;
 Mon, 29 Jun 2020 10:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mUMQBpWA8/buAmRWchgLW3e3qoVa4wLDDSi2yUI7jTM=;
 b=V3n15UdO3kNxinKrmh7Y9xCMJjWnGd/yLFyrQDorlGhu2O1eejtuSUUIXErVfqEXSp
 AKafuI9/2/sa+ESSILMP7cQuaLZtFaTOlFh9R4pSfYchruDOM5alI1QgDXK8HboCo/T8
 wZgC05lm1e090wU5g4Ozz1usZh6KPV1YlNOA/Gonae1/vSPeKgrT5FyU/c4UrIxpThya
 ZJ3izs5SZNx2eiB3aTNZKconLuLQuchTwNDi+RNR/RhkpbUbyAbcZ4ZMrvjMg8vEvUw6
 sahpdTiEGiehjAdi+lIPhYpf5rU3JyI0tBEhmTwC4OMEXVrCFEP2+tYLHwC3vcfSKMH6
 UHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mUMQBpWA8/buAmRWchgLW3e3qoVa4wLDDSi2yUI7jTM=;
 b=AQRJ89f69YXyppK/2VDB1+ZIgqzj2bHUx+w0h6n9SfZ8mFNv4vvYPcIfHTgbvvepV+
 aOWasiB+32PrqUS9LQXeGAeB3PEa8EK6sh+cTqs9JJdUSTRFVhiCp6IXxRJGsPCH/asG
 RQod8O+7VpDeSpNLHI5cOcKDehkJn8i1CcW8v010MkwqvOmi2OeY0o6HU26shtEDpKYA
 AioLHKzaW5H9wuYlOa9VkOrHh2PTg5tk4eECAODQBzzQF6x2fp9LSBa/3aGs/XdcbIKf
 1WFnpu4EV5nNqKKXPdfzeZj5UUJwzEFC5MvuWFTjqtp14d9zgiTokxYt/DC3zm7Q/Eu5
 flow==
X-Gm-Message-State: AOAM532DaN8024q144KknbBCxI552+pf9MR4gblE6RRy8fRR8lg2MaZd
 r2udVUgZSmGaqk91MCojdOQfvE1mud4=
X-Google-Smtp-Source: ABdhPJyAc+CXAjQpcB+pqE/+rZIHsG9DhYWFlMH40fl5Uy1zpWvxxjeLqae9mW7cNdmapfHggexVqg==
X-Received: by 2002:a05:6402:cb3:: with SMTP id
 cn19mr15019383edb.368.1593452312045; 
 Mon, 29 Jun 2020 10:38:32 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id ce19sm216029ejb.24.2020.06.29.10.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 10:38:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] hw/i2c: Document the I2C qdev helpers
Date: Mon, 29 Jun 2020 19:38:21 +0200
Message-Id: <20200629173821.22037-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200629173821.22037-1-f4bug@amsat.org>
References: <20200629173821.22037-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit d88c42ff2c we added new prototype but neglected to
add their documentation. Fix that.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i2c/i2c.h | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index c533058998..fcc61e509b 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -79,8 +79,56 @@ int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send);
 int i2c_send(I2CBus *bus, uint8_t data);
 uint8_t i2c_recv(I2CBus *bus);
 
+/**
+ * Create an I2C slave device on the heap.
+ * @name: a device type name
+ * @addr: I2C address of the slave when put on a bus
+ *
+ * This only initializes the device state structure and allows
+ * properties to be set. Type @name must exist. The device still
+ * needs to be realized. See qdev-core.h.
+ */
 I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
+
+/**
+ * Create an I2C slave device on the heap.
+ * @bus: I2C bus to put it on
+ * @name: I2C slave device type name
+ * @addr: I2C address of the slave when put on a bus
+ *
+ * Create the device state structure, initialize it, put it on the
+ * specified @bus, and drop the reference to it (the device is realized).
+ * Any error aborts the process.
+ */
 I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr);
+
+/**
+ * i2c_slave_realize_and_unref: realize and unref an I2C slave device
+ * @dev: I2C slave device to realize
+ * @bus: I2C bus to put it on
+ * @addr: I2C address of the slave on the bus
+ * @errp: error pointer
+ *
+ * Call 'realize' on @dev, put it on the specified @bus, and drop the
+ * reference to it. Errors are reported via @errp and by returning
+ * false.
+ *
+ * This function is useful if you have created @dev via qdev_new(),
+ * i2c_slave_new() or i2c_slave_try_new() (which take a reference to
+ * the device it returns to you), so that you can set properties on it
+ * before realizing it. If you don't need to set properties then
+ * i2c_slave_create_simple() is probably better (as it does the create,
+ * init and realize in one step).
+ *
+ * If you are embedding the I2C slave into another QOM device and
+ * initialized it via some variant on object_initialize_child() then
+ * do not use this function, because that family of functions arrange
+ * for the only reference to the child device to be held by the parent
+ * via the child<> property, and so the reference-count-drop done here
+ * would be incorrect.  (Instead you would want i2c_slave_realize(),
+ * which doesn't currently exist but would be trivial to create if we
+ * had any code that wanted it.)
+ */
 bool i2c_slave_realize_and_unref(I2CSlave *dev, I2CBus *bus, Error **errp);
 
 /* lm832x.c */
-- 
2.21.3


