Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C741C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 00:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B152467B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 00:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6a4h0Wa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B152467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igeAC-0007jR-Qu
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 19:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ige93-0006JH-7W
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 19:21:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ige92-0006Ff-3p
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 19:21:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ige92-0006DQ-0A
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 19:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576455711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NbuokKpyZ6Rqq7FIEeSB/3yNDkaQil2rMod/VmsNJf4=;
 b=S6a4h0WaYn1iFznwUbcfcvtkHLlUl57Wagfs35tVSsa210JvFngUnDzpdhu8/qbCE2zKqX
 DiqZcBr8ytk0/6E3U/pBpTQ/NOg4Le2ngvhb0Ccs+FuHDeT2vTGJAlPBqyS2U9tkvQFHTq
 LeiJQrUNESTptUkmizVDymbE0TG0LgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-7A9sLIAcP56usoo-tQ5Tmw-1; Sun, 15 Dec 2019 19:21:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33A4A107ACCA;
 Mon, 16 Dec 2019 00:21:47 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 229301001901;
 Mon, 16 Dec 2019 00:21:44 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/pci/pci_host: Remove redundant PCI_DPRINTF()
Date: Mon, 16 Dec 2019 01:21:33 +0100
Message-Id: <20191216002134.18279-2-philmd@redhat.com>
In-Reply-To: <20191216002134.18279-1-philmd@redhat.com>
References: <20191216002134.18279-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 7A9sLIAcP56usoo-tQ5Tmw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit 3bf4dfdd111 we introduced the pci_cfg_[read/write]
trace events in pci_host_config_[read/write]_common().
We have the following call trace:

  pci_host_data_[read/write]()
    - PCI_DPRINTF()
    - pci_data_[read/write]()
        - PCI_DPRINTF()
        - pci_host_config_[read/write]_common()
            trace_pci_cfg_[read/write]()

Since the PCI_DPRINTF() calls are redundant with the trace
events, remove them.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/pci/pci_host.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index c5f9244934..0958d157de 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -115,8 +115,6 @@ void pci_data_write(PCIBus *s, uint32_t addr, uint32_t =
val, int len)
         return;
     }
=20
-    PCI_DPRINTF("%s: %s: addr=3D%02" PRIx32 " val=3D%08" PRIx32 " len=3D%d=
\n",
-                __func__, pci_dev->name, config_addr, val, len);
     pci_host_config_write_common(pci_dev, config_addr, PCI_CONFIG_SPACE_SI=
ZE,
                                  val, len);
 }
@@ -125,18 +123,13 @@ uint32_t pci_data_read(PCIBus *s, uint32_t addr, int =
len)
 {
     PCIDevice *pci_dev =3D pci_dev_find_by_addr(s, addr);
     uint32_t config_addr =3D addr & (PCI_CONFIG_SPACE_SIZE - 1);
-    uint32_t val;
=20
     if (!pci_dev) {
         return ~0x0;
     }
=20
-    val =3D pci_host_config_read_common(pci_dev, config_addr,
-                                      PCI_CONFIG_SPACE_SIZE, len);
-    PCI_DPRINTF("%s: %s: addr=3D%02"PRIx32" val=3D%08"PRIx32" len=3D%d\n",
-                __func__, pci_dev->name, config_addr, val, len);
-
-    return val;
+    return pci_host_config_read_common(pci_dev, config_addr,
+                                       PCI_CONFIG_SPACE_SIZE, len);
 }
=20
 static void pci_host_config_write(void *opaque, hwaddr addr,
@@ -167,8 +160,7 @@ static void pci_host_data_write(void *opaque, hwaddr ad=
dr,
                                 uint64_t val, unsigned len)
 {
     PCIHostState *s =3D opaque;
-    PCI_DPRINTF("write addr " TARGET_FMT_plx " len %d val %x\n",
-                addr, len, (unsigned)val);
+
     if (s->config_reg & (1u << 31))
         pci_data_write(s->bus, s->config_reg | (addr & 3), val, len);
 }
@@ -177,14 +169,11 @@ static uint64_t pci_host_data_read(void *opaque,
                                    hwaddr addr, unsigned len)
 {
     PCIHostState *s =3D opaque;
-    uint32_t val;
+
     if (!(s->config_reg & (1U << 31))) {
         return 0xffffffff;
     }
-    val =3D pci_data_read(s->bus, s->config_reg | (addr & 3), len);
-    PCI_DPRINTF("read addr " TARGET_FMT_plx " len %d val %x\n",
-                addr, len, val);
-    return val;
+    return pci_data_read(s->bus, s->config_reg | (addr & 3), len);
 }
=20
 const MemoryRegionOps pci_host_conf_le_ops =3D {
--=20
2.21.0


