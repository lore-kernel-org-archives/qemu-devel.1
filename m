Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910C5C2D0FA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61136206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J12+pN33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61136206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYp5w-0008SA-JL
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 06:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYp1L-0000XT-D1
 for qemu-devel@nongnu.org; Wed, 13 May 2020 06:53:51 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:35038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYp1K-0000QB-Je
 for qemu-devel@nongnu.org; Wed, 13 May 2020 06:53:51 -0400
Received: by mail-lj1-x241.google.com with SMTP id g4so17264457ljl.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 03:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sGqFZp4/8DHvwZ4dwcHeJPKSRCfhEUhOLVb+pJ0fcYc=;
 b=J12+pN33wM5Owx84NBMNCQH6a9Mig52SeRRTD6DHQ8SZNkMLwcv7BhoTXGqhfxrgPX
 7F6GBRVRn7M5D5239EYd3ak84BM6oSFCxje9KvHvRHKmEG6sgEjEfrDcrb3HpSUzy2WM
 hyh8K6WJWSs8vC6VD1DwBXmfRBGEtM4FbJLEeZP+npTpOoC9nBItyd11HnrnhWRF1ngB
 Ct4mTqomqr9KivtWtu8TttMHGP6MSLmNAH2gP2voFTXcfOkzoFTr5tn1odPTpa9vDq4U
 kjeJpZPGSW68CZP4GTYeaSborfpDf4ezXhIBSh63Guurop4fdKkeEtxAlO6FgBHpkx2n
 jkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sGqFZp4/8DHvwZ4dwcHeJPKSRCfhEUhOLVb+pJ0fcYc=;
 b=NWqqP92JkV+Gj40gWfl/7AhVbzqwvbxrzEIgmW1eybMyRITGERBWq11OJdeLZ18Drt
 KBQnxhgyLejbyAcR1Lg/BdgKokcPBpMLYlRhWheu3gtWpSqrKErOgr1xCamh6nQct9n6
 vV28S1ACgHjb4BfZTPpTOvHzpFOQzHhY9YOz+vFLKrr8fAiYrAXrmmWfq8jk9s8ZtAMD
 TljCJov7DcikVLseITNvamuaKzLSGE9NaZLJBLbITOxnesOo8Ut92G+aUCFDVs5+PBfe
 Wc4OgI04X8jSolZN7KHZsf8fR/f7a2AaZAY0QJD4sCrPRgGCAvnClBkrJQzbjoS6fOqO
 M8zA==
X-Gm-Message-State: AOAM533iu+YNqwjyDYnSQe63TQwaejwf8v7qiOmjcEaRmkbx1QlGD170
 shCPnZnAakQ+afYpE1t9ihCza3+cEkI=
X-Google-Smtp-Source: ABdhPJzXznTWu9qTDoKP4xzQ2eY1sL6N9BEexZWq1FH2nuxSSoGhasi+WcHFEbEOo/OfwFhdogwejw==
X-Received: by 2002:a2e:3813:: with SMTP id f19mr16627059lja.216.1589367228882; 
 Wed, 13 May 2020 03:53:48 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id z64sm15749417lfa.50.2020.05.13.03.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 03:53:48 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/12] hw/mips: Convert Malta "ifdef 0"-ed code to comments
Date: Wed, 13 May 2020 12:53:07 +0200
Message-Id: <20200513105307.22638-13-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513105307.22638-1-aleksandar.qemu.devel@gmail.com>
References: <20200513105307.22638-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x241.google.com
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
Cc: aleksandar.rikalo@rt-rk.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The checkpatch complain about "#ifdef 0". Convert corresponding
dead code to comments. In future, these cases could be converted
to some no-nonsense logging/tracing.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
CC: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_malta.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index e4c4de1b4e..f91fa34b06 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -427,10 +427,12 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr addr,
         break;
 
     default:
-#if 0
-        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx "\n",
-               addr);
-#endif
+/*
+ * Possible logging:
+ *
+ *        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx "\n",
+ *               addr);
+ */
         break;
     }
     return val;
@@ -515,10 +517,12 @@ static void malta_fpga_write(void *opaque, hwaddr addr,
         break;
 
     default:
-#if 0
-        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT_lx "\n",
-               addr);
-#endif
+/*
+ * Possible logging:
+ *
+ *        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT_lx "\n",
+ *               addr);
+ */
         break;
     }
 }
-- 
2.20.1


