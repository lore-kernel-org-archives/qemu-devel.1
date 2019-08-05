Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35DBC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716B92064A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkSpI3/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716B92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufVN-0001kB-Oy
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58373)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPb-0000Jx-Pd
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPa-0002rJ-Qx
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:39 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPa-0002qe-L7; Mon, 05 Aug 2019 12:00:38 -0400
Received: by mail-pf1-x441.google.com with SMTP id m30so39884295pff.8;
 Mon, 05 Aug 2019 09:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=4njfrOWQQMyLEX/rfHOtnIEzjwmjoWXLAc2Ndz0IW6c=;
 b=bkSpI3/5lKu6DEO+/4bYFMyPoc/GWN6bwf2h7On0Tpvl/beL252Tglz+hZtX/FHj5n
 OWfIHvPHALcGGaGmFSDSRQlKI6kCB7J7eyKz9mMLUjk4EbLfpnrneFtsUGoqLU0Hv1gm
 7O9sbjgF8rO22e4+D7aL+qh8c108Bcz8aagxGAiyf+rPiyqudQrKgBP/xuaBnDTL/uTz
 mMAdoKUCUfyUfnGsMKU6JIq354IyA/RLm4U8k/7PWroBSPjnbL86f3/K22Ha3MGO3Get
 U+qXZf35wOeE3HAauh3Ro9DcyaJsyMU3/KXZI3lCAi5EFV0Wm1coegIgZnB3ITMiWooO
 lleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=4njfrOWQQMyLEX/rfHOtnIEzjwmjoWXLAc2Ndz0IW6c=;
 b=j3XmeHigaZR6w4ve0/XkBThfuvnEg2NEy0221VvxM71sgZ4QxFciPre0/TRkwD+JSg
 nQfVc3+0YBVTtuC59mWj3Kff7B+pvytBiexpKATZpqj5+rcr3hy/SAHuJanGhN4QUx/O
 FOhZzq7etfVokXB2r83dTTplcOcTiEC3Jfe53p1aAj5+aSSt75FZ+7keqkJJxTGw+Em3
 +3qtKz+hfgP2XBPTaey7Rd4ICUgOucAgqd5JMlnrIKpdxcwNlI/sfS7sN7W8mi/I0W9f
 2OrVIwVsKqwJJ6Xz9CIxCdc+7wo9GGlMoRxcDOUhEdtaH62YU6Xp1YMJNaVapzC+Q/kj
 aBTw==
X-Gm-Message-State: APjAAAV1BR5dvG6pxI5Ug0zi0DRyd9CqqRSqvsbeoRQbE2My3R3Qv4ic
 DWLW+8u2NhrWnk/Ci33P4c4=
X-Google-Smtp-Source: APXvYqzKpcUeJFDxc35XZPwJ9AmRY4g0sH7xbrazO60YoJYAFLsrq39tnRsk97uzg0ZwXX+ctoeOOA==
X-Received: by 2002:aa7:97aa:: with SMTP id d10mr55989869pfq.176.1565020837917; 
 Mon, 05 Aug 2019 09:00:37 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.36
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:37 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 09:00:04 -0700
Message-Id: <1565020823-24223-10-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 09/28] riscv: sifive_u: Update UART base
 addresses
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This updates the UART base address to match the hardware.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_u.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index b235f29..9f05e09 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -60,8 +60,8 @@ static const struct MemmapEntry {
     [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
-    [SIFIVE_U_UART0] =    { 0x10013000,     0x1000 },
-    [SIFIVE_U_UART1] =    { 0x10023000,     0x1000 },
+    [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
+    [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
     [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000 },
 };
-- 
2.7.4


