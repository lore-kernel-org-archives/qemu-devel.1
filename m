Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78696C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01EB8206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1byI4t1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EB8206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqj3-0006Py-2J
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVS-0006iZ-IW
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:35 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVR-0006ox-3L
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:34 -0400
Received: by mail-wr1-x442.google.com with SMTP id s12so4200861wrw.11
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BCWVGCPNXUFy3nRxMocemyad6VMwd8PqBpJd9BV4XTI=;
 b=H1byI4t15wSujl+40TPORXoUTeo5ZaWCkEdoKNVb/QRqsAoSP+UIH9jBRz+uUw6QGp
 1G8praNbyptIMl854E58DW5duSe/54aktf9ec7GqhaSUtwWv1o1viJIVVe8/Fnf1YSsk
 ui8aIeKgaFRjbVZyBPb/N3CJtuPoKph2GyQDaGZkLl5Wd33ygKICAKG9v+apQjKqE+eL
 CF2yUzZSZqTYxJdTGY8plDx+ESbBBsNCwN86dNx72D+6zeFf5uzdltpKw40SS5Hzr3v0
 3dUF7GcHjaSZG+6ejJphmmgEDk9fwW7guNmuEVCGSsrQhYH8ojRhePxbJZfwH5IIy0wv
 TzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BCWVGCPNXUFy3nRxMocemyad6VMwd8PqBpJd9BV4XTI=;
 b=pbG75FfRVl7yA7P/08SN3hvcQ5ppRDjNo7MCbPV8lWEajws1oMdPXJLughuCk9qn1M
 MKIPijxMkxV0Y7i9b9ZsqjXIw/yZnNCLpc3wqtKV1aWP4NLmFeRaQTfLAo1RVCnZmWhW
 1da5LqP8TvQ1NS34fgrHImnnSPFCxtCTdvUBXGtCqBK+hJWJy5umjTaH8aZKfycylolf
 vEXa8MLxFg8l4672rNWsqkss54kkwvNSjr3MYBN/6ltDtwcTA7i2gSH/hYIV3mf2xt1k
 cMlZz8IdwA4OpkZiQAyrNv9gqCtG8vPeOje+HSc4RRiSfo9NbbjMQIYMafZ3Zq3sRBfg
 OBnw==
X-Gm-Message-State: AOAM5325CwYkV6Kzj9iaGqlybxB8yKOuNQrK2RSo6XVFNM9Z1y379QPP
 isDu7ux76NYhRbLqbZW6HtUWnXSHmjhtfdK+
X-Google-Smtp-Source: ABdhPJyzuGNIm+v3roe/wNjaxp7HdxknkQAYJ77w7XoO9DHjC0bh+bhRUP7rM2LDTVSFU2TM5Gwk1w==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr5320757wrt.84.1601051011557; 
 Fri, 25 Sep 2020 09:23:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d6sm3565824wrq.67.2020.09.25.09.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:23:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 11/21] qga/qapi-schema.json: Add some headings
Date: Fri, 25 Sep 2020 17:23:06 +0100
Message-Id: <20200925162316.21205-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925162316.21205-1-peter.maydell@linaro.org>
References: <20200925162316.21205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
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
 qga/qapi-schema.json | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index d2ea7446db6..cec98c7e065 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -2,14 +2,16 @@
 # vim: filetype=python
 
 ##
-#
-# General note concerning the use of guest agent interfaces:
+# = General note concerning the use of guest agent interfaces
 #
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


