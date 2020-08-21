Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489DFC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B3220702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teljjaHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B3220702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Aua-0007Jl-6T
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Ar3-00018V-D3; Fri, 21 Aug 2020 13:29:29 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Ar1-00019q-FH; Fri, 21 Aug 2020 13:29:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id z18so2625739wrm.12;
 Fri, 21 Aug 2020 10:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oj9xYFI9YtdfvQ2O+xvr5D4uPJDnz6Js3VTiAoIt79Q=;
 b=teljjaHoiUGABM8mobeV/fWOijAOVcbj02kYv9u3qTaIqBFpkOczmzAYuHr1SMWN7+
 8R1UuMwv56G6q9OzI3j+f2xaP+VVrME5jb5dxXttO5Z3HxDTtQgB4gpIC9nZuv8EYjj0
 UtPW5QVxXVeK62Mhk8agtrdupsfkiR5Mg1bK0ahuWuMS7ULu4F4Abi6/6gKISZVd/FTu
 ok0PaBPmpG16VJYd0ODBt4RqUmxQNJaXEGrHRDNyhkR1OabrmjXyT5B+eZeBN0uM/qda
 TZ1Evpha6n58N3Y68oQ3EWm/6ibq/dIm2145Kck4lUigRvY3FFpAbZDBWIfNnXeJzwhq
 pEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oj9xYFI9YtdfvQ2O+xvr5D4uPJDnz6Js3VTiAoIt79Q=;
 b=TCw1lEewdoTRrD3YpkaO2LdKNIa782pVGY0l/C2ZOVw/6wMEheFhEvSinH+gDXk7Y2
 ApWOgOLLhkZ7vF/SKK7n+Wza31z8KFu5PEfKLhJpRJ342wsCFmlukECI2WtzTj1PvbKD
 kXTxXpsSXAM7Cbdywv/ogv5AE+7qbiEr+PyJGA87HSsiYZvdy+cQqgSrFfgoGoTDLNKl
 wg5GsNe4IJ5EQXUL9B+aDLmG44S1/uWaJDxtNugFbMpN8k866SMnxd1shXFOZrrZerFI
 j5psg+JZhptdMIraN46veK1zQvAscMTFA1RLMKCDFrUO9FWsrtxqaHG6ijnrUBrIJ8gV
 Q1BA==
X-Gm-Message-State: AOAM531I4kwnBSEn4Vl+3GK3xK5Yckx8TGHhEl6AqtAO7xg5E9/7Bhbg
 /I915jGmomApGXI6ScaVUMHEzv0MtxQ=
X-Google-Smtp-Source: ABdhPJyCCh2AQ7mcDZPU9mCwJoQ0f616gDKVuRLBXGVDPD1KMiZqwFIYr4Z3aWkE1FKjzyiL//Wq7A==
X-Received: by 2002:adf:9e8d:: with SMTP id a13mr3459990wrf.94.1598030964965; 
 Fri, 21 Aug 2020 10:29:24 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm5315471wrn.86.2020.08.21.10.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:29:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/23] hw/sd/milkymist: Create the SDBus at init()
Date: Fri, 21 Aug 2020 19:28:57 +0200
Message-Id: <20200821172916.1260954-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821172916.1260954-1-f4bug@amsat.org>
References: <20200821172916.1260954-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need to wait until realize() to create the SDBus,
create it in init() directly.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200705211016.15241-4-f4bug@amsat.org>
---
 hw/sd/milkymist-memcard.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 11f61294fcf..747c5c6136b 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -261,6 +261,9 @@ static void milkymist_memcard_init(Object *obj)
     memory_region_init_io(&s->regs_region, OBJECT(s), &memcard_mmio_ops, s,
             "milkymist-memcard", R_MAX * 4);
     sysbus_init_mmio(dev, &s->regs_region);
+
+    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
+                        DEVICE(obj), "sd-bus");
 }
 
 static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
@@ -271,9 +274,6 @@ static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
     DriveInfo *dinfo;
     Error *err = NULL;
 
-    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
-                        dev, "sd-bus");
-
     /* Create and plug in the sd card */
     /* FIXME use a qdev drive property instead of drive_get_next() */
     dinfo = drive_get_next(IF_SD);
-- 
2.26.2


