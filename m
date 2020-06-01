Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C134CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8745320679
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA7Os5ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8745320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjsK-0004jU-Nk
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjmr-00066A-DB
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:43:29 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:35946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjmq-000553-Cw
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:43:29 -0400
Received: by mail-wm1-x336.google.com with SMTP id d128so11247181wmc.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nBjzGdklMexKb/6JWGFmjUnmUd5clhjwawZNup6d0kc=;
 b=HA7Os5utpMJ6K5ebFO3TxMCYc4cK79e9DMTw9txAPs5N0hEL8GpUzTZPCGQBFCbfft
 SGUvqnUgT+5tevMoUIdsMIrrOsiYAZwj5gWeDzP303GC0QO8pTJyghUE/XEe7ibJ9D3n
 Hkt1W3RSmluVknf8SEvgZoNvsywYxmgisSKrJqeyUNKS4SxhgZCir8KJWR7XUz7jbN+M
 cE2bSW8R/1img46ueaupMI3IvSuvDDfzFUSXsQ8UZgwUiu806i2A/XPHotTNQPqWhT6w
 I0rZah2n6v49dt/uOcAoFodmqueikB0HXYLY/UShnB1ES7vexRdPOblMRnL6PpJ56QQ1
 aD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nBjzGdklMexKb/6JWGFmjUnmUd5clhjwawZNup6d0kc=;
 b=eEi/FkepCS8eLspDljqZGgM+lqtGYdr7YNAnidFwvYcYAWFr9eXR5m+AE1pG6whqHV
 oybS18iChtDiQWpRZSxx2P2PGQHGVNIC726b1k5ywh4JDyuJmNNSd9NXnSWlpcwyOid3
 Tp644wGnxIpfEQw+QWwVSuKESXmul2cbe4Z3tz3sqjpDGI1K/B6cxn7c/+l3hXuBDUBj
 rSwGOGBSst4UyiOLe/Sey+JakLWnxNuDd2mhlym6OVmt6BWa/juFBp19dc92Abd2Ed+y
 o9X2NcPEftCyfNP79F90OKOj0dyQ+/CFgeJHZlhSpQVeiQdiVGbn/0fJpysED7Wq021q
 EmmQ==
X-Gm-Message-State: AOAM531bUVLIXwXmE8/Ul3QnUPZ9TtHJuVAaKNn+GXGwoyNOMaDuJDnt
 /4VaZVHMtxeZ2dDJ9ibLGVWOXCzOylY=
X-Google-Smtp-Source: ABdhPJw19BJJITyC6pSG9g2LKsP4MEWbB/E06UB4GqgeSIloPA3RqcAagpZ+IpExvcf6sNII9Gsp/w==
X-Received: by 2002:a1c:a3c1:: with SMTP id m184mr23025164wme.91.1591015406783; 
 Mon, 01 Jun 2020 05:43:26 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id n23sm10948474wmc.0.2020.06.01.05.43.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 05:43:26 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/6] tests/Makefile: Fix description of "make check"
Date: Mon,  1 Jun 2020 14:43:20 +0200
Message-Id: <1591015405-19651-2-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591015405-19651-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591015405-19651-1-git-send-email-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x336.google.com
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

From: Huacai Chen <zltjiangshi@gmail.com>

The description of "make check" is out-of-date, so fix it by adding
block and softfloat.

Reviewed-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <1588674291-6486-1-git-send-email-chenhc@lemote.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index a00ccc9..6e3d637 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -4,7 +4,7 @@
 check-help:
 	@echo "Regression testing targets:"
 	@echo
-	@echo " $(MAKE) check                Run unit, qapi-schema, qtest and decodetree"
+	@echo " $(MAKE) check                Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
 	@echo
 	@echo " $(MAKE) check-qtest-TARGET   Run qtest tests for given target"
 	@echo " $(MAKE) check-qtest          Run qtest tests"
-- 
2.7.4


