Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A84C43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 19:00:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE192085B
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 19:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE192085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJi6L-0005CI-LC
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 15:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrN-0006EK-Bf; Sat, 19 Sep 2020 14:45:21 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:48803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrL-0001Nt-9c; Sat, 19 Sep 2020 14:45:20 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M6YEz-1kQZTV3Kiv-0070Dx; Sat, 19 Sep 2020 20:45:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 07/17] hw/timer/hpet: Fix debug format strings
Date: Sat, 19 Sep 2020 20:44:41 +0200
Message-Id: <20200919184451.2129349-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200919184451.2129349-1-laurent@vivier.eu>
References: <20200919184451.2129349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CSSWRgZh6JbcXyahwv74b0wDlMXHchcCc40SQ2MSmlbSCjkOzFo
 7nivfKBzWtx6v3f/J3GQxfcpkk+chZ1FUVJXL0PqcVBJ0poMvpFPyvno4HTXLOcggZItKQh
 Ynk/diSRSaEKuKZQ9O08EneM+sORLs53LPWsF9USvK5Wnw3ts8vJK3BZ09SuKZVmS67g/3a
 EKbtU6IkroH2XQ57bTl2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HX8wdJf/Q+4=:ppFnfpa1xF62RSms8tATaF
 UcwqTy1ao4NSAXBEeelyUx2XfUb7lOnzqSx8uH/HJcZCkGShnoaUiRZKATolq91ryRwRBMmQj
 dSyT+Z0T4cuzfF+ICODBWLv3xFPXh1F3hq5sFxfbchPY+PZSuYEv7YcB35pEsu4KT0SkjOR+O
 Iootx1XmjEPLhBO47bgnCZbzq/4ZIOO8ABTo2GSq1DZrkAU6NmGE7UAQCMV8QgmoscCxRX8mH
 +6JphVRHy9xJhAbd2ZXQUEP6Up0OKB49ulMKyaQ0ouYeD6c02YdPMurDuVE4lAJisO2m6QXo4
 f+iqi9ORGMpsomjaxDrHQCI31ETZImeGuLlzYmVxQBZf3knmQvc8spdSrN22ynJk0PiPgO5EQ
 IYu0LdJ2FX9UMETbZ58fWYQ5L90oaqlJV9qnhhw+ycX0g2pN+B5wmgEijEj1JTFz3gHvArHXa
 4uMa2l8X0ofDAJFLg9U0RigFE0DvuGggPLH0GjW0WjadDUGoZDemsvkVmYaCv3vWHfHcMGPmj
 QsA5wrhrwgUD7mAYm4PTjz+LfHGeS+EX5SmuLFa3o8oCyr6xLdhT3WjfPizsIdl2IcRw3G+RO
 MOBdZV3ymxsobVc/I5otSf6O15v/rZ917+QjgonrcM9L9xaB9dKxdlFX5JyBrMZEjcBbbxYcS
 gG3MzfSZqKpRI30VCgI7yCcr64afdvhGGkGvEjr5AudH3j599y7hUS4I2nhm8bHqRxIEMsLvM
 GR0D0bWxowwcJVnpyDM0bnsptauBgKCCLv8V+CW7l+JKFB/ILCwAwGLdhO9N1DUaWBRu1eIH5
 p0HSg1RHWJxDkPzDOWbrN7UWTJCAlq4548d2I2OUqsv/vvN+yowC5wWhfRqWPPtTGDUmUVT
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 14:45:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Dov Murik <dovmurik@linux.vnet.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dov Murik <dovmurik@linux.vnet.ibm.com>

Fix compiler errors when compiling with -DHPET_DEBUG due to mismatch
between format string token "%x" and the argument type uint64_t.

Also "%#x" is replaced by "0x%" PRIx64 according to the coding style.

Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200909083650.46771-3-dovmurik@linux.vnet.ibm.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/timer/hpet.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 07ff82b33358..edaa5a0adfb5 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -498,7 +498,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
     HPETState *s = opaque;
     uint64_t old_val, new_val, val, index;
 
-    DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = %#x\n", addr, value);
+    DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = 0x%" PRIx64 "\n",
+            addr, value);
     index = addr;
     old_val = hpet_ram_read(opaque, addr, 4);
     new_val = value;
@@ -508,7 +509,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
         uint8_t timer_id = (addr - 0x100) / 0x20;
         HPETTimer *timer = &s->timer[timer_id];
 
-        DPRINTF("qemu: hpet_ram_writel timer_id = %#x\n", timer_id);
+        DPRINTF("qemu: hpet_ram_writel timer_id = 0x%x\n", timer_id);
         if (timer_id > s->num_timers) {
             DPRINTF("qemu: timer id out of range\n");
             return;
@@ -640,8 +641,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             }
             s->hpet_counter =
                 (s->hpet_counter & 0xffffffff00000000ULL) | value;
-            DPRINTF("qemu: HPET counter written. ctr = %#x -> %" PRIx64 "\n",
-                    value, s->hpet_counter);
+            DPRINTF("qemu: HPET counter written. ctr = 0x%" PRIx64 " -> "
+                    "%" PRIx64 "\n", value, s->hpet_counter);
             break;
         case HPET_COUNTER + 4:
             if (hpet_enabled(s)) {
@@ -649,8 +650,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             }
             s->hpet_counter =
                 (s->hpet_counter & 0xffffffffULL) | (((uint64_t)value) << 32);
-            DPRINTF("qemu: HPET counter + 4 written. ctr = %#x -> %" PRIx64 "\n",
-                    value, s->hpet_counter);
+            DPRINTF("qemu: HPET counter + 4 written. ctr = 0x%" PRIx64 " -> "
+                    "%" PRIx64 "\n", value, s->hpet_counter);
             break;
         default:
             DPRINTF("qemu: invalid hpet_ram_writel\n");
-- 
2.26.2


