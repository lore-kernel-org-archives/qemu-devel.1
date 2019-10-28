Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17634CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE512214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6MC+IBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE512214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP9Bp-000102-8S
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 13:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iP7z5-0001yR-D2
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iP7z3-0007DV-2l
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:35:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21729
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iP7z1-0007CC-8r
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572280506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dp/nKQVZFywaOMixL/+A3VBgd7NuzQl0q2mvB/663P0=;
 b=V6MC+IBR1B7Op16r8sTiUS3oVUJF2idx97K2vd7bk3WT3siuAbxyf/7CTM0K7CvBlAsrjx
 V+Olhe438cqQtMmr+HK8dAC86QGju5cll3korj9VE5taSzBHSLDYStxGa1o5dC/oOkTaSH
 Bw+dhGYyHUoMOGPS3ab3Vvo75J1zoQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-jv3xlSrfNuO1g5qxhHnCIQ-1; Mon, 28 Oct 2019 12:35:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E700A81A334;
 Mon, 28 Oct 2019 16:35:00 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-87.brq.redhat.com [10.40.204.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9390C26192;
 Mon, 28 Oct 2019 16:34:55 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/20] MAINTAINERS: Keep PIIX4 South Bridge separate from PC
 Chipsets
Date: Mon, 28 Oct 2019 17:34:28 +0100
Message-Id: <20191028163447.18541-2-philmd@redhat.com>
In-Reply-To: <20191028163447.18541-1-philmd@redhat.com>
References: <20191028163447.18541-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: jv3xlSrfNuO1g5qxhHnCIQ-1
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The PIIX4 Southbridge is not used by the PC machine,
but by the Malta board (MIPS). Add a new section to
keep it covered.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Li Qiang <liq3ea@163.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 MAINTAINERS | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42e702f346..1f04502fac 100644
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
@@ -1730,6 +1729,12 @@ F: hw/display/edid*
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


