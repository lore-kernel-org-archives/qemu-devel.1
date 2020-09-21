Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7B0C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2AF0207D8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9H0Uvxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AF0207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKCwc-0000G5-SW
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 23:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKCsz-0004N1-Rd; Sun, 20 Sep 2020 23:53:05 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKCsy-00030A-8T; Sun, 20 Sep 2020 23:53:05 -0400
Received: by mail-wm1-x343.google.com with SMTP id b79so11040596wmb.4;
 Sun, 20 Sep 2020 20:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3AjXG5w656FN23Be/Hsok/QAzJiXXjNLyOG7YnfgnNo=;
 b=h9H0UvxpYdAmTGw6vkfHy7CmkRryqCaWAqDtjFWiieXT0tTd8zXqbgazKrzULUMSxk
 Bf0BEGMwtchgO/GB2VcMHDEh31tQYb/lWClxzjmpXW+VKvyyYK5CvYrM0CRgvneHfOoy
 Ga3am9DlOn/aHP2HFatMIULVg8tSBMHwldtR4KjlqEHjvsxo72oZNlULzVhM+6lO9YZg
 qi1ZKCd1gSHwK6oL2SqVv4kZdKVe7qWr0XW3o4oVoFpjLDNDhUmba8pCNlDHUBHitYau
 EMwQ6wJqGxQJJ/PQFVZiyxuCrHFfd8fN2KAx4RNEJDIDpIAMCUfKifZbV1EtGYVfwKWV
 9zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3AjXG5w656FN23Be/Hsok/QAzJiXXjNLyOG7YnfgnNo=;
 b=R4mx3/xIJB7PVGxVuGQZt0tOpW5tPbYA4VW5KoDZq1M8cys2/BO6s6dOHv26HKGycb
 t+DTOZbJpWjkoSBHuyQVh2Nh38btZn76kVslx/NBrWs7I1izjs0y9IXbHNV8q4ChpXhR
 BsDEJrbDKqDgQTIiB+IPrXjNAmMQ4kkmRIbdspKiLwNpqBN3kfiA/pWCde4FdpIvulvT
 aK/G5aG2L2Bxtn0yooWveM3bUjZp/FU/+yybZOZKSUMOpjjgWThp4ugghgFjfg7bGZAA
 dGtlOrKeOXrGTBj75WNJnRPZUaps0vxglDclJCEuSqgiG1RW1RJEawNWSrS0vLDJsBBW
 3GyA==
X-Gm-Message-State: AOAM53376cRRkaM1HbANQ6AUtQHZPWafiz+9i53ZO09e2VEdjbdm1qo5
 EvEd3ZeA9KIrc3W+l7rgF8zjv1ANWLE=
X-Google-Smtp-Source: ABdhPJwUmv0Zim/84lID1wmhTMas5abQoKCPogiScrn4qGrqI3NqShPh9tuOcE8ERtoXqNeqWKuDMQ==
X-Received: by 2002:a7b:c8c9:: with SMTP id f9mr28700692wml.67.1600660382318; 
 Sun, 20 Sep 2020 20:53:02 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a17sm19633754wra.24.2020.09.20.20.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 20:53:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/5] hw/timer/bcm2835: Introduce BCM2835_SYSTIMER_COUNT
 definition
Date: Mon, 21 Sep 2020 05:52:54 +0200
Message-Id: <20200921035257.434532-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921035257.434532-1-f4bug@amsat.org>
References: <20200921035257.434532-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the BCM2835_SYSTIMER_COUNT definition instead of the
magic '4' value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/timer/bcm2835_systmr.h | 4 +++-
 hw/timer/bcm2835_systmr.c         | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
index 64166bd7120..11272837a6b 100644
--- a/include/hw/timer/bcm2835_systmr.h
+++ b/include/hw/timer/bcm2835_systmr.h
@@ -18,6 +18,8 @@ typedef struct BCM2835SystemTimerState BCM2835SystemTimerState;
 DECLARE_INSTANCE_CHECKER(BCM2835SystemTimerState, BCM2835_SYSTIMER,
                          TYPE_BCM2835_SYSTIMER)
 
+#define BCM2835_SYSTIMER_COUNT 4
+
 struct BCM2835SystemTimerState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -28,7 +30,7 @@ struct BCM2835SystemTimerState {
 
     struct {
         uint32_t status;
-        uint32_t compare[4];
+        uint32_t compare[BCM2835_SYSTIMER_COUNT];
     } reg;
 };
 
diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
index 3387a6214a2..ff8c5536610 100644
--- a/hw/timer/bcm2835_systmr.c
+++ b/hw/timer/bcm2835_systmr.c
@@ -134,7 +134,8 @@ static const VMStateDescription bcm2835_systmr_vmstate = {
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(reg.status, BCM2835SystemTimerState),
-        VMSTATE_UINT32_ARRAY(reg.compare, BCM2835SystemTimerState, 4),
+        VMSTATE_UINT32_ARRAY(reg.compare, BCM2835SystemTimerState,
+                             BCM2835_SYSTIMER_COUNT),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.26.2


