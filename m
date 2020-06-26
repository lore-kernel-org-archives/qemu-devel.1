Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37E8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942EC20836
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3gWdjH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942EC20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jot6B-0006B2-Sh
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot0H-0003uL-Lv
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:23:09 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:43805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot0G-0005Ae-3j
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:23:09 -0400
Received: by mail-wr1-x430.google.com with SMTP id j4so7923106wrp.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yj24Wzj4vkjm2AUHX/QFJODVj3pT/AuxBZvUIsPK3rA=;
 b=X3gWdjH8+1B3v90sEFF8ZAs7dLb+0eheYORittm3YCnHTCAPkbZrGYP689LAcXPIcv
 olo4zbWLrKvZf5CSal25I1MaBms99ISXWbwum+3Wp28B/6FGXd5OBuMjGd3Jpa6cfdwH
 D1IXWShlK4EydjWVR0EK3hsxUyGeMguEiBanFj5Vhu9ipwUjoM+S9nW5uSXD5XNKd8rd
 Gim5W6O41vblXSiMtbn+ywbP8e5gQ2aZX+R89BMvMgEn+INnGlbIhmhnuyb7Vp/ipXB5
 yUy0FB4SvdRVEI6QoeqsfGj4nLKkaSl2y6ChiJi9LID22LRNEaq5JzbjmRFUQGHQt7bL
 jg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yj24Wzj4vkjm2AUHX/QFJODVj3pT/AuxBZvUIsPK3rA=;
 b=FDabMTvrXzgFtGgRWJ4OERSBeW5R/gK+9cWsMF5eMg2aTl6+/vW4I7nWnTIXnY8Nrg
 lqBPBgDZXNGhOjvMxaz3j+jrhc5bjdreMihJOGppbbWSBJgDXPFp7z5PI99jSmR/1iUO
 VDQhtqa5QQ7BQISBD1F7+DUu5ZaG+kgDaTrD5FO8L+g3uX2259n9lhe6vI6j9OPl8Xyb
 zcuMmSQleiFptW5KRzZkBtW+2UWg22c8dGqTkqaBzOx2A8gTm2/3aK3Ed6xoog4xAzoU
 tyDiW4OqV9TYaeUSrfK0jpP5cU/dzuT3JsvEfPCrgLpIH4DmoR3dIQ/m/dN+3jTZqmni
 1h8A==
X-Gm-Message-State: AOAM533fvxyOh8AXEKT7Nl2Ry2BkIqYhYxy1wLAMnBxd2/Jur+7GdA10
 bZyn65pQ8i9cNxU1TSBeiVYz5A==
X-Google-Smtp-Source: ABdhPJzuKzr+e8QlT87GmxTbvScbbPlxAvskG2R7KQlipEbBT42aE3GSrSKX4prYCa8Lm053lNgIJw==
X-Received: by 2002:a5d:6045:: with SMTP id j5mr4936219wrt.209.1593195786722; 
 Fri, 26 Jun 2020 11:23:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 65sm18894760wma.48.2020.06.26.11.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:22:59 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7D1F91FFAF;
 Fri, 26 Jun 2020 19:14:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 27/30] gitlab: add avocado asset caching
Date: Fri, 26 Jun 2020 19:13:54 +0100
Message-Id: <20200626181357.26211-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626181357.26211-1-alex.bennee@linaro.org>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These can be quite big so lets cache them. I couldn't find any nots on
ccache in the gitlab docs so I've just ignored it for now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200622143204.12921-19-alex.bennee@linaro.org>
---
 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 17c3349dd9e..eb5b335c1e9 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -8,6 +8,12 @@ stages:
   - build
   - test
 
+# We assume GitLab has it's own caching set up for RPM/APT repositories so we
+# just take care of avocado assets here.
+cache:
+  paths:
+    - $HOME/avocado/data/cache
+
 include:
   - local: '/.gitlab-ci.d/edk2.yml'
   - local: '/.gitlab-ci.d/opensbi.yml'
-- 
2.20.1


