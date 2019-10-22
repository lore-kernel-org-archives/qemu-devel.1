Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFF4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 21:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35532084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 21:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkeley-edu.20150623.gappssmtp.com header.i=@berkeley-edu.20150623.gappssmtp.com header.b="cVTdazFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35532084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=berkeley.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN1eR-0002XJ-CT
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 17:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dayeol@berkeley.edu>) id 1iN1b1-0000bj-2m
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 17:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dayeol@berkeley.edu>) id 1iN1az-0001ei-Fk
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 17:21:38 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:41024)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dayeol@berkeley.edu>) id 1iN1az-0001eN-5p
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 17:21:37 -0400
Received: by mail-qt1-x842.google.com with SMTP id c17so26077522qtn.8
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 14:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=berkeley-edu.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4ciWYO+JQTfvwrYJqiccgIFokh0umLIjCGNk8VTvZkI=;
 b=cVTdazFlt+E+xN+sUem5370SgcTGwyhjVxJXbzsYy5by9y4njNglJcHtu5y8/bCCo4
 zH3mOFyd9FNKLwkhqVHzDkEi2P/yryiJ0of76nnqxTUFoAYWpXE5Mr1UZKzjez4E0BOd
 lqrlYqirqnyc1aXGMbQwsiTV85oPWafEVzjCedjHurVnBmPA8e6D4hOj5cekY2OmmJIQ
 6nX9Xrfl3gFQ0hTlIQrK858UdOBWept0FA9qnCnIk3ZBCbaUjdMDAFBEC1mTK95Wh+42
 +Ya05P/CM77DB3u9Cfg8tAQOUj+hC4FvIPbUJZ3CfO0RiU2TETaBiGXzc9Ri89HbP3vw
 kFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4ciWYO+JQTfvwrYJqiccgIFokh0umLIjCGNk8VTvZkI=;
 b=Q6XbG/uOIZUEi7RvX691bNZzTcpJeUM+ZE7ojCcyYQnFRyT3j59GblN50yYogNUgV5
 X/G4kKLwPLyGH4vvvmtxUoAyvElQCO4feYsE+luczfGPnM3QMY28qf/U6KiUMbyqJMv4
 9hbP5yhqaVQejrje9egwNmQFpUnqoEoQWJImERehRpmGUuAhApLWMzA02RMSt8590dQS
 AshK9vtjRmuQOM1B87+14vpevBY1ptL12Zn640PclGF2kxHXPBoCs/n623Nwo0m4ioD7
 sU2nGQcN/faeaUI7J9P0+YLe5zVAc7CTOLMwVdgrZmKcLhJNeZdnCmvgypLByIeDzEHq
 +h/Q==
X-Gm-Message-State: APjAAAWC+TDcu1pEGzhhJlo7wkFHcY/dgtO7rSVB8JWATkOzChDfaH8N
 rxZrMB/8AVwPMJMCQ1xzc8AZXPh8Im1Zkw==
X-Google-Smtp-Source: APXvYqwsdr6ZhYJ8iiAjz/Hg+tgGmCI7x+R7tbcmQgArv30Q09txhTI2OVFfcCfN2iRTQPqYmh99Lg==
X-Received: by 2002:ac8:73cf:: with SMTP id v15mr1610041qtp.310.1571779295221; 
 Tue, 22 Oct 2019 14:21:35 -0700 (PDT)
Received: from ip-172-31-33-50.ec2.internal
 (ec2-34-206-44-154.compute-1.amazonaws.com. [34.206.44.154])
 by smtp.gmail.com with ESMTPSA id z5sm9625014qkl.101.2019.10.22.14.21.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 22 Oct 2019 14:21:34 -0700 (PDT)
From: Dayeol Lee <dayeol@berkeley.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/riscv: PMP violation due to wrong size parameter
Date: Tue, 22 Oct 2019 21:21:29 +0000
Message-Id: <20191022212129.8452-1-dayeol@berkeley.edu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Dayeol Lee <dayeol@berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, diodesign@tuta.io
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

riscv_cpu_tlb_fill() uses the `size` parameter to check PMP violation
using pmp_hart_has_privs().
However, if the size is unknown (=0), the ending address will be
`addr - 1` as it is `addr + size - 1` in `pmp_hart_has_privs()`.
This always causes a false PMP violation on the starting address of the
range, as `addr - 1` is not in the range.

In order to fix, we just assume that all bytes from addr to the end of
the page will be accessed if the size is unknown.

Signed-off-by: Dayeol Lee <dayeol@berkeley.edu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/pmp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 958c7502a0..7a9fd415ba 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -232,6 +232,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
 {
     int i = 0;
     int ret = -1;
+    int pmp_size = 0;
     target_ulong s = 0;
     target_ulong e = 0;
     pmp_priv_t allowed_privs = 0;
@@ -241,11 +242,21 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
         return true;
     }
 
+    /*
+     * if size is unknown (0), assume that all bytes
+     * from addr to the end of the page will be accessed.
+     */
+    if (size == 0) {
+        pmp_size = -(addr | TARGET_PAGE_MASK);
+    } else {
+        pmp_size = size;
+    }
+
     /* 1.10 draft priv spec states there is an implicit order
          from low to high */
     for (i = 0; i < MAX_RISCV_PMPS; i++) {
         s = pmp_is_in_range(env, i, addr);
-        e = pmp_is_in_range(env, i, addr + size - 1);
+        e = pmp_is_in_range(env, i, addr + pmp_size - 1);
 
         /* partially inside */
         if ((s + e) == 1) {
-- 
2.23.0


