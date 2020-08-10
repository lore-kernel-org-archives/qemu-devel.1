Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7059EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3171D22BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NmgetztG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3171D22BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Dvq-0007qb-G6
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Dom-0000hh-0c
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Dok-0004o9-89
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:47 -0400
Received: by mail-wm1-x344.google.com with SMTP id c80so615298wme.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PgKydQ283kCxKymfkeo9fXBKb+pwyveUlMS1tfRsFkw=;
 b=NmgetztG8+no4e2Yy3erL3ZXfh/D8KDHPRvA+g+74sph/Bn8X3rrQHA5HrKY4sVxnT
 2oA6cbcJ/qWyJfDmm4Y3zosY3cCanu9ER1WyZts0P8sOR/vsTnvpZVZxdz8EfjvKjxpn
 9Vl3ATJazq3QQiWsadEtdItIystg+d5azQMxp5npoFNvT2qEa2rrlsCb2RFc1uhOjLj/
 RcAfIJq6qCHl+Xau8gRoxqcE0AO6CDI+lH9cR7mn4zKbUeugofr7kctB1nuzb1IylCa0
 GV65Xg7+e7/tPD5d3USznZ9DUmgEcrJLkqlQNIxDI13LPxEY45LdsdrUktkf98Bxkdim
 tX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PgKydQ283kCxKymfkeo9fXBKb+pwyveUlMS1tfRsFkw=;
 b=V3qn0Gj+i1gXSAnKk4S7VPdAP8/XW3fVGcKmnAdK7UIhBCrLgTnHAYi4toaOhRqc34
 NqQ9URYyB5FZK1Dyp2+QCUAEQJOTyyqY4bT7sdW02m+4y7Xo0zJgn88f23nOZ/0pkPiK
 sHE+U646L/SCywageg4E/tNIXpr+q98/OyHAuLx/YXt6lfpeIcHYeELxJNgKl/vewveA
 w28bcIvYt55KUk9XiJ4oKZgdptErrac4pzLol1yui3GQ5+QXZizDQkNOHLDApmKmI+7i
 4f7CYczKpYpqOVIxJhb4AE0G+ICp3yi+uiqghmxolL2qqeUyWrFl2M2X4K6Vve/5gt/X
 03Kw==
X-Gm-Message-State: AOAM5337GOXf7AGCy+djXVvuT6V8koJDnBu9Vka4YHsGYdPOElmabUUd
 PKD9SBLqm0JRlwveGmEoPMQrfYKSEI1/UQ==
X-Google-Smtp-Source: ABdhPJwoQY2bUhtM+FLWY3WoV/3cGLuMc0QmiCcwheIBt69C3ts4dFhq0JQZLWyUx//OKlnOuzUzKA==
X-Received: by 2002:a7b:c0d3:: with SMTP id s19mr759190wmh.84.1597089044037;
 Mon, 10 Aug 2020 12:50:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 13/20] qga/qapi-schema.json: Add some headings
Date: Mon, 10 Aug 2020 20:50:12 +0100
Message-Id: <20200810195019.25427-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add some section headings to the QGA json; this is purely so that we
have some H1 headings, as otherwise each command ends up being
visible in the interop/ manual's table of contents.  In an ideal
world there might be a proper 'Introduction' section the way there is
in qapi/qapi-schema.json.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qga/qapi-schema.json | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index b1e9ed836de..401467860a7 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -2,14 +2,18 @@
 # vim: filetype=python
 
 ##
-#
-# General note concerning the use of guest agent interfaces:
-#
+# = General note concerning the use of guest agent interfaces
+##
+
+##
 # "unsupported" is a higher-level error than the errors that individual
 # commands might document. The caller should always be prepared to receive
 # QERR_UNSUPPORTED, even if the given command doesn't specify it, or doesn't
 # document any failure mode at all.
-#
+##
+
+##
+# = QEMU guest agent protocol commands and structs
 ##
 
 { 'pragma': { 'doc-required': true } }
-- 
2.20.1


