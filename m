Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CA0C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 22:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1FDD20702
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 22:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rcs/JAIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FDD20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsCur-0006tQ-Uc
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 18:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsCuB-00066m-LI
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 18:14:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsCuA-0006VW-7s
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 18:14:35 -0400
Received: by mail-wr1-x444.google.com with SMTP id j4so36475455wrp.10
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sRKts3lB7oFf5r6VBGBdxzozSAiEPP1/+u8IK4TiZVo=;
 b=Rcs/JAIEtT9giNu1diM1amzojBuXBKMP8Bo+7gdb5CZ5hX4aNHwB9vTPXeRswmsdag
 y+b5aJ+1V19wVtQOHM2q5gGI7+yccGGbXncWfcI4Y+jEDgIIMD08QD1XVqV2WVPaZJUT
 x31YWHeZ/Yk//yZDA3fcahiH9IsCRvwC5KdRokK9iY8EPD5ok/Tk6yz1uB4eo0RuvuJU
 bNoIkZIlL518eP38qWos1gX6OeKwuVu7vYvsz1SoxAnOqxtvAx7lS3n5uitSEiKzhsc0
 zBAsD36F6VeZ5OR1wy9dwjH00t27QntD/THGKUq5HiAoTwNcujIjENB4zzXDTeaIVQJl
 7New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=sRKts3lB7oFf5r6VBGBdxzozSAiEPP1/+u8IK4TiZVo=;
 b=c2Swryk8Ui57DUVh/A3IAHOS3IcXl3hG8qQA8HnYQRfnfNMIRnas4U4Pb4PKRUHXNG
 qtDLyQzd7L5U/DASAhiES/LEDIE0B+Gt57QSSQn2g2LAln4AbmH+oMKy0j7Lb1JR2/YA
 IELlu3fiKhRFleIOTAbyvU603K8J5YKezQpksKd0bb/Vn5PH5NFUqLOrsgolRavY3stb
 MCOdndor+5I1E7xYYW5Jng+uLVzm3Dv/H2jQ+ikyScPTVBi9p89QAkEAmQt1PJimDMpW
 XljzTiNThcfWFs0wh7UqLPybpP5RkCV8+f9ZBBehMu9SVegZxY2zfo3obLXa43DwFyf6
 QosQ==
X-Gm-Message-State: AOAM531IH7mUKe9qPlNobfTdOyjNaA6hxHA2Z+t3sbWOiCua5dG7MgJi
 1nd4l4QkqUUFNtmVv1ySEMcVBwhz/bQ=
X-Google-Smtp-Source: ABdhPJyhzZwLUfbyBj+7HARBmhhhr6mNPlq1HK4Il537sLasZQZe0LTYkUFroeaM3Or08dPWYyQfmg==
X-Received: by 2002:adf:db4d:: with SMTP id f13mr45157124wrj.336.1593987272333; 
 Sun, 05 Jul 2020 15:14:32 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id e4sm21084712wrt.97.2020.07.05.15.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 15:14:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/core/qdev: Increase qdev_realize() kindness
Date: Mon,  6 Jul 2020 00:14:30 +0200
Message-Id: <20200705221430.30207-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 510ef98dca5, qdev_realize() aborts if bus-less
device is realized on a bus. Be kind with the developer by
displaying a hint about what is wrong.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Use errp (bonzini suggestion)

Paolo, I was tempted to check errp is really &error_abort else
it is an error! :P

    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
        error_setg(errp, "%s: Unexpected bus '%s' for bus-less device '%s'",
                   __func__, DEVICE_GET_CLASS(dev)->bus_type,
                   object_get_typename(OBJECT(dev)));
        assert(errp == &error_abort); // <--------------
        return false;
    }
---
 hw/core/qdev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 2131c7f951..9d1530c39d 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -392,8 +392,11 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
 
     if (bus) {
         qdev_set_parent_bus(dev, bus);
-    } else {
-        assert(!DEVICE_GET_CLASS(dev)->bus_type);
+    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
+        error_setg(errp, "%s: Unexpected bus '%s' for bus-less device '%s'",
+                   __func__, DEVICE_GET_CLASS(dev)->bus_type,
+                   object_get_typename(OBJECT(dev)));
+        return false;
     }
 
     object_property_set_bool(OBJECT(dev), true, "realized", &err);
-- 
2.21.3


