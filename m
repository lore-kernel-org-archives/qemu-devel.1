Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1680FC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E027420768
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E027420768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDrIg-0004fS-GS
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 11:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jDpMI-0000GE-As
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jDpMG-0001c6-2b
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:00:42 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:52079)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jDpMB-0000Y2-61; Mon, 16 Mar 2020 09:00:35 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 119AC747DF5;
 Mon, 16 Mar 2020 14:00:33 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E572D747DFF; Mon, 16 Mar 2020 14:00:32 +0100 (CET)
In-Reply-To: <cover.1584134074.git.balaton@eik.bme.hu>
References: <cover.1584134074.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2] hw/ide: Move MAX_IDE_DEVS define to hw/ide/internal.h
Date: Mon, 16 Mar 2020 13:55:05 +0100
To: qemu-devel@nongnu.org,
    qemu-block@nongnu.org
Message-Id: <20200316130032.E572D747DFF@zero.eik.bme.hu>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can move this define now that less files use it to internal.h to
further reduce dependency on hw/ide.h.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v2: Alternative version of patch 7 that applies without
    [PATCH 4/8] hw/ide: Move MAX_IDE_BUS define to one header

 include/hw/ide.h          | 2 --
 include/hw/ide/internal.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/ide.h b/include/hw/ide.h
index d52c211f32..c5ce5da4f4 100644
--- a/include/hw/ide.h
+++ b/include/hw/ide.h
@@ -4,8 +4,6 @@
 #include "hw/isa/isa.h"
 #include "exec/memory.h"
 
-#define MAX_IDE_DEVS	2
-
 /* ide-isa.c */
 ISADevice *isa_ide_init(ISABus *bus, int iobase, int iobase2, int isairq,
                         DriveInfo *hd0, DriveInfo *hd1);
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 1bc1fc73e5..55da35d768 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -27,6 +27,8 @@ typedef struct IDEDMAOps IDEDMAOps;
 #define TYPE_IDE_BUS "IDE"
 #define IDE_BUS(obj) OBJECT_CHECK(IDEBus, (obj), TYPE_IDE_BUS)
 
+#define MAX_IDE_DEVS 2
+
 /* Bits of HD_STATUS */
 #define ERR_STAT		0x01
 #define INDEX_STAT		0x02
-- 
2.21.1


