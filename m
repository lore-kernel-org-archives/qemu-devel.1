Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1184C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB9520782
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPcc4yGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB9520782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrSFi-0003sq-SB
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9k-0008MI-Qb; Fri, 03 Jul 2020 16:19:32 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:34173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9j-0001WH-AY; Fri, 03 Jul 2020 16:19:32 -0400
Received: by mail-wr1-x429.google.com with SMTP id f7so30933043wrw.1;
 Fri, 03 Jul 2020 13:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yrLkH70WzIihdGm/NjbQjxTYMS+wbXewYaB/SgI3i5c=;
 b=DPcc4yGf1Z4stLcHhv7nxz6yIz2mqLYJJI42zmHJ2G0V+4Ygz0GVTBCkSgVPR8lWdo
 VV9BleOFs3RAgCU6TZy3GGBlgLsXtzJIB5g0tlQzZH9TOUj7bqDhab9+7QIue77z8BSL
 rcOEYulRh1uobMV2haKUFolWMT/Bf//oXSPdcz/BmybzkWtZyYwqE9JuzN9z8ejg7l5c
 nubGvp+tN6FTkqJSM1Cdth6Hr5nF5zuvq5DY0WkoGwCkykDjl8LWYJ3+X+Epee7LYhio
 fhZm/ZqMqRDCIrBzeIz7/bW1mJFnFslwngBJNEFrpa9F03aSdMR9NvKv9FsoVx/9Njy6
 ejog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yrLkH70WzIihdGm/NjbQjxTYMS+wbXewYaB/SgI3i5c=;
 b=hyBg2HkICHiK+ttpEfBHUG46Ko/JvvGs3s3rNtp/9wxAmy0pS8TWcQStZm5RfeByh2
 2xFNl/0EjfWhYygIUDitdbd0J3r7XdvxkTVlY8cuOse/31F12hqoe4O5pimXrkztq7O7
 Un+5rXDyTBj8jHeoQV7oI1lGgtQINXPXHVGSip+RDs+1x/J1M2hInc3KfNq8aF2Dn4If
 G5X5jqmc0G9eyfaCAb3T/Ef3pguiSZaPvdq3lRAVzZcNBdOOqJUyQUXokmnknubD+56k
 avrJ2mEYTLG9deAjwXGySdpcxmk5jrAlkTH1o/oMHc5DtlXOEsXaEbCe+GXhTU73IEhb
 /ZQQ==
X-Gm-Message-State: AOAM533sJcBFh4UshAzXy9Sh9WB2ZgS276wkTs1Iik2W6vPLfxkJVejE
 YO0R9gJwgjS9ItPs4EUDB7Z6eICjbxI=
X-Google-Smtp-Source: ABdhPJzPQkKAsw+WVIpI3SO5UKRRm5SfW2rhLL5gG2nSORaBH81Vnn3Ir3F2i9l85m7w1ZuGNxXdpA==
X-Received: by 2002:a5d:6846:: with SMTP id o6mr38567514wrw.370.1593807569583; 
 Fri, 03 Jul 2020 13:19:29 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u65sm14229625wmg.5.2020.07.03.13.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 13:19:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 11/18] hw/usb/hcd-ohci: Mark the device with no migratable
 fields
Date: Fri,  3 Jul 2020 22:19:04 +0200
Message-Id: <20200703201911.26573-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703201911.26573-1-f4bug@amsat.org>
References: <20200703201911.26573-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x429.google.com
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
Cc: Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This device doesn't have fields to migrate. Be explicit
by using vmstate_qdev_no_state_to_migrate.

Add a more descriptive comment to keep a clear separation
between static property vs runtime changeable.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/hcd-ohci.h | 2 ++
 hw/usb/hcd-ohci.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h
index 5c8819aedf..3bcbad1269 100644
--- a/hw/usb/hcd-ohci.h
+++ b/hw/usb/hcd-ohci.h
@@ -100,6 +100,8 @@ typedef struct {
     /*< public >*/
 
     OHCIState ohci;
+
+    /* Properties */
     char *masterbus;
     uint32_t num_ports;
     uint32_t firstport;
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 1e6e85e86a..6c76f65734 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1983,6 +1983,7 @@ static void ohci_sysbus_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = ohci_realize_pxa;
+    dc->vmsd = vmstate_qdev_no_state_to_migrate;
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
     dc->desc = "OHCI USB Controller";
     device_class_set_props(dc, ohci_sysbus_properties);
-- 
2.21.3


