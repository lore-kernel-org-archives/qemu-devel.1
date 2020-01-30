Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BE8C35240
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF152082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2XyrrVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF152082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCVQ-0006zq-1n
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTl-0005D1-IV
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTj-0002nh-I9
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:41 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCTj-0002ms-C9
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:39 -0500
Received: by mail-wr1-x443.google.com with SMTP id g17so4826026wro.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=toXoJk3kWKWDO6UmwWx0b6Nlul4ANvuG6q0d24EnKXQ=;
 b=X2XyrrVhUwOVshAUgEsnyTu9eoKCB57WH0tVejYJhQ5oYqupu2u15o8bcYq8F7ldH0
 JgrTwyG2Dtm7+x/GJsCn66wOlOukQxLm9pxTbzrT/NWi/Zyk0KBi0nSsLRsRu5LKpDRP
 47DDktESraA4iD8GtPWV2QSlVgFm4HpNcZV4AQSVDq6xQkxXFMZwaBaWx/nhfu3hk9fI
 SCJ7cLUjW8sZcQcJWswDx9KAMErdwg7uCGLGxOAbhVGRMsSuUKeoZVUnvSMqMfVmkqxN
 hhyUVa+su2JM3S8uHYWEpmh77gXoFIuzcKHkL4Wm351IjMP0lpFGCzYXr2G1ntpk/Cv/
 y2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=toXoJk3kWKWDO6UmwWx0b6Nlul4ANvuG6q0d24EnKXQ=;
 b=ass1DmNA24SnhbioEqIcWRwhcn2k6O92u/Dach0QkPmIoLJOAWn2ozydil7/RCjM03
 WSkVJfcrUZzIglp3Z2zWP3aZ+k3AfXQBjilAOlaLWa0sUqP0CQRUU4sECFpT0JnOKb6r
 H19fYDZGoSYDl+E2LaisgEXE+ra4/jBpf6XPIKUtFgoGJ1ZFydKTeCxsCfSkTZETE5+U
 5mGcgD4h+z3ybBMtTE4Gb711eKdDtAdBX6oXV6j8ooVvcREtDulel0ub/UZV5+/8Txf6
 KdA8pmfaYhcb9eU1a/wZXUlr6tFpcMBeY7v12wKbV7od235bb5xVRI1fbTmPSN8Q1rgA
 y1bA==
X-Gm-Message-State: APjAAAV2E0Y8oe2NMkmC7MSpPmEPrk3EhV87yXVdgV1YBuF82NV9SsV9
 zRYbTLMZlA+/RNVETPzXNUzFhXKUkRB8dw==
X-Google-Smtp-Source: APXvYqyd8wRwCRMYXC15aGDi6OfNDcsly+vVxS35QozWXkKJL0wi0aUQ10hikWYve1K8R3WpWwZqBQ==
X-Received: by 2002:adf:f484:: with SMTP id l4mr6757720wro.207.1580400938111; 
 Thu, 30 Jan 2020 08:15:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/26] target/arm/arm-semi: Don't let the guest close
 stdin/stdout/stderr
Date: Thu, 30 Jan 2020 16:15:09 +0000
Message-Id: <20200130161533.8180-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The guest can use the semihosting API to open a handle
corresponding to QEMU's own stdin, stdout, or stderr.
When the guest closes this handle, we should not
close the underlying host stdin/stdout/stderr
the way we would do if the handle corresponded to
a host fd we'd opened on behalf of the guest in SYS_OPEN.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200124172954.28481-1-peter.maydell@linaro.org
---
 target/arm/arm-semi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 788fe61b51a..8718fd01948 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -403,6 +403,15 @@ static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
 {
     CPUARMState *env = &cpu->env;
 
+    /*
+     * Only close the underlying host fd if it's one we opened on behalf
+     * of the guest in SYS_OPEN.
+     */
+    if (gf->hostfd == STDIN_FILENO ||
+        gf->hostfd == STDOUT_FILENO ||
+        gf->hostfd == STDERR_FILENO) {
+        return 0;
+    }
     return set_swi_errno(env, close(gf->hostfd));
 }
 
-- 
2.20.1


