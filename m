Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42DDC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BE9205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BE9205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE94d-0008Pb-MH
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jE8yy-0008Li-84
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jE8yw-0006gR-Qj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:57:56 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:31359)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jE8ys-00060V-9X; Tue, 17 Mar 2020 05:57:50 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id B155B747E19;
 Tue, 17 Mar 2020 10:57:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 37290747E06; Tue, 17 Mar 2020 10:57:44 +0100 (CET)
Message-Id: <7679b82b4f26fdb16f00c3b130f8e6a807724f73.1584437958.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1584437957.git.balaton@eik.bme.hu>
References: <cover.1584437957.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 3/7] hw/ide: Remove now unneded #include "hw/pci/pci.h"
 from hw/ide.h
Date: Tue, 17 Mar 2020 10:39:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org,
    qemu-block@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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

After previous patches we don't need hw/pci/pci.h any more in
hw/ide.h. Some files depended on implicit inclusion by this header
which are also fixed up here.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ide/ahci_internal.h        | 1 +
 include/hw/ide.h              | 1 -
 include/hw/ide/pci.h          | 1 +
 include/hw/misc/macio/macio.h | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index 73424516da..bab0459774 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -27,6 +27,7 @@
 #include "hw/ide/ahci.h"
 #include "hw/ide/internal.h"
 #include "hw/sysbus.h"
+#include "hw/pci/pci.h"
=20
 #define AHCI_MEM_BAR_SIZE         0x1000
 #define AHCI_MAX_PORTS            32
diff --git a/include/hw/ide.h b/include/hw/ide.h
index 21bd8f23f1..d52c211f32 100644
--- a/include/hw/ide.h
+++ b/include/hw/ide.h
@@ -2,7 +2,6 @@
 #define HW_IDE_H
=20
 #include "hw/isa/isa.h"
-#include "hw/pci/pci.h"
 #include "exec/memory.h"
=20
 #define MAX_IDE_DEVS	2
diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
index a9f2c33e68..98ffa7dfcd 100644
--- a/include/hw/ide/pci.h
+++ b/include/hw/ide/pci.h
@@ -2,6 +2,7 @@
 #define HW_IDE_PCI_H
=20
 #include "hw/ide/internal.h"
+#include "hw/pci/pci.h"
=20
 #define BM_STATUS_DMAING 0x01
 #define BM_STATUS_ERROR  0x02
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.=
h
index 070a694eb5..87335a991c 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -27,6 +27,7 @@
 #define MACIO_H
=20
 #include "hw/char/escc.h"
+#include "hw/pci/pci.h"
 #include "hw/ide/internal.h"
 #include "hw/intc/heathrow_pic.h"
 #include "hw/misc/macio/cuda.h"
--=20
2.21.1


