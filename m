Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3727C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986AF212CC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986AF212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jokdA-0000Rs-TH
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 05:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jokaK-0003hU-SG; Fri, 26 Jun 2020 05:23:48 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:34206
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jokaH-0004Sh-VM; Fri, 26 Jun 2020 05:23:48 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jokaG-0007bz-5o; Fri, 26 Jun 2020 10:23:47 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org, laurent@vivier.eu, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Date: Fri, 26 Jun 2020 10:22:58 +0100
Message-Id: <20200626092317.3875-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626092317.3875-1-mark.cave-ayland@ilande.co.uk>
References: <20200626092317.3875-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 03/22] cuda: convert ADB autopoll timer from ns to ms
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is in preparation for consolidating all of the ADB autopoll management
in one place.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200623204936.24064-4-mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/cuda.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 47aa3b0552..01bf47327c 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -210,8 +210,9 @@ static void cuda_adb_poll(void *opaque)
         obuf[1] = 0x40; /* polled data */
         cuda_send_packet_to_host(s, obuf, olen + 2);
     }
-    timer_mod(s->adb_poll_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-              (NANOSECONDS_PER_SECOND / (1000 / s->autopoll_rate_ms)));
+
+    timer_mod(s->adb_poll_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+              s->autopoll_rate_ms);
 }
 
 /* description of commands */
@@ -238,8 +239,8 @@ static bool cuda_cmd_autopoll(CUDAState *s,
         s->autopoll = autopoll;
         if (autopoll) {
             timer_mod(s->adb_poll_timer,
-                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                      (NANOSECONDS_PER_SECOND / (1000 / s->autopoll_rate_ms)));
+                      qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+                      s->autopoll_rate_ms);
         } else {
             timer_del(s->adb_poll_timer);
         }
@@ -264,8 +265,8 @@ static bool cuda_cmd_set_autorate(CUDAState *s,
     s->autopoll_rate_ms = in_data[0];
     if (s->autopoll) {
         timer_mod(s->adb_poll_timer,
-                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                  (NANOSECONDS_PER_SECOND / (1000 / s->autopoll_rate_ms)));
+                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+                  s->autopoll_rate_ms);
     }
     return true;
 }
@@ -544,7 +545,7 @@ static void cuda_realize(DeviceState *dev, Error **errp)
     s->sr_delay_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_set_sr_int, s);
     s->sr_delay_ns = 20 * SCALE_US;
 
-    s->adb_poll_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_adb_poll, s);
+    s->adb_poll_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, cuda_adb_poll, s);
     s->adb_poll_mask = 0xffff;
     s->autopoll_rate_ms = 20;
 }
-- 
2.20.1


