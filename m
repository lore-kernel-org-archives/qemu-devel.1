Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A056C17442
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279BA2245C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ghjrz3Ef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279BA2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUrNC-0008Rp-BP
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 07:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUrJW-0004zy-Rn
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUrJV-0004DK-TC
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:59:58 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:33606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUrJV-0004Cp-NX
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:59:57 -0500
Received: by mail-wr1-x42b.google.com with SMTP id w9so2068482wrr.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 03:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=stPfjhlfRMtU6DLfmn85a0s8Wa67hLr8dK2T2ih0OY4=;
 b=ghjrz3EfbiQsT3+7cAy6uSTO21arqBT2RfdyzbPyda5Yc7JKMQ9Rnnzhc0Xt5UzpfB
 Gf0t4Z2lKPAYYZlZzjT6QaO9Uqf6QGcN/o7SgOnKoMvck7ofZMT/ruRqkJ7KGnFvVC3p
 jFnvXxBSfKopEaCcA5JfK5RduVzXq7+13rMJB9Oan5X4SL2bZbPcudw03nqWIVbh9zLi
 UKzK+HoLOH1+qm7K5hdXqlW10dJdXwPrK5K2WOHj5WZlyPvKjtsppAQgT2lxutLH3eoT
 TSSEeLirOyDFKCYLbKSUqIN0DmFPrS4DypwFBIP5sQfNZWcbzjFcHTblPH7bGipxsmQW
 FMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=stPfjhlfRMtU6DLfmn85a0s8Wa67hLr8dK2T2ih0OY4=;
 b=WqJ7zPn6slGxJIDdlmioJmFwOENbVfI1xOtx77dhkcfBsyackNne+d1XlPJlznScjK
 5c0xOo8IO1GIsKk7lfniaDUa3UYWEKkG9zyn0biyABf8okly0hxk7AliwMiN3snbX0ku
 ZHO9G4XxuszeKSA8N3VZBE7xd9LGDZFHz/y9QgF9z7BJD8CAOqnlU2ZCRav+VvlzuH+m
 QmRVnSwL+gwLPuB/eobPtqDZ0VS10UoGW8qV2NCmtyhIqOtHrB/Cqoom1uuN8eKxghPt
 gd+7u/gKHbC343gJnpIwtvZx2apPaU1qNts5l15W2Gxpz5lCMNTaYdn+0Npnf33QHZoK
 sRMg==
X-Gm-Message-State: APjAAAXzqkY5Wk2CjkQyL4ZHm3rV4TlKUDBdzPLxJ1AdIeJvO1wtSOqW
 Rbsi0vzdP+tFAzrzQPh2K5CkHQ==
X-Google-Smtp-Source: APXvYqyMajJS/tDBpz4XlN2In++Z2eymT6t2FosMhvJpna+UJKiainjnIgtwK91nhA3uQwlDlNLL7g==
X-Received: by 2002:adf:ffd0:: with SMTP id x16mr2348584wrs.86.1573646396534; 
 Wed, 13 Nov 2019 03:59:56 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d202sm1900461wmd.47.2019.11.13.03.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 03:59:52 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 57A141FF8F;
 Wed, 13 Nov 2019 11:59:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 2/5] docs/devel: rename plugins.rst to tcg-plugins.rst
Date: Wed, 13 Nov 2019 11:59:49 +0000
Message-Id: <20191113115952.775-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113115952.775-1-alex.bennee@linaro.org>
References: <20191113115952.775-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes it a bit clearer what this is about.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/index.rst                        | 2 +-
 docs/devel/{plugins.rst => tcg-plugins.rst} | 0
 MAINTAINERS                                 | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename docs/devel/{plugins.rst => tcg-plugins.rst} (100%)

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 2ff058bae38..c86a3cdff2f 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -22,4 +22,4 @@ Contents:
    decodetree
    secure-coding-practices
    tcg
-   plugins
+   tcg-plugins
diff --git a/docs/devel/plugins.rst b/docs/devel/tcg-plugins.rst
similarity index 100%
rename from docs/devel/plugins.rst
rename to docs/devel/tcg-plugins.rst
diff --git a/MAINTAINERS b/MAINTAINERS
index ff8d0d29f4b..b160d817208 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2369,6 +2369,7 @@ F: tcg/
 TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
 S: Maintained
+F: docs/devel/tcg-plugins.rst
 F: plugins/
 F: tests/plugin
 
-- 
2.20.1


