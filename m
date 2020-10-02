Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66450C35257
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E8E20719
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUcdYUiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E8E20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOTCb-0002IS-PU
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 18:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOT60-0002e1-Qg
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:00:08 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOT5y-0007P2-UV
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:00:08 -0400
Received: by mail-ot1-x342.google.com with SMTP id y5so2877440otg.5
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 15:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=alZjlQJXj3PE/fgiElfGG8lmZ092HOwXFHnkKr7NfsI=;
 b=eUcdYUiSmOLmvla2rtrnuoi1pzh744TEe44bOlVtAgw8+NvZVdc2bXArY7DuelD04O
 w7HJZP/pzKf6r1dsQao0tiJrRHLfWnjkwC9uc3QH67sWTA86DEYlJz067luFaKvLq7OL
 sJ1ClV6tg7+8TeKee3hbBrH/fLpIIPmY6Zeo/R/f0JhoCXqpgxfDXWJAvoKdLQ06RDim
 m73XpI/AbFBU4Mr7JYbL3np7yJrPRPg7UP/+8b2ALXAS/iZrJuAi1RHCcwiVmpEPZU35
 LYwO5bryl+f5gtz3u5Hz5jn2ilyeBJbwm4qOrtsRlwOIzApbvwuEgkaXL3KKJut8s7Tm
 sBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=alZjlQJXj3PE/fgiElfGG8lmZ092HOwXFHnkKr7NfsI=;
 b=tGGXb+55+HQounVAC+A23dnzfpv/8FqyVfWCvgL0/1drXc7oNL0IXvenSP0nm4s/lC
 0kRbFwWowUj7LecjtuzWETq8Hsc/efvO4+slii2ZMkV6jIpguKLkKEIbKYuWCeAb0Ulz
 2Q+cyNpWjKqQ79JOfE7dprOJ0o3ovotpUkiMKGqnVEtFkmQnWVMLzt/N82491EemwFpT
 NiPeR9agBom5elwM2FMK1fDPdFVhxr60DA4pFW60qg6yYMjlZOWpgr2ElSHt5Dtw/AAj
 WGXffOpiRv/a+vaTqIpj7R0wkTYz2zGXp6CcNRWwsyianNADBMgyuWTwwUu7teJu2GLe
 oiKw==
X-Gm-Message-State: AOAM533peehMGX1sN5PLBYU7c18YAy/BN/hz3/D84kUcOkwy1ggjHVci
 ghpZTsaO+fEHL1LoqO+C18EBb9tCQMGrm3QA
X-Google-Smtp-Source: ABdhPJzAwkqMnyDkaRt2Hhi7hKZSwOFDBLSrdfxuy2ZLAyLSRw3vxCSGx7WK8zk2WM+41m87kzuNww==
X-Received: by 2002:a9d:a24:: with SMTP id 33mr2921358otg.305.1601676005510;
 Fri, 02 Oct 2020 15:00:05 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id k10sm684268ots.60.2020.10.02.15.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 15:00:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 5/8] linux-user/elfload: Adjust iteration over phdr
Date: Fri,  2 Oct 2020 16:59:52 -0500
Message-Id: <20201002215955.254866-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002215955.254866-1-richard.henderson@linaro.org>
References: <20201002215955.254866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The second loop uses a loop induction variable, and the first
does not.  Transform the first to match the second, to simplify
a following patch moving code between them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7572a32a30..735ebfa190 100644
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
2.25.1


