Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E026FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5FD8206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2i8EjQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FD8206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiDvp-0002gO-VV
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDsB-00085D-Eu; Mon, 08 Jun 2020 05:15:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDsA-0006ZP-Oj; Mon, 08 Jun 2020 05:15:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id l11so16559650wru.0;
 Mon, 08 Jun 2020 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JZJrkLA/SBPZqar+T/Pdm4HVA3BodVf1OjgW7SLCEjM=;
 b=P2i8EjQP3BExQwIsGyjE1XhEg87m4I0jWUELA/2CvKga+Hyzy9h4fzLd5n3/Hi3F/t
 H0H+oIL/eMXbtVbTxKSsM9Ggd1QetxRYPC5W5keLZWGggSUhPbUyYbGZbDdKih+I+SOe
 2jTwlYgH7ybjch84/G1B+4Rey040yiZ9gyuIRggkZXN+Q6bEvzuyztWMSlfgGc+6Igjh
 ZYiD+jswnq4kEFAA6QQfduK+a0w7O6IaBW90HlCrmMohU8oIGleDsG8powwvxfS0KxHi
 aEWBraiud2qJ4FBG41i85KrkX9+W9FnU5pJ8Eok5ZbHLhJDiHqh312dwtz7cBkbnCSym
 mCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JZJrkLA/SBPZqar+T/Pdm4HVA3BodVf1OjgW7SLCEjM=;
 b=GAjy+E7MhHEN1Z6drCJ/frLZx4NiUOeRXcBwkx/N652XZ5Dbzpu90V5DRJhV41rRu4
 YXW1ZhCJyyuZBrsJGuMDNl+tQnv9dMwmDW/AKu0SdcDHgeIi5ryDMgEE6nIkzAidrS6H
 UGOh3+icZjOuM91oYSexXN+RXj1sw2im97cojXaMbi52KyKLZg/H0b3rkQSu6tQnkeJD
 j7R7jkYf6056Hp2l8+rxCeq+9h2c1srnkp1uVgutBRQuUD1ijCbtF419ICqSKUNqyQEX
 xrt7rP7Ci4vGmNa2WBE3Vd++z25xK1CHdcLOO/+eTDcFZXZXw6dwmsOD+xQ/aMYDTJyn
 bzSQ==
X-Gm-Message-State: AOAM532Dh7McDr44zfNi/bOSPgqSav4rVchXJgLDw+MOLpotss5bwUqt
 vVJ5CDYqhv9tDf0weOaBzr0ZS447
X-Google-Smtp-Source: ABdhPJyD2A17b5V7wfNeYKHToJiZQs6oWzZzmEykFm1ifI+DuyB+DF3LsbtBFwwWbCj9bQQ/jUK0oA==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr24007262wrv.207.1591607712767; 
 Mon, 08 Jun 2020 02:15:12 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id c5sm18258653wma.20.2020.06.08.02.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 02:15:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/net/opencores_eth: Remove unnecessary address masking
Date: Mon,  8 Jun 2020 11:15:08 +0200
Message-Id: <20200608091508.19838-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608091508.19838-1-f4bug@amsat.org>
References: <20200608091508.19838-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The memory region is limited to 1 KiB, so the address is
garantied to be in that range. No need to mask.

  711 static const MemoryRegionOps open_eth_desc_ops = {
  712     .read = open_eth_desc_read,
  713     .write = open_eth_desc_write,
  714 };
  ...
  725     memory_region_init_io(&s->desc_io, OBJECT(dev),
  725                           &open_eth_desc_ops, s,
  726                           "open_eth.desc", 0x400);

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/opencores_eth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 90d3846bb7..0c9879e8a7 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -687,7 +687,6 @@ static uint64_t open_eth_desc_read(void *opaque,
     OpenEthState *s = opaque;
     uint64_t v = 0;
 
-    addr &= 0x3ff;
     memcpy(&v, (uint8_t *)s->desc + addr, size);
     trace_open_eth_desc_read((uint32_t)addr, (uint32_t)v);
     return v;
@@ -698,7 +697,6 @@ static void open_eth_desc_write(void *opaque,
 {
     OpenEthState *s = opaque;
 
-    addr &= 0x3ff;
     trace_open_eth_desc_write((uint32_t)addr, (uint32_t)val);
     memcpy((uint8_t *)s->desc + addr, &val, size);
     open_eth_check_start_xmit(s);
-- 
2.21.3


