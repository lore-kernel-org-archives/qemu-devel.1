Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03104C2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EB620656
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI0OO7eQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EB620656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNli0-0008WO-TY
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 19:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJu-00036w-5k
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJt-0006V7-6E
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:43:18 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJs-0006Si-W4; Sun, 12 Apr 2020 18:43:17 -0400
Received: by mail-wr1-x442.google.com with SMTP id p10so8531185wrt.6;
 Sun, 12 Apr 2020 15:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3QRm8Wqt1J2otRs7IHGLTNCRC9I2pIq2Ldqm2vYIZwQ=;
 b=BI0OO7eQOT9kON+/WoQdaSkswe9KIOYn0LuVWTQG19Osoy7nIPv1kWrm01BaRVd+HY
 dKLe9U7lhvy1vxqRdTmkfVjoI8ZhCGIimT5f+twxLbXawn9ZJDmJDJ+cTDjHgN4C3Ocd
 Lp+43j3OY2meI1NI2VooapLB7emwYx9/PzaR5S6hFTZLWWsQWeUKG+SUiOe0DF+BfwXD
 PJWsyUBETLr/ALdZWbz2rf9oJdZCoYH60KzwzIoE6Xc8W2JqC1hjODQ/yjGusUcvIN7A
 iW3w5+XZ05inhuYtPMM/tE4a1aHIlJYUcBNTLRCbW7qMRoL+1w2Ar81lVYiwRmi2u+ul
 Jz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3QRm8Wqt1J2otRs7IHGLTNCRC9I2pIq2Ldqm2vYIZwQ=;
 b=o+pb5lj8gLWy4CUPByLXJSSMsLQSZpia65/N6skr+YaUD2UZYHfBpT4jfck1PFTxBP
 jhhpVDVM8sXwKvq/OwOpEJBa6GD+bMqHJStQ8yKzRzVJ1iKUOShwRxvpaLFzvOVZjUzi
 BwW1xcruWqwE1A18NJy2Mg+1j9t1tcVL5RV8i5TkXu2phwUgF4y+li6kBu3SjLFhgfGU
 rWqP2Hh73ucL0xP+GbfvHrboaaikKyYG7vw0n/NpOLo2b49OLhQs5Qxd+rtOA1ifeFBo
 9UJpRtLVguTYlIqV1c8HwK1+ydS5aa0eDein8afg0kC4hHiBEwm+g3zg4MPghoj5P11k
 rC/A==
X-Gm-Message-State: AGi0Pua7cMwiGlYAj70RmUKZyfhCTsvm9iuj8zPStdV8xu1LZL4pZ6er
 mhLGyu+szANBh/0Vz65uSZbfjn0EBuaB/w==
X-Google-Smtp-Source: APiQypK7QdJdqrw+hpKuFm1WJizwJEdtv7s86S/tUtKPH6Iv6i7VdrGKNo7cihiI0dSGjkHhEFTw5Q==
X-Received: by 2002:a05:6000:e:: with SMTP id
 h14mr16915034wrx.128.1586731392852; 
 Sun, 12 Apr 2020 15:43:12 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f63sm12083825wma.47.2020.04.12.15.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:43:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 23/23] hw/sd/milkymist-memcard: Add missing
 error-propagation code
Date: Mon, 13 Apr 2020 00:41:44 +0200
Message-Id: <20200412224144.12205-24-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412224144.12205-1-f4bug@amsat.org>
References: <20200412224144.12205-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/add-missing-error_propagate.cocci \
    --keep-comments --smpl-spacing --dir hw

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/milkymist-memcard.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 926e1af475..87294c1b71 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -280,6 +280,10 @@ static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
     carddev = qdev_create(BUS(&s->sdbus), TYPE_SD_CARD);
     qdev_prop_set_drive(carddev, "drive", blk, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(carddev), true, "realized", &err);
     if (err) {
         error_setg(errp, "failed to init SD card: %s", error_get_pretty(err));
-- 
2.21.1


