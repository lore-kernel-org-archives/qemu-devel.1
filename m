Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23286C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21CA206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dm6TfdA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21CA206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXARQ-0001Sn-2S
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 15:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iXAOD-0007UU-O9
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:46:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iXAOC-0001jz-9K
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:46:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37809
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iXAOC-0001js-5N
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574196379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S6SqXgFoKot0ZX5FUnMp7mvmipVHKaABULgQfgHhejk=;
 b=Dm6TfdA0jXcVvUVVO/UsERdpghILOYY86Kc5NnWphez8EHK7cCufihLS0ZOhRuHMW+ynC+
 1R1ksYLZDlE5pSYFWE6b5mWQxsroL/l38HDFcp9psBRSzUC5Yr4dSP887Goc/HZjA9FEVt
 1luaUlfdErIR1pT2cFZsL8bQz+Itre0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-skaemc6XPfyCQA7xQAFcug-1; Tue, 19 Nov 2019 15:46:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7D581005511;
 Tue, 19 Nov 2019 20:46:13 +0000 (UTC)
Received: from localhost (unknown [10.36.118.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACD9560259;
 Tue, 19 Nov 2019 20:46:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-4.2-rc2 2/2] hw/mips/gt64xxx: Remove dynamic field width
 from trace events
Date: Tue, 19 Nov 2019 20:45:51 +0000
Message-Id: <20191119204551.240792-3-stefanha@redhat.com>
In-Reply-To: <20191119204551.240792-1-stefanha@redhat.com>
References: <20191119204551.240792-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: skaemc6XPfyCQA7xQAFcug-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Since not all trace backends support dynamic field width in
format (dtrace via stap does not), replace by a static field
width instead.

We previously passed to the trace API 'width << 1' as the number
of hex characters to display (the dynamic field width). We don't
need this anymore. Instead, display the size of bytes accessed.

Fixes: ab6bff424f (gt64xxx_pci: Convert debug printf to trace events)
Reported-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20191118222746.31467-3-philmd@redhat.com
Buglink: https://bugs.launchpad.net/qemu/+bug/1844817
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191118222746.31467-3-philmd@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/mips/gt64xxx_pci.c | 16 ++++++++--------
 hw/mips/trace-events  |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 5cab9c1ee1..f1af840d8e 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -642,19 +642,19 @@ static void gt64120_writel(void *opaque, hwaddr addr,
         /* not really implemented */
         s->regs[saddr] =3D ~(~(s->regs[saddr]) | ~(val & 0xfffffffe));
         s->regs[saddr] |=3D !!(s->regs[saddr] & 0xfffffffe);
-        trace_gt64120_write("INTRCAUSE", size << 1, val);
+        trace_gt64120_write("INTRCAUSE", size, val);
         break;
     case GT_INTRMASK:
         s->regs[saddr] =3D val & 0x3c3ffffe;
-        trace_gt64120_write("INTRMASK", size << 1, val);
+        trace_gt64120_write("INTRMASK", size, val);
         break;
     case GT_PCI0_ICMASK:
         s->regs[saddr] =3D val & 0x03fffffe;
-        trace_gt64120_write("ICMASK", size << 1, val);
+        trace_gt64120_write("ICMASK", size, val);
         break;
     case GT_PCI0_SERR0MASK:
         s->regs[saddr] =3D val & 0x0000003f;
-        trace_gt64120_write("SERR0MASK", size << 1, val);
+        trace_gt64120_write("SERR0MASK", size, val);
         break;
=20
     /* Reserved when only PCI_0 is configured. */
@@ -930,19 +930,19 @@ static uint64_t gt64120_readl(void *opaque,
     /* Interrupts */
     case GT_INTRCAUSE:
         val =3D s->regs[saddr];
-        trace_gt64120_read("INTRCAUSE", size << 1, val);
+        trace_gt64120_read("INTRCAUSE", size, val);
         break;
     case GT_INTRMASK:
         val =3D s->regs[saddr];
-        trace_gt64120_read("INTRMASK", size << 1, val);
+        trace_gt64120_read("INTRMASK", size, val);
         break;
     case GT_PCI0_ICMASK:
         val =3D s->regs[saddr];
-        trace_gt64120_read("ICMASK", size << 1, val);
+        trace_gt64120_read("ICMASK", size, val);
         break;
     case GT_PCI0_SERR0MASK:
         val =3D s->regs[saddr];
-        trace_gt64120_read("SERR0MASK", size << 1, val);
+        trace_gt64120_read("SERR0MASK", size, val);
         break;
=20
     /* Reserved when only PCI_0 is configured. */
diff --git a/hw/mips/trace-events b/hw/mips/trace-events
index 75d4c73f2e..321933283f 100644
--- a/hw/mips/trace-events
+++ b/hw/mips/trace-events
@@ -1,4 +1,4 @@
 # gt64xxx.c
-gt64120_read(const char *regname, int width, uint64_t value) "gt64120 read=
 %s value:0x%0*" PRIx64
-gt64120_write(const char *regname, int width, uint64_t value) "gt64120 wri=
te %s value:0x%0*" PRIx64
+gt64120_read(const char *regname, unsigned size, uint64_t value) "gt64120 =
read %s size:%u value:0x%08" PRIx64
+gt64120_write(const char *regname, unsigned size, uint64_t value) "gt64120=
 write %s size:%u value:0x%08" PRIx64
 gt64120_isd_remap(uint64_t from_length, uint64_t from_addr, uint64_t to_le=
ngth, uint64_t to_addr) "ISD: 0x%08" PRIx64 "@0x%08" PRIx64 " -> 0x%08" PRI=
x64 "@0x%08" PRIx64
--=20
2.23.0


