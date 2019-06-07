Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05376C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7FB420B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjChq4jl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FB420B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47372 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZAxV-0003JB-Ch
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39400)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAp1-00048Q-T0
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAp0-0004Qj-37
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:03 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:37434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAoz-0004KG-Nk
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:01 -0400
Received: by mail-wr1-x435.google.com with SMTP id v14so1350003wrr.4
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jMI2SGNeZLWPMTiphBl8d5qoJBryaOiVTeyWEFf0GRk=;
 b=IjChq4jlAKRwvAQredZdjoabtSchtttqVsl0Qj+mYjguYu7xjuiJoGUZe7O2rmqcmZ
 EyYwlQOTOMy+JWg7QZ6piVE1sQLBnS9Fj9QtO4Ryfzp1ApwnsaUVHWEZVFv2rgnYA5/I
 X/eaN5a6L3BqG5FBNJ3SFyXS3LkjyjlKAq77LGNeEakaFiYmqJjM+j0bcC519NopcBeg
 NcX+WhAEpZW/Rdwj03qADNsKFenNohWSNnw7rncP/UTgjQnUsMyjBRZXkTtLUoQJ3HCD
 /J160FpaWI5hSvQB+WBEc0lW+DX1R7fGn4NHEtrd5PEb9Kf1bOAP1+8IvS+hOUiAT+z4
 qBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jMI2SGNeZLWPMTiphBl8d5qoJBryaOiVTeyWEFf0GRk=;
 b=ZtU6KcCWiMdJyRAE1vTVQsxojkjw9WzuI6G15gb6oqMSc0hqzfqGbtAxhuORUXP7Pj
 dXNFlBV6tpTvVvmNN2L3yygIqnAtbRnyvBvZJsR+LOAKq1AYviBuO604JyNjaYSrCiS3
 XIucAYRBbuVfc4IltCDPrbg1XrJyT9yKT3aNYIXnKths4Lncpe1GCiV+jR6kV+zw+yYs
 bQq8Cc7Tx1LRfcfYOLTF/JuPbW+pcfXjZvoEk3M9T+4xcVG0Z5pawarRpq2TG3sbbfS/
 3waKVkxl9kzH9Orknv34Y3+Jl4UuDRsXzZP0rZPhzCLWPa8gnUT0WD4HG+XqIl5i/gvX
 +Skg==
X-Gm-Message-State: APjAAAVozcKnPzltewOByyYIZHmeaLlf3RIV1+XkEX7hkjbduuQ6fAlI
 v/ltYuUR2DvrtCIEnJoesc9LIg==
X-Google-Smtp-Source: APXvYqw8zDl2ZPcAhoThNQ6HwVwEZKkEhGFei7kK+oMa3YvvD+jZDTVKojR6CFvfJCI7KimCRdJ8Ww==
X-Received: by 2002:a05:6000:cf:: with SMTP id
 q15mr1677853wrx.52.1559898359991; 
 Fri, 07 Jun 2019 02:05:59 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id u5sm1515236wmc.32.2019.06.07.02.05.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:05:57 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C8D5C1FF9A;
 Fri,  7 Jun 2019 10:05:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:09 +0100
Message-Id: <20190607090552.12434-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PULL 10/52] tests/vm: Fix build-centos docker-based
 tests run
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

`make vm-build-centos` run docker-based tests on CentOS. The
created containers should have network otherwise some tests
fail. Also fixed the BUILD_SCRIPT template to correctly
evaluate "V=1" for verbose output.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20190329210804.22121-5-wainersm@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/centos b/tests/vm/centos
index ba133ea429..7417b50af4 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -26,9 +26,9 @@ class CentosVM(basevm.BaseVM):
         export SRC_ARCHIVE=/dev/vdb;
         sudo chmod a+r $SRC_ARCHIVE;
         tar -xf $SRC_ARCHIVE;
-        make docker-test-block@centos7 V={verbose} J={jobs};
-        make docker-test-quick@centos7 V={verbose} J={jobs};
-        make docker-test-mingw@fedora V={verbose} J={jobs};
+        make docker-test-block@centos7 {verbose} J={jobs} NETWORK=1;
+        make docker-test-quick@centos7 {verbose} J={jobs} NETWORK=1;
+        make docker-test-mingw@fedora  {verbose} J={jobs} NETWORK=1;
     """
 
     def _gen_cloud_init_iso(self):
-- 
2.20.1


