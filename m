Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28134C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25412083B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcaMislM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25412083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRh8n-0007Zd-Q5
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 15:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5H-000296-Ar; Sun, 11 Oct 2020 15:32:43 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5F-0006qV-RK; Sun, 11 Oct 2020 15:32:43 -0400
Received: by mail-wr1-x441.google.com with SMTP id e18so16555098wrw.9;
 Sun, 11 Oct 2020 12:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fmlcfpwvQZt/h1AszpZppC7oD9iO0g2rLKUxf53gOoA=;
 b=NcaMislMSa6o2M9nrk/84IKWm5dGHuZv+nc/Y5349o6NNgIRrLhaJECEb9XqbZy/iP
 FJEBH+1yHoPomXvovucwcoHXfyV5MAEe8PtZ9xIevsX6JRO7zY2dJI8QCSE2gZfDQvVf
 0LV3Xn7cffiBCxI2nPjyRsXlb1taDc4uo03PGy5bQXNIHUJxzCk8BRffsDy+B8iAbfyj
 YLwUSl2lCmat12M6ZHLdBREMFHpch1t33lvaOyLzH9no/iQCkM30yPLcN6YC/hJI82TM
 KFiXDx4daXw81RFX92NM2YTVGjEQFqX1Mw9G9o/6vd3vIDemOsPme+kinFp7Cf97uIFQ
 b6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fmlcfpwvQZt/h1AszpZppC7oD9iO0g2rLKUxf53gOoA=;
 b=TO3LnUEZ9QU2/04FgrJfzPMYG9Zg//8pkgKnBCgdeqnLaJLhsFTe65nCChU1F1s7vh
 lqJKcQP33Im1zLStU20I8d3xE/Bgy2/xhIbA2lCrxuNtWUVQzWwLOvN37wCd1dR/r07m
 MZt7ED5eFWozRNEWwW2QGTfah/I3gy2ICvTcqjpZtFOHLNEmOFtDfhSQ4zHIdIMXylwK
 hl3Sug8hj2QYLpKU/S929owX8+opcUwNG60gTodseJpMu92eyD+6EzguZ0dQ+1aOiDuA
 HBa5YRGeReOgspQyJ8veT/0bMtdMz3LyixY7V/x+/HoSrs9H9fRCPn0tGL4+kpe9Fhd7
 EnYg==
X-Gm-Message-State: AOAM533mcmhn1aYtrRS7HHaufIvaWUOT2cIGUp5wrEPA05YQphGQ5PHS
 YYkkenRjAfiM1SUg2HUyrXIxC+Kko1U=
X-Google-Smtp-Source: ABdhPJwP4pvSU3pkp8ODHNw31Z3zzsI/u/U0SIw4XgY9isItuzQmKM/BuB8bCTlwgEcDb4/3n0RBbQ==
X-Received: by 2002:adf:97cb:: with SMTP id t11mr27954881wrb.292.1602444759130; 
 Sun, 11 Oct 2020 12:32:39 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a17sm21215068wra.29.2020.10.11.12.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 12:32:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/10] hw/isa: Introduce IsaIrqNumber enum
Date: Sun, 11 Oct 2020 21:32:20 +0200
Message-Id: <20201011193229.3210774-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201011193229.3210774-1-f4bug@amsat.org>
References: <20201011193229.3210774-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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

We are going to list all default ISA IRQs. As all the definitions
are related, introduce the IsaIrqNumber type to enumerate them.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/isa/isa.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index ddaae89a853..2a052ffa025 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -8,7 +8,9 @@
 #include "hw/qdev-core.h"
 #include "qom/object.h"
 
-#define ISA_NUM_IRQS 16
+enum IsaIrqNumber {
+    ISA_NUM_IRQS        = 16
+};
 
 #define TYPE_ISA_DEVICE "isa-device"
 OBJECT_DECLARE_TYPE(ISADevice, ISADeviceClass, ISA_DEVICE)
-- 
2.26.2


