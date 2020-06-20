Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B408C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 04:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49492343B
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 04:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7ANyMbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49492343B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmV1L-0001Lt-5o
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 00:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmV0k-0000tC-4n
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 00:21:46 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmV0h-00056e-LZ
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 00:21:45 -0400
Received: by mail-pf1-x441.google.com with SMTP id 64so5408569pfv.11
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 21:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TAe8KKKkOOFRCOosQ4q8vUyVYs1sY+xLFIIRj01uYEk=;
 b=J7ANyMbl1iQxugBYElm7pahQgEOFNYhNdMmdmEsRwdSns9gHgTUgCrFWmKaZo7rZz2
 lonu0vC4zeRkK7v1NIBPzJlv3JpPph6CWuQ386xsxtRPGKbMxFfVS2qDUdAKswMOoRPo
 3QzqDh5mmCosCimDs3NwgEVxNvjW/uin2l2EKP+Z//2DIBCdHz7PozQJu7ShoNfMuvLj
 Ca81NJ9wMV7c7uyU2PbtBTpyTMw2ydRID3mjohEHxwfOBAa7Z32qXAhjim2vWP1Xybmm
 /0kbD68FrmRVJV7qsudECJjXpv9+KNgT/juBp9walLGHe6ahgGSrgytCfIMgKAHzRH2C
 1pOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TAe8KKKkOOFRCOosQ4q8vUyVYs1sY+xLFIIRj01uYEk=;
 b=fJSLwH/gjMFrlsh37f+Y5k8pwBuE+6UB3b3/GCml5ApKx1Cq82eBDWRLfg4kUc4AZW
 cAIzZLuBiWXSrtCxwR4tD4txCKctbkKiWgTzwdZUXMvVQRDe6puPvygYz4PgFuhLNtDE
 B7ZXqcnkKaiv3ZeOlNLaI8WW3KkM3k8GzH3OrHRZeFGHe73uBtV9EXCW8oO3QYz2gyGw
 EYUV0wAPM/IgeQn5OxSqJhftVsiBeytzeM8zTOsaOExEGwtd1us+XGqukO3iotx3Bqvk
 K78fqs/GH4Fdj+jShmexLGogjVAriiR/YIC5azgFsqUkn2gzZS8HFEEVHdF81DUeJ8z6
 gLZQ==
X-Gm-Message-State: AOAM533h5JfZ11Bc9Iwcg2/87lmWQfzcRB3ih6UeFB7mYuuDoYHY4dxT
 +cO5RckUG1m77QQLJEpuj94QeEGRRvs=
X-Google-Smtp-Source: ABdhPJyxfsFntCJJLXoumwXSOhjppsasqcCDbtk725KlKOWjsmxV4VliFDQ/9cOawaoxJYmkxafm6Q==
X-Received: by 2002:a65:6916:: with SMTP id s22mr5578825pgq.128.1592626901569; 
 Fri, 19 Jun 2020 21:21:41 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y10sm7601349pfq.34.2020.06.19.21.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 21:21:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/s390x: Fix SQXBR
Date: Fri, 19 Jun 2020 21:21:40 -0700
Message-Id: <20200620042140.42070-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The output is 128-bit, and thus requires a pair of 64-bit temps.

Buglink: https://bugs.launchpad.net/bugs/1883984
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/insn-data.def | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 91ddaedd84..d79ae9e3f1 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -798,7 +798,7 @@
 /* SQUARE ROOT */
     F(0xb314, SQEBR,   RRE,   Z,   0, e2, new, e1, sqeb, 0, IF_BFP)
     F(0xb315, SQDBR,   RRE,   Z,   0, f2, new, f1, sqdb, 0, IF_BFP)
-    F(0xb316, SQXBR,   RRE,   Z,   x2h, x2l, new, x1, sqxb, 0, IF_BFP)
+    F(0xb316, SQXBR,   RRE,   Z,   x2h, x2l, new_P, x1, sqxb, 0, IF_BFP)
     F(0xed14, SQEB,    RXE,   Z,   0, m2_32u, new, e1, sqeb, 0, IF_BFP)
     F(0xed15, SQDB,    RXE,   Z,   0, m2_64, new, f1, sqdb, 0, IF_BFP)
 
-- 
2.25.1


