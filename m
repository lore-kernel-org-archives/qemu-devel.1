Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08832C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE8C2064A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgInzE9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE8C2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLW98-0001XV-04
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrj-00032f-NJ
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVri-0003aa-Nc
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVri-0003a7-Hm; Mon, 06 Apr 2020 13:48:54 -0400
Received: by mail-wr1-x435.google.com with SMTP id h15so479930wrx.9;
 Mon, 06 Apr 2020 10:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yVPysyauLZ9816b43kjwmsf3uNlRLSQxh41Q/NDSUAk=;
 b=qgInzE9DuiBq83mdV005JH1bGJ40enGk4b8J/HhxDzlszjkSL3mnUEB2gLzjZLAcZH
 JWdNgjTz1rca1kwfV97GbN0y/kNmyGg+nuO448OJE15oh2BJUCvL0BdUEC9LllDm1sFT
 qdPCmUIVGQP+wMArcy5Mo3RG7RXR9SuIeuqn+aBqFrzy/6Ki0VHf/4DLpEa7WMBR61Yk
 y40E2eqFe1ZVAtFqwMRv+V+OUHDt/D4luA7ufnIR5ORxQkNFOT1x3HaK/NcauAScxhED
 oZWaMJu0wPAEpUOVMJLg9veCrYuhAMzv0vFRJ3f3TKkG1aE7wqvwkSxw9RygKUIQIuf4
 41VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yVPysyauLZ9816b43kjwmsf3uNlRLSQxh41Q/NDSUAk=;
 b=G/xAR9vvyRlrGxCAtgt7louPIpYDf0Yk8IQJ6F9fcY1t2X/ecQogIeeoA3ZS1MTZTY
 aNSn08OjaAtIVfmHqmQzaQHTQDxZe49D6Tmq9GfBezTn0jfS1qNrjdMe/srvXkHCPlON
 zxsEYTmNdVJGzso7zdUmGiEVzzkIcdLRh5klDIvQg3Gkka4MVT50xsJyMOKvJZ2e8q/b
 ITBN3125mZHWn/obpYTLY8/sNvpIphTk/ljIxCMbylqayaVriARDOg45EZ/fAEO8s2/o
 Gw8xuVIQa1+tX90EzOpqpKDMFjDCGeGt8wv16SlNfXGAiiOXywaUN0Ad4j8VRqVz4v0Z
 eX+Q==
X-Gm-Message-State: AGi0PuYlRRce75eiYN0jzwL/h+gKXiM0TzXi4qoR0bl+x8AYxhFadxZr
 JLOSWTootQvrTtaKqjGrMK/BaduwCZA=
X-Google-Smtp-Source: APiQypLFxeR4+SkELFoJnRLU9Hm6BZnfmxGevkXCmHCwi/bjnyYbt2YU8n12D92EDgdM/KiDr3pGGg==
X-Received: by 2002:a5d:464a:: with SMTP id j10mr349757wrs.3.1586195333447;
 Mon, 06 Apr 2020 10:48:53 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 46/54] hw/riscv/sifive_u: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:35 +0200
Message-Id: <20200406174743.16956-47-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/object_property_missing_error_propagate.cocci \
    --keep-comments --smpl-spacing --dir hw

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/riscv/sifive_u.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index b07526aba1..b6c27bc970 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -574,9 +574,17 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
 
     object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
 
     object_property_set_bool(OBJECT(&s->otp), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
 
     for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
-- 
2.21.1


