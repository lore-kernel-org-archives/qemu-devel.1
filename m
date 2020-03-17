Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63FAC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 805B42073E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUEYm0Gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805B42073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFVx-0000Oo-Ih
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCn-0003z4-Hg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCm-00045K-5y
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:37 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:38015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCl-0003zS-UZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:36 -0400
Received: by mail-wr1-x429.google.com with SMTP id s1so4826255wrv.5
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mfXBsBn9LUhSN6WgjaxZSay9usosB3zq5/7Zod3QK24=;
 b=QUEYm0GvgtCTNgoqFK+49ALq0djvwNFe8r0Xv+LW/Ri4C19e9ps7Z2wAGtxu5r//9f
 ROkmA6VWTsMns3NN2D+6Qs/V5K63h/AxbvmhP5yfgwePIPfFScyJu3flpVE3r5s0ivsF
 zyHvRq6AKPieVIR50GBCat0tnwWvr3obgCG5jVMtIQWCWtGQnZG5a636A3GX2+vut1i9
 mggir+p+4M1U7/gldFuJAfprah/nWk6zRgQ74PRlCekRYFOOPHI3esHYstiM4GpGutfl
 bvHBsBC1IACsMAnnIAtwxTvkBF8UH1FtIRRhd+RxTshfyK9VdWZr8+QXaYVIK3vHAbaS
 A9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mfXBsBn9LUhSN6WgjaxZSay9usosB3zq5/7Zod3QK24=;
 b=EZwKcQbcKhOEJOlyFY4PokuAf3w4zpgJG6PWlN3suTRWbUVG/QCqi2SL8uuUJHMLgH
 cj0LgRfbSt0PrJLSoBuY7f80B3B3ri5MhNuCuMeCTa7uUcS7R3vPx01wdg+tYsxM4QID
 yv2AvqDPaAgPgA4OjMuNLlO2g2O5H2viXB3Png0bikIk78ft2iG/Bg98Dq/of00H8Wqm
 a32z93itv/PyXaQNcMNb4+41qxv0VYemlfUgNizMzVutUvsupGq7lCukjnxZVFP4ZMLr
 IRktO4+PwUq/8WfDL8y+S1exwB57Fcej2tq6GybZiVpNSQnCsid7fNn0LJOehVE1rWwf
 PqbQ==
X-Gm-Message-State: ANhLgQ1tXiPzUr+qZMmWb6aBwCIYP2kgFR9z2Iz6ucJIaeRK+CsgOG9a
 LafO/3fXUEmu1/FWoHUrylalSYku
X-Google-Smtp-Source: ADFU+vu8MQpL6fMH0lHScUI41zm4gGAnlcUOc+fKFS+r6hLbYszFO5ukKdhCg6U/BkJPmU061awhhQ==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr7085696wrv.104.1584462994353; 
 Tue, 17 Mar 2020 09:36:34 -0700 (PDT)
Received: from x1w.redhat.com (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id b202sm4618697wmd.15.2020.03.17.09.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 09:36:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/13] target/rx: Dump bytes for each insn during disassembly
Date: Tue, 17 Mar 2020 17:36:15 +0100
Message-Id: <20200317163616.30027-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317163616.30027-1-f4bug@amsat.org>
References: <20200317163616.30027-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

There are so many different forms of each RX instruction
that it will be very useful to be able to look at the bytes
to see on which path a bug may lie.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190531134315.4109-24-richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/rx/disas.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index dcfb7baf99..6dee7a0342 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -102,7 +102,21 @@ static int bdsp_s(DisasContext *ctx, int d)
 /* Include the auto-generated decoder.  */
 #include "decode.inc.c"
 
-#define prt(...) (ctx->dis->fprintf_func)((ctx->dis->stream), __VA_ARGS__)
+static void dump_bytes(DisasContext *ctx)
+{
+    int i, len = ctx->len;
+
+    for (i = 0; i < len; ++i) {
+        ctx->dis->fprintf_func(ctx->dis->stream, "%02x ", ctx->bytes[i]);
+    }
+    ctx->dis->fprintf_func(ctx->dis->stream, "%*c", (8 - i) * 3, '\t');
+}
+
+#define prt(...) \
+    do {                                                        \
+        dump_bytes(ctx);                                        \
+        ctx->dis->fprintf_func(ctx->dis->stream, __VA_ARGS__);  \
+    } while (0)
 
 #define RX_MEMORY_BYTE 0
 #define RX_MEMORY_WORD 1
-- 
2.21.1


