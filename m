Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2155AC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5364206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kom6OthB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5364206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWDK-0000yy-47
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrx-0003Og-C4
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrw-0003iM-9x
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:49:09 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrw-0003hw-4H
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:49:08 -0400
Received: by mail-wm1-x342.google.com with SMTP id a81so301016wmf.5
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Naug8W0LWReLORHDTW9K27qxlHJDeDYvP9vX7iexkhs=;
 b=kom6OthBa1HHCt05KjRZ2xdxS03CX4msDX2U98L+ldTABVJ6kcDNRStWcXR68WiOHM
 zYRcmG1vYzqAcWA4yEfx5cc2RVb20ikXqncpT7ny8jMrElb4l033MR9zD+qcU/uWHMze
 jEGVkVQAn/2+aUH0yYEmmKvm0XyVMWNDml6Sgk+l6fVjiUEQfY5CiRWm/hreG13CxqMp
 +tn/vhO2amngwTUu3fywiCqSm1Int1KGQP4FGLwoacPglrYtvtgm25XSz9j3lSElvJ1a
 4n4+0V1PLFC4RkzXfF3zSbm+6vSvlgf+s6zR+aDPv9xMMHde2V3AizArmIZKUPB8ZyxD
 9IgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Naug8W0LWReLORHDTW9K27qxlHJDeDYvP9vX7iexkhs=;
 b=klnmFIVxyOZRsGmjSC3cAfgp8auwlxdm92hlO/c+4hMVEMezl/7HeLhjx4YswRYmdH
 cAfY072Lo9zBvXcohmgF8LvIz+NIfEwfTMJysPxafX+bgbrfAochHKrSaoRrClWR8LBS
 nkPSc4lgzVRYrLfNoDWXEAfCr7YPyPfTa+jpf1S+jeMPv8tVc7KY+qSgdqIKfc7fyvFJ
 SQ0CraqxOniE0BGoWa35ocQtaynFFUq6pJxBlm/SUW2pjmzoeUyaJYFLWnjvF/bNKf8f
 ClqLs45Y5FIs/tbLyYehjSHvC/P4TC+5PeCtIo0+RFctiIr8iuRri/xLZfHs+IY55X4n
 MHoA==
X-Gm-Message-State: AGi0PuaEosLBk8SmGcia2vg6qN44AVT3ppo2DtohF4yTnpW7qBhA+MAk
 FwLa/6loNpPpSzmyLqPWXzOGVq5tZdQ=
X-Google-Smtp-Source: APiQypISbAA9E22Tjd8A4TvYtQmYANzQdqOHeHtYajV402tH77ees9VOCozC4dvQJv/txjNCZIJCYw==
X-Received: by 2002:a1c:4d13:: with SMTP id o19mr209445wmh.82.1586195346929;
 Mon, 06 Apr 2020 10:49:06 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:49:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 53/54] hw/mips/mips_malta: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:42 +0200
Message-Id: <20200406174743.16956-54-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running the coccinelle script produced:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/find-missing-error_propagate.cocci \
    --keep-comments --smpl-spacing --dir .
  HANDLING: ./hw/mips/mips_malta.c
  [[manual check required: error_propagate() might be missing in object_property_set_int() ./hw/mips/mips_malta.c:1193:4]]
  [[manual check required: error_propagate() might be missing in object_property_set_str() ./hw/mips/mips_malta.c:1192:4]]

Add the missing error_propagate() after review by adding
a Error* parameter to create_cps().

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_malta.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index e4c4de1b4e..8d43cfd41b 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1183,18 +1183,27 @@ static void create_cpu_without_cps(MachineState *ms,
 }
 
 static void create_cps(MachineState *ms, MaltaState *s,
-                       qemu_irq *cbus_irq, qemu_irq *i8259_irq)
+                       qemu_irq *cbus_irq, qemu_irq *i8259_irq,
+                       Error **errp)
 {
     Error *err = NULL;
 
     sysbus_init_child_obj(OBJECT(s), "cps", OBJECT(&s->cps), sizeof(s->cps),
                           TYPE_MIPS_CPS);
     object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
-    if (err != NULL) {
-        error_report("%s", error_get_pretty(err));
-        exit(1);
+    if (err) {
+        error_propagate(errp, err);
+        return;
     }
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
@@ -1207,7 +1216,7 @@ static void mips_create_cpu(MachineState *ms, MaltaState *s,
                             qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
     if ((ms->smp.cpus > 1) && cpu_supports_cps_smp(ms->cpu_type)) {
-        create_cps(ms, s, cbus_irq, i8259_irq);
+        create_cps(ms, s, cbus_irq, i8259_irq, &error_fatal);
     } else {
         create_cpu_without_cps(ms, cbus_irq, i8259_irq);
     }
-- 
2.21.1


