Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77050C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 21:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5662076E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 21:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzN5dF1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5662076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8rz6-0002we-9A
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 17:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k8rxp-000268-Ch; Thu, 20 Aug 2020 17:19:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k8rxn-0005mJ-NC; Thu, 20 Aug 2020 17:19:13 -0400
Received: by mail-wm1-x344.google.com with SMTP id t14so3223908wmi.3;
 Thu, 20 Aug 2020 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hbIrPl+rsWG1vBV69qHS3hfday0JjoBFKP80JFbnZcI=;
 b=mzN5dF1ppjLxAmgLB8GD9y+/dYvoZMW1QzxIt+IA55aZz0v0+vbM3N/UiM+SMzqVfL
 /VMH6CUD1vl+HrppI5ghk+5NOHjzm+yNXdswct24D7r/M0cd5t82ohFaVJFGIVAqx9G+
 gX0OTsbNu7mRwMGt0NLN7+85f6SrU0XGwy826bGD0+7z6MaC24/UddkcZomYNufAq9aN
 p/QkXyOjfnWhycVVVQnJq0jsvW9Y4RCVnHswLU3gWGEJ+kl2jod5BBt2zIxY6uW5/2U5
 D+w9vmTQu7bUM3vbgl62mmmwGFDCCPfTEF45nbu4vi7gkTR8tp6dBL+3LKY6MIYh3B1v
 +MBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hbIrPl+rsWG1vBV69qHS3hfday0JjoBFKP80JFbnZcI=;
 b=t9Xh6gmmyKahsYM2Lb8APgwLyH81c4L/xPSQ9XCQ4gA0ecLMvL3salS2bX/+6/547S
 00e1rBVy6Hk0XoW/tCg6hLfuwy6CixpOIarSV5h5Gtc6fG2ftK7eAdqo5DIAnoL9gXZ4
 KeHYAOXBn4OuK8y28t9PcK20fNx301PhEUqiIMhgBX9sL2tDvN1XM2pdFUbEdZlHBrW5
 44V9fOd6gTVIFb88l+Y9UbS5dcYdlzH4Ku7nhhhX0qaDaOdetL2NSddOuEnFP5ZA8wWC
 StQ5fsXqaeBcIH5tP+vtXI44ilCgHSHcmlEJFrLfhzKgX1O3GL4fo5YU+PQKwD4C0ZR5
 r21A==
X-Gm-Message-State: AOAM5315DwT2rgYJclfRwkvMtW/qwHQL/+zN+q7efp62UoXWQ4gD0FOu
 8YcRMmSidyzHJ9/Blu1hO8yTqycOzY+rsA==
X-Google-Smtp-Source: ABdhPJw3AJHGVGXNbGs99Or1NSDRNE1QzOmgzbEvG0/3nBmBiuVclz+DQX3+dmmwlJ6PN6fTh1ttvg==
X-Received: by 2002:a1c:c1:: with SMTP id 184mr363061wma.105.1597958348824;
 Thu, 20 Aug 2020 14:19:08 -0700 (PDT)
Received: from localhost.localdomain (109-186-18-89.bb.netvision.net.il.
 [109.186.18.89])
 by smtp.gmail.com with ESMTPSA id j5sm6857766wma.45.2020.08.20.14.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 14:19:08 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-iotests: Fix FilePaths cleanup
Date: Fri, 21 Aug 2020 00:19:05 +0300
Message-Id: <20200820211905.223523-1-nsoffer@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If os.remove() fails to remove one of the paths, for example if the file
was removed by the test, the cleanup loop would exit silently, without
removing the rest of the files.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 dtc                           | 2 +-
 tests/qemu-iotests/iotests.py | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/dtc b/dtc
index 85e5d83984..88f18909db 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit 85e5d839847af54efab170f2b1331b2a6421e647
+Subproject commit 88f18909db731a627456f26d779445f84e449536
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 717b5b652c..16a04df8a3 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -468,11 +468,11 @@ class FilePaths:
         return self.paths
 
     def __exit__(self, exc_type, exc_val, exc_tb):
-        try:
-            for path in self.paths:
+        for path in self.paths:
+            try:
                 os.remove(path)
-        except OSError:
-            pass
+            except OSError:
+                pass
         return False
 
 class FilePath(FilePaths):
-- 
2.26.2


