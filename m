Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92EBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FC9207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sNLIoDgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FC9207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTUmT-00063s-89
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 14:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgS-0000VI-0W
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:32 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgG-00026u-Cp
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:29 -0400
Received: by mail-pf1-x444.google.com with SMTP id w21so1987334pfc.7
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 11:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/PhyfxonOHMia69Uhhz8aFrAtnkrEZKYG1wmZQKttSI=;
 b=sNLIoDgxTpluHbWkpp0asVN19lAwCAgynZMkI8ZMUh8GMo6c0PfhLUbY4Td+mRPYEr
 +r6fPFn3dlw4c0tsT3mKrRNZeF4kvkH7zJXCslIeRh/ZEkAU5aTzD1zduPujDyXAh5FC
 MtVryWDp7mRaBlMknHDT9jfFwmhcScD0gHQ71iZjCxKKX7mpvkaqSuvX1y+jdfQyhjSu
 Isqf9znWrtxMwwbHfMiFxXZ/pFWmCxhwUpBg+esvOpA5WX6aiQ+MlQWpCnXbitqcS6hD
 Rg49QGoj5SyIrBvwJqXZUQqcmkY0lknuFwsZ1SXrN4JIo3m9xQDLUhDPn2T9tRMpSc4m
 VY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/PhyfxonOHMia69Uhhz8aFrAtnkrEZKYG1wmZQKttSI=;
 b=VCxoYPKzJbxaCy3UaJVDb9I481zKSQaLT66/ViZQ9hRcDicfJ4UXxdNRoaD5sKSxMz
 47g39uRTr9kYd+Z+aR/6Yghswd1Owx6qka5G/ysByWG8efHNdpeFKy66kg11lapaisYr
 8X/BgRGcEsMv31E8ywajNnEXit9wU6sfUQqkBo9YnTNOQn7vX6o+UstMyUJZZsCwuXsd
 fy0otSz4zUJsuB+nUgpxzDPFGf/XyKEarV1z3gvJHDtePRPwwatuMwK22jqP9ZOWAJZM
 2nd4P2T842zwZISPfHZAK+YNdxza7jzOD6rEyuKmDKf60h7MWvEm+kZ9Ty4LGiHv+x+u
 DqNw==
X-Gm-Message-State: AOAM530rxRgvLTUDpKBl1HEs90OSxujYkK8EXpRkiSl3IasTiLTO7MAf
 tlPT9NcQkMxQdmBhk6JP+GWiM48syDHaUQ==
X-Google-Smtp-Source: ABdhPJzrv+6PeNDYtLb8YQEIYw1XJoNkudToEiPoF5XvPNx6dqfN7ViMuLo35wCuTQQMvISDVr57hw==
X-Received: by 2002:a62:6dc2:0:b029:152:637c:4cf5 with SMTP id
 i185-20020a626dc20000b0290152637c4cf5mr4974356pfc.15.1602873737369; 
 Fri, 16 Oct 2020 11:42:17 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c15sm3426011pgg.77.2020.10.16.11.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 11:42:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 05/12] linux-user/elfload: Fix coding style in
 load_elf_image
Date: Fri, 16 Oct 2020 11:42:00 -0700
Message-Id: <20201016184207.786698-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016184207.786698-1-richard.henderson@linaro.org>
References: <20201016184207.786698-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixing this now will clarify following patches.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 1a3150df7c..290ef70222 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2531,9 +2531,15 @@ static void load_elf_image(const char *image_name, int image_fd,
             abi_ulong vaddr, vaddr_po, vaddr_ps, vaddr_ef, vaddr_em, vaddr_len;
             int elf_prot = 0;
 
-            if (eppnt->p_flags & PF_R) elf_prot =  PROT_READ;
-            if (eppnt->p_flags & PF_W) elf_prot |= PROT_WRITE;
-            if (eppnt->p_flags & PF_X) elf_prot |= PROT_EXEC;
+            if (eppnt->p_flags & PF_R) {
+                elf_prot |= PROT_READ;
+            }
+            if (eppnt->p_flags & PF_W) {
+                elf_prot |= PROT_WRITE;
+            }
+            if (eppnt->p_flags & PF_X) {
+                elf_prot |= PROT_EXEC;
+            }
 
             vaddr = load_bias + eppnt->p_vaddr;
             vaddr_po = TARGET_ELF_PAGEOFFSET(vaddr);
-- 
2.25.1


