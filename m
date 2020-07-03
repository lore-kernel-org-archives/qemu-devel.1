Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45611C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183BC20724
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTZ/AZxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183BC20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrQtt-0001nq-BS
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 14:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrQt7-0000YE-0d
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 14:58:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:35285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrQt5-0001UB-Kw
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 14:58:16 -0400
Received: by mail-wm1-x334.google.com with SMTP id l2so33569243wmf.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 11:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wpS510g0PsDSPMVgjXGeNihl06G1BtPWSiqFQOesBaQ=;
 b=aTZ/AZxHikEnaMA0LUS+J82N5gfqYqixd9o9B/ZrJCmuQWqqdPKAjMohzbfZPaHE2p
 reDc+nBo4cM4emGeuKesOnOr8Ku5yB54N6q7OvTuAMiz5TaCc2YDrnD1PH5QPgRcLcJW
 J+BtCAn+5Z123PZeMCLk4mZW5RL/zEtbfOZjSbRo0E9zlrWpNyjoK88uEL6MrpcDC/kA
 iUCpT0094WYY2OQnOlyw0CZnOpX9+u4qqSe4XJRWQhX9vCGxyCDnlCIAfm+1ivnMmzWd
 5BejPBtKetAwQx+lCqW8dgFZzYWP4Wq6BeR27y1dPNmVxlc24fxYa+hnhcfQwnyCGVTy
 6MKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wpS510g0PsDSPMVgjXGeNihl06G1BtPWSiqFQOesBaQ=;
 b=fNbNDHjKlQNLv0B6GivuQrr2MAXtoDC7oX3q1VjKs7IGe1D1fUlSS40rirXyZHxXBS
 ZaazBbDRF9JEmfQdjkEOXNGsXAa6ouPPJ1vVpd+Yu3nkZx0+zTrymgpV2R5UXU4YWWqA
 J/XRfMEzLZw8SA4ReP8jPlYHD2y7UJx9djVUL3Tkno2Tca4wVwjfEM8DWcz5B/toWR+b
 GOOZGTnbfu3bCQnwY9jXRKQ4pfy4Ek3cVG0X/439nh4uuHICa3Wo420T4gmeB3AVM7aX
 slKK2drByfKfcXRMVjqfU5Gg+vunHZ6hMx5HmQQqhMKXYNRiF9ifFrmxdH+qwmyd5Q5D
 sgNw==
X-Gm-Message-State: AOAM530PimiQZfAYInm7ytQ//3wlNqMnU/7g5NQXA/2wxOq7R+Sa6wme
 zBjgi4J5RpNSD8S7HSZygXoiZcXgTz8=
X-Google-Smtp-Source: ABdhPJwO4fp2BwxLxAAN1nWnEG/kUyMWMaDf7zHmtpJWAvO9rtsJtKbbIF/iwo31Yl4wGrNrUBac4Q==
X-Received: by 2002:a1c:1f54:: with SMTP id f81mr37869040wmf.4.1593802693685; 
 Fri, 03 Jul 2020 11:58:13 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id t16sm16060929wru.9.2020.07.03.11.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 11:58:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/char/serial: Allow migration of the I/O serial device
Date: Fri,  3 Jul 2020 20:58:09 +0200
Message-Id: <20200703185809.5896-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703185809.5896-1-f4bug@amsat.org>
References: <20200703185809.5896-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x334.google.com
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The serial device mapped on the I/O bus hold a migratable
SerialState. Keep the same version range from SerialState:

 837 const VMStateDescription vmstate_serial = {
 838     .name = "serial",
 839     .version_id = 3,
 840     .minimum_version_id = 2,

Fixes: 10315a7089 ("serial: make SerialIO a sysbus device")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/serial.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 9eebcb27e7..c167b584fb 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1002,12 +1002,22 @@ static void serial_io_realize(DeviceState *dev, Error **errp)
     sysbus_init_irq(SYS_BUS_DEVICE(sio), &s->irq);
 }
 
+static const VMStateDescription vmstate_serial_io = {
+    .name = "serial",
+    .version_id = 3,
+    .minimum_version_id = 2,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(serial, SerialIO, 0, vmstate_serial, SerialState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void serial_io_class_init(ObjectClass *klass, void* data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = serial_io_realize;
-    /* No dc->vmsd: class has no migratable state */
+    dc->vmsd = &vmstate_serial_io;
 }
 
 static void serial_io_instance_init(Object *o)
-- 
2.21.3


