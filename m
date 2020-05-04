Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF1DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F20206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F20206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdgH-0003wq-E8
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdWE-0001aj-9d; Mon, 04 May 2020 12:00:34 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdWC-0005wC-9D; Mon, 04 May 2020 12:00:33 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MXGak-1jdtPD37AE-00YfI9; Mon, 04 May 2020 18:00:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 19/19] hw/timer/pxa2xx_timer: Add assertion to silent static
 analyzer warning
Date: Mon,  4 May 2020 17:59:56 +0200
Message-Id: <20200504155956.380695-20-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
References: <20200504155956.380695-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZR9NwCl1SFOgGjyeI8D8NNykyUUgcLLZMaS5wwwT9tGrGCiso3d
 jKesMyobdiAq/1V/HdBSo4zP+EyzbIeW+wKRGU70X+KuHce1J31ptF5wxj/Lwk3PevYgdiM
 GpDbDiyg3R+Ncj0NVpCh/XXJ3BNk3BoPO+BsEb1qjuEHGkzNiAQNerJCPT3rKJY1K9+qFLA
 5di38YMSNBFPtps5uaHgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hTJ9bSQVtK8=:YSECT2GJKj6Au0QHE8bFYy
 9gpQ6CBPyhA4xIZulZOklEk1mGc6OAjWlTJRnhHAGgI+OsrBStqsg5Cqdp2Kv/0PW729sHU+B
 /DCI9fa91rP/MDGF4lg0+c5TrHJuu9MXclpTtPAopMaU7ava0wHfuuL/p6U+t6jNyCjuSd/IA
 EQ9V5jI5hLtBLhcNhWSoA5Ws02qyOTNbyF83zyXQAQg9maGtIgQOJtKzoXJWQiuA+Nh2E8Nt1
 00hVQ6e98laPdqmTCXKzA0KaGXsmLxs/ka++REhD3wl8ViqNWev8teY/MI8568TMosxpoRH+/
 4HhXtZQMFVX894TtwUGf/qkLQFhh9081M7ZS3mhIDjM0jcdZy9gufzAyW3xZDGRpTaAd67ZNU
 smDzQLQXiOz9XngK7igdPaQpYQhClQWpaR0uFJcPKUsnI1AgLwFSDfdlaXvqpTP+wjGBKTLDw
 czUhJ2Rf95gbdVYHg446bFOZkZ/XVrjhcM5cv7iCWHtcuT6LQRoyNjZicz313i3Xjx4Qwlzf/
 aWW7XPZZYHHa6R1nXWD5o+Vy0yb3RPvC8A4TgkU+a6HWoagwT22ZTh+JnLUcnJiVFYoj1gUww
 j9VL4HWH4Gy1yZ9I10/a6IvHC6S2dnXdrA2n12doqrJE0ASAY83/QaYnMVFZQFQjNMbPNUObo
 FK07mAcEL7SGSw490N68M+2Ato9dOZ7AHzeTiQWmRXKOhLI32P6wBqlrTWkkgel038r1SuL+g
 vfjGc3HMgRHTfu2dtYJ4ZzHaRfLxegMHANDJ9oclgpTHHofi0ENrnZP52Hedf6VmLXFQfpetn
 QHco45Tftjvr/pbicdCwWjCylCPXC14ysAQ/OPd49y2TEa78pL1/S8v3LnzKSQZW1WNOtCS
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 11:59:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

pxa2xx_timer_tick4() takes an opaque pointer, then calls
pxa2xx_timer_update4(), so the static analyzer can not
verify that the 'n < 8':

  425 static void pxa2xx_timer_tick4(void *opaque)
  426 {
  427     PXA2xxTimer4 *t = (PXA2xxTimer4 *) opaque;
  428     PXA2xxTimerInfo *i = (PXA2xxTimerInfo *) t->tm.info;
  429
  430     pxa2xx_timer_tick(&t->tm);
  433     if (t->control & (1 << 6))
  434         pxa2xx_timer_update4(i, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), t->tm.num - 4);

  135 static void pxa2xx_timer_update4(void *opaque, uint64_t now_qemu, int n)
  136 {
  137     PXA2xxTimerInfo *s = (PXA2xxTimerInfo *) opaque;
  140     static const int counters[8] = { 0, 0, 0, 0, 4, 4, 6, 6 };
  142
  143     if (s->tm4[n].control & (1 << 7))
  144         counter = n;
  145     else
  146         counter = counters[n];

Add an assert() to give the static analyzer a hint, this fixes a
warning reported by Clang static code analyzer:

    CC      hw/timer/pxa2xx_timer.o
  hw/timer/pxa2xx_timer.c:146:17: warning: Assigned value is garbage or undefined
          counter = counters[n];
                  ^ ~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200422133152.16770-10-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/timer/pxa2xx_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index cd172cc1e960..944c16588926 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -140,6 +140,7 @@ static void pxa2xx_timer_update4(void *opaque, uint64_t now_qemu, int n)
     static const int counters[8] = { 0, 0, 0, 0, 4, 4, 6, 6 };
     int counter;
 
+    assert(n < ARRAY_SIZE(counters));
     if (s->tm4[n].control & (1 << 7))
         counter = n;
     else
-- 
2.26.2


