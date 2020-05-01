Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CBAC47258
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 11:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36862166E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 11:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l9q7LBAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36862166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUTef-0007Gi-PS
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 07:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUTdS-0004cw-8t
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUTdR-0002dP-OC
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:15:14 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUTdR-0002b2-A6
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:15:13 -0400
Received: by mail-wr1-x436.google.com with SMTP id x18so11186563wrq.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 04:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rRylNRWTBVo7YQC3o8Kz8zhYtOK72AU2Kfl82H2UXNY=;
 b=l9q7LBAewGmR8w5ILyNKlacsw9m8H6h3yrEk24jDaGL1afy2JtneX0LIIyxIKOxrXd
 YlCRwqDLa7vz5IwvcOJsPdQTAJizYLPq0k+TY092S5cOUVesH/laCuDwuQzSizo2qpcV
 QsC/u9d2EVrJZqVNtTn6cavGmjqSp46HLaD70a26sJeSG6XJKLXLwkQbUwgeM7YjLkhh
 76LoNoYPFcguW6PMbQsvdV6b78usLkU7qHT0tckRzoW/xZVc5c/owOrdfS/Ewfcjj999
 lttZEarShN4Re7vjoS7NEeJ8cdc4n2ARdLmATpYVHhMy0bK3ASITdD8BHtFPi2X1/4fK
 +JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rRylNRWTBVo7YQC3o8Kz8zhYtOK72AU2Kfl82H2UXNY=;
 b=oKINEgR5gxqx0VixJMJ64KpZ8Iy+3s2kqAdrfVol37MzuEcY7Sb9WmxVImntDXwA46
 vhJn9b6p/Ky6WD0783smjlHdXGw/awW18kqEe8aW4s5u6SBpaR0dgpE0mg4wi4aqL10M
 WsnlHqpIP5WPG9zjB2/x4VT6CR8ZVZ5PMyBkiQvFKWoF5lrtmbFCGuDTO0EL8E2xacmc
 YiYzfrJG5ye1LZJqwGAJz6xaRK/lIifr/TRVtWAD/YVZODm+oGblrm2AnBU79EPodxud
 5P3htpbYExNUwxjCmJfCMD8EZUL4sYA+X3HgthmM4/GkuCT/jngW5wk9qpVpL4uUeOie
 3mYg==
X-Gm-Message-State: AGi0PuaQ47IJSLn2e0PCs6+QS6EkwpLfSHr68HpHOzK9BTqnky5QLl4f
 A8Up8o79VvBj2NUKlQTJG+/XZQ==
X-Google-Smtp-Source: APiQypK0CBSpkVoiv91mkyLAYXQmlMTbU6a1R5LaKqsDjVoscbiqW7V45tsLgmoDvPeWeh/mHwW9eQ==
X-Received: by 2002:adf:c109:: with SMTP id r9mr3636697wre.265.1588331711844; 
 Fri, 01 May 2020 04:15:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b12sm4438770wro.18.2020.05.01.04.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 04:15:07 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CF8661FF90;
 Fri,  1 May 2020 12:15:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/4] .travis.yml: reduce the load on [ppc64] GCC check-tcg
Date: Fri,  1 May 2020 12:15:05 +0100
Message-Id: <20200501111505.4225-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501111505.4225-1-alex.bennee@linaro.org>
References: <20200501111505.4225-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::436
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This seems to be timing out quite often and occasionally running out
of disk space. Relegate it to light duties.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 49267b73b3..fe708792ca 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -458,7 +458,7 @@ jobs:
           - genisoimage
       env:
         - TEST_CMD="make check check-tcg V=1"
-        - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},ppc64le-linux-user"
+        - CONFIG="--disable-containers --target-list=ppc64-softmmu,ppc64le-linux-user"
 
     - name: "[s390x] GCC check-tcg"
       arch: s390x
-- 
2.20.1


