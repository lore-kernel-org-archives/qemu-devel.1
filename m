Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CE3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63D520826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGOsJZ5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63D520826
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrSIC-0000y7-1Q
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9r-0000Bf-QU; Fri, 03 Jul 2020 16:19:39 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9q-0001XL-DU; Fri, 03 Jul 2020 16:19:39 -0400
Received: by mail-wm1-x342.google.com with SMTP id g10so11555776wmc.1;
 Fri, 03 Jul 2020 13:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0Pfe0OziCwEN/zelbtovrsLHghLzfvQjekbFJCfSsxs=;
 b=jGOsJZ5gUezMX7n2P/N1nMtvqU0P451lscnCVy4IhOxkOx48vC12J0ePLu8ewJVeO5
 BY03gHWhpLarWYdxkoYy8Jvxukkb5M1MjwA47TqPeMMSJnaesWxF92OW6jvf9AxRTrQs
 n7UVzB41+D7eoj4xGbsByMSggqJJTbOggTSbowETE2g4WMYLCXLISR28uxliQwmkCj+a
 NAdmxTOuyvm4H1uv3nxpdxbMoIOTqOcLD5Sw5p0yDotTJ0H/EfsaffgDMDTAsuir6d1w
 O+mxBwfLRu8OMOe8tKWfWr0kMG+gvPmQmBKaRgBmLw/5PXQUQAVLFM8R07i18DgsBUR3
 k+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0Pfe0OziCwEN/zelbtovrsLHghLzfvQjekbFJCfSsxs=;
 b=hY5I6i912aXBceENXmb8vy5/fM/bLUcTsNN606prHBqann244UDMwdUAiFhzUYdlCK
 7hsMwxpkbq+fRlbEqoRLWAnMWqqjzB3unWSpcUM/UsyquYUtAKxBDikBK3o69dwIIou2
 gj1XW3Zot2PiyxP23AzdCBt5UKc9l+DT7tbYgKVyE19rdb6kg34DnZasRoQDRkiZ5+tM
 f3JSJiiDCcuxhAmhg9abGUJvSWUEypw8Xl0irXD6J1kLtKgtGO7IeeFTbJftdN9i8Gzr
 tJnjmHMbUohpONebY3vKXsW+agL6B11uBVVYfUh7AD7AHtkDou0p5gfKNAW43KI4HrZq
 VDyg==
X-Gm-Message-State: AOAM531ciVfdg/w3+5tnXVoQJgyOe2vVnQ3WHhN8e8w6M50vfbclPrKO
 HgXahs7Nyc2pLC6j32QkXvUwAzZmf4U=
X-Google-Smtp-Source: ABdhPJxGGodbxQ4LLpVO9BwjxBwJsfWrkqwmpiIZmB1xW3EdP4+OROtdm/tZ07JdbKGmRuanwOrOMg==
X-Received: by 2002:a1c:63c2:: with SMTP id x185mr38688445wmb.68.1593807576612; 
 Fri, 03 Jul 2020 13:19:36 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u65sm14229625wmg.5.2020.07.03.13.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 13:19:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 16/18] hw/nubus/mac-nubus-bridge: Mark the device with no
 migratable fields
Date: Fri,  3 Jul 2020 22:19:09 +0200
Message-Id: <20200703201911.26573-17-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703201911.26573-1-f4bug@amsat.org>
References: <20200703201911.26573-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/nubus/mac-nubus-bridge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/nubus/mac-nubus-bridge.c b/hw/nubus/mac-nubus-bridge.c
index 7c329300b8..ede36ccc5d 100644
--- a/hw/nubus/mac-nubus-bridge.c
+++ b/hw/nubus/mac-nubus-bridge.c
@@ -27,6 +27,7 @@ static void mac_nubus_bridge_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc = "Nubus bridge";
+    dc->vmsd = vmstate_qdev_no_state_to_migrate;
 }
 
 static const TypeInfo mac_nubus_bridge_info = {
-- 
2.21.3


