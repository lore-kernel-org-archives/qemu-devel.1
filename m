Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70568C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8839C206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UOV8RhnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8839C206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYELN-0005vi-25
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 16:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kYEK5-0005TO-4S
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 16:15:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kYEK3-0001QA-DU
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 16:15:00 -0400
Received: by mail-wr1-x443.google.com with SMTP id x7so4166313wrl.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7N7oKZMwd7h1K49wSrhLl7yGC+wR7WCLzITb/p/R9xc=;
 b=UOV8RhnZAzVbGCjC9OOpQib6M+caAmjkx5e+9OyXTLSwtalN1ygE3+2lXVfumUCkNi
 I9MrsLOkvQiwBzdC6pj+msnWC9Aq6PfgSrR2iK3sV7hThXx97PDTt8BcPAvRA0ofaLyO
 rnLw6q2Q678C1BlgzL/2U9CRyo/bEUdwPeoBd7CvWI3yfEntuA1yaCqqbLqRhjIDqJlC
 lQsFDzW8LqbjR/U2GsVJQlKsvSJuYLeUlH9MKedg6tkaM3piLrJedr73dFIIDz5m/BY4
 ITnQir4Y/uea0wc2XiadWXmrJxut+di+7XVmykniz/Cxo7n5S8emvZgyvfSsV7+gzxM0
 I+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7N7oKZMwd7h1K49wSrhLl7yGC+wR7WCLzITb/p/R9xc=;
 b=SdukAQPNvSHXnQE1pgaH7hLHEokAgFkhbNZbrHNfhbzlq4wji8IHsTTqbKUeU5vj5k
 3z+UuA9xZzNszrAa7n91V2/QUtrI9Y+Gn26JBwgdmbmkcVmeQSCMjexfQgar0FYZZaA+
 qvlYAnAkMNj0Ur9pfGWKoKdT1dQRke3y8Nj87LCPchsAN2gb2Y7wMszD2sb3zMyDVYJf
 FNpSBHyqVQIJAe5zp/ck6v7zlQugz//kFFUA7SNrnjDujAUKFGxgjSQ9V0tGdXZuxJNF
 ctGeyEVacEMDZB+qiV54cuIbN0sZm2FhfaW0Wq/jq40N7gm8KP5f0KZXAErkvm/vRTAZ
 HsoA==
X-Gm-Message-State: AOAM533hxhFq8S3cxRgHwCUtyH2EW200JH1Z32/Q2JAZ2ar94wIHWxro
 stjriH25HPGbGtr8QI9aIHAcFQ==
X-Google-Smtp-Source: ABdhPJxJXGYpLenaSR5JIekMh73ATWJ56+lIqn4NJSb0Okk7NE/v+bN/siwjIq3UlXgxidS4NpUNNQ==
X-Received: by 2002:a5d:6110:: with SMTP id v16mr8423758wrt.219.1604002497505; 
 Thu, 29 Oct 2020 13:14:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i126sm1716685wmi.0.2020.10.29.13.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 13:14:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 76F381FF7E;
 Thu, 29 Oct 2020 20:14:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: surface deprecated targets in the help output
Date: Thu, 29 Oct 2020 20:14:49 +0000
Message-Id: <20201029201449.6926-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: thuth@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Show the targets but keep them separate from the main list.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 55e07c82dd..6c2e9ff37c 100755
--- a/configure
+++ b/configure
@@ -1644,9 +1644,11 @@ Standard options:
   --prefix=PREFIX          install in PREFIX [$prefix]
   --interp-prefix=PREFIX   where to find shared libraries, etc.
                            use %M for cpu name [$interp_prefix]
-  --target-list=LIST       set target list (default: build everything)
+  --target-list=LIST       set target list (default: build all non-deprecated)
 $(echo Available targets: $default_target_list | \
   fold -s -w 53 | sed -e 's/^/                           /')
+$(echo Deprecated targets: $deprecated_targets_list | \
+  fold -s -w 53 | sed -e 's/^/                           /')
   --target-list-exclude=LIST exclude a set of targets from the default target-list
 
 Advanced options (experts only):
-- 
2.20.1


