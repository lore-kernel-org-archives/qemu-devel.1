Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A983C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2C220708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbEaSj6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2C220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqn5-0000HW-4j
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jsqec-00010s-1u
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:41:10 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532]:39179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jsqea-00058e-2g
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:41:09 -0400
Received: by mail-ed1-x532.google.com with SMTP id d18so33419468edv.6
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PGU7dWoVIz4tYYeC6s1zofBWZC9jCGKi7Dk/esJJ5mo=;
 b=LbEaSj6Pqtr+8JukoLUb0hpBPFhV38PtnaGb03LnnhDE8f7TeObrJuAEFCgNerTdt6
 UQVd8gza1h2WwuF4LtjYoa+H3kKgC4uVJgrh3RxXwBgpv1X/nrX4Qr4AWbIo/aVPpiYF
 qUSWjpM2jDsRssVm5Yz8aw7/wt2hN8MmVZDacWWIC2DsPzSFW39gTBk6X7Kr+6uBNRqU
 XP/eA6S+M2W1cV8CGEgrnyDnyMHq/psqTjqg0+OIbSu6SHFPLN+l8qvKysR1jpbCsLrt
 cfEqNRYMG54FHFZWokQYaxFnGyGTrvcVwfy+kkq4ReXprcYl35wPa3JqjOFkBWQVHGM3
 j+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PGU7dWoVIz4tYYeC6s1zofBWZC9jCGKi7Dk/esJJ5mo=;
 b=p+hwgP79aEj+btzWUPs59bUHzvYbP0eZS97xWiCqNjjoA9Krk6Wrn0MO5gCvV86AH0
 eC0eV4u4W150jIsUhTeJE9ak0E/uBS46BZMjP0w3QZUtw1rE0TfrcB2ewZI8HNd14c52
 BK+7yLvsf1AI+3PTIMsKZRkXht4XbxZtOmFvEzQgLQM6iTASebmy5tF8oXvNRRXexASc
 MimUQAgjxCzUZhcrNnqpWyWaiCRyC2rAToRqj8RRB5K05d605Nx5GxKH3u5PPrqMtuEp
 DVemu28QYMcvjRXYSz8w/worcw0RIYs96HlrfDyYtJRliDL8RnfP80O7ivHn5dTz8Zfb
 ffyA==
X-Gm-Message-State: AOAM533Cv/Fx/EzUMBr+6+SOJMXk2PcSsaaZElgWNSfknfyIAK5a4NcG
 mmerUGChXglrBJNixRncKebThxEI
X-Google-Smtp-Source: ABdhPJwwYtEu6vbzoSm6GE02fLygW+KJLUEQ0vkG0VRAIcVaZxY68ysw0LLeZmqIlqHePjMytd1fKg==
X-Received: by 2002:a05:6402:1614:: with SMTP id
 f20mr60041647edv.129.1594140064986; 
 Tue, 07 Jul 2020 09:41:04 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 23sm26428065edx.75.2020.07.07.09.41.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jul 2020 09:41:04 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 1/3] target/mips: fpu: Fix recent regression in add.s after
 1ace099f2a
Date: Tue,  7 Jul 2020 18:41:00 +0200
Message-Id: <1594140062-23522-2-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594140062-23522-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1594140062-23522-1-git-send-email-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ed1-x532.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>

After merging latest QEMU upstream into our CHERI fork, I noticed
that some of the FPU tests in our MIPS baremetal testsuite
(https://github.com/CTSRD-CHERI/cheritest) started failing
It turns out that commit 1ace099f2a accidentally changed add.s
into a subtract.

Fixes: 1ace099f2a ("target/mips: fpu: Demacro ADD.<D|S|PS>")
Signed-off-by: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200703161515.25966-1-Alexander.Richardson@cl.cam.ac.uk>
---
 target/mips/fpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 7a3a61c..56beda4 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1221,7 +1221,7 @@ uint32_t helper_float_add_s(CPUMIPSState *env,
 {
     uint32_t wt2;
 
-    wt2 = float32_sub(fst0, fst1, &env->active_fpu.fp_status);
+    wt2 = float32_add(fst0, fst1, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
     return wt2;
 }
-- 
2.7.4


