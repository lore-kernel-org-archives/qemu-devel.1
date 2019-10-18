Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C05CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D02222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D02222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSdv-0004jS-T9
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLSc5-0003BF-0t
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLSc4-0005ZV-0h
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:48:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38146)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLSc3-0005ZC-RZ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:48:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E50093086E26;
 Fri, 18 Oct 2019 13:48:14 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29AE560BF4;
 Fri, 18 Oct 2019 13:48:06 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/20] MAINTAINERS: Keep PIIX4 South Bridge separate from
 PC Chipsets
Date: Fri, 18 Oct 2019 15:47:35 +0200
Message-Id: <20191018134754.16362-2-philmd@redhat.com>
In-Reply-To: <20191018134754.16362-1-philmd@redhat.com>
References: <20191018134754.16362-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 18 Oct 2019 13:48:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The PIIX4 Southbridge is not used by the PC machine,
but by the Malta board (MIPS). Add a new section to
keep it covered.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 MAINTAINERS | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe4dc51b08..c9f625fc2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1230,7 +1230,6 @@ F: hw/pci-host/q35.c
 F: hw/pci-host/pam.c
 F: include/hw/pci-host/q35.h
 F: include/hw/pci-host/pam.h
-F: hw/isa/piix4.c
 F: hw/isa/lpc_ich9.c
 F: hw/i2c/smbus_ich9.c
 F: hw/acpi/piix4.c
@@ -1716,6 +1715,12 @@ F: hw/display/edid*
 F: include/hw/display/edid.h
 F: qemu-edid.c
=20
+PIIX4 South Bridge (i82371AB)
+M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
+M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
+S: Maintained
+F: hw/isa/piix4.c
+
 Firmware configuration (fw_cfg)
 M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
 R: Laszlo Ersek <lersek@redhat.com>
--=20
2.21.0


