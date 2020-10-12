Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999B6C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FD52078E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAW3cETD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FD52078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0M4-0000io-AN
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS0K1-0006Z7-3x
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:05:14 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS0Jz-0002TV-Hy
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:05:12 -0400
Received: by mail-wm1-x343.google.com with SMTP id d3so18056588wma.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JguspvpXF+DkogdsxEqfqlEtENU/Ft8xqLKiNF8xPdE=;
 b=uAW3cETDNS3qxLNGv0tx24t6VweQw/2JORaAVPfL0OVtJAZYKDtlUJspcvD3U+z7hX
 l0SylycUTx9y2y+fmOjloxOhZnZ67oVoaO5PUmBPRpaxA/+JwPDitDaTlvSaaiGZtHwE
 Txe+Iyb/yog9g5HWGpHOMZtV21Q3nBqZv1RVyUIWANhArpHDURAYcA16BCC4AVjbXj8b
 LXKaiacLSxHPDWBbKWK81IE0WS0I7ZAd0xoI6/4KHOiFNIgk28VoGYTbvzyazmrdhumz
 vucV7vYb6MYrpMx/I7crqBpNqDjK+KN+dVxt2LUA6J6p/hy7XCDE2PTbBzQ+1GS/M1kX
 WO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JguspvpXF+DkogdsxEqfqlEtENU/Ft8xqLKiNF8xPdE=;
 b=tbbAUO/bgsRiHqDAHaXT4KTW6QkRCnPD4u3fOYGAVg8MCgGACQ8NEx2S8IuDUqhd8U
 pKcLvubHhrWGvEP+gUSlq8FYFiwWHhu/e3YcgQzf5Ko6H0UD4cWeJcCdmhKqiZ3y34t5
 c1cBpIdYD6m2b804Rjq0eEHxZT78xKmx8Ps3euH4VnQFVSmnY7MEoWgioP6/OybQTYUT
 i/LZn65KlpDl/pgJ98cVLwLN97yDeRl6tbkRA59IQjiDWweJB2wK0ji+EuMr9QXYauQR
 c+hxSHzQGY0KN2293zwk5Fxxe1gOAQvIsePnQ83/6wro4cUadp8e+kq3oBssyK43ynje
 V2EQ==
X-Gm-Message-State: AOAM533sYg4mJ7CMcL8FQr71XO7c2kLyalkcGvRt9MZbafdfkIf0KLGU
 t4fcFzrjEjmIr5YUu15Xke2ZWF1+uXc=
X-Google-Smtp-Source: ABdhPJwXuJwWo5w/acriuuuMU7uOA/fQpSD2O4jYrpJuV5LctOcPVstl1pfIcFs4BMvbkfIiyPjUGw==
X-Received: by 2002:a1c:2c0a:: with SMTP id s10mr11489684wms.103.1602518709972; 
 Mon, 12 Oct 2020 09:05:09 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x6sm24900367wmb.17.2020.10.12.09.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 09:05:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/mips/malta: Move gt64120 related code together
Date: Mon, 12 Oct 2020 18:05:02 +0200
Message-Id: <20201012160503.3472140-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012160503.3472140-1-f4bug@amsat.org>
References: <20201012160503.3472140-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'empty_slot' region created is related to the gt64120.
Move its creation close to the gt64120 instance creation.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 4019c9dc1a8..fe8f6f7ef51 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1235,13 +1235,6 @@ void mips_malta_init(MachineState *machine)
     DeviceState *dev = qdev_new(TYPE_MIPS_MALTA);
     MaltaState *s = MIPS_MALTA(dev);
 
-    /*
-     * The whole address space decoded by the GT-64120A doesn't generate
-     * exception when accessing invalid memory. Create an empty slot to
-     * emulate this feature.
-     */
-    empty_slot_init("GT64120", 0, 0x20000000);
-
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* create CPU */
@@ -1395,6 +1388,12 @@ void mips_malta_init(MachineState *machine)
 
     /* Northbridge */
     pci_bus = gt64120_register(s->i8259);
+    /*
+     * The whole address space decoded by the GT-64120A doesn't generate
+     * exception when accessing invalid memory. Create an empty slot to
+     * emulate this feature.
+     */
+    empty_slot_init("GT64120", 0, 0x20000000);
 
     /* Southbridge */
     dev = piix4_create(pci_bus, &isa_bus, &smbus);
-- 
2.26.2


