Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8903AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F9A206B6
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfYiAQd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F9A206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmwx-0005Ct-7M
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmoD-0001lz-DU
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:45 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:55081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmoB-0003jZ-Rj
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id p15so6122089wmi.4
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LfhnJlD5ICt8SM68uBqo2cJX//28deS2z59iVNfu0PI=;
 b=JfYiAQd/bhekY/nPqLmhS0HWkfBC73prgWUMUtFgcG4iQaQtgGhh9z06CeSeIKwJrv
 4JeTvDoqmZs66JC5j46jngl0fj7oaCR+OwxONsXdAKCTY+itW4wk9i1Ehz/5ayI3vIiR
 7eUDp4LUnwnzpSZIV8QHMdsmdoIMMyfLcsSK0O1X2tpK3AO1rVWIjkBrETRBcECJv0l8
 yigZyxjky+3UXCX5+TXJdd2zRx/jZm15csBXKvSvpZD6J4Mvvsxlg7yDs6d9+GcSwFiw
 ayWWTxhxJ5HsLX6R64kmMWJAMoyfemq9LxzdAWI7yrhQUG7Rtp2WHw1hQaYUcyi2hG9Q
 irRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=LfhnJlD5ICt8SM68uBqo2cJX//28deS2z59iVNfu0PI=;
 b=Bqjo/+V1Luypi0bw6qH1FntGQyQ5iwaB263PVapzgpHZFp3oTwMRS1SQ/8oj1/mmCH
 JeCHyp4wB8YyPiXb+iPirIzTdtBbt7d3UlOpLJSaaHqkcQcMFgUt9ooyoX0wd5IRmE73
 YWR9wU7Y4RpsUmR57UPrI0bBXovEvrY2/MjhhS5Lg7JJDKb8W1S5LYbQq922iu+5TKSg
 HVlDdA0PKTC8dTowGVialNs7BkXJcCcnjirLFig4ufJ/Vxrw/J4CJu2K2w+x7ImiU4mv
 s1zx5lFrIRKjGF85aiCJlLdkjU3oSPaS+MEyG2abIHCjI9DMPuQE/PXo3XwP8Xt1gBx4
 t8IA==
X-Gm-Message-State: AOAM533sVqzgIwFN5hOS4L1v2sAhxDucvqPlsY+rMvA0hRyzDvHFfFSL
 qorfsvSJ76XwHwjI4EO9MzjHXE8CbA8=
X-Google-Smtp-Source: ABdhPJxuGE3erFN1R3CnyNhjkcDeOQbvlhsJ6lxe8pRD9gkn5Yeqh/ay8KId3J23Shb40JAI+v/zlw==
X-Received: by 2002:a1c:bb06:: with SMTP id l6mr8944254wmf.40.1602943421884;
 Sat, 17 Oct 2020 07:03:41 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id e11sm3013725wrj.75.2020.10.17.07.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:03:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/44] target/mips/op_helper: Document Invalidate/Writeback
 opcodes as no-op
Date: Sat, 17 Oct 2020 16:02:11 +0200
Message-Id: <20201017140243.1078718-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x334.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU does not model caches, so there is not much to do with the
Invalidate/Writeback opcodes. Make it explicit adding a comment.

Suggested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20200813181527.22551-3-f4bug@amsat.org>
---
 target/mips/op_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index c15f5c07761..2496d1dd718 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1586,6 +1586,11 @@ void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
         memory_region_dispatch_read(env->itc_tag, index, &env->CP0_TagLo,
                                     MO_64, MEMTXATTRS_UNSPECIFIED);
         break;
+    case 0b000: /* Index Invalidate */
+    case 0b100: /* Hit Invalidate */
+    case 0b110: /* Hit Writeback */
+        /* no-op */
+        break;
     default:
         break;
     }
-- 
2.26.2


