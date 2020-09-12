Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9B0C10DAA
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B777021D6C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSwHns8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B777021D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH3uy-000373-L6
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 07:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3th-0001Pe-3J; Sat, 12 Sep 2020 07:40:49 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3te-0000Sx-W8; Sat, 12 Sep 2020 07:40:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id k15so13889775wrn.10;
 Sat, 12 Sep 2020 04:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=34kk1edcAv9gPx2tbUUFoSPGnc2hB1OEkRGzgkZ3UyM=;
 b=qSwHns8pnvRcyHGrA6m6QJYDbIa9MegbKjQShn4pRkdvDWB1rdtPDt3nWzPDQz7OAM
 PlesndzWMGYz7tGB1k+tKf1s1BLhIq8QfSMcraNH8t1AslRWYKyYsdmW30uJgkd4knmy
 GHnN4ZG0VN8ToXeo9Gunl9yn7uzIOwBs2d+vf0klmrTwZRnPkK4BtV/Epd468NMjtzpt
 jMHO3kve/Uwh91YPXVsbTKhXMPPGvqkPf/taolCuj7y4CETBJqdp4i9o9cey1geps/if
 tGMG5w+XW7geXXR7I0i+v2IlH1Sb7siLWaqpI8hBdvEPfj93UNFc1Fl5pi48uBeuaHWH
 ZBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=34kk1edcAv9gPx2tbUUFoSPGnc2hB1OEkRGzgkZ3UyM=;
 b=nrA7oKW5RWEx1P3p16j/PBp/9d4aBAFaiz+U1OTHqKmPSR0CAtmr8vHSRUES+iw6qP
 0oPQj8Ust/AzCvK0y65F83j/jbkZh/xgiSgNS0lKnebW7jCELUgMdizIZZCSX//u+RnW
 LD4r1j/Zj3egaX2KEvrNWXKBTmmk5gr0SeX+d/nhEhVI5393PwA0y1UjxcBdIKI18+Me
 ko4L341s/C/xo1K+z4liPIRD23pzefScUDCM2MauTCo+gblzqL+kAd2Sr9ur2YbtEXFp
 cQVM+Vr9lxghaojrb5BCTRfZhxzzGtolctQbj+8l1XC6WqnGps0/yIh6Mv9UQ65BoBJK
 z/lQ==
X-Gm-Message-State: AOAM530s2aDAf+/eUyXFfQHuvp77eIOCbQCq57j1qrPpc/BFnd3CHDCf
 27pNRIhrpPriYc5Gwrgka30=
X-Google-Smtp-Source: ABdhPJxBfxV8QkEtvA+iRweVpgQY7yx7umsKtYT8+OouFCiBWv/6XSDMSHJ3MBcxNgztCZRszD7ntQ==
X-Received: by 2002:adf:f290:: with SMTP id k16mr6962931wro.124.1599910844047; 
 Sat, 12 Sep 2020 04:40:44 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h6sm9373895wmb.22.2020.09.12.04.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 04:40:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/7] hw/char/serial: Assert serial_ioport_read/write offset
 fits 8 bytes
Date: Sat, 12 Sep 2020 13:40:34 +0200
Message-Id: <20200912114040.918464-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200912114040.918464-1-f4bug@amsat.org>
References: <20200912114040.918464-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The serial device has 8 registers, each 8-bit. The MemoryRegionOps
'serial_io_ops' is initialized with max_access_size=1, and all
memory_region_init_io() callers correctly set the region size to
8 bytes:
- serial_io_realize
- serial_isa_realizefn
- serial_pci_realize
- multi_serial_pci_realize

It is safe to assert the offset argument of serial_ioport_read()
and serial_ioport_write() is always less than 8.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 23864794929..a855ef66ea2 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -344,7 +344,7 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
 {
     SerialState *s = opaque;
 
-    addr &= 7;
+    assert(size == 1 && addr < 8);
     trace_serial_ioport_write(addr, val);
     switch(addr) {
     default:
@@ -485,7 +485,7 @@ static uint64_t serial_ioport_read(void *opaque, hwaddr addr, unsigned size)
     SerialState *s = opaque;
     uint32_t ret;
 
-    addr &= 7;
+    assert(size == 1 && addr < 8);
     switch(addr) {
     default:
     case 0:
-- 
2.26.2


