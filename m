Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27346C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CAE22CF7
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RQ2zqNxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CAE22CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dvH-0000PG-Rt
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSy-0004J7-Ep
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:44 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:39387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSw-00083k-RA
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:44 -0400
Received: by mail-pf1-x434.google.com with SMTP id z188so16876324pfc.6
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DQhH2Q4YXEvegCMiWnmy59ZjpowYkn1863Fk7UHo49Q=;
 b=RQ2zqNxhZk49Ts2mpe1T+5pIJ/G7/aBW4vrT6RvizMInbOIqWVmHuzpe/WcQxrUxiX
 UVVQ7J/2cHSdimQqIEqwc2I9REkLC3cBlyzWnjH9jT3h3zw504bkviI/nUPZmC8VpVcL
 0KXZlHYJakba4O6mhleokDTBx6Wg7lhO20qDke1ai4PfY8hCjiVzjE/nIsynpsQ9ONmX
 yoHXBQJtBlwDCpJ7Fv4Is03W1kRtrojCH0AeO0/1aOahsvyJWgttlZOJfwzfq8FPAYP/
 PoJ5DHj5MAIlS0cdxNDlKRGclTRyQy05tm5RTz5upU96lnkGpI1RbRw1qYHzBSuYPxLn
 6O4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DQhH2Q4YXEvegCMiWnmy59ZjpowYkn1863Fk7UHo49Q=;
 b=R1aRYrjLM09NQsvYaUkC/OT9CdISzmlLYKnixds41KoaTzjRAJBHjd1E2OXAGaa4oF
 5ePquaYsDNxyNb9giKSvEW9SkSn4oLy+Qh86QQYqeNudcXGG1iHy0LreWsBzsYjzqWg2
 xPBi7XI0WMGuwtU8n4Lr0fEW9kloBbswGJ6ViAhf4HNOM21oXwPen6kuJAjsWBq0zO/R
 Degsb5CZ59/YobvaL0keXw6NfGc20h0FaLmyWR+MGy8rdH5xOMLq3unWly7gfR3eR95j
 mMRovtf/d1dx0WOirXv8nH+jXsRIlzwhKTFd1uIqmwHBRw/k2R7dRLemH8F+NuL/oham
 LFaA==
X-Gm-Message-State: AOAM530TSvYUbZjdTXcxQ6fqYNA4jFLYosM4Htu7p9M8ou59VBr+bgFp
 GqqL0miFfz+180wE4fa6Vkc3ED+avcY=
X-Google-Smtp-Source: ABdhPJyw3RVjDkYcyh30/fJ80sFTIxjKQCstNrpmEojzumQmg3ItF5mEgNLdi2rJkqn++RjvGtAR/Q==
X-Received: by 2002:aa7:9519:: with SMTP id b25mr7537412pfp.292.1596710981504; 
 Thu, 06 Aug 2020 03:49:41 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:49:41 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 58/71] target/riscv: rvv-1.0: widening floating-point
 reduction instructions
Date: Thu,  6 Aug 2020 18:46:55 +0800
Message-Id: <20200806104709.13235-59-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 9e8798902a3..64bd4aa239d 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2965,7 +2965,7 @@ GEN_OPFVV_TRANS(vfredmax_vs, reduction_check)
 GEN_OPFVV_TRANS(vfredmin_vs, reduction_check)
 
 /* Vector Widening Floating-Point Reduction Instructions */
-GEN_OPFVV_WIDEN_TRANS(vfwredsum_vs, reduction_check)
+GEN_OPFVV_WIDEN_TRANS(vfwredsum_vs, reduction_widen_check)
 
 /*
  *** Vector Mask Operations
-- 
2.17.1


