Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF05C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8C02071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZolPyyYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8C02071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNhm-00020K-SK
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNZk-00061t-Fy
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:37:32 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNZi-0006aE-QY
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:37:32 -0400
Received: by mail-wm1-x342.google.com with SMTP id g10so15103237wmh.4
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 07:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dpnea5tgBr5eCnz0xsYvFDQLPTuuc6m9Mmvt4C1s0eA=;
 b=ZolPyyYC8yN8buNdSKVSPpCvndq4fcDi/bkkH/ySGqrvTH6Ji5bNgJfoaCKt/RAlym
 s5ZAO+uDpKG7X3oWldfHi9WVN9eedlxqTDsCN4RgiBV3SV7nWoMLbkAkbHf3XAib7EnM
 Dgqo4qNAinkcxuifhFOsENeZQzIIwWsQVDMyNYQjQyoP1bL/3XhGRFxn/B/fZCzwctA4
 fG2d5/LeKRUJzlmXn+URue0XBSpqKjGPVXJeQlY7KXRoRJKuEA1ESnIYJxx7xVLlbc1i
 JvqbHaREqLUYBDyCXsrNpxnkkVSGcdIa6MJzdKFqvpoh7EHh718QrhO2bBczzzsRlu1N
 LVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dpnea5tgBr5eCnz0xsYvFDQLPTuuc6m9Mmvt4C1s0eA=;
 b=Lmxsd7VDA3fUB0Ga2iVnxcC13nh/nHU6XVteI5dT/MagVB99e+FndWId81UtfywlGS
 LyKBbdhWQtnW0oygiNi6AdE+IoaYb40zOB8VvCOLma3gU+yv/XVzfQ3aC6ndUOrAChhz
 dfZuHvHz5Kv4VgPEfgX2t+OdGeKMJezqijXbPgG9kfnYaxZ7bkTxKN9Dov87Msibm3o/
 M0a8uO8ccZ09wYttNaWjkUcSf5XXlIJyf7iNpbowUCb87OKOmCIBYlohhSqblp6SmOa8
 TD7/lWwOrl7NR3j8epux1Qw80SXdcoa+A7ZiN4iEzvTlI1WqkZP/LLNc45gBpsOFA7dD
 LjVw==
X-Gm-Message-State: AOAM533p0UxUl5cYQ/oYcu0aRAmn2DUFHlUcDwFpHGMR0hIj7yXnI3A9
 wtQ3poaFMJgBqyU54R+Bo6qWlw==
X-Google-Smtp-Source: ABdhPJyb3G3YQ4eyt0CIfSnlIr+KeD9cC2jyPa0pkUfhDoikcIAayIfii+fO9iXk50dZwPUHaGyPkQ==
X-Received: by 2002:a05:600c:2307:: with SMTP id
 7mr5775371wmo.115.1592836649483; 
 Mon, 22 Jun 2020 07:37:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n8sm15088881wrj.44.2020.06.22.07.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 07:37:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7939D1FFA6;
 Mon, 22 Jun 2020 15:32:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 18/18] .gitlab: add avocado asset caching
Date: Mon, 22 Jun 2020 15:32:04 +0100
Message-Id: <20200622143204.12921-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200622143204.12921-1-alex.bennee@linaro.org>
References: <20200622143204.12921-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
---
 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7816f1434c3..693ecad770f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -14,6 +14,12 @@ include:
   - local: '/.gitlab-ci.d/edk2.yml'
   - local: '/.gitlab-ci.d/opensbi.yml'
 
+# We assume GitLab has it's own caching set up for RPM/APT repositories so we
+# just take care of avocado assets here.
+cache:
+  paths:
+    - $HOME/avocado/data/cache
+
 .update_apt_template: &before_script_apt
  before_script:
   - apt-get update -qq
-- 
2.20.1


