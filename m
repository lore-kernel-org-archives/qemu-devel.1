Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4384C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372DD20796
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu9yn4I5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372DD20796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF6P8-000864-74
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kF6Nn-0006B5-V4; Sun, 06 Sep 2020 21:55:47 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kF6Nm-0007La-Cv; Sun, 06 Sep 2020 21:55:47 -0400
Received: by mail-wm1-x344.google.com with SMTP id x23so2943833wmi.3;
 Sun, 06 Sep 2020 18:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0L6FMvGCY7Yqd00xQ/ZxKfuTHVYGmeZNYt98i5HNRDQ=;
 b=Nu9yn4I572XTs2h/pxBeMKSFLjGP9QBvQ5EEsO3R1rF7zesE2dh8nvd0nrdIqqMaLp
 ic9oKnFgq6cR/TRt4Hdn/iHYWZaHLT+GrhyXe5nBxvuY1f1Ctu7yIeXfzB62LAbRyqDa
 I6HIuDYOGDPDIspKcvyQPki2OmqbC2O7KZ2rlz0AIIR05wwcMLuorORaY4ZGvhOmcBQp
 HTO2MfRSVVimUnQy9hVrbfclPgmuCcH7NPvhWk/5v6y0kdBgTycUkoVhKsy+2t0bNn9C
 E13N8BLsQt9pKPblQe4CL3U8yGPc5QuvYPP/MNg6ZQR/V4iHcCZH4Co5hAjbUmIl/5Cu
 92vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0L6FMvGCY7Yqd00xQ/ZxKfuTHVYGmeZNYt98i5HNRDQ=;
 b=FlBQXChFP70ARsl5nvgmK48HtAYz6tgf1jd7Dwg7W8U4S2zeT5KjSSU2MqMNWG/nbx
 +q+RuiqapzDQv6g9aR6FcrdKHNt0QhV20V4tuqBinGclDdnJt5+Z6+aohmsALGBNSZDv
 9vyLvoUzxCRjvhK3Qbt/wNe/jIIMvk68fL+EenMCKEXiPc2x3pmgnuB+2F7AyWcf41a6
 ZFz1fMvJq5x0ZXxP6fFax2kExSuHWYO7ETS8e4B4CawYmoI+4Cf7cbn3DbFWVst2LUwA
 xVBVWZU6D0yK4OzD5CWRHN95ALGBhTgNTyBKSGnhLK5DMJtP6lrw5MK4GRz9RjMDUyny
 T5Rw==
X-Gm-Message-State: AOAM531yiBuRAEB3WVNLHyE4Z2vtNhOiWC3DFW4mp/d3LBDSMTK8UnIt
 5a7c7t20om/qHUzHxJlZYePUZnksyLE=
X-Google-Smtp-Source: ABdhPJz0+Wx8FlePRpciApvzJoZqsUGQeqDUyIJzpgtF9yr1rUki+orEphbcJKcqE9s5fB3m0cYnDg==
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr18864165wmc.45.1599443744300; 
 Sun, 06 Sep 2020 18:55:44 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b84sm29377773wmd.0.2020.09.06.18.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 18:55:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] hw/char/serial: Make 'wakeup' property boolean
Date: Mon,  7 Sep 2020 03:55:33 +0200
Message-Id: <20200907015535.827885-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907015535.827885-1-f4bug@amsat.org>
References: <20200907015535.827885-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the "wakeup" property introduced in commit 9826fd597df
("suspend: make serial ports wakeup the guest") a boolean.

As we want to reuse the generic serial properties in the
ISA model (next commit), expose this property.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/char/serial.h | 2 +-
 hw/char/serial-isa.c     | 2 +-
 hw/char/serial.c         | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 535fa23a2b8..3d2a5b27e87 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -60,7 +60,7 @@ typedef struct SerialState {
     uint32_t baudbase;
     uint32_t tsr_retry;
     guint watch_tag;
-    uint32_t wakeup;
+    bool wakeup;
 
     /* Time when the last byte was successfully sent out of the tsr */
     uint64_t last_xmit_ts;
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index b4c65949cd8..a0c338796d5 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -116,7 +116,7 @@ static Property serial_isa_properties[] = {
     DEFINE_PROP_UINT32("iobase",  ISASerialState, iobase,  -1),
     DEFINE_PROP_UINT32("irq",    ISASerialState, isairq,  -1),
     DEFINE_PROP_CHR("chardev",   ISASerialState, state.chr),
-    DEFINE_PROP_UINT32("wakeup", ISASerialState, state.wakeup, 0),
+    DEFINE_PROP_BOOL("wakeup",   ISASerialState, state.wakeup, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/char/serial.c b/hw/char/serial.c
index ade4adfd526..ade89fadb44 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1015,6 +1015,7 @@ static const TypeInfo serial_io_info = {
 static Property serial_properties[] = {
     DEFINE_PROP_CHR("chardev", SerialState, chr),
     DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
+    DEFINE_PROP_BOOL("wakeup", SerialState, wakeup, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.26.2


