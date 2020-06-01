Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429DBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B8F20679
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4rwZP0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B8F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjQk-0002bS-7w
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjOb-0007uW-RR
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:18:25 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:45733)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjOa-0007mI-VS
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:18:25 -0400
Received: by mail-wr1-x42f.google.com with SMTP id c3so11217889wru.12
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=//oQPQNfOG3Cowa0+33C2vqPBy/QAFTT+RnBfWuuERs=;
 b=P4rwZP0ur4zLD7xp41abf8XXhYkcQoSJMaTcob0POFfaQ66U9jPZFPthTvSoejU1PP
 JpcM0tvnQjyLLiHWoVhCQ5d+LEpNkDgNpwzP2WCbwtjGdwVvkcPMfiEoy7p1uUvzqYsu
 C/x/p7SUH5PX/3GuCsAgpvLrOl+b0TE5M8/QbPUnCJ8h4tR3E2cPsmIMZJdJ0LlfMvZR
 9ICnMxre2peDpk1I7NZC6R5YVPQAUKitJejNyRAMO3cdmHl4YlrfKfP2RHHWe5Lf1D6M
 yN9BIrAlKaUWeRIhqQXEXJWR10oDri7wlLZ8BSfIMDhzR1fZKygT12QPFzx3cBtZC1lQ
 xWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=//oQPQNfOG3Cowa0+33C2vqPBy/QAFTT+RnBfWuuERs=;
 b=XIGMRXlNH2tf80gI0TLu9E5mXa+EhSy9qq/q0X8qpka8NRTNPK9q1PCllS6AeNlJzC
 vv7/Wdw9+6aObRw8Yf+Fb0N3u9BTfuj5rxr+cpnHlnU7vc1qtQ/V9k7xR5Z8jzPINk6l
 6OfLUQ8JvfFuv8RcxyzGdRjd9ErJURhrveHjstU+4/enf734TsTiECXF3O/2Jy7Ci+cJ
 J8WdunLg6ENqzYQ3GfO2Z5ox4/Izb8ZQ6KMpH0ms1Q0ObHP8J2nouTAXxAICEndWFv2N
 Jky2V/to+MnmHKk0k3WP9HPlDQOOWG6ibv/V3kp+8IGEZLpYoArxGR+FYOR/ZjmHLpTH
 Lxbg==
X-Gm-Message-State: AOAM532SsLKsc7Gnn+ClYKZHUDKjCzCLonb2dOIlgY55gSnS3943z6oh
 I6YZ8iZSu1Q2jTfHi3qEO36Ur+Ee/6A=
X-Google-Smtp-Source: ABdhPJwB2Zl8eZZ6wTr5rr7MyjfG0ANnNJOYawulcPiP+1amrvn6/CfknQs165lHS+dhQF74+o2Sjw==
X-Received: by 2002:a05:6000:47:: with SMTP id
 k7mr20638875wrx.233.1591013903545; 
 Mon, 01 Jun 2020 05:18:23 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id y185sm12332136wmy.11.2020.06.01.05.18.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 05:18:23 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/6] target/mips: Support variable page size
Date: Mon,  1 Jun 2020 14:18:17 +0200
Message-Id: <1591013898-23391-6-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591013898-23391-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591013898-23391-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Huacai Chen <chenhc@lemote.com>

Traditionally, MIPS use 4KB page size, but Loongson prefer 16KB page
size in system emulator. So, let's define TARGET_PAGE_BITS_VARY and
TARGET_PAGE_BITS_MIN to support variable page size.

Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
---
 target/mips/cpu-param.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 308660d..9c4a6ea 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -23,7 +23,12 @@
 #  define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 #endif
+#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 12
+#else
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 12
+#endif
 #define NB_MMU_MODES 4
 
 #endif
-- 
2.7.4


