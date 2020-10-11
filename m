Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8BAC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347F820790
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEwwLhXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347F820790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRhEz-0006pv-BH
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 15:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5r-0002zd-1q; Sun, 11 Oct 2020 15:33:19 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5p-0006vE-Ii; Sun, 11 Oct 2020 15:33:18 -0400
Received: by mail-wm1-x341.google.com with SMTP id j136so15336054wmj.2;
 Sun, 11 Oct 2020 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ottyxadkfdG6t1j9EHj71mxgUhLG6Ki7NMaGNynZJD0=;
 b=qEwwLhXfmlgPiK25yyOcjxsJ3q6RS8jvY3+SEaEz2+i7iO1P0LlvcWHDK4l3Ri4LPB
 qGpOdydfbM0UerCDmcJ94eviy2yU5Sb2QSx5PCS3a9QmWlP6G4lmErLaesEeYq33Eqk8
 Oq78gsC/3iuwPT39zyXdDhPj8J+50eBMUnUYHnZxrdpgtDRdcFOqnLT2l88GYI1PwJy+
 SAP4Eqycljc26DjboqgJ+oXEl852pxyECm7Fyg1eLe7CaIhjeqiMnkVMGG1AYRdlgKoF
 F75IVc/9m9kzcxiIa8Ts3FWnLnRpJQXeCvUZQBxZFW7R5dbuW5PBhnAz/sjMa4x7qfmq
 8Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ottyxadkfdG6t1j9EHj71mxgUhLG6Ki7NMaGNynZJD0=;
 b=SrYQeNm6OyekXfDBGNV2Pkyv/cwzBj5qBeJuOScA1MH4w8Fj3LQzU6NOTTO9H0/b42
 bV7Z5lxTUg2oBAFATSXqEghdArJkkFFBz5f5VmqUhrsNtTgnid+Y/OzS8N5661CDNZtc
 It/YIzebLpXtto5Fz97RU5e3miGriH6F9UZFDYKl/YuTf6HSt8LmH11GxSTx57tRhj5Y
 rnL+YR/VEpoEov94ZkF7ga+ykZU8C7NUo45rJ0if+84+Ha/4Ft8mBIq6/JIBNO+SKk2A
 bZpzO3L6hgkT1wiANXTtHkjNnTVRQb8N1QnBuUi1ofRdkEHqD7e+p40d2OQSRRQxPpHo
 Kwsg==
X-Gm-Message-State: AOAM532V76eorRPsVoc1VmdUPOJBzZw+eoY9KYZJNy9reUoW5rwrEk04
 T9vZk9XmDvYh1wqwy5HCs8MfTJgXEHM=
X-Google-Smtp-Source: ABdhPJxwCHk9ZmaUKr7CkbYZxWaEQIWMZ6rAQBHwbNpxGejuErNgC8kytvS3q5p8QQv7R4bsOtQhNQ==
X-Received: by 2002:a1c:3b8a:: with SMTP id i132mr7793744wma.178.1602444795066; 
 Sun, 11 Oct 2020 12:33:15 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 88sm22673596wrl.76.2020.10.11.12.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 12:33:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/10] hw/isa: Add the ISA_IRQ_NET_DEFAULT definition
Date: Sun, 11 Oct 2020 21:32:27 +0200
Message-Id: <20201011193229.3210774-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201011193229.3210774-1-f4bug@amsat.org>
References: <20201011193229.3210774-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Corey Minyard <minyard@acm.org>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The network devices use IRQ #9 by default. Add this
default definition to the IsaIrqNumber enum.

Avoid magic values in the code, replace them by the
newly introduced definition.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/isa/isa.h | 1 +
 hw/net/ne2000-isa.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 9f78ff11246..11166592246 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -15,6 +15,7 @@ enum IsaIrqNumber {
     ISA_IRQ_FDC_DEFAULT =  6,
     ISA_IRQ_PAR_DEFAULT =  7,
     ISA_IRQ_RTC_DEFAULT =  8,
+    ISA_IRQ_NET_DEFAULT =  9,
     ISA_NUM_IRQS        = 16
 };
 
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index dd6f6e34d3c..e31e86c14af 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -80,7 +80,7 @@ static void isa_ne2000_realizefn(DeviceState *dev, Error **errp)
 
 static Property ne2000_isa_properties[] = {
     DEFINE_PROP_UINT32("iobase", ISANE2000State, iobase, 0x300),
-    DEFINE_PROP_UINT32("irq",   ISANE2000State, isairq, 9),
+    DEFINE_PROP_UINT32("irq", ISANE2000State, isairq, ISA_IRQ_NET_DEFAULT),
     DEFINE_NIC_PROPERTIES(ISANE2000State, ne2000.c),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.26.2


