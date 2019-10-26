Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644CDCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 16:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A3D20663
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 16:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A3D20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOPF7-0006qj-Rk
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 12:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iOPCm-0002Vm-8j
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 12:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iOPCl-00011g-9X
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 12:46:20 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:42253)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iOPCl-00010s-03; Sat, 26 Oct 2019 12:46:19 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N95mR-1htMEY0ng7-0167vV; Sat, 26 Oct 2019 18:45:53 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v15 01/11] esp: move handle_ti_cmd() cleanup code to
 esp_do_dma().
Date: Sat, 26 Oct 2019 18:45:36 +0200
Message-Id: <20191026164546.30020-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191026164546.30020-1-laurent@vivier.eu>
References: <20191026164546.30020-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JL7/f9MYlM3Ni5d31Jhi5pzDIukczD49yhLrr2OrxXJ94USFtj/
 Ol2/M3csHzbDC2poCE0yL3k8YQNTywU1H6kddRiNnNr5Z1FBUP7EkTCKfbcpHpxlyPflNxC
 6wizxX3OO3C/qIOXrE8WXaVF1B4kC97tciCJ5HJZBSI0xFoqv+qsC4Xmo06cTkqBZ1ncOia
 kHKoBtteFCus1/HxKrQHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x8dXg1xNW6g=:SagtE7GgKFBXmz5bPI/u/H
 GpqpoKvkE+5QC7yV/cEcgbUrDsJlSnnybwoL5ttzBbs4KITHLH6E7C/RCewRQHe+U3fFW7LPj
 eU4Ci4bEbLUpAoQ9Dd9ht52sRT+C/pvNcpUrXK2K14fYffoIKh7B6mVqnsP/NqMzErFOeR5YS
 zbjoBBiP84h/AHhthdCqWAJvXo5zjvgdqrfejCkpDTkAiMD+ZIpF6qSqGLu9A6aAJy6rTjDWP
 j9mtSJx6YypGi3DmNDllUgsAlOxYOfzvp0XMwVnbpZ0SaGtB++Wezpz8yYaq+hJC/vUuTqoHn
 Pkc2JYCUYqq357zNo9ye76a6syn9hXm/fdyOUsk+nNfEo0Idgdz3nhPYhl+/q6ITjTPjwj0WP
 j3nG/Xt0h4frEsQ10ZEYbOxe10YbRjY92IngtRSwbgJHY12En6cLttmB//qoIiRJMN2RFZgIX
 DGRz5eYUkTyQCzyO0bEdKvh00OGaA0swA2XncfBQuPhVCyWUVF0HiSHi1v1MfrIPq4oSM4o/f
 ZuWhwEGkjBDOH7EH/IVQiuxlhq4v9q2XEAZyY47Yff7sT4Z52gD7FsRzEtmH7aWYF00CE3spq
 y+CbUI5d0+ek/BJBTl9LpehuG3GBdohpp4c2PDtSibFvcvpJ1RxvzPRsB8oEaCH/HkuAjdqFj
 Dhjmdq34YFXtTzCjTMUXJrnyc/WOk15Z7ZjrcovsGv34RYb4nfJoQsBvPxKTilFR5oN0aFzYQ
 TCaWHkT4Jb053p8ND+TneuKDyoXR/ATLzAT3E6dkRyAzRguzr/WXE+iCpmQ3yXn8MaX6G4fz+
 9lEJziNnxf85AtuIfBAUHo3CT/UU9gcgDzJTKynjPGrXMsujH8rKOCdVnCiaUNtH7MUh3gcwv
 XrEtxCZTZFCf9RJwZkJg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To prepare following patches move do_cmd and DMA special case
from handle_ti() to esp_do_dma().

This part of the code must be only executed with real DMA, not with
pseudo-DMA. And PDMA is detected in esp_do_dma(), so move this part
of the code in esp_do_dma(). We keep the code in handle_ti_cmd()
in the case no DMA is done.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/scsi/esp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 841d79b60e..09b28cba17 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -249,10 +249,19 @@ static void esp_do_dma(ESPState *s)
 
     len = s->dma_left;
     if (s->do_cmd) {
+        /*
+         * handle_ti_cmd() case: esp_do_dma() is called only from
+         * handle_ti_cmd() with do_cmd != NULL (see the assert())
+         */
         trace_esp_do_dma(s->cmdlen, len);
         assert (s->cmdlen <= sizeof(s->cmdbuf) &&
                 len <= sizeof(s->cmdbuf) - s->cmdlen);
         s->dma_memory_read(s->dma_opaque, &s->cmdbuf[s->cmdlen], len);
+        trace_esp_handle_ti_cmd(s->cmdlen);
+        s->ti_size = 0;
+        s->cmdlen = 0;
+        s->do_cmd = 0;
+        do_cmd(s, s->cmdbuf);
         return;
     }
     if (s->async_len == 0) {
@@ -373,8 +382,7 @@ static void handle_ti(ESPState *s)
         s->dma_left = minlen;
         s->rregs[ESP_RSTAT] &= ~STAT_TC;
         esp_do_dma(s);
-    }
-    if (s->do_cmd) {
+    } else if (s->do_cmd) {
         trace_esp_handle_ti_cmd(s->cmdlen);
         s->ti_size = 0;
         s->cmdlen = 0;
-- 
2.21.0


