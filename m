Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A72C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 07:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F5D2074B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 07:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMnoDIuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F5D2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwhHs-0004ED-Qx
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 03:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwhHK-0003kJ-0m; Sat, 18 Jul 2020 03:29:02 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwhHI-0004rB-FJ; Sat, 18 Jul 2020 03:29:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id j4so13243020wrp.10;
 Sat, 18 Jul 2020 00:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e8rHhYVCoB0qIGjBSBEzCo0D2nNfBhrU0Fv7m4M0wn4=;
 b=fMnoDIuHbMHvcHb834mcUTFneqKEDP/815kWPjfz1hwHCZDEpQ61D5ZyjtUa/ySItp
 B/DryIBsast53kRAV+fnw/K6+ymBZXYHKZXzHNZrAOJ/F7Dh++VEQoGMm1qSL8KVr8JR
 qj0M6m1V5+wCIu5AUaacVBHMaiWvWGXf+6YxeeL6X/0V/2pt4/Lf2aB+9mNRfiVxrpx+
 v3ZBwrQrwUY6Zr96B6OdNwwbL2YwPFXvdwPH10SoiEr7Q2sQ466booTsdbfJ1CwtYc6n
 a4I5zcsVbgmBcmLdpIRwrf33TVLO4g7wMnr1QQXf3XLLumJh7oIc2jTesY2/KdErE4VD
 cPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=e8rHhYVCoB0qIGjBSBEzCo0D2nNfBhrU0Fv7m4M0wn4=;
 b=OOwnHCzyMj0/1bpB8kwA1XCvjF09MQG0aA7RyMpub6QZdLd/d+vfkQoSbpvx99wQPZ
 oRQuJZg79xh+t4iCV9zixeZfDMX+2nWYVasRfVqPBBiyLmPmiDx/C+Pl/GLTve8fZsld
 BAlCdnJIPdlqeitSQKHSYD6B6heUWbGKhrCaDLkxDqS9D2m4+YaV3n8rdsgXQApQR0kj
 66I5OWYxhRZOVzTN/XkQPhs2TunZoHRJOw/aWXQraaRKI2Tv96ccrlSYkx/DGwC4VDsh
 xU+vptuzQZa+uJ1Lw7fHDaHqrUD1mSssDaJ0LBbZdW3pXOaBOjxsP13bf1kUu7Bt6ENU
 cqpg==
X-Gm-Message-State: AOAM532eWdM1eKBpi9cHo9PrquzgTaTZJ+lJwvyXO472LrPixt45FndK
 KxfdPGA7yELQ2zp8qZWnxaFbks7VXlo=
X-Google-Smtp-Source: ABdhPJzciD7uwDu9nDa2l0w1drb8xTcvTrEAGrsnKA0U+xhlzUI/0Db/+RJzsX+c8pFttVu6Mjsq+A==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr13324913wrt.174.1595057337874; 
 Sat, 18 Jul 2020 00:28:57 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u20sm17230005wmm.15.2020.07.18.00.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2020 00:28:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1] hw/ide/ahci: Do not dma_memory_unmap(NULL)
Date: Sat, 18 Jul 2020 09:28:54 +0200
Message-Id: <20200718072854.7001-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libFuzzer triggered the following assertion:

  cat << EOF | qemu-system-i386 -M pc-q35-5.0 \
    -nographic -monitor none -serial none -qtest stdio
  outl 0xcf8 0x8000fa24
  outl 0xcfc 0xe1068000
  outl 0xcf8 0x8000fa04
  outw 0xcfc 0x7
  outl 0xcf8 0x8000fb20
  write 0xe1068304 0x1 0x21
  write 0xe1068318 0x1 0x21
  write 0xe1068384 0x1 0x21
  write 0xe1068398 0x2 0x21
  EOF
  qemu-system-i386: exec.c:3621: address_space_unmap: Assertion `mr != NULL' failed.
  Aborted (core dumped)

This is because we don't check the return value from dma_memory_map()
which can return NULL, then we call dma_memory_unmap(NULL) which is
illegal. Fix by only unmap if the value is not NULL (and the size is
not the expected one).

Cc: qemu-stable@nongnu.org
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Fixes: f6ad2e32f8 ("ahci: add ahci emulation")
BugLink: https://bugs.launchpad.net/qemu/+bug/1884693
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ide/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 009120f88b..4f596cb9ce 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -250,7 +250,7 @@ static void map_page(AddressSpace *as, uint8_t **ptr, uint64_t addr,
     }
 
     *ptr = dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEVICE);
-    if (len < wanted) {
+    if (len < wanted && *ptr) {
         dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE, len);
         *ptr = NULL;
     }
-- 
2.21.3


