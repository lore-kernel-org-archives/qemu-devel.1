Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761ECCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7AE21721
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Nxr7bULA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7AE21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP7ue-0006Cr-LP
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 12:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP7Pr-0005lN-68
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP7Pp-00044T-Vd
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:47 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP7Pp-00043B-Qo
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:45 -0400
Received: by mail-pg1-x544.google.com with SMTP id l3so7150362pgr.8
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=Rf7l20baL3wXANMavS2hbKDA48ozo8auToQW/WNuPTs=;
 b=Nxr7bULAjuvvpptsDgYu04UUAZc4QgwYBV3m+t/eiYZ+mDLFhpXZ0tU7LlO/C7QbQI
 17FHjkQtB+/6fEShsASOYlKFsdVzp9xjCGLqCsCEh22EDb4TUYRJbBxRPc/yNe3kjghA
 SuY8Gk0HWWXQMHfQJI/dw7Az7JsivZlVMPkTI4VnKziFZzHnXqMsCHJlvil82RIERgLN
 a6p5X99yzBjjSNwzOEbhq3jVwTeGhh8Bjixu5INw0pFo2A7JEY7Tv4hGjfffHpn/CB9Y
 qOTkzL61CZmt/26y9wZWFZBrtpsuT8GWCM7fDPg52H1Q0zUoZKAkb3DrW8N2sL+54A8A
 cNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=Rf7l20baL3wXANMavS2hbKDA48ozo8auToQW/WNuPTs=;
 b=EKWftdZxDGSnm45RIKWsga1yvKU79cY7JzHO0MsW8j2wTzV86dC9pyDdRlmRV8iuoA
 t9ERmtKItmJ0dRvYLh6jpk5l7hAsTabxWetm7lg+JnQrV1uqMe9Cxv0nEO25PQDH4xHg
 KeqlH5DkvsiEYbWKNAQc5kJ3S+3DLLMl2Vpkh/4wFJEiHooUUdo0Mh8J3O2ZACbEvHaC
 iJZ+BmAadZXH2a6V6GB/Jj1JFvCpn75xNWbhbXi9TTl/+ZeHUMC9gPQ/NVboHHTALdyR
 oqQFfjuIu7FW91WsxIWHU6z+PGYIRxa8V1Ci3rOGtSWJ4F/L5+WWKQsMKIFITcooHDBc
 yNhA==
X-Gm-Message-State: APjAAAU7lfEXMO7FOcgH7ypv3Yr/qu5qiq9m9wMWYD/vrMbzqYOxBxsb
 cdStWjNA54taWUK7YdRMaBWzqIYUiUEc6w==
X-Google-Smtp-Source: APXvYqzP6RAn/bhU3NbvkC+OGNuHCBhWUIFWABoctEMHxx1ExPL2lnKjWH9JAcvwXd0+jzHcAmFxBQ==
X-Received: by 2002:aa7:8ad0:: with SMTP id b16mr21648902pfd.255.1572278324651; 
 Mon, 28 Oct 2019 08:58:44 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id y129sm12530908pgb.28.2019.10.28.08.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:44 -0700 (PDT)
Subject: [PULL 16/18] target/riscv: Make the priv register writable by GDB
Date: Mon, 28 Oct 2019 08:49:00 -0700
Message-Id: <20191028154902.32491-17-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028154902.32491-1-palmer@sifive.com>
References: <20191028154902.32491-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: qemu-riscv@nongnu.org, Jonathan Behrens <jonathan@fintelia.io>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jonathan Behrens <jonathan@fintelia.io>

Currently only PRV_U, PRV_S and PRV_M are supported, so this patch ensures that
the privilege mode is set to one of them. Once support for the H-extension is
added, this code will also need to properly update the virtualization status
when switching between VU/VS-modes and M-mode.

Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/gdbstub.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 1f71604b78..1a7947e019 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -387,6 +387,15 @@ static int riscv_gdb_get_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
 
 static int riscv_gdb_set_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
 {
+    if (n == 0) {
+#ifndef CONFIG_USER_ONLY
+        cs->priv = ldtul_p(mem_buf) & 0x3;
+        if (cs->priv == PRV_H) {
+            cs->priv = PRV_S;
+        }
+#endif
+        return sizeof(target_ulong);
+    }
     return 0;
 }
 
-- 
2.21.0


