Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66833C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA5920756
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGCOJMSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA5920756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkujE-0002ov-CZ
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkugv-0006KJ-Dt
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:22:45 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:35330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkugt-0003oO-RT
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:22:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id q25so743264wmj.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jE8JvQydKxf3dwKq+zWv/gv8SCLrHEfNtQdT23/Agqs=;
 b=GGCOJMSORxNrYG2ROAPqL1ki3zw6aKsrVAKebZl4ociOSkGzyhVU0tMsnYZxWHgXC6
 YzbExJnjOXyQDVofhik2cL5SN0h7r04Cij6p5YRJ5hakY8p+gIeOz+AiUwYKHe2jDYa0
 02Nxa6cLh2EUcIiafhIl5ee8o9P9dMTZ+M3Wjx4yKIx6nfqxhJxP3fE6eevzqmHgynGa
 fwmfv5EmDcckaGSbtMnm6HdaqGSsGjaihQwtG2XNMaDx9OCiZy5i0mkdBqal/0mOwUZ5
 hIB0UpGBXTbXEmtCI76dnDVr+hByksKQpzorsrS66/7BExgljS8QkLj1Gg+IPWLSpPys
 fyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jE8JvQydKxf3dwKq+zWv/gv8SCLrHEfNtQdT23/Agqs=;
 b=C/yXcz04GTbHyW6zGJtlbPbjFiZWD/Z/ktyy5AF6u2JKC+aAnuMkhCUXxxQ/AO0QTV
 VPQn9wqowOZvVKOX94JWrer533V0Ai/AqRibTs1FKi2RfT3+pdw91qqWY/gxvdUuZ6Mp
 5SEfRypQR9wKCXhZ1KOTxRqSstfUCRRwlgj2H1bxZd8AvpmKaqUAARx7XkxK1jiMigXO
 r0nMOtfmgXaWw+HgFPJzU9cHXxB/u/ASi0i0qe/9D3pl3L5TkwHGkDxJuW79GB8BUNdg
 bU9VamBSmza1vuBxqe+D8+nzMiKz0m7rJM7+E2PICXJuhIPRDqjsIAB25jjKc/IhkYqK
 wpbw==
X-Gm-Message-State: AOAM530c0DrRqlDdBF4k7vITCh0yQP1j+z9IkjjrxN11cVeAypolmkR6
 jZTySR3uxFr8qjZFX0EpM6m73szL
X-Google-Smtp-Source: ABdhPJx+vIpyVS9yQx3sMzTc4xE6VnChUx4j9drkno9patPg6xb74iJh/YbFM20MsMfPRSuFAgJevA==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr880159wmc.142.1592248962353; 
 Mon, 15 Jun 2020 12:22:42 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 50sm27823909wra.1.2020.06.15.12.22.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jun 2020 12:22:41 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 02/18] target/mips: Add comments for vendor-specific ASEs
Date: Mon, 15 Jun 2020 21:22:17 +0200
Message-Id: <1592248953-8162-3-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592248953-8162-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1592248953-8162-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x336.google.com
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
Cc: aleksandar.qemu.devel@gmail.com, Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Abbreviations of vendor-specific ASEs looks very similiar.
Add comments to explain the full name and vendors of these flags.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200614080049.31134-3-jiaxun.yang@flygoat.com>
---
 target/mips/mips-defs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index f1b833f..ed6a7a9 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -57,9 +57,13 @@
 /*
  *   bits 52-63: vendor-specific ASEs
  */
+/* MultiMedia Instructions defined by R5900 */
 #define ASE_MMI           0x0010000000000000ULL
+/* MIPS eXtension/enhanced Unit defined by Ingenic */
 #define ASE_MXU           0x0020000000000000ULL
+/* Loongson MultiMedia Instructions */
 #define ASE_LMMI          0x0040000000000000ULL
+/* Loongson EXTensions */
 #define ASE_LEXT          0x0080000000000000ULL
 
 /* MIPS CPU defines. */
-- 
2.7.4


