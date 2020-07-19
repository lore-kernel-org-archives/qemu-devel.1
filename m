Return-Path: <SRS0=x6dg=A6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ECEC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 13:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0A622B4E
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 13:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6JNAPn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0A622B4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jx9cF-00073t-Qr
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 09:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jx9bM-0006bJ-DU
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 09:43:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jx9bK-0007gp-Vk
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 09:43:36 -0400
Received: by mail-wr1-x441.google.com with SMTP id f7so15370322wrw.1
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2020 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LfW1+jmNf0jIYfs79jX6XnjBmyw2e7b92E+y4Bebo/A=;
 b=j6JNAPn0d0q0mWltH+mjts6BGnbZkeJRg+Ep4TOWkWoRfLBFnmMeV6f6KschPRkW/V
 1JfrwbFemoFNHlgkl2zrPcNt8tHw8ZDT/yWqBOd5gF0A/gpaUpglq/XZ7/Pgm0I92lBL
 VgkfrciwkktdJHpeFglw6udP1k/J19TwN00Qzi6yQrya65RX7Oeey8IlA7lH2scDUljG
 04ssi4Kc/XKm2ZFAqKXAzEV4EeVJ9KFutc27wmctNZBiWJxvsrYC3PB5JaEmEA1KAA4d
 Ur8Hp60IKZ6z8WOXFSDk6gP8mGT9T+jtvhwAYZVycRlh0Bz9HiDJECXlJaz1j6duKFcm
 FSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=LfW1+jmNf0jIYfs79jX6XnjBmyw2e7b92E+y4Bebo/A=;
 b=FjcptdV3n7qN7eLXQT79ogz9FxeZuRr9HUkFI2PcVmkogOcsH9lssJEYp7AnDtSJov
 JLkcevQbubPKmyjio+P8tMHSV6at4ui1nZtdFgVVJ6Is7cT5LuSW8a6GJ8Zn8fO3PIYO
 chXM1w3mzlAscsZrwxvPbk/F4gYvwJipTLnqV6XIhhBcxlszjgpgTcgrhjRbipAXFh88
 HnPAx9BNGdB+YAB0vWuvRvjufjBaUstClFf9MYgiuOYKeCNn9QAhawyJVRkRxd916NtN
 qGa7ttI8VIscvBUtBG6lU+Yrg9SFZOXf5LkAKaBosbhjeER78VdxOMSugbMpkZIHf7Ve
 UASw==
X-Gm-Message-State: AOAM533MUQ7hSq6Vy71PrXCEGUU/NaPZQU1URhrVHyfblyuQ1pVlz9US
 DctySAjRAWxvxDL/eEhZeVCZV+PBHW0=
X-Google-Smtp-Source: ABdhPJyUK9y6Q+06QHhCsonGFYX/Swo2jIw4BsdAwXWdMkebSXgn+/0MMci7SGcZe1P5ly9rCtXEKQ==
X-Received: by 2002:adf:e647:: with SMTP id b7mr19453675wrn.170.1595166212743; 
 Sun, 19 Jul 2020 06:43:32 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id w2sm25596104wrs.77.2020.07.19.06.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2020 06:43:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1] qdev: Allow to create hotplug device before plugging
 it to a bus
Date: Sun, 19 Jul 2020 15:43:29 +0200
Message-Id: <20200719134329.21613-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 510ef98dca made qdev_realize() support bus-less devices,
asserting either the device is bus-less or the device is created
on a bus. Commit 464a22c757 used qdev_realize() instead of
object_property_set_bool(). Since qdev_realize() now checks for
a bus, it is not possible to create hotplug devices unattached
to any bus anymore.

Fix by only asserting if the device is not hotpluggable.

Fixes: 464a22c757 "qdev: Use qdev_realize() in qdev_device_add()"
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/qdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 01796823b4..6c5540ecdc 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -393,7 +393,9 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
     if (bus) {
         qdev_set_parent_bus(dev, bus);
     } else {
-        assert(!DEVICE_GET_CLASS(dev)->bus_type);
+        DeviceClass *dc = DEVICE_GET_CLASS(dev);
+
+        assert(dc->hotpluggable || !dc->bus_type);
     }
 
     return object_property_set_bool(OBJECT(dev), "realized", true, errp);
-- 
2.21.3


