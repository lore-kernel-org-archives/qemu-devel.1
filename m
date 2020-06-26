Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53003C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3362070A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fzhf9Qki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3362070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jolbb-0007ik-C6
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jolaN-0005zU-4R; Fri, 26 Jun 2020 06:27:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jolaL-0001xU-C7; Fri, 26 Jun 2020 06:27:54 -0400
Received: by mail-wr1-x443.google.com with SMTP id r12so8916180wrj.13;
 Fri, 26 Jun 2020 03:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WXNiHmUXIOAvwV9mGyjf+bIvI09PaBvr0Sfo8hj14FI=;
 b=Fzhf9QkiVyLuqxX5k7JOE/qlSoygikWVdKv3N2W9Q416icqvpj9iFcofOTmSxgxGaE
 8+1ACpl8lIiWEWV3kzT8gzaS1MCSMVs0bhHzMrDCo7R5G/V1U3khbnGQPCA+QHqzZ3jK
 T+enfWht8QU0Mc+ftp5SLr/hlZxWhOVILJ+tAomejAoKz7apNWSWdCw/2kmQgIj/LRR9
 zLDp4xHxrJU73ro/9Mbbtg/xINZoedCtpuw6hl9aohNoiurbooB8cv6DGk1TZ5pxaskd
 jPIKeZTTQdYudsFWfXHtPqM9JvEtIwiUF6WvAMcdYVwM7Gw75V0RCumQI6+WCs3XZ2aw
 dsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WXNiHmUXIOAvwV9mGyjf+bIvI09PaBvr0Sfo8hj14FI=;
 b=I8V8nuqDIvjbz4yFpQIAIkoROxN/BvHDooa59TyfTM+8y5GKGJzxafFK5H0f0Vsd/x
 HcCNLMpoNNjSZ38KU+tMHZ0UNFG5gomtxpbCMqRaZ9rGHd4olJJgU9d+lQwALZzyJehi
 5oXywA7KQSRw55TDeIZsKtplruHi4sIrEWgHE9jQpR7oiOrMT7vxb9XHgedWt5UOvxuG
 qOWzA5aLAMa85dHqWH3pdogp/64TbheuyFV0M0Q2zZGGnihGC7T7Da+zHJLLA6rUjbvj
 Sp3K9TZGPKyJqkn87eFzoGKs9H/DvvUzvAJDots6eeQaCyjtpsFl2HMMwgdmO8g9urtu
 9JoA==
X-Gm-Message-State: AOAM531IEmlp4heerj8onychaIr1AmDNtnkUDh/7eV29Fx2O3t2On++X
 65/fmKbVsUVSevPMk67Bqj8=
X-Google-Smtp-Source: ABdhPJz9a3dt9hKB02TzUdc+DvSa3raTI8WgB9HyrzRIN971FG8OKzagewRKZrq+/NdjV0LF5t1FaQ==
X-Received: by 2002:adf:efc6:: with SMTP id i6mr2904546wrp.303.1593167271726; 
 Fri, 26 Jun 2020 03:27:51 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f13sm15598194wmb.33.2020.06.26.03.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 03:27:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 3/3] hw/i2c/smbus_eeprom: Trace reset() event
Date: Fri, 26 Jun 2020 12:27:44 +0200
Message-Id: <20200626102744.15053-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626102744.15053-1-f4bug@amsat.org>
References: <20200626102744.15053-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i2c/smbus_eeprom.c | 2 ++
 hw/i2c/trace-events   | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 22ba7b20d4..7a0e1e7455 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -31,6 +31,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/i2c/smbus_eeprom.h"
+#include "trace.h"
 
 //#define DEBUG
 
@@ -124,6 +125,7 @@ static void smbus_eeprom_reset(DeviceState *dev)
 {
     SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
 
+    trace_smbus_eeprom_reset(eeprom->description);
     memcpy(eeprom->data, eeprom->init_data, SMBUS_EEPROM_SIZE);
     eeprom->offset = 0;
 }
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index 08db8fa689..0539c9e111 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -14,3 +14,6 @@ aspeed_i2c_bus_read(uint32_t busid, uint64_t offset, unsigned size, uint64_t val
 aspeed_i2c_bus_write(uint32_t busid, uint64_t offset, unsigned size, uint64_t value) "bus[%d]: To 0x%" PRIx64 " of size %u: 0x%" PRIx64
 aspeed_i2c_bus_send(const char *mode, int i, int count, uint8_t byte) "%s send %d/%d 0x%02x"
 aspeed_i2c_bus_recv(const char *mode, int i, int count, uint8_t byte) "%s recv %d/%d 0x%02x"
+
+# smbus_eeprom.c
+smbus_eeprom_reset(const char *description) "'%s': reset"
-- 
2.21.3


