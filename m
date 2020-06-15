Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739E2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36AF620714
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkN6RRwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AF620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkutN-0006h7-Ew
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkun7-0003P7-0K
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:29:09 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:32899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkun4-0004j4-HP
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:29:08 -0400
Received: by mail-wm1-x331.google.com with SMTP id j198so695888wmj.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jE8JvQydKxf3dwKq+zWv/gv8SCLrHEfNtQdT23/Agqs=;
 b=RkN6RRwW1rKBaSuS4a4vGBPtE88VRDWdFc67UxXWIONuFiTS0EL0ZSOGfpcATVhN/3
 FUO5KTZuK5lj24TJqAPuXcP90vFLeT50ObRR5Xf4X3dqX1yHb8shVssyoRXbNBa5t0UX
 2RS0vXsMW9T2IKT+4apdZl9Qdfat+h2VmsfmwKXxCM8Umx3ftFuPKOoJxnxHwdisBx0k
 ri28kfdIP4XmWjTHMBFW10S1NQf/64IYdE11bg/547j2VqozCSYLXhvkEZejvn94iTSU
 PR9f/aVbODuM1OrrHN8w83asR0l0+aKcu8R3bwb8Iuve7FB9pY3Z7OWICYltK2unOvnj
 1meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jE8JvQydKxf3dwKq+zWv/gv8SCLrHEfNtQdT23/Agqs=;
 b=lG4J0dOXYQ76STxOlwwrusDq/3qln+t+/AkQ3NDshX5N17blMTOpIW9QqSat6NJQ9U
 c+SCIKQvD+bSC2mx0fK3pjTCgrqbrtL4bE7csVMa5N77DKwv4AzAB4F/xD60zw0cT4zt
 RM9V2bx2nj+t1dw0QMrD56b4Ms/SQhaiRrbMAdT4zQS0dnuPJsdz+o4xrsB3dIughHmE
 yvCr/oHUFsp5i//Xl3L+6mJisp+CVKHoLZ3MSsoBiajk/wDHzG0wCYWrGVbabRMvrIll
 L7cDObNshK37DKdjOsET8Ha84DHJqas/R8oTlDU6S0vUPp6JrTOOkz+QIcXwYH3LoYBu
 hylQ==
X-Gm-Message-State: AOAM531eEZ1XWj/6fyqfhmvw0UQJ5fnDzEK+5u9JTdtFo49p5DseZPXV
 4XhgdvTxvxL+V9E9jlNaTHa4/mUw
X-Google-Smtp-Source: ABdhPJxyL+Vh3ACPMZ/XcTfdlyjioR0zeIJM2c++fuTQt1aMZxMlCyBEF3K3/SDowQ47FCmCGPLMPA==
X-Received: by 2002:a1c:a403:: with SMTP id n3mr872145wme.2.1592249345047;
 Mon, 15 Jun 2020 12:29:05 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 138sm713098wma.23.2020.06.15.12.29.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jun 2020 12:29:04 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 02/18] target/mips: Add comments for vendor-specific ASEs
Date: Mon, 15 Jun 2020 21:28:44 +0200
Message-Id: <1592249340-8365-3-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592249340-8365-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1592249340-8365-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x331.google.com
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


