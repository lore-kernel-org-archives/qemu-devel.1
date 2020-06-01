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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C25DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2E9207BC
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q12Klci9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2E9207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjRp-00046r-1m
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjOa-0007t5-Pa
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:18:24 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:37261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjOZ-0007ln-Cv
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:18:24 -0400
Received: by mail-wr1-x435.google.com with SMTP id x13so11299184wrv.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nBjzGdklMexKb/6JWGFmjUnmUd5clhjwawZNup6d0kc=;
 b=q12Klci94bQLSwvtIvi3d5KLFfcW6pzYrbMPJA9RTXZCEanXUcGW2rcBiLT+V8dC5g
 FDEXH7DQO8pQsMrF8VD0EoU+Rf23m9tj6bKHSWIbk9JwX/m/GJl1sY8fpzVrkyTzTT91
 I/TwJ9ZNRKCX/yIeK1JT86JjNkeQ20+F1hrrcp0VkhSaSBtpZqC811k1rG9K7CjFEYqp
 aKMcGOpneCNM7giMCnuJutl+n4kypaqR7bCEJELk0dVtYWYzgipNc5ZfiW7pYk7EiPtA
 +Q0KD7bbHu9wWiCDaVj6Ss0+5BbbCsSoJ8/NwP6BlxEx3UsJEIfsGwleVwFBTo27vIpV
 Kydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nBjzGdklMexKb/6JWGFmjUnmUd5clhjwawZNup6d0kc=;
 b=n2JGxdtzH8cRF97BMwG8Xdxb70aCOvuFJqmmHPEWfn00dvNftMxFWKY0iHTYkY9x8r
 icDwS5rqOc3P4rOCUSyiz/1WhAhDaqphB8VvJpIrWzRYRESqhtANOxstFkl0+gRGRGKG
 oDABQEXdD6WWTFCpBxdy7RjBOCCYzNXQvvR6mPv/uJqhgCi4mFCCehnaW9LbHogR8TqA
 hQ47/CREVEj9mvRPK+JInqTNkUQbF5d3a1eCH2VvtMHtdUEFfshxHEfXlUigo9rUlj8h
 1UTyzZ8ZkY5azc9gj5k/4X1p1C7k/81iLlel6PWGq5mn2+gVCOcTCaRgdradMZIefmeO
 ar8w==
X-Gm-Message-State: AOAM533SY8pOCVDhRiDCSiqJDlZ5HjJ/Lw6UCw+vVKURCikxmA8nhE6h
 /Na/d7pNz3HefGcNzOay70nzAeBmL18=
X-Google-Smtp-Source: ABdhPJzCWKDCOewTjt4W2dM2UIlxLtxeF8kyJ/pZiRyoCTlS9q1HvuYDhBYAKQF2tIyfXw4M6DOUoA==
X-Received: by 2002:adf:ab08:: with SMTP id q8mr2937029wrc.216.1591013900556; 
 Mon, 01 Jun 2020 05:18:20 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id y185sm12332136wmy.11.2020.06.01.05.18.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 05:18:20 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/6] tests/Makefile: Fix description of "make check"
Date: Mon,  1 Jun 2020 14:18:13 +0200
Message-Id: <1591013898-23391-2-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591013898-23391-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591013898-23391-1-git-send-email-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x435.google.com
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


