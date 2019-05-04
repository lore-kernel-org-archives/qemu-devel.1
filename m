Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBF8C04AA9
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 21:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E627820652
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 21:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWt6A9WW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E627820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32847 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hN1pv-0004oF-3w
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 17:04:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hN1oG-0003rm-3A
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hN1oF-0004ak-3T
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:04 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1hN1oE-0004a2-U2
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id k16so12176440wrn.5
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 14:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=+fYqCs5sUPiNHHzHDoxsSG+QXYH6mcG8D/Amsajt7mM=;
	b=kWt6A9WWwlK0sO6LHCj83xye1QNGGZLFunKVHM2X7lQ1/9asHZiY4JVZtClm7dfk/P
	enpaDw703G5EIzOGYBYN9znWSf+mYPa2TPy4BbGScF76oc3uGhqh2MprrQFcAq7dQvYt
	j/ivqgVEs5IH9VreYmKK42TunCF6tL4JTmG1yqlvmUD1cQIJu4aBEPlaTuGjogCi58iJ
	Sc5zMXnAitNoDQn/rDxv3N0cm1bEXZ2ALTfdndwkRRyXvDsEDTnIK5j+IUVgig5mdqfb
	5OQcKgIYfTapafL4WQ97P14sIGLbSfaUWE+wXH7QUfXn40+xPKO+8jLPMr2+7IouQtea
	dIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=+fYqCs5sUPiNHHzHDoxsSG+QXYH6mcG8D/Amsajt7mM=;
	b=WTPjh9mkE/t0d9oemM0igH56hmPaArYCFlZJz+Ud+8P6fwKiDKp0QtAK26BNKVVGcu
	dRYyJnASSAjHeeMUEf//ljbWIyzd2T2b0KkjB/Ddyt465fPiiDbYXBki1B+427bildVE
	t+6/S5bFa+fXdhL/iwTK6W+9LQEg2ZEpO03brVrJkrP0Ddh6u9dNccF9DDY8vr420qtU
	UuNiU6QHV7EUEl35Ap/KusMl+3mPaTN7IgNv3gJL19C7JCBp4r1U44cJHiLaZ/nUoF+1
	wN7/KTIRc2qOxl7E8AANRQeV80cfPjjaJDI93eIrZ+yk35RF4Tx0eVjmlm7fVBvaKz/y
	mRVA==
X-Gm-Message-State: APjAAAUR/2YRf3GSVCmdhrqIHPPoT12yoG4UlBqaq+m1yd0+jzYwymK+
	3qg3INav9d3Xlu5ctHuqPc/+h28h
X-Google-Smtp-Source: APXvYqxreqz+an6Kx9RFFTcFX7fstY7tv7/vXXRpmbdC7sPmpD4h+3OJ0JytPEqcjcrTsIPO2rfGpw==
X-Received: by 2002:adf:dd89:: with SMTP id x9mr11311355wrl.8.1557003781938;
	Sat, 04 May 2019 14:03:01 -0700 (PDT)
Received: from localhost ([46.114.6.7])
	by smtp.gmail.com with ESMTPSA id d6sm4174060wrp.9.2019.05.04.14.03.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 04 May 2019 14:03:01 -0700 (PDT)
From: Artyom Tarasenko <atar4qemu@gmail.com>
To: qemu-devel@nongnu.org,
	hpoussin@reactos.org
Date: Sat,  4 May 2019 23:02:32 +0200
Message-Id: <1557003754-26473-2-git-send-email-atar4qemu@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
References: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v2 1/3] lsi53c895a: hide 53c895a registers in
 53c810
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504210232.MkYX718dvRMUrCXERU5GnpLhzlgyOt0e9gSNGU4e4rs@z>

AIX/PReP does access to the aliased IO registers of 53810.
Implement aliasing to make the AIX driver work.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 hw/scsi/lsi53c895a.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index da7239d..6b95699 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2271,6 +2271,9 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
     LSIState *s = LSI53C895A(dev);
     DeviceState *d = DEVICE(dev);
     uint8_t *pci_conf;
+    uint64_t mmio_size;
+    MemoryRegion *mr;
+    uint16_t type = PCI_DEVICE_GET_CLASS(dev)->device_id;
 
     pci_conf = dev->config;
 
@@ -2279,13 +2282,21 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
     /* Interrupt pin A */
     pci_conf[PCI_INTERRUPT_PIN] = 0x01;
 
-    memory_region_init_io(&s->mmio_io, OBJECT(s), &lsi_mmio_ops, s,
-                          "lsi-mmio", 0x400);
     memory_region_init_io(&s->ram_io, OBJECT(s), &lsi_ram_ops, s,
                           "lsi-ram", 0x2000);
     memory_region_init_io(&s->io_io, OBJECT(s), &lsi_io_ops, s,
                           "lsi-io", 256);
-
+    if (type == PCI_DEVICE_ID_LSI_53C895A) {
+        mmio_size = 0x400;
+    } else {
+        mr = g_new(MemoryRegion, 1);
+        memory_region_init_alias(mr, OBJECT(d), "lsi-io-alias", &s->io_io,
+                                 0, 0x80);
+        memory_region_add_subregion_overlap(&s->io_io, 0x80, mr, -1);
+        mmio_size = 0x80;
+    }
+    memory_region_init_io(&s->mmio_io, OBJECT(s), &lsi_mmio_ops, s,
+                          "lsi-mmio", mmio_size);
     address_space_init(&s->pci_io_as, pci_address_space_io(dev), "lsi-pci-io");
     qdev_init_gpio_out(d, &s->ext_irq, 1);
 
-- 
2.7.2


