Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4114AC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0E420872
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3/ZpwtR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0E420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISmW-0000EI-HB
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1kISg1-0000qO-1v; Wed, 16 Sep 2020 04:20:30 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1kISfx-0004x9-Go; Wed, 16 Sep 2020 04:20:27 -0400
Received: by mail-pj1-x1043.google.com with SMTP id b17so1155430pji.1;
 Wed, 16 Sep 2020 01:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fmGZF5+gALayIq6Zx2cIKlc+1e9CSaPO+NBWM9DNzS4=;
 b=d3/ZpwtRYd9FSiDDJcxMg2zer5dvnu25bGTxfieyDiAsDFEx7/xYkEDmuxHKF0L9GE
 wz2mYL03guGyNmhAdAYitxUaT0yCMnERoggjCBzyf8sSkMFnZbf+3qkF7tK+l1rL/qjQ
 QlFpSi6NnlDRtccpikPTNW7LA7kRRRsc2xggD2T9GFITbMuOM+SYnOXreB29erIJymUx
 WeZ0k3cRPhxACcNvKzLQnBk+98zL7GoHXXS11f+hl/ILSs5P5TSEVl2tDxnLXLZVQIag
 S04iUpqdh1RDTdxHOlwvZdNV8GHY8AzoCKfRJl1TA+StCUUfhZ2FCPk74bl2JpuWKCAA
 vDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=fmGZF5+gALayIq6Zx2cIKlc+1e9CSaPO+NBWM9DNzS4=;
 b=Iv8cN51GeGMP7jGu9OPE+yDF4BXwTFQ/uMO8IHA0dVUPzqHZ5QyHOYVu4LnQZ4qwkU
 97plTmgdRgWmuiouxwJ0ZmzwvEdoi0thgVC4ul6EodLbsowze/HtQ2htBZU0jYYl863y
 w4yr7sTpo1xE0OsxAlyskEr9s1VxvAidy/ZwJBy50UKizfUW9Oa8vul6XP72WZnFvUzA
 IUd4eGbzWHDpuGztMTFvaaRdrdUS+OyrCqQntcvv6OWFyC86M+3xSDeEQ/qCn+1fIY3p
 EpRaZaD5A72JRwZPW4uSU08uKc0MAF2sp66qh8O6UibWD88xF+iFoAiLdtFUWzUrqRRt
 qOQg==
X-Gm-Message-State: AOAM531ZccrqEEdHNq7IcVGphQOnO6X+XFu/8wDafVxjvpm9b8qUHtl7
 myiBMM55OF8OCkXEf2UvJzg=
X-Google-Smtp-Source: ABdhPJxECdFJqGk12P+s+ScfoMctJg30qv8RccShVzalt05avCWlqun88pPPGy8oKywI76EWhzQD9g==
X-Received: by 2002:a17:90a:d997:: with SMTP id
 d23mr3017491pjv.171.1600244421394; 
 Wed, 16 Sep 2020 01:20:21 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.18])
 by smtp.gmail.com with ESMTPSA id hg16sm1763850pjb.37.2020.09.16.01.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 01:20:20 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] misc: aspeed_scu: Update AST2600 silicon id register
Date: Wed, 16 Sep 2020 17:50:12 +0930
Message-Id: <20200916082012.776628-1-joel@jms.id.au>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aspeed have released an updated datasheet (v7) containing the silicon id
for the AST2600 A2. It looks like this:

              SCU004      SCU014
  AST2600-A0  0x05000303  0x05000303
  AST2600-A1  0x05010303  0x05010303
  AST2600-A2  0x05010303  0x05020303
  AST2620-A1  0x05010203  0x05010203
  AST2620-A2  0x05010203  0x05020203

The SCU004 (silicon id 1) value matches SCU014 for A0, but for
subsequent revisions it is hard coded to the A1 value.

Qemu effectively dropped support for the A0 in 7582591ae745 ("aspeed:
Support AST2600A1 silicon revision") as the A0 reset table was removed,
so it makes sense to only support the behaviour of A1 and onwards.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/misc/aspeed_scu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index dc6dd87c22f4..40a38ebd8549 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -670,7 +670,12 @@ static void aspeed_ast2600_scu_reset(DeviceState *dev)
 
     memcpy(s->regs, asc->resets, asc->nr_regs * 4);
 
-    s->regs[AST2600_SILICON_REV] = s->silicon_rev;
+    /*
+     * A0 reports A0 in _REV, but subsequent revisions report A1 regardless
+     * of actual revision. QEMU and Linux only support A1 onwards so this is
+     * sufficient.
+     */
+    s->regs[AST2600_SILICON_REV] = AST2600_A1_SILICON_REV;
     s->regs[AST2600_SILICON_REV2] = s->silicon_rev;
     s->regs[AST2600_HW_STRAP1] = s->hw_strap1;
     s->regs[AST2600_HW_STRAP2] = s->hw_strap2;
-- 
2.28.0


