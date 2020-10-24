Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F03BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD5FC21D41
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG+2MJ0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5FC21D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWQWI-0003aB-Oj
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 16:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWQVH-00031G-Nv
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 16:51:08 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWQVE-0006GH-Lz
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 16:51:07 -0400
Received: by mail-wr1-x443.google.com with SMTP id b8so7108475wrn.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mf8jmSVivEDI3YZ0cQwYjT/GiMph8yQ9KvEBl9GSzXY=;
 b=JG+2MJ0ozIaoUvxSW64FhLwdw8QBxovfloRtB4zzDZ9zoBi3mi4A1sIcYkbiFM2gCT
 2xQmU1AFOSyGvIvFXJPW6/IYg92dEz4v1q4HtRAqONxOTMljfwtB6n2K9xFP3w0FbHLB
 ddp2/0OlLf8oCZimhG4k0xiXgkL+1vw2zIayNvjeZ473Wjl9F4lpCFcqU2DGZI8r0Lgx
 vy8Sxf4Tffk7so0vygZ1cqwKfJhdsm6PQnyLAE41H8nkr5gs1446xFt2oN1J6iNv2axH
 OQyqTvw87diA7BHztW/AoBLjbSBsNzY72Vw8uPk4Bb2h9jZYvk72RbRQ/p0/f8nl4IPh
 1tXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Mf8jmSVivEDI3YZ0cQwYjT/GiMph8yQ9KvEBl9GSzXY=;
 b=aTHx3bL/phI/Qc46vUum8GE/HPoMneJBIpSDZdhgvRM11RlNZnpNj4o9C3CelV8rtF
 a4IKQtEmubxNsXN/F0RlV5Le9iDbRcdg5t5RZCOVZM8Sa7Mf+Y93k8HayoAU1CJJaPlM
 b4r1zwqlE9hSwt/N0ZHGxJRrjYG8WRs1Vk0jBa5XaNtioB6QooGLk9Qo+9QrsnFr1N6p
 XR0e7i3XL4HQNzo8W9YcSBfne7bbL1TdZVycZ+xbvskWXL9CoEMdFxmDOr3cEGB9MfvC
 gQ6z4nDweGEo+uf7u8YjAKoVRcBJMYtgKfhY1s4Y0fqQLWDQiOzQWe6D/rExw/Ha20dC
 AQ9Q==
X-Gm-Message-State: AOAM532kNLMret3/xYIL1/FLpKBhnJ/u9PR563XxxpRn1rIUHVOf3jMF
 Dxvh1yx1pXQwcO6Vhpj100M=
X-Google-Smtp-Source: ABdhPJxvr5DvipLfkYUxbmsPi4nhIi/phGIF/v7fX/O1iZ4A/vfmBdWAjshtPjn8sdAThhfpc4LCBQ==
X-Received: by 2002:adf:e849:: with SMTP id d9mr10118800wrn.25.1603572662949; 
 Sat, 24 Oct 2020 13:51:02 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e11sm12925120wrj.75.2020.10.24.13.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2020 13:51:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org
Subject: [PATCH v3] hw/display/tcx: Allow 64-bit accesses to framebuffer
 stippler and blitter
Date: Sat, 24 Oct 2020 22:51:00 +0200
Message-Id: <20201024205100.3623006-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Michael Lorenz <macallan@NetBSD.org>, Andreas Gustafsson <gson@gson.org>,
 1892540@bugs.launchpad.net, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The S24/TCX datasheet is listed as "Unable to locate" on [1].

However the NetBSD revision 1.32 of the driver introduced
64-bit accesses to the stippler and blitter [2]. It is safe
to assume these memory regions are 64-bit accessible.
QEMU implementation is 32-bit, so fill the 'impl' fields.

Michael Lorenz (author of the NetBSD code [2]) provided us with more
information in [3]:

> IIRC the real hardware *requires* 64bit accesses for stipple and
> blitter operations to work. For stipples you write a 64bit word into
> STIP space, the address defines where in the framebuffer you want to
> draw, the data contain a 32bit bitmask, foreground colour and a ROP.
> BLIT space works similarly, the 64bit word contains an offset were to
> read pixels from, and how many you want to copy.
>
> One more thing since there seems to be some confusion - 64bit accesses
> on the framebuffer are fine as well. TCX/S24 is *not* an SBus device,
> even though its node says it is.
> S24 is a card that plugs into a special slot on the SS5 mainboard,
> which is shared with an SBus slot and looks a lot like a horizontal
> UPA slot. Both S24 and TCX are accessed through the Micro/TurboSPARC's
> AFX bus which is 64bit wide and intended for graphics.
> Early FFB docs even mentioned connecting to both AFX and UPA,
> no idea if that was ever realized in hardware though.

[1] http://web.archive.org/web/20111209011516/http://wikis.sun.com/display/FOSSdocs/Home
[2] http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/sbus/tcx.c.diff?r1=1.31&r2=1.32
[3] https://www.mail-archive.com/qemu-devel@nongnu.org/msg734928.html

Reported-by: Andreas Gustafsson <gson@gson.org>
Buglink: https://bugs.launchpad.net/bugs/1892540
Fixes: 55d7bfe2293 ("tcx: Implement hardware acceleration")
Tested-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Andreas Gustafsson <gson@gson.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since v2:
- added Michael's memories
- added R-b/T-b tags

Since v1:
- added missing uncommitted staged changes... (tcx_blit_ops)
---
 hw/display/tcx.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index c9d5e45cd1f..878ecc8c506 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -549,20 +549,28 @@ static const MemoryRegionOps tcx_stip_ops = {
     .read = tcx_stip_readl,
     .write = tcx_stip_writel,
     .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
+    .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
 };
 
 static const MemoryRegionOps tcx_rstip_ops = {
     .read = tcx_stip_readl,
     .write = tcx_rstip_writel,
     .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
+    .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
 };
 
 static uint64_t tcx_blit_readl(void *opaque, hwaddr addr,
@@ -651,10 +659,14 @@ static const MemoryRegionOps tcx_rblit_ops = {
     .read = tcx_blit_readl,
     .write = tcx_rblit_writel,
     .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
+    .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
 };
 
 static void tcx_invalidate_cursor_position(TCXState *s)
-- 
2.26.2


