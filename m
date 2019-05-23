Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08061C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E5F20856
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p5tQ8Zvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E5F20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38514 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpM6-0000A3-VJ
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:10:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpKL-0007Tl-7A
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpKG-0001rR-Hr
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:17 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:40316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTpKG-0001qz-Dr
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:12 -0400
Received: by mail-vs1-xe43.google.com with SMTP id c24so3789583vsp.7
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=TEbS/eoBr4jNITUxq1vwaffydS2jov7Vs7szIedqxOI=;
	b=p5tQ8Zvsrg+FsGqAg0pIKs6S6X1EuEhBle8Irz693Guj17d97K9ft/OR+Od6kNajsh
	Xc6b9AOk3QRm8fdBSyhix0E5gwsC6WGPhc+mXnKTqvAW+L+/NpH9CycwY+3PIaugJe91
	LwYvqueE1IcEl0895q8SBlE4fn5ZDMb7aYFhowe31bDPnvg7ziticaQ8N0TAYUYQnDYF
	LSuXnCJTEqJmOosMHWWB2TCRmE5IAWUEvd+Rs8rOQ1+NgUXaU9Zwk1Jq7VwKwIBWSHz+
	x5lEjsRKAOHXb1MKRoiE6bEwtVsGkR1+B4v3qTYP99zV29yD1WiRUQNzo3vx6R9/uHg+
	39wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=TEbS/eoBr4jNITUxq1vwaffydS2jov7Vs7szIedqxOI=;
	b=NqmgE//8lVHMuK6xD7uB0PVm3GhFCmvyHIQVTXNYojzxuAcanUtR6D+9bZtVaF5AIE
	r7u27TtLHWjWJFrGSGwAB7Fg435x+vK7hbJ5XrhbQSS9fn5Vq/osyFC0AtnFX6gc3BcV
	9D/+qCgjrkq/9NPt9hT0y9J3DMVHeBBqUEjWvBShoTM6wntBK1G0GBMZ+xZe9WgyAWmF
	S4Cvo7oaVDf45ZYcp3F91lAUQBZdmN4DUHGoIMLgIKHInlLN+z533SYN4q35Yk6M3Z2h
	Glw68SThynPbKzEVYW5vDuku1b6qtgLz1C8AeeJxMWDcPybbWkbMFoH+DrHu0dDp/RwH
	XC0Q==
X-Gm-Message-State: APjAAAUrJbMp+3GYeOFYiFzWVkBzUOJwyrkZAYRwshs/X8k8+pslf3nn
	39vS0TQQLy6wfIqoSwNoPEaRgl0dFpY=
X-Google-Smtp-Source: APXvYqx2yna4UYoIugEcpKkAw0nKUdlJUpxLzVhhLg9GnA/emubzi1s+113nh1akNu3Zg+o/0xuULA==
X-Received: by 2002:a67:ee4f:: with SMTP id g15mr38007273vsp.38.1558624091304; 
	Thu, 23 May 2019 08:08:11 -0700 (PDT)
Received: from localhost.localdomain (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	p70sm4227462vsd.25.2019.05.23.08.08.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 08:08:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:08:00 -0400
Message-Id: <20190523150803.31504-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523150803.31504-1-richard.henderson@linaro.org>
References: <20190523150803.31504-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e43
Subject: [Qemu-devel] [PATCH 3/6] target/rx: Use prt_ldmi for XCHG_mr
 disassembly
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Note that the ld == 3 case handled by prt_ldmi is decoded as
XCHG_rr and cannot appear here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/disas.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 515b365528..db10385fd0 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -366,13 +366,7 @@ static bool trans_XCHG_rr(DisasContext *ctx, arg_XCHG_rr *a)
 /* xchg dsp[rs].<mi>,rd */
 static bool trans_XCHG_mr(DisasContext *ctx, arg_XCHG_mr *a)
 {
-    static const char msize[][4] = {
-        "b", "w", "l", "ub", "uw",
-    };
-    char dsp[8];
-
-    rx_index_addr(ctx, dsp, a->ld, a->mi);
-    prt("xchg\t%s[r%d].%s, r%d", dsp, a->rs, msize[a->mi], a->rd);
+    prt_ldmi(ctx, "xchg", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
-- 
2.17.1


