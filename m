Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17111C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 04:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75572067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 04:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2O0E7ki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75572067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgLJu-0000BI-4v
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 00:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agrecascino123@gmail.com>)
 id 1jgLJ6-000834-Vn
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 00:47:17 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:47009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <agrecascino123@gmail.com>)
 id 1jgLJ5-0003U4-Je
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 00:47:16 -0400
Received: by mail-qk1-x741.google.com with SMTP id c12so895332qkk.13
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 21:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version:signed-off-by
 :content-transfer-encoding;
 bh=s6+YMUuVhhNWxmx7LyIpHPOkYQWcY2ok8nyPrVicrec=;
 b=h2O0E7kil0cg6g4QGkiLu6WIjKKpeYgWErTJSBcX5nMOmhtR71G/BxImi3mrywf4VE
 aaDA/Wv9jz81b9tDWkC/kQNhn/VgVQlSZIWE2r+uSDxIIsnB4OYZLzyGGSg/LRgHBnhc
 /D2mXC7fbqOMDAOp0OLOoCrVpto7FKqp3Uc1ryP9MKAaEashTRQnEJcla2Kf85IcRt17
 Jh6nGOTOV2RL/P3+h+WBVpwZDJ0b7AUuTUfdSoXGipPUqeU1KjO6kOfWXq0J4Jf6X66l
 dwKn56fhWxlobLfwJ1FZqqMPIxMqId/U0kPSXkfDVnEVDy90cmZN5ebPuZwoD2NMq4RH
 FBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :signed-off-by:content-transfer-encoding;
 bh=s6+YMUuVhhNWxmx7LyIpHPOkYQWcY2ok8nyPrVicrec=;
 b=IMBnbXX9DMWxAnMdh7WlzlU8SIOrU7W68g8kxCQdBKvIN2F4pWdJcLVypf1y0IUvv0
 UBipVkKLUWP7HZzE03It33YUghBtO5Kq2t2lEsaBUtDLb6PhrMxtiC4Iw2HSHhYcQteR
 e9kfvvhMOY2aeUZM/Swh0reZr4nDuIo2D6BGRGwNtOo85S15W0L1MmU3C27KyEqenivd
 Chr2WmJqG1hi8dwMe7t2nvz+hHGYFRIE5cn5/0ELT4WnBFDXQXUNHoifpXXVr7WhYLeO
 dKqVPn+JQGVo1Ouz+JYyi7/eOJLDIurSJvm650ytFr5mDcovPgKondj3qWIWign3MyZf
 uycA==
X-Gm-Message-State: AOAM531534OSZQan6oXLYoo/dKGa6pU82gw5bjavmJasdZx9oLIKmPVn
 xdEELM3WJ4mh5gX4cgupYc2pEXx58Sg=
X-Google-Smtp-Source: ABdhPJyZa07nRakHo2Ib+XDeDhiaeDBXanwcju6AGc12tdJg96khKN71Dhl7HXfQ4WPtE1zQ3pwjjA==
X-Received: by 2002:a37:6196:: with SMTP id
 v144mr21088642qkb.337.1591159633232; 
 Tue, 02 Jun 2020 21:47:13 -0700 (PDT)
Received: from localhost.localdomain
 ([2600:1700:3c90:1b60:a140:f7e4:76fb:39c8])
 by smtp.gmail.com with ESMTPSA id p13sm990551qtk.24.2020.06.02.21.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 21:47:12 -0700 (PDT)
From: agrecascino123@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg: Sanitize shift constants on ppc64le so that shift
 operations with large constants don't generate invalid instructions.
Date: Wed,  3 Jun 2020 00:47:01 -0400
Message-Id: <20200603044701.10748-1-agrecascino123@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Signed-off-by: "Catherine A. Frederick" <chocola@animebitch.es>
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=agrecascino123@gmail.com; helo=mail-qk1-x741.google.com
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


