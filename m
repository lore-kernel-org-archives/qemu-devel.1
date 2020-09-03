Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F63C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866DE206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMg9yE2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866DE206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwqn-0007P1-J2
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLG-0003yS-QU; Thu, 03 Sep 2020 17:00:24 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:42322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLE-0007bB-48; Thu, 03 Sep 2020 17:00:21 -0400
Received: by mail-oo1-xc43.google.com with SMTP id a6so1118408oog.9;
 Thu, 03 Sep 2020 14:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=b3KQN/Kte9yOknsbzt0CDZ4AvatyRKhckS3n3Zf19Fo=;
 b=IMg9yE2nza1NjXHuqgj8vpy0D5pb/EbUf38oh7UHpghM3PT/FWDzjNoekuQ7w9ky4G
 vnITpKkUzzzHziDyo3VPs0pu4BMtzKbeUiKFDb9/wdakeaYsrdcyMlYIynEuFMRCE+S1
 qNsx3a60qks/ilXWS0gTnnrPmhBXO9taWp/3vp7eoQd2kVWp29O8CZhf6ryoKBRtkgCP
 TW3/vr5MYcbL3QmP4/H7zPIDrRelyoS381HLAlnfJ6iU2QV1cdcQgMXwEgGfTjrLByAu
 WqftyLlTDTIXyMUXJS3/9Pdd8CfU1S5/b1lAeevwNgyUjLS6r5Hlr7gMFKhg5qT7Z9hl
 8BzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=b3KQN/Kte9yOknsbzt0CDZ4AvatyRKhckS3n3Zf19Fo=;
 b=fMWXMGqCPOXs7MaPwtT434NAHjucAK0tenVT+niZluPKnfXDYUBnW1vZDb3jRsYNlT
 VMhfU/IDrodGsRhvTF6MfU3SyXlgpjI7zG+VZFzqs2rbgMUkPDbtMwHDdPP1aKoOwiGz
 cKeI41XtNlIxtwtrms+5U7j7yTb4FjeWeCyiUbQDRsxe1uXLd9/4B2xNLpYN3azJzFj/
 q+o44Kle+4f12c1DPd57isK0yPawKuwoi7EF645lvEOCQJlHW+TYR+Syg15e+qfLPBjf
 MPsbjuL60YmVy9+wfVKEvXd/ato+ypqHkHoZdSC/0oPrZwLYnZOCZU2MnsFNK53ijg3j
 7NzA==
X-Gm-Message-State: AOAM530Jp248s9m6xRFJ11Y9fQ8iVXNT7R5CHSOjzxhPGhkkE/w2CW42
 /k40QSG4cSmGO/gK3Y8SgGn0z9Iizh8=
X-Google-Smtp-Source: ABdhPJxMIaneA/FtV97r7S/vzL2QCYXzkK5Gu0x6tPm+WGdLfqAqXBBcogQAMJo2J5EUXsF52XS3zw==
X-Received: by 2002:a4a:a648:: with SMTP id j8mr3362294oom.44.1599166818155;
 Thu, 03 Sep 2020 14:00:18 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id t84sm294237oif.32.2020.09.03.14.00.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:17 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 30/77] hw/riscv: Allow 64 bit access to SiFive CLINT
Date: Thu,  3 Sep 2020 15:58:48 -0500
Message-Id: <20200903205935.27832-31-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Commit 5d971f9e672507210e77d020d89e0e89165c8fc9
"memory: Revert "memory: accept mismatching sizes in
memory_region_access_valid"" broke most RISC-V boards as they do 64 bit
accesses to the CLINT and QEMU would trigger a fault. Fix this failure
by allowing 8 byte accesses.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei<zhiwei_liu@c-sky.com>
Message-Id: <122b78825b077e4dfd39b444d3a46fe894a7804c.1593547870.git.alistair.francis@wdc.com>
(cherry picked from commit 70b78d4e71494c90d2ccb40381336bc9b9a22f79)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/riscv/sifive_clint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index e933d35092..a2a4b7d752 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -180,7 +180,7 @@ static const MemoryRegionOps sifive_clint_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
-        .max_access_size = 4
+        .max_access_size = 8
     }
 };
 
-- 
2.17.1


