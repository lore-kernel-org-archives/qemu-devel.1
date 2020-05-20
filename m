Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8827DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41EBC207D4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbqpozNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41EBC207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPOK-00049B-Ev
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM1-0008Qz-Hd
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:53 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:35291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM0-0001tc-O7
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:53 -0400
Received: by mail-ej1-x642.google.com with SMTP id s21so3982580ejd.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mvfZ9b5X++pjGPlHODQLP+73HAFs/zH+An8fEoHT3r0=;
 b=lbqpozNmAb3aRO7b+SST0+hxyC4PY7mto6WovSWVkUo3NE6DY4rIqhynN7k3L6FWfH
 MNrijzr+8Krb6W8ERK/b1GxWSm0qYnFtZX1kA4RjnG7mi2Kovm0yR5tolGF/BhIFrGTf
 kv+oqzgEUlgr4FRJaHj7YKm6b0oZGomWcnV6JLVI65p9H4aREhp728lJeeHjOsfg2SmI
 rG6gvcC/oKUtN66IYfnPA8yWIXUBI+rEaWuDS4dfeCNR9j7d29P8NkWakIsR+odvk/+z
 O0ojMCOiZNq8hhPQKQM/QXNsQ3n8WiYQ3rHSYc9fwHD8PRV1044YTR6ZRajB/+joI/M4
 ptcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mvfZ9b5X++pjGPlHODQLP+73HAFs/zH+An8fEoHT3r0=;
 b=G58ZyDmD0dLnCaYSaxfX6AhSaU8qoczpzLaxFIxztIot+neCe6PlvUwF6r61c2C/1b
 Yjq9278zkWLc9ayuy9VYE5VdRih/HvtxRVqbWFyKcA96CJkvoLACDoNNPMO1knUPR7hI
 Z4tXJnoSZ638uo1fc7ZiBIFu2PDfc4nf89IbXKU1hliQxq9JXPdSQmMJ6LGiiC7sUzEA
 aDLJacmblBylA6ajcYZoqLnosDOC9iIQEe+aMYs8VKID+TG1tWYCnJoCqTigftql7O3n
 1Qhxryv/mqeK/OFpdLKHOfhECmmABSrN+/+Zqmrhn9wbHP0XH48TUQG8debD4RoiL+Ub
 41bg==
X-Gm-Message-State: AOAM533Noev1J3qphx1EKwFix3MTs5oTIW52veKXOd3/xNcyUsamM3FL
 zRBrq0ytFn84O/l8kx9c7iNQU3cCO6M=
X-Google-Smtp-Source: ABdhPJxKbw0YI15135ryOFdJhtTO5KfRNwrIdNtEq0cmQgmhGVgK+Rwzm795Ce/HsZVSH1TqexQMBA==
X-Received: by 2002:a17:906:9404:: with SMTP id
 q4mr3769343ejx.138.1589983548742; 
 Wed, 20 May 2020 07:05:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k3sm1844624edi.60.2020.05.20.07.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 07:05:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4E2A01FF87;
 Wed, 20 May 2020 15:05:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 01/15] configure: add alternate binary for genisoimage
Date: Wed, 20 May 2020 15:05:27 +0100
Message-Id: <20200520140541.30256-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520140541.30256-1-alex.bennee@linaro.org>
References: <20200520140541.30256-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not all distros ship genisoimage which is a Debian fork from the
original cdrtools. As the options are pretty much the same support it
as a fallback binary.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 26084fc53ad..a574250524f 100755
--- a/configure
+++ b/configure
@@ -941,7 +941,7 @@ done
 
 # Check for ancillary tools used in testing
 genisoimage=
-for binary in genisoimage
+for binary in genisoimage mkisofs
 do
     if has $binary
     then
-- 
2.20.1


