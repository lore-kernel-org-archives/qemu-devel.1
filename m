Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B34C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:24:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7B220659
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="appegyxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7B220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgLst-0004fW-VP
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 01:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agrecascino123@gmail.com>)
 id 1jgLs5-0003lE-KY
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 01:23:25 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:34280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <agrecascino123@gmail.com>)
 id 1jgLs4-0001jd-ID
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 01:23:25 -0400
Received: by mail-qk1-x743.google.com with SMTP id f18so1022200qkh.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 22:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j8VXDASI5aQYEqppOzLmp1wJ4HPP9ZCMyCH9q2Xqdpc=;
 b=appegyxe/FzumERBTA1lRwK/DXLnfNJ4jnDPtZvfzq4ME2EoefOqNzEo12D+VIkWFg
 WmtQUezErwb5Mqfd4mRW5PvTgohFxUNEKaaK4fKSbsv3JEW7BvHTBwVBEA37P9BtiVNc
 PlTDhDxAFIjLLTg7oiYzbd50ViaC5/PS9FgNOKpA4tf++KBF7FwgqwPZwwb27nAyExzh
 znKYDKaT1v4EyeNBkWOMT7UQN4W11pKtRd87mQxWAAuTvuBLy0mveymcVseodz8kqZjJ
 FBBCZ3aRa0jEziY7zWNyAn//Cmr36CSvxjJg+cMOZy52/zReRFrQyuNW8W9PRvJcR22d
 TseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j8VXDASI5aQYEqppOzLmp1wJ4HPP9ZCMyCH9q2Xqdpc=;
 b=TK/jHWGsf8XurWpcVaxxd5pRZlbnpEY9ypRtqXLhqCXD2sR17bOIgIw5Iyg9Ik4Gwf
 Pffdm/VeKN80eg2NkUeqXqGWkoDLlENE3iAAUAG8A7G66QWUEnYJyFxaDbtsO0tKdbq/
 hgjVonivqTDaQeVMlgwIDsaqv+D5il/Anw/hKd+uCx6hteA33fhY3DlqgLw9reuCQGas
 BEAmcdjX+tTuq+ey8wpPMIbhG5QAG96ZVlp7mGOQJj32GPpS9/lySH0+AS8egowthhsX
 oKimiAQ8WJPp8qRHlsFhC+qnE3JQutKt9WiADDMxjXVICmbT7exVLx7+puwSCfK6a8tA
 M1hg==
X-Gm-Message-State: AOAM5302YzORVzr4GYNiDUI/m5elfGeMcdwelc7NIaWkPuF9uYsQBJ0s
 cL13YE8x0KTr48ZxYegr12p7PvJOxp0=
X-Google-Smtp-Source: ABdhPJz7zh7DhS367MPLeHOSbtd8ZU3FdT6B62qtoilEZyBWU86MspwWNQ5/OLA0P4txpJDq9wFo6A==
X-Received: by 2002:a37:8a43:: with SMTP id m64mr9954446qkd.37.1591161802677; 
 Tue, 02 Jun 2020 22:23:22 -0700 (PDT)
Received: from localhost.localdomain
 ([2600:1700:3c90:1b60:a140:f7e4:76fb:39c8])
 by smtp.gmail.com with ESMTPSA id q207sm781577qke.55.2020.06.02.22.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 22:23:21 -0700 (PDT)
From: agrecascino123@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg: Sanitize shift constants on ppc64le so that shift
 operations with large constants don't generate invalid instructions.
Date: Wed,  3 Jun 2020 01:23:08 -0400
Message-Id: <20200603052308.11744-1-agrecascino123@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=agrecascino123@gmail.com; helo=mail-qk1-x743.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "Catherine A. Frederick" <chocola@animebitch.es>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Catherine A. Frederick" <chocola@animebitch.es>

Signed-off-by: "Catherine A. Frederick" <chocola@animebitch.es>
---
 tcg/ppc/tcg-target.inc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index ee1f9227c1..a5450a5e67 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -790,21 +790,25 @@ static inline void tcg_out_ext32u(TCGContext *s, TCGReg dst, TCGReg src)
 
 static inline void tcg_out_shli32(TCGContext *s, TCGReg dst, TCGReg src, int c)
 {
+    c = ((unsigned)c > 32) ? 32 : c;
     tcg_out_rlw(s, RLWINM, dst, src, c, 0, 31 - c);
 }
 
 static inline void tcg_out_shli64(TCGContext *s, TCGReg dst, TCGReg src, int c)
 {
+    c = ((unsigned)c > 64) ? 64 : c;
     tcg_out_rld(s, RLDICR, dst, src, c, 63 - c);
 }
 
 static inline void tcg_out_shri32(TCGContext *s, TCGReg dst, TCGReg src, int c)
 {
+    c = ((unsigned)c > 32) ? 32 : c;
     tcg_out_rlw(s, RLWINM, dst, src, 32 - c, c, 31);
 }
 
 static inline void tcg_out_shri64(TCGContext *s, TCGReg dst, TCGReg src, int c)
 {
+    c = ((unsigned)c > 64) ? 64 : c;
     tcg_out_rld(s, RLDICL, dst, src, 64 - c, c);
 }
 
-- 
2.26.2


