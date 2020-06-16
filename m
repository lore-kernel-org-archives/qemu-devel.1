Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A33C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD01320767
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJCnoy+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD01320767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl6Pv-0007yv-WF
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 03:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl6Nb-0003qt-Nl; Tue, 16 Jun 2020 03:51:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl6Na-00085H-52; Tue, 16 Jun 2020 03:51:35 -0400
Received: by mail-wr1-x444.google.com with SMTP id r7so19698344wro.1;
 Tue, 16 Jun 2020 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G6lKanRQH/GfdgMJk57r0dQsTnmvZD4sTSFGUEMnT+8=;
 b=iJCnoy+jzbnpq4MspV66mcR8W9OLQyPaNrTgFvghZJew4pyRMkFpsBEsb3u9BcH9AH
 GUIEW2JkvqcKbEgQ8SdvGnQj/mZtUdC0vHAGwGTsolPN8xORhMaUOZtZmzbpRAWCJx2q
 TLo/WsF23IW78QnCbvXH3q7Z8s2V51e3mKgt65ySZ3GYvyrAmjJeD6e9U1MwdgEdF26U
 +AEeewBrtCA3QWFholGOv/LQP2RifuF3CsOvgaP6RZTe31MX5lSTTgtXCwdIcSeS/PgH
 eKHcjbaJLIv4IYE5slrX77/ICK4pzmnWkbfnarVYxe0yFGeRGnLOPMoFNuFaD0i1D6NR
 KF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=G6lKanRQH/GfdgMJk57r0dQsTnmvZD4sTSFGUEMnT+8=;
 b=ACpopsp0oyBUPx6GAuYVEx/ayeVryUJTNIidbaD9ZBosvAdBqyVwZP1YOd3oi0SUG6
 1hmtzIVzaUO30R1vGjaER+CIUDW60DQ+RdoF7fm955CmSQ/wwU+WhqnuHlbN5iKGLxil
 oguF1ItpBlXBbgatBmgTgpjo87ph6g9AglqQ7kxLiiCMnvyztaPqF1Lwof9KuqAr3URT
 tIoWkNfyG5uCGhaJk76GoICb5HCgY8IvM48DwJ4RaEAtbRB48Ym+v0HTJsC2CITrtV3E
 qWja0umVdPI0t3zxGZGE3scnE86wjJYWCWkQVbYckGyB8letrIxzOu7diUi6VoRiIAnq
 Yc8g==
X-Gm-Message-State: AOAM531Nm6p9AYfOImeIty0bie2Ddg8MyiVygS22jtKOMlgO3Dpe0ocE
 TEY/IRSOeWsYoDxp/x0kvBiP3SlP
X-Google-Smtp-Source: ABdhPJxc/ut3CrLejgtMaoW7b+CKbd6QBvEnKCkbw3lP8vJsYndJAgt+nkcsh88++Key55zlSFHmxg==
X-Received: by 2002:a5d:6cc1:: with SMTP id c1mr1729297wrc.144.1592293891841; 
 Tue, 16 Jun 2020 00:51:31 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q11sm28093538wrv.67.2020.06.16.00.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 00:51:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] hw/ipmi/ipmi_bmc_extern: Reduce timer precision to
 milli-second
Date: Tue, 16 Jun 2020 09:51:20 +0200
Message-Id: <20200616075121.12837-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200616075121.12837-1-f4bug@amsat.org>
References: <20200616075121.12837-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current implementation uses nano-second precision, while
the device can not be more precise than a milli-second.
Simplify by using a milli-second based timer.
Rename the timer 'extern_timer_ms' to have the unit explicit.

Inspired-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ipmi/ipmi_bmc_extern.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index f9a13e0a44..441d3ed18e 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -81,7 +81,7 @@ typedef struct IPMIBmcExtern {
     unsigned int outpos;
     unsigned int outlen;
 
-    struct QEMUTimer *extern_timer;
+    QEMUTimer *extern_timer_ms;
 
     /* A reset event is pending to be sent upstream. */
     bool send_reset;
@@ -112,8 +112,8 @@ static void continue_send(IPMIBmcExtern *ibe)
     }
     if (ibe->outpos < ibe->outlen) {
         /* Not fully transmitted, try again in a 10ms */
-        timer_mod_ns(ibe->extern_timer,
-                     qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 10000000);
+        timer_mod(ibe->extern_timer_ms,
+                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 10);
     } else {
         /* Sent */
         ibe->outlen = 0;
@@ -137,8 +137,8 @@ static void continue_send(IPMIBmcExtern *ibe)
 
         if (ibe->waiting_rsp) {
             /* Make sure we get a response within 4 seconds. */
-            timer_mod_ns(ibe->extern_timer,
-                         qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 4000000000ULL);
+            timer_mod(ibe->extern_timer_ms,
+                      qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 4 * 1000);
         }
     }
     return;
@@ -303,7 +303,7 @@ static void handle_msg(IPMIBmcExtern *ibe)
         ibe->inpos--; /* Remove checkum */
     }
 
-    timer_del(ibe->extern_timer);
+    timer_del(ibe->extern_timer_ms);
     ibe->waiting_rsp = false;
     k->handle_rsp(ibe->parent.intf, ibe->inbuf[0], ibe->inbuf + 1, ibe->inpos - 1);
 }
@@ -502,7 +502,8 @@ static void ipmi_bmc_extern_init(Object *obj)
 {
     IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(obj);
 
-    ibe->extern_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, extern_timeout, ibe);
+    ibe->extern_timer_ms = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                        extern_timeout, ibe);
     vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
 }
 
@@ -510,8 +511,8 @@ static void ipmi_bmc_extern_finalize(Object *obj)
 {
     IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(obj);
 
-    timer_del(ibe->extern_timer);
-    timer_free(ibe->extern_timer);
+    timer_del(ibe->extern_timer_ms);
+    timer_free(ibe->extern_timer_ms);
 }
 
 static Property ipmi_bmc_extern_properties[] = {
-- 
2.21.3


