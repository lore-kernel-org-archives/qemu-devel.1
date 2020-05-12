Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9EFC54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C61206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lve2YfLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C61206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYP2a-0007VK-Fq
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 03:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYP08-0004Ov-1E; Tue, 12 May 2020 03:06:52 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:36822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYP07-00085D-8R; Tue, 12 May 2020 03:06:51 -0400
Received: by mail-ej1-x62d.google.com with SMTP id z5so9311112ejb.3;
 Tue, 12 May 2020 00:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6Uadd1ojRpaMx0mLMXfks6u0zzq06r1l8ClSFuRdt/0=;
 b=Lve2YfLxhhXeSgv5Krij9v7iClkHFU9IYLL1EMzOtur3IbsSeX5J2PhnP3ea5rcDow
 KCO/7Ix8CN9b+m8CsAIY0pmFSuliKq3InStM3c/YPkvHoUAI+y/XOstktewpaTglkXEe
 R029xn2fabGHuoCSfdrlWuPlCbDMHh8/rZPfQBZ3f/I/qECKUWyVOt/48IDcOiOJM+th
 Acida2utRJvngm7vbXkBRC04KtD2Tgqr7TWTLwHQjfEi/LDTgJaXwtDV0yg21iRrQduo
 cboOXzAuYYEkATvUfF2mEzCPhSE0PHvgXw6PKJkBHZ5g7KKbzBAPoFbjnYSPlwkrU4xY
 YR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6Uadd1ojRpaMx0mLMXfks6u0zzq06r1l8ClSFuRdt/0=;
 b=jPS4w/Z1c5gNnxNPeqhU0I4ODDqG0MpsRHjptUu07lILvX6RekKCS0TbYheQVmias1
 AxaZtdUFVL8khZJmCfR1PEFgZOeJTzqA9vx9MxCz7e1ydYhFn/rEL2A5FYa4N6x6odbz
 Um0FgHTwjIvFCu8t7d3s9gJDsSXLIxpE2TAmGxx1n4FePXKqs1y1JiPp4UbuOFlUqtZl
 pXNcZ7i8kdw+4eR8YcQcaY7SAlzuQBKYhvL8HsPTJIm7rjhPqSguMm443EMPZZgAwle6
 q74d5ZlVVZmQrgShOFuYi5zdjAH8RRzQ2FYEYY8ujnVlOiX6BFrF2O4SHjGXE9ba7A+z
 8ZYQ==
X-Gm-Message-State: AOAM531M162Ntii+2R3vH0LRIKmMDID1JBoM2O5flRY+VuBHRq5DOlC9
 9Dm8UKzrYMWd2u8W4GnHz9Waq6ZSpqM=
X-Google-Smtp-Source: ABdhPJyuIeaK/oBHofNRayb58D3awM1asnahvw86j9vw44VhzMHZmbFRxKnXxl0x1VRgby9/5HHuoQ==
X-Received: by 2002:a17:906:f84b:: with SMTP id
 ks11mr4649807ejb.114.1589267208486; 
 Tue, 12 May 2020 00:06:48 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id ch8sm247345ejb.53.2020.05.12.00.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 00:06:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] scripts/qmp: Use Python 3 interpreter
Date: Tue, 12 May 2020 09:06:42 +0200
Message-Id: <20200512070642.23986-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200512070642.23986-1-f4bug@amsat.org>
References: <20200512070642.23986-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x62d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qmp/qom-get  | 2 +-
 scripts/qmp/qom-list | 2 +-
 scripts/qmp/qom-set  | 2 +-
 scripts/qmp/qom-tree | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qmp/qom-get b/scripts/qmp/qom-get
index 007b4cd442..7c5ede91bb 100755
--- a/scripts/qmp/qom-get
+++ b/scripts/qmp/qom-get
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 ##
 # QEMU Object Model test tools
 #
diff --git a/scripts/qmp/qom-list b/scripts/qmp/qom-list
index 03bda3446b..bb68fd65d4 100755
--- a/scripts/qmp/qom-list
+++ b/scripts/qmp/qom-list
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 ##
 # QEMU Object Model test tools
 #
diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index c37fe78b00..19881d85e9 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 ##
 # QEMU Object Model test tools
 #
diff --git a/scripts/qmp/qom-tree b/scripts/qmp/qom-tree
index 1c8acf61e7..fa91147a03 100755
--- a/scripts/qmp/qom-tree
+++ b/scripts/qmp/qom-tree
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 ##
 # QEMU Object Model test tools
 #
-- 
2.21.3


