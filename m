Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19595C4332E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:04:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB872072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AT+8vAnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB872072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEqAf-0006dq-1n
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 04:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jEq7Y-0001fm-2P
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jEq7W-0005N0-U8
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:24006)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jEq7W-0005KC-Oq
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584604898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ssy9iYBYNdlyaM+qTxCdmrI48NkNzUMw9zb+KooWCBc=;
 b=AT+8vAnVk8MPy0viq7Mf7tZPAHX48+tBerSzFzc6SO9UNE7mjpaEEKAJtiVp8zGXJhoDIO
 Yo4JrqBRyQWNM+2XsqEsBEXgiDXKIwgzgr1ewrE0J6rihIyE0t6GtYHhj8URKUDKrwHHuA
 hRNhfNGDsikPEK40uGAm/wEy0LDrTF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-uo82Brs9O6CaKmy7Sa_LBg-1; Thu, 19 Mar 2020 04:01:36 -0400
X-MC-Unique: uo82Brs9O6CaKmy7Sa_LBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9174C18B9FC4;
 Thu, 19 Mar 2020 08:01:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D5A719757;
 Thu, 19 Mar 2020 08:01:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EB5B03EBB9; Thu, 19 Mar 2020 09:01:17 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/13] [testing] seabios: update config & build rules
Date: Thu, 19 Mar 2020 09:01:12 +0100
Message-Id: <20200319080117.7725-9-kraxel@redhat.com>
In-Reply-To: <20200319080117.7725-1-kraxel@redhat.com>
References: <20200319080117.7725-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/Makefile               |  5 ++++-
 roms/config.seabios-128k    |  2 ++
 roms/config.seabios-microvm | 25 +++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 roms/config.seabios-microvm

diff --git a/roms/Makefile b/roms/Makefile
index f9acf39954dc..c0dde0a063c6 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -72,9 +72,12 @@ default help:
 =09@echo "  clean              -- delete the files generated by the previo=
us" \
 =09                              "build targets"
=20
-bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
+bios: build-seabios-config-seabios-128k \
+=09=09build-seabios-config-seabios-256k \
+=09=09build-seabios-config-seabios-microvm
 =09cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
 =09cp seabios/builds/seabios-256k/bios.bin ../pc-bios/bios-256k.bin
+=09cp seabios/builds/seabios-microvm/bios.bin ../pc-bios/bios-microvm.bin
=20
 vgabios seavgabios: $(patsubst %,seavgabios-%,$(vgabios_variants))
=20
diff --git a/roms/config.seabios-128k b/roms/config.seabios-128k
index c43912bf9de4..bbed77cfc5c5 100644
--- a/roms/config.seabios-128k
+++ b/roms/config.seabios-128k
@@ -11,6 +11,8 @@ CONFIG_USB_UAS=3Dn
 CONFIG_SDCARD=3Dn
 CONFIG_TCGBIOS=3Dn
 CONFIG_MPT_SCSI=3Dn
+CONFIG_ESP_SCSI=3Dn
+CONFIG_MEGASAS=3Dn
 CONFIG_PVSCSI=3Dn
 CONFIG_NVME=3Dn
 CONFIG_USE_SMM=3Dn
diff --git a/roms/config.seabios-microvm b/roms/config.seabios-microvm
new file mode 100644
index 000000000000..46bb019ada68
--- /dev/null
+++ b/roms/config.seabios-microvm
@@ -0,0 +1,25 @@
+CONFIG_QEMU=3Dy
+CONFIG_QEMU_HARDWARE=3Dy
+CONFIG_PERMIT_UNALIGNED_PCIROM=3Dy
+CONFIG_ROM_SIZE=3D128
+CONFIG_XEN=3Dn
+CONFIG_BOOTSPLASH=3Dn
+CONFIG_ATA=3Dn
+CONFIG_AHCI=3Dn
+CONFIG_SDCARD=3Dn
+CONFIG_PVSCSI=3Dn
+CONFIG_ESP_SCSI=3Dn
+CONFIG_LSI_SCSI=3Dn
+CONFIG_MEGASAS=3Dn
+CONFIG_MPT_SCSI=3Dn
+CONFIG_FLOPPY=3Dn
+CONFIG_FLASH_FLOPPY=3Dn
+CONFIG_NVME=3Dn
+CONFIG_PS2PORT=3Dn
+CONFIG_USB=3Dn
+CONFIG_LPT=3Dn
+CONFIG_RTC_TIMER=3Dn
+CONFIG_USE_SMM=3Dn
+CONFIG_PMTIMER=3Dn
+CONFIG_TCGBIOS=3Dn
+CONFIG_HARDWARE_IRQ=3Dn
--=20
2.18.2


