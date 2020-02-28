Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FA4C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D319F246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0p+w1pA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D319F246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7fBq-0000XR-2V
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 07:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7fA1-0005kl-Lb
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:54:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7fA0-0002uz-Jo
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:54:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37362
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7fA0-0002uG-GE
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582894467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGbS/zlE8uJcFaugSfNNCFiui8oNM2qeJ1yh+1ke7gM=;
 b=P0p+w1pAFzwHKjiPJp/UyCPEFZhmx/W5CxVhR0nBcNDRUozd6u2MUjVuDuv1LVLBbsa8aW
 UCDJ5C6iwsLtde3RQqaeTjVg3A/x73uIt4pokMOKbZ38le5xSNPaKi7LXZDWPZGMH4eTcM
 TR9iMRa8sKRzF/4niNXSMHWZSkTdwM0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-DDbzvcI2OEmDvDnd87G1Yw-1; Fri, 28 Feb 2020 07:54:26 -0500
X-MC-Unique: DDbzvcI2OEmDvDnd87G1Yw-1
Received: by mail-wr1-f69.google.com with SMTP id n23so1278689wra.20
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 04:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4y3/KK4nBcHl83eeBXH6BEe9dO9OSqQV02N1QOTozm8=;
 b=l6mGTDamWLs3LiUxv+3Qe+iPorau7sPBIAPsnOaPyMn4byxgWBVVqXkdHvfZ+XmNeN
 vD+SzkIhboqubO4SeDWhNX4stANgIldyEhQzzJ7/L3uTHJRV4MVkPcS1E8JRut6PZtp4
 gkp4yRwkTFyTic4xg1KuVQFNyO6lajqd5iWte9lx0DtYvCxt1XQWVDFrX9cCz9BMfYUA
 GDXj69KSv98b+iHFrIkr+W3lYM02Eu6yZbvhvpFIGEZ+n07ytMZzxn0OdsXI1rkfB2Wv
 Ir2TSyF7RPaBN9cgspnpEV7++mhq/bppoln1nxCyyTw0zqhtMiu5AAMvikyVjwkgQ9MC
 g2CQ==
X-Gm-Message-State: APjAAAXmRUQ8MzV4Dsk6Adhrwso6WFyki0meywuiEc5Vn7FUhQ3MPKVP
 /0HlSHVlK1L/AMbN26osorxHT6LGHC0TERPpLeRBxZMI3qinQXqcYPfLbJjNVtTzOqLM7VN0/XM
 R3Buv2MQoy/37+Zg=
X-Received: by 2002:a1c:f401:: with SMTP id z1mr4725374wma.103.1582894464760; 
 Fri, 28 Feb 2020 04:54:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTDFFrbbWQ1gqyE0HnPAEiinU20JFQYfC+X6S6SGvjuV/pj15/Xx2f7qLM3AzvvyK/uw8RcA==
X-Received: by 2002:a1c:f401:: with SMTP id z1mr4725353wma.103.1582894464487; 
 Fri, 28 Feb 2020 04:54:24 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id y7sm340988wrl.26.2020.02.28.04.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 04:54:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] hw/arm/z2: Simplify since the machines are little-endian
 only
Date: Fri, 28 Feb 2020 13:53:50 +0100
Message-Id: <20200228125351.29482-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228125351.29482-1-philmd@redhat.com>
References: <20200228125351.29482-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We only build the little-endian softmmu configurations. Checking
for big endian is pointless, remove the unused code.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/z2.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 4bb237f22d..a0f4095990 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -300,7 +300,6 @@ static void z2_init(MachineState *machine)
     uint32_t sector_len =3D 0x10000;
     PXA2xxState *mpu;
     DriveInfo *dinfo;
-    int be;
     void *z2_lcd;
     I2CBus *bus;
     DeviceState *wm;
@@ -308,15 +307,10 @@ static void z2_init(MachineState *machine)
     /* Setup CPU & memory */
     mpu =3D pxa270_init(address_space_mem, z2_binfo.ram_size, machine->cpu=
_type);
=20
-#ifdef TARGET_WORDS_BIGENDIAN
-    be =3D 1;
-#else
-    be =3D 0;
-#endif
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     if (!pflash_cfi01_register(Z2_FLASH_BASE, "z2.flash0", Z2_FLASH_SIZE,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                               sector_len, 4, 0, 0, 0, 0, be)) {
+                               sector_len, 4, 0, 0, 0, 0, 0)) {
         error_report("Error registering flash memory");
         exit(1);
     }
--=20
2.21.1


