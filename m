Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026DBC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68E2206ED
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvTkBGI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68E2206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lc9-0006Ol-Uy
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lXQ-0005in-6K
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lXO-0005PX-UY
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60827
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lXO-0005P3-Qw
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582204002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+QWKOueI8xj2IyxqHiN0HDA2FYFFiq+hf4rVm2QXvB4=;
 b=VvTkBGI9MFwt+yQNtKJ+kXhLb06Wmk5A+xl98vSTZkqz88z39Df9I+fIPXpJpxkxrv/Uqt
 dOY58/uHbJH3sLLcZ6htSd2zUwoKu3YlDdzMlaHFBNQDOZBwQ1keHQE8orTh/XSmqdDyKM
 mpSaUytEm+gmsO0JXd7bbyL4xLVBhW8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-t6Zt-jZJNg2qFOv7TpU_xw-1; Thu, 20 Feb 2020 08:06:40 -0500
Received: by mail-wr1-f69.google.com with SMTP id m15so1683358wrs.22
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=afmBLGH/B/Ms0UWZ94UmoIT7hbpf9let5QJOgK6MO7U=;
 b=shfy+K2YVrbWzCacxvtqTdTNbXh+gek6tglRXoskHSzNkUNvKcG8taheBPr/GTvsyv
 mDDrnI374adYNWyEymwOryCMT3kx7asvtJUaDREobpZO8cNtBaPcjgi+79tLO0xTtQ8e
 nX8vzcaZVaLoMWAvqAqONkm8pc/lZJw1mbH/YcDUoYw6lDMu8PpVRJSGE8rNQdecmvAB
 fh4SZM14I3bs9onR7JJSbZn89MarVyNMazZE5ckYxtuydSeBvZec/9HmOwhhm4zgI2qh
 dTT9b1saqrvOACDCtYVPtoiAEK5HXJ88ukDBdfWszW1dKL2ZAuySBLDI4U464qADSW/u
 EqKg==
X-Gm-Message-State: APjAAAUMoKOha5m5Z5zofTerbm89zMs+eNd/5J/JWTWi1xMK6Kr2erGy
 YJTaZZufgXeehiwP+HqT4/Gk8vlA5Ch22qG8VQTZzoyD74fP/ycP+vFbk53wau7f3fDCiakrtS0
 NPjetU8UvFvpdhWE=
X-Received: by 2002:adf:82ce:: with SMTP id 72mr42311856wrc.14.1582203999002; 
 Thu, 20 Feb 2020 05:06:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/3uQMphtI1ikMZVT/CqYmBN8hXBmJPGI/dMUcHwpK44vfqMtR6BuBqN22Zj6SP9un5Qj48Q==
X-Received: by 2002:adf:82ce:: with SMTP id 72mr42311818wrc.14.1582203998804; 
 Thu, 20 Feb 2020 05:06:38 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:06:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 12/20] hw/ide: Let the DMAIntFunc prototype use a boolean
 'is_write' argument
Date: Thu, 20 Feb 2020 14:05:40 +0100
Message-Id: <20200220130548.29974-13-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: t6Zt-jZJNg2qFOv7TpU_xw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'is_write' argument is either 0 or 1.
Convert it to a boolean type.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/ide/internal.h | 2 +-
 hw/dma/rc4030.c           | 6 +++---
 hw/ide/ahci.c             | 2 +-
 hw/ide/core.c             | 2 +-
 hw/ide/macio.c            | 2 +-
 hw/ide/pci.c              | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index ce766ac485..1bc1fc73e5 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -322,7 +322,7 @@ typedef void EndTransferFunc(IDEState *);
=20
 typedef void DMAStartFunc(IDEDMA *, IDEState *, BlockCompletionFunc *);
 typedef void DMAVoidFunc(IDEDMA *);
-typedef int DMAIntFunc(IDEDMA *, int);
+typedef int DMAIntFunc(IDEDMA *, bool);
 typedef int32_t DMAInt32Func(IDEDMA *, int32_t len);
 typedef void DMAu32Func(IDEDMA *, uint32_t);
 typedef void DMAStopFunc(IDEDMA *, bool);
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index ca0becd756..21e2c360ac 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -590,7 +590,7 @@ static const VMStateDescription vmstate_rc4030 =3D {
 };
=20
 static void rc4030_do_dma(void *opaque, int n, uint8_t *buf,
-                          int len, int is_write)
+                          int len, bool is_write)
 {
     rc4030State *s =3D opaque;
     hwaddr dma_addr;
@@ -630,13 +630,13 @@ struct rc4030DMAState {
 void rc4030_dma_read(void *dma, uint8_t *buf, int len)
 {
     rc4030_dma s =3D dma;
-    rc4030_do_dma(s->opaque, s->n, buf, len, 0);
+    rc4030_do_dma(s->opaque, s->n, buf, len, false);
 }
=20
 void rc4030_dma_write(void *dma, uint8_t *buf, int len)
 {
     rc4030_dma s =3D dma;
-    rc4030_do_dma(s->opaque, s->n, buf, len, 1);
+    rc4030_do_dma(s->opaque, s->n, buf, len, true);
 }
=20
 static rc4030_dma *rc4030_allocate_dmas(void *opaque, int n)
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 68264a22e8..13d91e109a 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1461,7 +1461,7 @@ static void ahci_commit_buf(IDEDMA *dma, uint32_t tx_=
bytes)
     ad->cur_cmd->status =3D cpu_to_le32(tx_bytes);
 }
=20
-static int ahci_dma_rw_buf(IDEDMA *dma, int is_write)
+static int ahci_dma_rw_buf(IDEDMA *dma, bool is_write)
 {
     AHCIDevice *ad =3D DO_UPCAST(AHCIDevice, dma, dma);
     IDEState *s =3D &ad->port.ifs[0];
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 80000eb766..689bb36409 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2570,7 +2570,7 @@ static void ide_init1(IDEBus *bus, int unit)
                                            ide_sector_write_timer_cb, s);
 }
=20
-static int ide_nop_int(IDEDMA *dma, int x)
+static int ide_nop_int(IDEDMA *dma, bool is_write)
 {
     return 0;
 }
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 7a8470e921..a9f25e5d02 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -376,7 +376,7 @@ static void macio_ide_reset(DeviceState *dev)
     ide_bus_reset(&d->bus);
 }
=20
-static int ide_nop_int(IDEDMA *dma, int x)
+static int ide_nop_int(IDEDMA *dma, bool is_write)
 {
     return 0;
 }
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index cce1da804d..1a6a287e76 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -181,7 +181,7 @@ static int32_t bmdma_prepare_buf(IDEDMA *dma, int32_t l=
imit)
 }
=20
 /* return 0 if buffer completed */
-static int bmdma_rw_buf(IDEDMA *dma, int is_write)
+static int bmdma_rw_buf(IDEDMA *dma, bool is_write)
 {
     BMDMAState *bm =3D DO_UPCAST(BMDMAState, dma, dma);
     IDEState *s =3D bmdma_active_if(bm);
--=20
2.21.1


