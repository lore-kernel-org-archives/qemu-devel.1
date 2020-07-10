Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F278BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:03:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6DD20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LEuYT8eq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6DD20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsgy-0005iF-Ua
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqc0-0004nw-UK
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:50:36 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqby-0006Ia-7C
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:50:36 -0400
Received: by mail-pg1-x541.google.com with SMTP id e8so2368718pgc.5
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gIClYh77YnToY+rzZTLHItNPlAaqhPTdCd+nqEyek5o=;
 b=LEuYT8eqtQgmCuymrPSdwWN1uE7Rq+koBF0TxKfmNtzZMGu/JRP4eNUa6WjG9ETPLr
 dA3KjZgG8bLvsRUsygC2TuanBeFeeGGp29OF5mGkX3eSPkX5LtWlt1qS8auijXDEreQq
 u770GH+K1cSkQ315ZOcjh0b/jEeawwJbRvQ2lV0qy8ST+TSYQOECE4xYjbt5MUCnj5pZ
 pIpVGcwkfqYI70g2HnXOJmvaXrGOjRzhv14pw62lOXCgiWfBU183yx6V1eNSoUpu4N+p
 nqUctDXQRZUp02x/hn38uBJqb+55nFWfFMtks06h+yy5JpVJWNRHeSW57Npkvdzq3F35
 TsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gIClYh77YnToY+rzZTLHItNPlAaqhPTdCd+nqEyek5o=;
 b=JaKjKnd+648JcZkgkv/rBUGdgGupPxu5Tb9DoObV9wOIJqrBJNssjd2Zea55aQe0FK
 eUPX5eD3lHZgZp0xoR0R/bQfyY8UW8xLORTPbu/HEjplbKGTqlfxx/CTjfFXOfJ6coYu
 +ykJc3vc5/I+upwZNLlPkgefvdmpSRQSSEy1bmP06aSd2Uhx6aCpJ3T7lxudAQXBSUIS
 xfaQHlSxSii763K6XAw6V5fYaPIq8eDI1J/jwLq4fMNea1KPv6+X1+WgtSewnUtiXSRt
 sCjiwu7pnYh22jCQO9SgZBwMpLNVe7w56jERt5d3LFIQJknxCi66cAcKpSHkN/3yO136
 YPow==
X-Gm-Message-State: AOAM531NFxhN4paLbWsrxrWfBCX9lc/HG5kxV7R9GVmToWwFhtXuJ4JT
 cJO149l1ppp/tb1w8iFlY2nbJ94kQvAzpw==
X-Google-Smtp-Source: ABdhPJx1cTTD54qhMUuyphj3/zVDEMzhCmqbbM+eMuwOelyIhZsiWGqWmNNzg2OMB3tG+xfndm7Fjw==
X-Received: by 2002:a63:4b44:: with SMTP id k4mr60175496pgl.305.1594378232762; 
 Fri, 10 Jul 2020 03:50:32 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:50:32 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 03/65] target/riscv: fix return value of do_opivx_widen()
Date: Fri, 10 Jul 2020 18:48:17 +0800
Message-Id: <20200710104920.13550-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x541.google.com
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
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:17 -0400
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

do_opivx_widen() should return false if check function returns false.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 7cd08f0868..c0b7375927 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1151,7 +1151,7 @@ static bool do_opivx_widen(DisasContext *s, arg_rmrr *a,
     if (opivx_widen_check(s, a)) {
         return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
     }
-    return true;
+    return false;
 }
 
 #define GEN_OPIVX_WIDEN_TRANS(NAME) \
-- 
2.17.1


