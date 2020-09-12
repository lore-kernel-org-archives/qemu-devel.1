Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D575C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 08:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEFE214F1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 08:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGw7Ujhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEFE214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH0xR-0004W6-31
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 04:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH0uu-00025U-Ku
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 04:29:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH0ut-00023E-5b
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 04:29:52 -0400
Received: by mail-wr1-x444.google.com with SMTP id z4so13633084wrr.4
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 01:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gAoMYvbh6PKb/CST4Gg+2AFyuso3E0ZdXk61WQRCbQo=;
 b=DGw7UjhjP2vauXfLjAsCfKYqeWU5h53umqgNAQdDyHZL7+UZa8lNDgcWEK1bz82g3A
 12NLLuAjCsqqqtlBdthVAPy3bk5apZMlzdI5Nsd1bgBUDDlVFkGi7g+1AuNH1+2WE0GU
 oJgA/cSl9u9dJi19lgQrwz/sjQQVc3tOkvZJmZHxn7xjorf1v801BlgMIq95LfbCU/sq
 N2B2YSGn86guSZwCojkcs58N8MY62r4a6dquVSqPRB23FV2H9r5inKKPxWmRwebuk/oV
 ndZER8eRrPoifjHW8YkUYfZ95HNiETaTVTnOOmrlUrQ04V8lJyTwYtzxVWP982VJXBer
 HV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gAoMYvbh6PKb/CST4Gg+2AFyuso3E0ZdXk61WQRCbQo=;
 b=qI4oQ5mCXclFjiSmnDE6pLF2jFmK2MQ+APi36MaYVlKe/Rhq3f961EN/mnpxUGUerG
 6UzOYjfVB3XfiYu69sKZJVRx7U4GHno49Xr9TyyJc8SAN+tSZs79F3i0aH94xnxOumei
 D4GNbDFXzZWBa/XWOnDou0snAtNAsrhKz0h9toSENbYOPI1brOz6xIngvEfAczbu+g8k
 tXorj/mtL3WCeVh7URkSevN+gfAFhUfc4YfTirlAK6gCEp+twJy5/+0qqXZ76Dpzw1pk
 O7N/RaOWLstRdqzu6oHdjaFmKnhpqrEu8K9DwmfJ9tN4I5Fb6bUzzLmVUklFfac/J+36
 wUOA==
X-Gm-Message-State: AOAM531hTMreS5smSm5U5vI2STNC+ftL75hzAry84CntqycWetIUWBW5
 kvGP6oXttY2RR0C7mLlixqREM6vEtA8=
X-Google-Smtp-Source: ABdhPJwkWo6+i0YDX58FSEg9FV+YKqke0U8ziBczkQ/pFuFvZ8wCS/NwF+p+PYlSYZXdcydWX+bp5Q==
X-Received: by 2002:adf:eacf:: with SMTP id o15mr6241963wrn.12.1599899389810; 
 Sat, 12 Sep 2020 01:29:49 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t188sm9598698wmf.41.2020.09.12.01.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 01:29:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] hw/char/serial: Remove TYPE_SERIAL_IO (superset of
 TYPE_SERIAL_MM)
Date: Sat, 12 Sep 2020 10:29:44 +0200
Message-Id: <20200912082944.890972-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200912082944.890972-1-f4bug@amsat.org>
References: <20200912082944.890972-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

TYPE_SERIAL_IO is a superset of TYPE_SERIAL_MM, and it is
not used anymore. Remove it.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/char/serial.c | 41 -----------------------------------------
 1 file changed, 41 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 23864794929..fd80ae55929 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -985,46 +985,6 @@ const MemoryRegionOps serial_io_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void serial_io_realize(DeviceState *dev, Error **errp)
-{
-    SerialIO *sio = SERIAL_IO(dev);
-    SerialState *s = &sio->serial;
-
-    if (!qdev_realize(DEVICE(s), NULL, errp)) {
-        return;
-    }
-
-    memory_region_init_io(&s->io, OBJECT(dev), &serial_io_ops, s, "serial", 8);
-    sysbus_init_mmio(SYS_BUS_DEVICE(sio), &s->io);
-    sysbus_init_irq(SYS_BUS_DEVICE(sio), &s->irq);
-}
-
-static void serial_io_class_init(ObjectClass *klass, void* data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = serial_io_realize;
-    /* No dc->vmsd: class has no migratable state */
-}
-
-static void serial_io_instance_init(Object *o)
-{
-    SerialIO *sio = SERIAL_IO(o);
-
-    object_initialize_child(o, "serial", &sio->serial, TYPE_SERIAL);
-
-    qdev_alias_all_properties(DEVICE(&sio->serial), o);
-}
-
-
-static const TypeInfo serial_io_info = {
-    .name = TYPE_SERIAL_IO,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SerialIO),
-    .instance_init = serial_io_instance_init,
-    .class_init = serial_io_class_init,
-};
-
 static Property serial_properties[] = {
     DEFINE_PROP_CHR("chardev", SerialState, chr),
     DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
@@ -1178,7 +1138,6 @@ static const TypeInfo serial_mm_info = {
 static void serial_register_types(void)
 {
     type_register_static(&serial_info);
-    type_register_static(&serial_io_info);
     type_register_static(&serial_mm_info);
 }
 
-- 
2.26.2


