Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D845C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29D5206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJ6cAyQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29D5206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8Vq-0005bK-VS
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nh-0002YY-UE
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:09 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Ng-0008Ka-E9
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:09 -0400
Received: by mail-wm1-x341.google.com with SMTP id k18so6552342wmj.5
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LXvU+0XkQjXvJi8RBmEkZmklmgOSv1oOkVzzR13SKwU=;
 b=tJ6cAyQAMuXh4ZKZEzlvS7E7gz26NhSsWq8j+3UBoz/APZLUUk4l/yrny7rcGXqlf3
 vvgS3Rgzttj7crbrxRDFEgzNUPFPRhO6BIN3ML+4dQrWhUaRKd/qRucs2jARfezG6P7/
 bSn3xAERChvyR8lZRslowaiEQ/qpRaiG9TSc1Tdgpl3+ZXW8H9ZQ5q9h46tJ6pHHyxdY
 ra1kyivZNLeSCNnAAEYQ8WqVSViViXSVY70XCh/lfGhQHFWX9eLuSChIuLAAd0t2jGmJ
 gXXFaC2x7f4DjBQTjs2r8bbXMfZm4P8/PmJokQJvyQdLF8RRknFPKwUJT4y18f998oU3
 HPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=LXvU+0XkQjXvJi8RBmEkZmklmgOSv1oOkVzzR13SKwU=;
 b=sLPhVDp/0HloMAvsDx5jfoJU+1C7WPcuLMJqJN8WiPUSDdQPERb25wBQfjUGZmMCPA
 Z6psTSQorH08LKW3/898ZJMPCum2lZGWqS+t2rlhL6REP01C1TOCJNg22Xj7lZc4cd5E
 yJQ+pTsAFXzwwyOLGtXtcK+0RTVyxJmSMGTFcZTOr/wGK6p0OkbTDH6ZcWQUWNq9DjpW
 7r6yaYehZueArCMTuJx7qL4u7Sj0x//gdm+rN61NBcgI/HBgrA2opYnH2mixw13EdJEm
 /xmOg56qFCYom2HQ2HB0yyQFACuO1Cy4EI7Dltjec93MJCDkCT4HfPzDaIg5/3Sln/nP
 vupQ==
X-Gm-Message-State: AOAM53282pwPy2OJXAuFGDGDpYDqPWjJOohqvKPyyfIkwGErcEFD+Roa
 uREFvxmwoDOlLH5FFo8+M4KZsxdJyhRIvw==
X-Google-Smtp-Source: ABdhPJzOUfThX3OMx3oUNAr68qjHOV7HVwIWtyvgyL1brL1uFGMHL8I/ci53LAJh6kfRGKNsyPBfUw==
X-Received: by 2002:a7b:c418:: with SMTP id k24mr12831281wmi.118.1601834707020; 
 Sun, 04 Oct 2020 11:05:07 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:05:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 15/21] contrib/gitdm: Add Renesas to the domain map
Date: Sun,  4 Oct 2020 20:04:37 +0200
Message-Id: <20201004180443.2035359-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004180443.2035359-1-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributions from this domain,
add its own entry to the gitdm domain map.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 contrib/gitdm/group-map-renesas | 3 +++
 gitdm.config                    | 1 +
 2 files changed, 4 insertions(+)
 create mode 100644 contrib/gitdm/group-map-renesas

diff --git a/contrib/gitdm/group-map-renesas b/contrib/gitdm/group-map-renesas
new file mode 100644
index 0000000000..4d54ec2307
--- /dev/null
+++ b/contrib/gitdm/group-map-renesas
@@ -0,0 +1,3 @@
+# Renesas Electronics
+
+ysato@users.sourceforge.jp
diff --git a/gitdm.config b/gitdm.config
index 1c56131769..6db72da339 100644
--- a/gitdm.config
+++ b/gitdm.config
@@ -39,6 +39,7 @@ GroupMap contrib/gitdm/group-map-ibm IBM
 GroupMap contrib/gitdm/group-map-janustech Janus Technologies
 GroupMap contrib/gitdm/group-map-nutanix Nutanix
 GroupMap contrib/gitdm/group-map-oracle Oracle
+GroupMap contrib/gitdm/group-map-renesas Renesas
 
 # Also group together our prolific individual contributors
 # and those working under academic auspices
-- 
2.26.2


