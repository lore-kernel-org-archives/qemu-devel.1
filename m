Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DBCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CAF20707
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOinNast"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CAF20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1josyC-0000ca-1s
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1josrt-0007ZG-N7
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:14:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:36893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1josrk-0001K2-JJ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:14:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id o2so10228232wmh.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R/BE2XE6etuSC77gKrMmoWm+NEYkm1ni6VwaHNKkepk=;
 b=QOinNastaUJXPpyMw4NO8+J0iZlcQkKQXvn5XBFD4ro/7qXqQiQXXlmkcrBF6ERVly
 6pnMd8uwuKILEKWU19vAQAY5fRo374CkhZvrFklFhUe7KCH+DNDksCYo4mvRVAuZDZre
 RuxdQC7IgNw8W82VrMWRclZWwAo+L7s7SFncJqEPTs+PqCSF/viCxEF4iTGSIfg5Hjn3
 FteroPD27XOgUkc/gxs+mzD4K5jrknzfqsslBj7wVpEV/ypbJs9WuP6qQya7Yg/TO69d
 WJQhQ3vYIJA7O6d4IdaQdZAFM1sia1B1R+/W9HgdekbMQF+k5/oaHiA00AdOXny1KK9Q
 M3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R/BE2XE6etuSC77gKrMmoWm+NEYkm1ni6VwaHNKkepk=;
 b=S5S5BwdSXJkDjaOs/usw4E0qjwKfKYg8yWp2CDMung332hxxHIt9eYnKV2g864AGtK
 J0zuffQ8qkXxkT/xYumWWtvARvRjTqycPE6OC/Nmts/6a0o+5Lz9rIwxlEsCoNROg8YB
 rOgYgNAOyqBmFyGMfobauLMw57MDvrGVRoJ1GnbWJ59jVdhvJrrPUxvKauAFQLVCqquW
 hkhwIIhFKjoUdCqFrdIOOsQQwRLIubSN4pqDN7qbVhhrCo9FPKNnbhJCIlPsoihR7AIi
 3yRlZhnndLC8hu4OMQqP/w3NY5b+qUHk8An71fdyeF+AfJB9HVgypEZ4vCPShtLhDRMh
 0udA==
X-Gm-Message-State: AOAM532UO8vhjF9RVoFHCDxVH1CFqHnBy8duR8MRiAefVaNZptm4+DiR
 Rx9ZQRWyccIt6fCLhJov1Gk54g==
X-Google-Smtp-Source: ABdhPJwd19ceimdwjl1hHH3vu8LJSxv3dhgNqqSaQdRnPnmufln37JH7NkjWrNL6LYh51ac5vZ4n+Q==
X-Received: by 2002:a7b:ca52:: with SMTP id m18mr4663236wml.92.1593195258752; 
 Fri, 26 Jun 2020 11:14:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a10sm38384515wrm.21.2020.06.26.11.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:14:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 773551FF9E;
 Fri, 26 Jun 2020 19:14:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/30] gitlab-ci: Fix the change rules after moving the YML
 files
Date: Fri, 26 Jun 2020 19:13:44 +0100
Message-Id: <20200626181357.26211-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626181357.26211-1-alex.bennee@linaro.org>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Laszlo Ersek <lersek@redhat.com>, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The edk2.yml and opensbi.yml files have recently been moved/renamed,
but the change has not been reflected in the rules in the YML files
yet.

Fixes: 922febe2af ("Move edk2 and opensbi YAML files to .gitlab-ci.d folder")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200625151627.24986-1-thuth@redhat.com>
---
 .gitlab-ci.d/edk2.yml    | 2 +-
 .gitlab-ci.d/opensbi.yml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/edk2.yml b/.gitlab-ci.d/edk2.yml
index 088ba4b43a3..a9990b71475 100644
--- a/.gitlab-ci.d/edk2.yml
+++ b/.gitlab-ci.d/edk2.yml
@@ -2,7 +2,7 @@ docker-edk2:
  stage: build
  rules: # Only run this job when the Dockerfile is modified
  - changes:
-   - .gitlab-ci-edk2.yml
+   - .gitlab-ci.d/edk2.yml
    - .gitlab-ci.d/edk2/Dockerfile
    when: always
  image: docker:19.03.1
diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index dd051c01245..6a1750784ac 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -2,7 +2,7 @@ docker-opensbi:
  stage: build
  rules: # Only run this job when the Dockerfile is modified
  - changes:
-   - .gitlab-ci-opensbi.yml
+   - .gitlab-ci.d/opensbi.yml
    - .gitlab-ci.d/opensbi/Dockerfile
    when: always
  image: docker:19.03.1
-- 
2.20.1


