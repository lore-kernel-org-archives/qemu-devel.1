Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE463C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4ED2054F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CORuOirn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4ED2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFiCq-00056b-It
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrN-0005TD-R9
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrM-0003Rl-OU
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:17 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrM-0003R0-Hn
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:16 -0400
Received: by mail-wr1-x42e.google.com with SMTP id v8so20519792wrt.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fj1AKGyMUrtlB+uC4vz0fN5u5wPsLJxKVwRlCM2AV/0=;
 b=CORuOirnOaqyHmbCkvsaMss2mzdHDH4DC6uB1r4pwqG4QS6mRLswlv5s5wyo5Gm6lR
 qJFSiQ1iamFcYp85Okx6f3x/cVEyqNU856ObEpeccmYDRZFa+eJ3wPYr4HqLeYLF+sfB
 sedouvTPV6YOS1Nx1IC+yutyA2fiRUlTvPm/xt2dErI4ACUA3cueHLXOnhGiC0wniFqt
 H/0zb4+554VDfgzIbGcnf4oYKDGOEPsbJU1AW5oJmCjGP10b4CR/nx9mXMH5EKY/0/0Z
 Rbn3ytZRs+WWIOI3AtO303Wxe0+Mj9SEVIhZLMDAim5FpJ5XGY5bBRPIhM+6+JB+mzmN
 hx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fj1AKGyMUrtlB+uC4vz0fN5u5wPsLJxKVwRlCM2AV/0=;
 b=FGlxd7DVJKal/d4uzHAip5VY2g01DTv63+L4J6goNN0OajGPvThTdJaO6QYrt/s/Ia
 hNgkUxYI8KXGW9LbCnaXRFk4zfqG/eElEaJcST5Im4of8PwDTyAk4FWGmezFYarvvM1d
 AcQ9UshYztA2HTnN7lxyqN128C9D9EkxSFfgV4Bn7ai2sSMZBvunVitN99NU09jC88rF
 0/RBOE2H9TwwGj+BQOy+oqP1+MxDQmZyp9kotihZGlq4H8+mGiIpcRc0JOOoGXkx/yWN
 Qj5GaFL8X6BQVcy7ydoR4dXsafB2oj7Zix8m+s1KwTEDfC0C9y8afPwRrFCy0S9bEDmN
 4ZJg==
X-Gm-Message-State: APjAAAX90fG53mqCNqDqw7xy4oAd58GUAAATCQ38AGj3IRopHq1aL5Ku
 NaJL3dRn/wbTGhe3oDNehnDu+Ah1
X-Google-Smtp-Source: APXvYqwfYyWfIs9bJTfD7vJT1nrb/8CrygBZAGOiDiLRp7E25HEWnylZAPKHAzWw1Y3Acux1gGHqMA==
X-Received: by 2002:adf:e410:: with SMTP id g16mr3271189wrm.297.1570035135434; 
 Wed, 02 Oct 2019 09:52:15 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/30] lm32: do not leak memory on object_new/object_unref
Date: Wed,  2 Oct 2019 18:51:43 +0200
Message-Id: <1570035113-56848-21-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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

Bottom halves and ptimers are malloced, but nothing in these
files is freeing memory allocated by instance_init.  Since
these are sysctl devices that are never unrealized, just moving
the allocations to realize is enough to avoid the leak in
practice (and also to avoid upsetting asan when running
device-introspect-test).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/timer/lm32_timer.c       |  6 +++---
 hw/timer/milkymist-sysctl.c | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index ac3edaf..cf316ed 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -186,9 +186,6 @@ static void lm32_timer_init(Object *obj)
 
     sysbus_init_irq(dev, &s->irq);
 
-    s->bh = qemu_bh_new(timer_hit, s);
-    s->ptimer = ptimer_init(s->bh, PTIMER_POLICY_DEFAULT);
-
     memory_region_init_io(&s->iomem, obj, &timer_ops, s,
                           "timer", R_MAX * 4);
     sysbus_init_mmio(dev, &s->iomem);
@@ -198,6 +195,9 @@ static void lm32_timer_realize(DeviceState *dev, Error **errp)
 {
     LM32TimerState *s = LM32_TIMER(dev);
 
+    s->bh = qemu_bh_new(timer_hit, s);
+    s->ptimer = ptimer_init(s->bh, PTIMER_POLICY_DEFAULT);
+
     ptimer_set_freq(s->ptimer, s->freq_hz);
 }
 
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 9583507..6aedc11 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -283,11 +283,6 @@ static void milkymist_sysctl_init(Object *obj)
     sysbus_init_irq(dev, &s->timer0_irq);
     sysbus_init_irq(dev, &s->timer1_irq);
 
-    s->bh0 = qemu_bh_new(timer0_hit, s);
-    s->bh1 = qemu_bh_new(timer1_hit, s);
-    s->ptimer0 = ptimer_init(s->bh0, PTIMER_POLICY_DEFAULT);
-    s->ptimer1 = ptimer_init(s->bh1, PTIMER_POLICY_DEFAULT);
-
     memory_region_init_io(&s->regs_region, obj, &sysctl_mmio_ops, s,
             "milkymist-sysctl", R_MAX * 4);
     sysbus_init_mmio(dev, &s->regs_region);
@@ -297,6 +292,11 @@ static void milkymist_sysctl_realize(DeviceState *dev, Error **errp)
 {
     MilkymistSysctlState *s = MILKYMIST_SYSCTL(dev);
 
+    s->bh0 = qemu_bh_new(timer0_hit, s);
+    s->bh1 = qemu_bh_new(timer1_hit, s);
+    s->ptimer0 = ptimer_init(s->bh0, PTIMER_POLICY_DEFAULT);
+    s->ptimer1 = ptimer_init(s->bh1, PTIMER_POLICY_DEFAULT);
+
     ptimer_set_freq(s->ptimer0, s->freq_hz);
     ptimer_set_freq(s->ptimer1, s->freq_hz);
 }
-- 
1.8.3.1



