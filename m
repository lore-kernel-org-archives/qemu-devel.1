Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED43C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066F82310F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDuWQ0W2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066F82310F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xy2-0005AC-7r
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1k6xqe-0002tO-HV
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:11:56 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:46083)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1k6xqb-0000Wk-Ru
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:11:56 -0400
Received: by mail-qt1-x844.google.com with SMTP id o22so9154511qtt.13
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QM//LrDWGGGhJjEJLnCRBQiCm5i3PZw6ntawugMtwbE=;
 b=RDuWQ0W2ArdnCj026iFG7RlRS5XaBFyPwXjaiIwm8G1iS3CL5Z/BrzmRExHudpMvVj
 SOF/mXhB2pLFMMBbwcqTjlZZCA7IlWjAVOK2U6waMfow+Vpp01bB+xoyEu8fv27x8rWw
 +wDWMskb6LLb844A9wFuJePwANbnWCnZvV0odPW9++tBQ+5J65esYrVOrgSI6J0Wi5Uh
 dXjuH5xTpX8Rvj/r8pVA0VHobQixYyoQofaVgdXKsCZiHF2I6vM/mlNzbfKFm6UIIGh6
 RcFrJgBydcAdx/zmU+1VDFBHyn12N9yD+sqWmfVLE9x9iG7b7tI7GNrA4qUDa2bWX8pl
 ntzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QM//LrDWGGGhJjEJLnCRBQiCm5i3PZw6ntawugMtwbE=;
 b=ZjUFb+pjl792a05HzcN3bJ/Wl0YivB+z5a0ViJ8qk0VKQa3KlPYCa3ktsVLJYv9z5g
 304Zw0zeVrhsd3KUR3BmcREvbsL5z5XxsCj2oVG2M3pdWQIA6mm8fVIqa4oRDSVNhKzJ
 KZSEI23lT2H92nfjMfe9arijhjL2dl2TlqPFMSs7zXUYxOyxk/qmq2MdhYrrZu8BMmuO
 z1VgS0E2rYtzItIN+/wOQx+vrgszWPzGR5EXU8x/btitMnIp5emCxexYLWhFfWYR/Eej
 D60mKXAOF8Z9wANM6vL4sYnBtBOqWafQ5/4BriabyGmS3/0wldECuVVDyPA1qqu8F2kb
 EZIw==
X-Gm-Message-State: AOAM531e6b2eRmRXIPDaY8+0LAbggETfcORfNA+itc0s1ItVML5zf3qY
 49DVwpz9OaWdqaCFkeZ62pFGpx6qUzIFiA==
X-Google-Smtp-Source: ABdhPJy0N0CclBWwtH7XYQ9RtEprpyRe2NL5o9AhkD08/CACS9PtUan4RK7SCVnrNU9bjk+8C10IOA==
X-Received: by 2002:ac8:520f:: with SMTP id r15mr6753561qtn.116.1597504312313; 
 Sat, 15 Aug 2020 08:11:52 -0700 (PDT)
Received: from ubuntu.localdomain (pool-108-35-56-31.nwrknj.fios.verizon.net.
 [108.35.56.31])
 by smtp.gmail.com with ESMTPSA id w44sm14203233qtj.86.2020.08.15.08.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2020 08:11:51 -0700 (PDT)
From: Rohit Shinde <rohit.shinde12194@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Fixes: Fallthrough warning on line 270 of
 qemu/qapi/opts-visitor.c
Date: Sat, 15 Aug 2020 11:11:48 -0400
Message-Id: <20200815151148.10571-1-rohit.shinde12194@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=rohit.shinde12194@gmail.com; helo=mail-qt1-x844.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Rohit Shinde <rohit.shinde12194@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added the fallthrough comment so that the compiler doesn't emit an error on compiling with the -Wimplicit-fallthrough flag.

Signed-off-by: Rohit Shinde <rohit.shinde12194@gmail.com>
---
 qapi/opts-visitor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 7781c23a42..43cf60d3a0 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -266,6 +266,7 @@ opts_next_list(Visitor *v, GenericList *tail, size_t size)
         }
         ov->list_mode = LM_IN_PROGRESS;
         /* range has been completed, fall through in order to pop option */
+        __attribute__((fallthrough));
 
     case LM_IN_PROGRESS: {
         const QemuOpt *opt;
-- 
2.25.1


