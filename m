Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AE7C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984EA22249
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnungbFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984EA22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuGa-0000Nb-JZ
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu1L-0005bT-C6
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu1I-0003y3-OF
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:55 -0400
Received: by mail-wm1-x343.google.com with SMTP id a72so2331641wme.5
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=RtcPvqNCOS79G2dgK0yUnCFnAWOUpfEt7w3PR2fLO38=;
 b=jnungbFoI3TRJTAOm1lXL+oJp8v28bYk50DK+TFDxmyrpxDGyinyCYnIGY/hozYrfR
 REP3AVhzgVwD01Xj2BcyDDZfXhLAjtqdOYbn63KBb9yD46VPs0HLoswu1YHawSa4/Na9
 optrtuWh4Qct/SzE5Hj0W9VAQWj2hui2EoYG+Kz+a43ER0XQIoOKijsxjAv2Bdp1s5Om
 Cq4brvuzhVGZsSloFRiFO7JZyw/2YVFhLADxkne39f2cz/tiiFr3pUt1cdQqA83rF8XG
 nwkhjY6GQPx/IKydxzN7gVUw0HJhtt/kPtpR5O0l/DxqpLepFZspIpJRFiGpnw4nVpGF
 RczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RtcPvqNCOS79G2dgK0yUnCFnAWOUpfEt7w3PR2fLO38=;
 b=rqNYVmmKHdbWwrRVsBCYxDs2pXnlRmcWYp7HgFiSuti0lEMvkZXYfCR+O4/tWnelxe
 jp8DJCbY2EV2H/0hPPNsZUngHpei3G9AT8UN0uK1kAFe1smBiXqytaH0uAF+w2XucGPQ
 cLo/4HBB+b67PAKk5+p82IFyucZbhMSduWiXS05XFcF3GWLHLUHKICLa5N/TFVEujm0y
 odkABNtgHVCqcpaihAC9a0IfNfIrtUpGwwp+0onoQYnTKjMzad3i4mpq8Yr0H71SMWHR
 PHqMRNl/PQgM/nqdjT0qwiaauRq1l5SVOD84hC+2mEso+8abxVFdgVmiFsxXuU4AD1WL
 1sng==
X-Gm-Message-State: AOAM532oFVYhGFGjr2xYQm10HZSA8zErF+JLSFE/GHT10OZwYz2zN2Bv
 kGLspT5BMl9KDW29nzLcWv/TDhuoGoLJZw==
X-Google-Smtp-Source: ABdhPJxsUd7wY8n9dqYbsAAV3q5oKszA0EtD8PIkdvBxbQH7IC9dR31KqTSHPAo1tayy2QiM40NQKw==
X-Received: by 2002:a1c:cc07:: with SMTP id h7mr3803798wmb.55.1603209470976;
 Tue, 20 Oct 2020 08:57:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/41] linux-user/elfload: Adjust iteration over phdr
Date: Tue, 20 Oct 2020 16:56:50 +0100
Message-Id: <20201020155656.8045-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The second loop uses a loop induction variable, and the first
does not.  Transform the first to match the second, to simplify
a following patch moving code between them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201016184207.786698-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 290ef70222b..210592aa90a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2426,17 +2426,18 @@ static void load_elf_image(const char *image_name, int image_fd,
     loaddr = -1, hiaddr = 0;
     info->alignment = 0;
     for (i = 0; i < ehdr->e_phnum; ++i) {
-        if (phdr[i].p_type == PT_LOAD) {
-            abi_ulong a = phdr[i].p_vaddr - phdr[i].p_offset;
+        struct elf_phdr *eppnt = phdr + i;
+        if (eppnt->p_type == PT_LOAD) {
+            abi_ulong a = eppnt->p_vaddr - eppnt->p_offset;
             if (a < loaddr) {
                 loaddr = a;
             }
-            a = phdr[i].p_vaddr + phdr[i].p_memsz;
+            a = eppnt->p_vaddr + eppnt->p_memsz;
             if (a > hiaddr) {
                 hiaddr = a;
             }
             ++info->nsegs;
-            info->alignment |= phdr[i].p_align;
+            info->alignment |= eppnt->p_align;
         }
     }
 
-- 
2.20.1


