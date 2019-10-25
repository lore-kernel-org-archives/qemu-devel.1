Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AF8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D88F206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RUiwI4If"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D88F206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtxo-0008NW-NF
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtpy-0004f7-Ul
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtpx-0007Dq-Ts
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:42 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:45070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtpx-0007DU-O4
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:41 -0400
Received: by mail-wr1-x429.google.com with SMTP id q13so997227wrs.12
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oU5dDnk/ix9jKreAwN5NeNPxvAcZF9bkPDrfgoNnBe0=;
 b=RUiwI4If+ugx8YioCNYq4bYplKIS0BE1k+l6Z7bxIaM81SMLBfwg0QPbQ8McyCMS0L
 GJdwN2fsSzyWe8w/iUowOkpixu1QnnO2XEwY1e8CNftoMYefU7ccyXKDJrGHceN77I/s
 PU1uieyIYjhex6L2uwqr1OJHa5bFJhnurbeJqXkhe3pazdS6twLDetTBGfZ2HBaZDj6a
 fUR3a/fr216ifNj0YrIpbQ1H8uZVdGNo8pJBUK+EJOWq0LnKUbjyfCUtWFb3aTF2T8vX
 PyLFkBWe3krBXA9gJ0oZRKyDuA/dpN4HN3yVMeDAM2UoFx4TL0e7XxrHusQRgFaBbdgf
 8M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oU5dDnk/ix9jKreAwN5NeNPxvAcZF9bkPDrfgoNnBe0=;
 b=HnZ6ELV1LKGvZ5i6Gg8+zYXuAO5IsgQNqYvmKUA/Rf++jJifakqvvigi9Gj7mwIrec
 u+qLck8/htBgNvRbkSjyDn7TPjdOoAs7CxOx1zHXcfFgOZgll82NmGfJFYCWDkXBrAAB
 Ba8ohqA2mtrY4SIHXScCsJ3qtihzOnnO2UaFcQXHmHmuNcn/ITE3vTzoIOssAUbl6Z0X
 PempyKyXgY6R/+3KJr9JvEinF21D1nTgcBZIdqrm7lE0TdqMnI1FspUpfTOcXnb1m8lm
 u1mK3dkyas/goic9+vpEsyEvgUbhjif5QBB+sinEt/ChFq+ANhy3IMjWi0C/pBEXV+Ji
 XgDw==
X-Gm-Message-State: APjAAAXkIfexKNTgHzv5PcXUcjE0sCXS84D8qSuQ9LCNDVtXRAE21vo3
 z7NTk7zK3UKd0GieJZHvqMh/k1vlRjA=
X-Google-Smtp-Source: APXvYqzrwN6psV5nYWLqQPbXnmZ3DYGaXdMFqSPMwhH70HXT3dyCkhzjXQvgLlRZ70rmvcK2JwM0qg==
X-Received: by 2002:a5d:49c9:: with SMTP id t9mr1484583wrs.146.1571987800568; 
 Fri, 25 Oct 2019 00:16:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x205sm1469280wmb.5.2019.10.25.00.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 00:16:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7925C1FFD3;
 Fri, 25 Oct 2019 07:37:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 61/73] tests/tcg: set QEMU_OPTS for all cris runs
Date: Fri, 25 Oct 2019 07:37:01 +0100
Message-Id: <20191025063713.23374-62-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will important for ensuring the plugin test variants will also
work.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/tests/tcg/cris/Makefile.target b/tests/tcg/cris/Makefile.target
index c1173ead422..24c7f2e7616 100644
--- a/tests/tcg/cris/Makefile.target
+++ b/tests/tcg/cris/Makefile.target
@@ -47,7 +47,7 @@ CRT_FILES = crt.o sys.o
 	$(CC) $(ASFLAGS) $< -o $@ $(LDFLAGS) $(NOSTDFLAGS) $(CRT_FILES)
 
 # The default CPU breaks (possibly as it's max?) so force crisv17
-$(CRIS_RUNS): QEMU_OPTS=-cpu crisv17
+QEMU_OPTS=-cpu crisv17
 
 # Additional runners to run under GNU SIM
 CRIS_RUNS_ON_SIM=$(patsubst %, %-on-sim, $(CRIS_RUNS))
-- 
2.20.1


