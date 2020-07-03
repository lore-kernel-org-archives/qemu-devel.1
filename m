Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6417CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2113A20826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9Iosb0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2113A20826
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrSCA-0004ve-Cm
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9a-0007y2-UE; Fri, 03 Jul 2020 16:19:23 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9Z-0001Uo-DV; Fri, 03 Jul 2020 16:19:22 -0400
Received: by mail-wr1-x441.google.com with SMTP id o11so33963599wrv.9;
 Fri, 03 Jul 2020 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q3/bGOtcr45IhcibkAs++blT0o8mxncf3Hbly4HXOsg=;
 b=b9Iosb0n0PkfEEkjyh0SBdl3DM23Rpa6htfsb047x4azmdUvRkovslNvPDmxGNLcq1
 sGQqFFzMgdJ/1vzUew7hv2mtbm/RU8Oz2sERuEteUzyora92IdaK3e0czZkJWwpB4v8u
 CS3xHJF0NhN54D+svLgATPPgadD/BMpcT5jDfk/BHiNcx7Y6K4xgb+mlKFDkOhQgb5y0
 viwgLoqvnQo3BGzpDEi9JAtHbUWGEtw/ne0nUIEeSeEOLNLaUtEzvnynnrs5sWBmWlYG
 kV9ySVrCTh/BmIVehe/KUpN+p36hMWF38Lc+lAk5VuQv6VLieMyMHBLCaP4InJlGVq7h
 sj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Q3/bGOtcr45IhcibkAs++blT0o8mxncf3Hbly4HXOsg=;
 b=gazrO+1rRI04Ei7O4e8f1ztc7HKWAuYejwxqNdWRhvjI8SuUyJXVOQPhZmUdCyS1Hp
 C3AzRx7k/BphI+8W1n9pQ46Pb8NwyvyyguOP8SPZt1a+85p+A+Asa07dnezVGmmWVQU2
 NU/GxBqo2EZadXOjxsxff4OrHSPemgI1nS7oax0kJkPA2p72QhXzlTJ60oLtsNazh+l/
 KFwlIFsfX5vOxDSoHLWtl8bDpG2vohrA3p8B1zHnXkPZNWEZ/j0nl0NyZwq9mdF4I7YW
 sSEUEVEYsEybY4rG8fhuU6Hl8OvlAloQOKPP0289GthWFgGgSYN5zp4WgX6sEPtFPyhn
 BCxQ==
X-Gm-Message-State: AOAM531cZWmeX43AW/XEPgk+p0e8hbuP+yHzgNqfIy3YZGm31LDwsP9Q
 iyuKmz/gy1eZpBC3bnXAz+JyZWqDU5s=
X-Google-Smtp-Source: ABdhPJxfocojOq6wX7vnMoeA/OyrO/IXrGrbT914Pmmvx7nrcobv/IqiRbSWVHSBLmBXiJNQ9UXMEA==
X-Received: by 2002:a5d:69cf:: with SMTP id s15mr27237873wrw.10.1593807559603; 
 Fri, 03 Jul 2020 13:19:19 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u65sm14229625wmg.5.2020.07.03.13.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 13:19:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 04/18] hw/arm/armv7m: Mark the device with no migratable fields
Date: Fri,  3 Jul 2020 22:18:57 +0200
Message-Id: <20200703201911.26573-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703201911.26573-1-f4bug@amsat.org>
References: <20200703201911.26573-1-f4bug@amsat.org>
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
 hw/arm/armv7m.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 3308211e9c..3f78fccc12 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -366,6 +366,7 @@ static void bitband_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = bitband_realize;
+    dc->vmsd = vmstate_qdev_no_state_to_migrate;
     device_class_set_props(dc, bitband_properties);
 }
 
-- 
2.21.3


