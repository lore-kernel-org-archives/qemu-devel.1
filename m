Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05247C38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 15:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE1120735
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 15:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1zj040d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE1120735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXo0X-0006w6-Vl
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 11:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXnsr-0006GI-5L
 for qemu-devel@nongnu.org; Sun, 10 May 2020 11:28:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXnsq-0000yz-Go
 for qemu-devel@nongnu.org; Sun, 10 May 2020 11:28:52 -0400
Received: by mail-wr1-x443.google.com with SMTP id g13so7719641wrb.8
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Px9WR0XkE8GuycVpdZd0K01muDBPGEtID7KYWMZhl04=;
 b=Y1zj040dxOQID0WLZ0m8woVy/TYdTCDtIYrQxUxxWnGCYrKmdzVNM6+kPlv1DILaXW
 2m6SPPO6V9JxqNKf7P4Xo+VsWMYUTC3fpFSHxHLUoF0+BV5ITXncxcohz6BMta4t/i87
 Cpni2UjGou5VvRXgSRgbCSFiE6iiIXb2m8YUj4kab6p1rINwq5Aam3DeR/XAM6xwHOgi
 2Hvsz2RAsTLlYrbH1+3fYRzhO5lvmkZ0BCbP0+elVWlsJig/MpsnSt16rTaVRktlRD1Q
 aajxQsRb/ef4X4uaCy07aQ0GKSD6s2DAnglLB51RFvkiov34oucCazGUT/yjt/I2lhCJ
 6gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Px9WR0XkE8GuycVpdZd0K01muDBPGEtID7KYWMZhl04=;
 b=VAhZzJq5fLZVUW6XDQpkGSMSmXEL4T//UdQxU87lTR6W62PvC8bsIdGNuX7gp74cZv
 CCM0/1/x+ZSJ+x1jPMJulOGymkMKmDAKH3+WZ6K5/drTYu/t3187NE1B6VbJr9jPjO/j
 fjoRVjYECUTxMB+gHFh36XAA/Af3uZ5mOHgL4AXdVr3VFBmZhog0gULGg191JhxsrGMc
 9IfBNvKcuLZXnhJ31KV3oonk+K1KFLf6bmNlBJ/SNFt0myiArYm/CJU+ON2/ciqqgqsI
 bvZPiCR8BM07oR7hsAClMaGAPfFsklPl7nnT3p3JEgu0Rlpde56Czl4vMdsAfQaApkxT
 fQDg==
X-Gm-Message-State: AGi0PuZBBuIDj8JMVQCA0cG9cVI1r7NwtSlQQCsTbCW+UfCXG9g2KU4b
 zuBXWXVYntWs/842HPeS69t9z7C9l6A=
X-Google-Smtp-Source: APiQypLefDygx0GN6RWBKoRnU+dqf8+G8L0kOvyE6mAKHW1LjZgq6MmF0yZdO9DDuXDqmykUm2p41w==
X-Received: by 2002:adf:ec09:: with SMTP id x9mr13920736wrn.21.1589124530927; 
 Sun, 10 May 2020 08:28:50 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a67sm24186702wmc.30.2020.05.10.08.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 08:28:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] hw/misc/empty_slot: Add a 'name' qdev property
Date: Sun, 10 May 2020 17:28:37 +0200
Message-Id: <20200510152840.13558-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510152840.13558-1-f4bug@amsat.org>
References: <20200510152840.13558-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a 'name' qdev property so when multiple slots are
accessed, we can notice which one is accessed.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/empty_slot.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index 0df086fe98..576b276c4b 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -31,6 +31,7 @@ typedef struct EmptySlot {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
+    char *name;
     uint64_t size;
 } EmptySlot;
 
@@ -72,13 +73,17 @@ static void empty_slot_realize(DeviceState *dev, Error **errp)
 {
     EmptySlot *s = EMPTY_SLOT(dev);
 
+    if (s->name == NULL) {
+        s->name = g_strdup("empty-slot");
+    }
     memory_region_init_io(&s->iomem, OBJECT(s), &empty_slot_ops, s,
-                          "empty-slot", s->size);
+                          s->name, s->size);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 }
 
 static Property empty_slot_properties[] = {
     DEFINE_PROP_UINT64("size", EmptySlot, size, 0),
+    DEFINE_PROP_STRING("name", EmptySlot, name),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.21.3


