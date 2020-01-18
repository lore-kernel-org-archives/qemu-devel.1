Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81702C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 08:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A04E24683
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 08:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aB3Z71X1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A04E24683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isjuJ-0001Ln-D7
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 03:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isjtC-0000Ma-Sz
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 03:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isjtB-0004Qx-Le
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 03:55:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54997
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isjtB-0004QQ-Hr
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 03:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579337729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2bpndsFJEwhvq3QvF0dJgfcdC1EMYmru72/TZYViLVM=;
 b=aB3Z71X1KV+8dFPAJV+78Y3z6Bes+kYh5riDc99y5eh0m4QJ/LRcw7bvtXAi1N0Z5esD8u
 QDPX1oodCN/dfxMl9YhqBXYd0jYvYK8A2KQ9I7an/X1rgA98W815XHecKPtr2/e33aWv+A
 PGZoDS2dWIB1rEPtrmtU+qW+/mhhtSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-_NpsNDtfNFaFUkWGx1SjFQ-1; Sat, 18 Jan 2020 03:55:23 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9100107ACC7;
 Sat, 18 Jan 2020 08:55:21 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-59.brq.redhat.com [10.40.204.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B23A5C1B2;
 Sat, 18 Jan 2020 08:55:18 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] MAINTAINERS: Cc the qemu-arm@nongnu.org for the ARM
 machines
Date: Sat, 18 Jan 2020 09:55:08 +0100
Message-Id: <20200118085509.30182-2-philmd@redhat.com>
In-Reply-To: <20200118085509.30182-1-philmd@redhat.com>
References: <20200118085509.30182-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: _NpsNDtfNFaFUkWGx1SjFQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not all ARM machines sections Cc the qemu-arm@nongnu.org list,
fix this.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Also fix STM32F405 (commit 529fc5fd3)
    and Netduino Plus 2 (commit 60d6c4278)
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55d3642e6c..52fbc18566 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -807,6 +807,7 @@ F: hw/arm/virt-acpi-build.c
 STM32F205
 M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/stm32f205_soc.c
 F: hw/misc/stm32f2xx_syscfg.c
@@ -819,6 +820,7 @@ F: include/hw/*/stm32*.h
 STM32F405
 M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/stm32f405_soc.c
 F: hw/misc/stm32f4xx_syscfg.c
@@ -827,18 +829,21 @@ F: hw/misc/stm32f4xx_exti.c
 Netduino 2
 M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/netduino2.c
=20
 Netduino Plus 2
 M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/netduinoplus2.c
=20
 SmartFusion2
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/msf2-soc.c
 F: hw/misc/msf2-sysreg.c
@@ -852,6 +857,7 @@ F: include/hw/ssi/mss-spi.h
 Emcraft M2S-FG484
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/msf2-som.c
=20
@@ -1400,6 +1406,7 @@ T: git https://github.com/jnsnow/qemu.git ide
=20
 OMAP
 M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/omap*
 F: include/hw/arm/omap.h
--=20
2.21.1


