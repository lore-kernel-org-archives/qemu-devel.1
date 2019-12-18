Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9EEC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1052146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7CL1f+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1052146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYdv-00013x-HR
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3f-00073f-MH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3e-0002Ww-8j
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:03 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3d-0002Vf-Un
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:02 -0500
Received: by mail-wr1-x434.google.com with SMTP id t2so2030973wrr.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uKWbw2FnihoJIGt9f/+APcjo5dktAD56+VxJMIHASKI=;
 b=L7CL1f+RwifD7VM9rNQavIU+2YSt1KDNNBSMahvUg/w0442Sjkse93vcBDTeBoL6K6
 KrIn9cRpaq5dGOtMMvsgUpiB5DdxtqFQDHfwRj9Dgz0bRdQ8jdlxbFbXikgKzxHI3ySg
 1mGgZVLLcahK702AVVH6QSIcWlT7bMVORs5+ej1dBa33F7/n0EqBfobkPIS4f9SGeHwf
 76IH/yQKCWXDboLIqmGCgjivMEHkt9U+sidWpY7JdzJcHdFP+Tm+UxX7YvVtY2EcgS9P
 diwnfdzOeu3dgM2MbAZGD/QXea0fknV4aS5cXN4EH1x8kxOmiNPbjP5qAeNtn8UnSTeR
 U9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uKWbw2FnihoJIGt9f/+APcjo5dktAD56+VxJMIHASKI=;
 b=kbFx92D1dy9AnPzZxJTclqUAH8+YY8RHmkd9fdCh18z4LvjAquG+l+u4o1p+LFHi1I
 RLrXWS9ddeVyEf+6qCe3NQX6SRUO/v8GKoqnRN2PdV97HIT2vCh4q2W3FOoDLEirglAf
 TmLjn0ZGrAcVlMcjDmW075UdWBrWY830r6jZCq8sRX8onkP0zMi0GvLe+BJljDS+gdNk
 p+EisyJ34SBeUbEgy7kpwcWuVX2Y6lu+0IxLK2Is64JWGPFqUl60P/oTaN0+HmzFGWY9
 7mgERQ7s5UlsMhA//Mzoiyjekcjkz4/MISMFzM7GlbVzhNrQT2sW3YBdqwisqJEaLKNO
 XayA==
X-Gm-Message-State: APjAAAWz1JZ5X8V5NXqzh5ZoBQFIl0HgmhsjkplOpL1jAFM4VHKmqMRp
 xHz42R2m4I9tfi5wQcOrJ720ymot
X-Google-Smtp-Source: APXvYqwfXpIiaMA2H+cxRwaRvO3UA+MwL8OxczZ1xq/a9TWj7FgPVxG7wXYFhD6QK+FhM3sBuCKF8Q==
X-Received: by 2002:adf:e5cb:: with SMTP id a11mr2411040wrn.28.1576670640735; 
 Wed, 18 Dec 2019 04:04:00 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 57/87] hw/i386/pc: Inline port92_init()
Date: Wed, 18 Dec 2019 13:02:23 +0100
Message-Id: <1576670573-48048-58-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This one-line function is not very helpful, so remove it
by inlining the call to qdev_connect_gpio_out_named().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 67fddcc..e36053f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -710,11 +710,6 @@ static uint64_t port92_read(void *opaque, hwaddr addr,
     return ret;
 }
 
-static void port92_init(ISADevice *dev, qemu_irq a20_out)
-{
-    qdev_connect_gpio_out_named(DEVICE(dev), PORT92_A20_LINE, 0, a20_out);
-}
-
 static const VMStateDescription vmstate_port92_isa = {
     .name = "port92",
     .version_id = 1,
@@ -770,8 +765,8 @@ static void port92_class_initfn(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_port92_isa;
     /*
      * Reason: unlike ordinary ISA devices, this one needs additional
-     * wiring: its A20 output line needs to be wired up by
-     * port92_init().
+     * wiring: its A20 output line needs to be wired up with
+     * qdev_connect_gpio_out_named().
      */
     dc->user_creatable = false;
 }
@@ -1282,7 +1277,8 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
 
     a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
     i8042_setup_a20_line(i8042, a20_line[0]);
-    port92_init(port92, a20_line[1]);
+    qdev_connect_gpio_out_named(DEVICE(port92),
+                                PORT92_A20_LINE, 0, a20_line[1]);
     g_free(a20_line);
 }
 
-- 
1.8.3.1



