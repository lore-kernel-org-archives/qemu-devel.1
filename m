Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD44C5517A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 21:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC37208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 21:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="O5y58U+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC37208E4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW4I6-0002Hl-6r
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 17:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <35EWTXwsKCr8mxpnssjrtjslttlqj.htrvjrz-ij0jqstslsz.twl@flex--hskinnemoen.bounces.google.com>)
 id 1kW4Gx-0000Yj-0l
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 17:06:51 -0400
Received: from mail-qt1-x84a.google.com ([2607:f8b0:4864:20::84a]:33258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <35EWTXwsKCr8mxpnssjrtjslttlqj.htrvjrz-ij0jqstslsz.twl@flex--hskinnemoen.bounces.google.com>)
 id 1kW4Gt-0002Co-KX
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 17:06:50 -0400
Received: by mail-qt1-x84a.google.com with SMTP id d22so2178524qtn.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 14:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc:content-transfer-encoding;
 bh=ouqoL7S29tD4PVEuJKzZnMTGGD9JXqB31xNOhXsD6FQ=;
 b=O5y58U+hMuiekVLNSNNsPbTzicuuiakhAj/nV/3TOmlHdCgEr1DgyLXMXsdi+oY81N
 ampYTRC2euR8k4rhk41Veg0SXUZ1qMzKbdiC1sAyGw9kjk5rdwfhq/yLDGNSrLbTuhoy
 E7K03icKGY1GPA5Qxo2um/xwEiVGygYL3N1NusgrFCEtuXW2FxE7VxvFd/I5EpeKcHaB
 m3k/Zh4exJxjD5DR6cOq50MYkdieEn0Z4aRj6Tfjlg91dZN1bciywHZIEQFCc9yxxsz2
 JcxJpEDoT1ifU53i5V+6bS1HChzBWRjlYXIqyPVZCtJQMoUaj/J7OUvsS6pxhWHIR8SD
 76Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=ouqoL7S29tD4PVEuJKzZnMTGGD9JXqB31xNOhXsD6FQ=;
 b=DDrBZZOZatt5LguYDydIu7KOSvACAoY97nGHAuSm+kIWbR1+mVawNo7lQAVjGR/z7u
 6a/j8H61pACxWy5TSBgKIHA1lKkqPDPe3cIWG5Sqn+yaJFqVHK/JZ+QIltRQdi0ImGsN
 uLFgG2hU6QrIlIWiFTVgCR1Z1FFiJztibXHzi/MGnq0eh1PC4e8vjqso8BJ9tfGFyuX0
 id+SsHXKZ50Vh9aCiEN96kbKt6l1QNgpp5TWeA7O3ujHSKaMA45ai4ORFzkKwWcla4GW
 6CcjlDGFUTz2yY7IwteM7H4S1ectufWR4pFOnALlbPJKRhIV7hYz7zlvxYvGmml5fq4D
 gqQQ==
X-Gm-Message-State: AOAM531PkXclihjYG+x18t61GjTA1nKFTs7n6DseDD6L8r8cYSD1Ji5G
 87c9O7HTdElY3Tz0ffxEYqLbbNOt2dQHN71TQw==
X-Google-Smtp-Source: ABdhPJzYdXPpb11Af+MA2roO/mAPxp6LJoyqZmVPKx0JzJWVUX1qeLkZG5a9Oyf4Z+SDtTq211sQvqeC8tVNAFgJRA==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by 2002:ad4:44b3:: with SMTP id
 n19mr1042465qvt.39.1603487204343; Fri, 23 Oct 2020 14:06:44 -0700 (PDT)
Date: Fri, 23 Oct 2020 14:06:33 -0700
In-Reply-To: <20201023210637.351238-1-hskinnemoen@google.com>
Message-Id: <20201023210637.351238-3-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20201023210637.351238-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v3 2/6] Move npcm7xx_timer_reached_zero call out of
 npcm7xx_timer_pause
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, venture@google.com, wuhaotsh@google.com, thuth@redhat.com, 
 Havard Skinnemoen <hskinnemoen@google.com>, 
 "=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=" <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::84a;
 envelope-from=35EWTXwsKCr8mxpnssjrtjslttlqj.htrvjrz-ij0jqstslsz.twl@flex--hskinnemoen.bounces.google.com;
 helo=mail-qt1-x84a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

This allows us to reuse npcm7xx_timer_pause for the watchdog timer.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/timer/npcm7xx_timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/timer/npcm7xx_timer.c b/hw/timer/npcm7xx_timer.c
index 5703e43d40..2df9e3e496 100644
--- a/hw/timer/npcm7xx_timer.c
+++ b/hw/timer/npcm7xx_timer.c
@@ -157,9 +157,6 @@ static void npcm7xx_timer_pause(NPCM7xxTimer *t)
     timer_del(&t->qtimer);
     now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     t->remaining_ns =3D t->expires_ns - now;
-    if (t->remaining_ns <=3D 0) {
-        npcm7xx_timer_reached_zero(t);
-    }
 }
=20
 /*
@@ -239,6 +236,9 @@ static void npcm7xx_timer_write_tcsr(NPCM7xxTimer *t, u=
int32_t new_tcsr)
         } else {
             t->tcsr &=3D ~NPCM7XX_TCSR_CACT;
             npcm7xx_timer_pause(t);
+            if (t->remaining_ns <=3D 0) {
+                npcm7xx_timer_reached_zero(t);
+            }
         }
     }
 }
--=20
2.29.0.rc1.297.gfa9743e501-goog


