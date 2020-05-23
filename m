Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F289C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 19:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE9C2070A
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 19:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoXg+N7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE9C2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcZd2-0008D6-Bn
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 15:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcZcE-0006pm-7O
 for qemu-devel@nongnu.org; Sat, 23 May 2020 15:15:26 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcZcD-0000ac-HV
 for qemu-devel@nongnu.org; Sat, 23 May 2020 15:15:25 -0400
Received: by mail-wr1-x441.google.com with SMTP id j16so1110264wrb.7
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 12:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3/P/RORFvG7UdbIPFf45C1Qd+GHf2aIOo5B6nteH460=;
 b=SoXg+N7DAPMypoBC0pnAmDlZpaQrNZB1Ouxv8y/HYodRu9HyaAc6ersGG04ww27FxQ
 DeDMDtFy1eTZuNJ79VnoyymBFa0GpvI4TSdAC9HO6RIousuYwq8/ghc0TpcJMzzSYh4n
 Wb/+ErcX/3eIrEeRtgjgq0mtOyOCkY11ph8L/ZF/80eeRVmiVvof4xv29Ju+/p5iT8RO
 j+1Tbe0XhXuibH1eeKVM/qwnf32colP4DPSiA94j1+OjXqEg107jtS7bj1Yr+PakqGtg
 viJCWFcocxD4v0tKjHACTirNJflHwZ3Vr0cPmH9Wnm0dxbkEabjz0j2f91nSbda99UtI
 ifTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3/P/RORFvG7UdbIPFf45C1Qd+GHf2aIOo5B6nteH460=;
 b=BA2uPTjLpswfq8hh49WfSE3HZBLKg3ZRzhEI/cqGQIQ/smXbBxUYzxYfe+Mr6p4bI0
 vH8OhBzUYiq7HRn1y3bIPpIUF+LnTQfq/pnmKn6HeYJ4qEcP/YBvfj1OMespBnnwWvi7
 /fYCyjmXWZjD8b75vMVP8NMa/3GrAsruIq5ATNkEJtdPZW26qNqtd5iVIKtGJLZaKZyO
 0Nxjvqs9uJMX5Ks4lcYiuG4619vmsGFV0iMOhBt+FOA6HAbsd8Gc87x7a4HfiNx1tg+E
 8WOr64yrOwqQIQ32/dFcImUx2BsCC5UhBTXzWUhdtlNELbgj5pahHvC8H49wh+pPXObh
 1MvQ==
X-Gm-Message-State: AOAM530Os9Zl94elBqd0hLly/6vT9QivU6MCcQBN1dPNvaUJidQk1Hak
 r5ZZIDQhvXMImksOHzmncDU=
X-Google-Smtp-Source: ABdhPJx88ks8u8aGQCwmP/F6yHx0VR5LfBXmdnGI4ewYtoxCh8rWoqvDmaxGJS8wpt3T5uUjvyQHXQ==
X-Received: by 2002:a5d:62c2:: with SMTP id o2mr8033540wrv.51.1590261324195;
 Sat, 23 May 2020 12:15:24 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id y185sm13370681wmy.11.2020.05.23.12.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 12:15:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 3/3] hw/display/artist: Check offset in block_move to avoid
 buffer over-read
Date: Sat, 23 May 2020 21:15:17 +0200
Message-Id: <20200523191517.23684-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200523191517.23684-1-f4bug@amsat.org>
References: <20200523191517.23684-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Invalid I/O writes can craft an offset out of the vram_buffer
range.

We avoid:

  Program terminated with signal SIGSEGV, Segmentation fault.
  519                 artist_rop8(s, buf, dst + column, buf->data[src + column]);
  (gdb) bt
  #0  0x000055fa83b05e0a in block_move (s=0x55fa8647e510, source_x=0, source_y=0, dest_x=255, dest_y=-5, width=22, height=16705) at hw/display/artist.c:519
  #1  0x000055fa83b071da in artist_reg_write (opaque=0x55fa8647e510, addr=1051392, val=16777211, size=4) at hw/display/artist.c:954

Reported-by: LLVM libFuzzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/artist.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 6f61b85a24..320e3c5050 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -513,6 +513,11 @@ static void block_move(ARTISTState *s, int source_x, int source_y, int dest_x,
         dst = dest_x + ((line + dest_y) * buf->width);
 
         for (column = startcolumn; column != endcolumn; column += columnincr) {
+            if ((int)src + column < 0 || src + column >= buf->size) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "block_move src:%d column:%d\n", src, column);
+                continue; /* FIXME */
+            }
             if (dst + column > buf->size || src + column > buf->size) {
                 continue;
             }
-- 
2.21.3


