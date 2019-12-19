Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9404C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB2C24676
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQN0Ey6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB2C24676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii14f-0004fe-L4
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 14:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tg-00074D-0U
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0te-0007r2-JY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:39 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0te-0007la-9g; Thu, 19 Dec 2019 13:51:38 -0500
Received: by mail-wm1-x342.google.com with SMTP id a5so6519270wmb.0;
 Thu, 19 Dec 2019 10:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EvN7owG5HPoEIvZGOHW50DRqlmt77IJjf48sxQbIWC8=;
 b=iQN0Ey6TvoUdvQhGvT3+wzjLpiqH49Soc8MMq9/2F18zlaA3ixJrdSQHcbQZMDUGaa
 EU9frq4JchJFigdK3xQy4N/UEYQUL5kWlIsGIEupClQxX1zZuBfvZzyATVefvtn6XC2o
 FsNwwihiNerV0zn7OO/AZLIbAVfwnw+2GUTPyo8Z6rFUXCoUp/Z/Q96gJnffvCG01Tis
 OR9uOWl8v23oBrLlLZTKGfE1QWcbL4XWtVueuN+xbyNhYJ4pQbpQlDNewDIPK9Wu2izU
 ZYr4Mu4UYQ8gDsLJgIEy7m4VXMz4ab5KL06ast+ZlbAracfi/CyMV8aGbr2aTKJel1P6
 GTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=EvN7owG5HPoEIvZGOHW50DRqlmt77IJjf48sxQbIWC8=;
 b=WuGJVqmYolxpuoh4B5Zzsr1TjjsLKLonvI09rPh4ZxVsL6zrHg1KFNbRpppGBkcj98
 0Gj1IULYi+fTJaN3jMG/4TqjKjsnQj0tDUxs4d7YG8ZNUagzCRlhhO60Ktu2PxWHnQcp
 7rBiIQN+cfM3KeqwH8foDY7quvQ/+q7o2v7fpWaRTe3hwLVXKtGe79D6NHcVGz8TArl7
 xJJVYVd3yLm+QZeHz4uJZYs2A1VDB/xyN2bQN47eCS8/YESRiWIzhuGUt7dSP+hJZRj9
 cNVynoSV+ipazEPyx9oy9Hs0pvg3rVFx7RV4Zh14AhBoXUcGKj9RvSNco57iJHUjvThn
 C+Rw==
X-Gm-Message-State: APjAAAUqnpoF41E+GDfU+tv0E+GJbOVCYjEY+mGU/ABH3ciThPKu2T27
 Vr8Q09q/2yqGtcQfNdlZq0vSYLU6
X-Google-Smtp-Source: APXvYqw9XQSwqS46Sp/Xh8kZUtnRV4WfPSCwWth8x8BajCzCyGJiyXXbtmQlP2TAUocuawJcJJfw7Q==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr11828185wmd.127.1576781497017; 
 Thu, 19 Dec 2019 10:51:37 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id b67sm7435494wmc.38.2019.12.19.10.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 10:51:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [RFC PATCH 06/13] hw/timer/allwinner: Rename 'timer_context' as
 'timer'
Date: Thu, 19 Dec 2019 19:51:20 +0100
Message-Id: <20191219185127.24388-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219185127.24388-1-f4bug@amsat.org>
References: <20191219185127.24388-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous 'timer' field has been renamed as 'ptimer'. The
'timer_context' can now be simplified as 'timer'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/timer/allwinner-a10-pit.h | 2 +-
 hw/timer/allwinner-a10-pit.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allwinner-a10-pit.h
index a60b9f3031..b5ac6898fa 100644
--- a/include/hw/timer/allwinner-a10-pit.h
+++ b/include/hw/timer/allwinner-a10-pit.h
@@ -21,7 +21,7 @@ struct AwA10PITState {
     /*< public >*/
     qemu_irq irq[AW_PIT_TIMER_MAX];
     ptimer_state * ptimer[AW_PIT_TIMER_MAX];
-    AwA10TimerContext timer_context[AW_PIT_TIMER_MAX];
+    AwA10TimerContext timer[AW_PIT_TIMER_MAX];
     MemoryRegion iomem;
     uint32_t clk_freq[4];
 
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index effdf91344..44e6eee3a8 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -301,7 +301,7 @@ static void a10_pit_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 
     for (i = 0; i < AW_A10_PIT_TIMER_NR; i++) {
-        AwA10TimerContext *tc = &s->timer_context[i];
+        AwA10TimerContext *tc = &s->timer[i];
 
         tc->container = s;
         tc->index = i;
-- 
2.21.0


