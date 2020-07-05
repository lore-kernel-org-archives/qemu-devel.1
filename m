Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77054C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 22:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41382206CD
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 22:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pa64QCEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41382206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsDNj-0001df-Ix
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 18:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsDKr-0004Vf-BZ; Sun, 05 Jul 2020 18:42:09 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:43212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsDKp-0002id-Mp; Sun, 05 Jul 2020 18:42:09 -0400
Received: by mail-wr1-x436.google.com with SMTP id j4so36515364wrp.10;
 Sun, 05 Jul 2020 15:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=03JSJVToJcQcJSvpPMYHIqI0Rkyfucv4Bhq/3adSmHA=;
 b=Pa64QCEPjloJBqohG2Ldz2+UkkDYfCROFrWvBArUohBlqeVQ/OT7esXN2fXiU01xnD
 oH88cL+mwwjWkta9hkav9YmNURTz7nyQLt4XJJ3uI1NdxNTj3tpEcN+xzCUSrXQY5F+f
 hjk1A69MxVRPvpRxFEYRoiv95M7tVHdMC6jCvaR54o3Y32Z7WjRcEzFXTJd+483yDTXr
 2bgfjRX9c1++Nz7rSV5bRl2WiUt7t1ahmLYDeCIzj8vHuk/TjR4F+rP8beIZKQyb8EPw
 MJr7g3h8hTxy58TTfbslIiX+CkWcsIy7FyzEf69Vns4s/RrsgNbuSAxRMkz255XU4UgH
 fwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=03JSJVToJcQcJSvpPMYHIqI0Rkyfucv4Bhq/3adSmHA=;
 b=W5UX2FDaLe4shq3MFVCYwljSvBte4bKNzTIut2rEDTODqxgx83GJcUvO8BQ6eqbVXZ
 NYHNk44rWJjQ8i162aJfjyZRrY+pOeTVHWl87hbRlae07seO325kKEQ9rrkPdcIFlsHP
 bQQWjzsi0svvNMKc0u8bTsJIqzRVeP7Up2zAlzHMaxxcI0B5RarUNadKf8iU92ajrqkE
 iveUW6sX8LedSr5gM62K7eyKMsnnzOM4P+eL1jW6pj3PD3OCicdG22nbhI1NnCk4oAQ1
 bkYMhPcL58AhgXCI7BjILm8Fb/2WEfT08NEUERlV9YfwrJbMPyjUG8NidsCeBhWez0Rt
 7nkA==
X-Gm-Message-State: AOAM530jINHMF82+WUtk1OjlDuYn8TP3eZM1qzWL+e2/YsP55dKn6hVw
 4+u/gCkR6+k6PKMT5gofiIjd95V50bs=
X-Google-Smtp-Source: ABdhPJwkpl10haJP9vxZaL3uCZqLj6afrDjEtqaEPkWD8uG2pYPtTIPgqvyABZQdQUYimw7pb5vF9g==
X-Received: by 2002:adf:e948:: with SMTP id m8mr47097487wrn.398.1593988925207; 
 Sun, 05 Jul 2020 15:42:05 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v6sm9151467wrr.85.2020.07.05.15.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 15:42:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] hw/i2c: Document the I2C qdev helpers
Date: Mon,  6 Jul 2020 00:41:54 +0200
Message-Id: <20200705224154.16917-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200705224154.16917-1-f4bug@amsat.org>
References: <20200705224154.16917-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x436.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit d88c42ff2c we added new prototype but neglected to
add their documentation. Fix that.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i2c/i2c.h | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index c533058998..a9c030a512 100644
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
+ * Create and realize an I2C slave device on the heap.
+ * @bus: I2C bus to put it on
+ * @name: I2C slave device type name
+ * @addr: I2C address of the slave when put on a bus
+ *
+ * Create the device state structure, initialize it, put it on the
+ * specified @bus, and drop the reference to it (the device is realized).
+ */
 I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr);
+
+/**
+ * Realize and and drop a reference an I2C slave device
+ * @dev: I2C slave device to realize
+ * @bus: I2C bus to put it on
+ * @addr: I2C address of the slave on the bus
+ * @errp: pointer to NULL initialized error object
+ *
+ * Returns: %true on success, %false on failure.
+ *
+ * Call 'realize' on @dev, put it on the specified @bus, and drop the
+ * reference to it.
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


