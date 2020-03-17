Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5D0C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83CA20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faoR57YO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83CA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELig-0007LS-Uq
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jELaR-0002C6-PJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jELaO-0001Jz-Kv
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:27 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jELaO-0001I9-Gu
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584487524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qVcbRFfRi8J5PAMXWOGMjOOSCw5AkybzeTOriUoBA2Q=;
 b=faoR57YOgDCwabXyzPQr0gI3YBqtQVTXxBXw7OnyD3KOu+LviNZEho1yxRjGkzUmCfPgi7
 gZEQam6rYaW6DcE3JuISXMr85t9rl3kcjAW+X+Xv65RaWIe9yogmfkwwtpN1YY3n6hS3ym
 /qyKhsFepYhvpIXh9uiR0emkDlJ5YYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-Iv0F6AWWNcyWQ_YVxWeTeA-1; Tue, 17 Mar 2020 19:25:20 -0400
X-MC-Unique: Iv0F6AWWNcyWQ_YVxWeTeA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE0B5100550D;
 Tue, 17 Mar 2020 23:25:17 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BE8160BE0;
 Tue, 17 Mar 2020 23:25:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 16/20] hw/ide: Remove now unneded #include "hw/pci/pci.h" from
 hw/ide.h
Date: Tue, 17 Mar 2020 19:23:25 -0400
Message-Id: <20200317232329.22362-17-jsnow@redhat.com>
In-Reply-To: <20200317232329.22362-1-jsnow@redhat.com>
References: <20200317232329.22362-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 Helge Deller <deller@gmx.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

After previous patches we don't need hw/pci/pci.h any more in
hw/ide.h. Some files depended on implicit inclusion by this header
which are also fixed up here.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: 444a5e34331bf1f7880541b8d46e0353f470f5a6.1584457537.git.balaton=
@eik.bme.hu
Signed-off-by: John Snow <jsnow@redhat.com>
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
 #define MAX_IDE_DEVS=092
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
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
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


