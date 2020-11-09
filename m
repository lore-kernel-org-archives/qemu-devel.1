Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E3AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE1920665
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M20kL2kq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE1920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcEzl-0001RF-4N
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 16:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kcExi-00085C-F7
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:44:30 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:36990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kcExe-0007fB-Fb
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:44:30 -0500
Received: by mail-wm1-x32d.google.com with SMTP id c16so982962wmd.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 13:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XSlTwROngisV9GGszX9Z7cojgUz4hcgCRiSSYiH/DTA=;
 b=M20kL2kq+DpIVCP7nWjz40dfJRHZuR4G3a8AWnriKYTfDc9ot1FB3awLXeKZHPjWLx
 HMZ1XdhIYP/gJnJc6LNotwzWR2XiQoS9nG2MLFo31PrQv3erMe8xllVUg9PjSiUCy/fK
 T/ZbBr8IZARZytAMVikWko7/dMla8e9F4LrlIO2CugDsbHzqjOzI42xu0GIPCZPx8xmS
 R5WgqWn2c5pqBB4Z+sfM8zgrlBwPVAHPQx3f6RseTL224IJ3xMiSQfGeeuXQpP0oIbOl
 Pp8DqGQfkRQ6r3T2AKXUt7qJOXVxngE1ZVx1cl47CbyBHUFPTEYtYgbRbItsgajNUXo/
 YEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XSlTwROngisV9GGszX9Z7cojgUz4hcgCRiSSYiH/DTA=;
 b=Yk+4tXIqcSPhTQdRxxbttE8rrhDiICg062yJGM1vJZgGZyKipW4hopSfmotQCCv3MZ
 pDePN83NR/5VT7WPFQlnYC6znoqMFllstoXjMewY0Ci3zeQgoki7CniMFrmOMSD1jOjn
 Z4qYzK4RxDuLnY9ZNoG5WJwWzorWza7bGhHftVeL+KJRkDsW51WxWk2C2q5HEZu/aHw+
 WtYZBKnxiC352K+fuWuut1DWOnIEW1/CMEMI8ZBOebe/v1l531O0DOZbgEW5aihDRnUq
 PFGQ9uqEQG1OpKxd1YygEDd62dvRvkfH+ahTHY/c9A6UED8iiNIKMAo6L42qgTxecJOG
 Pyvg==
X-Gm-Message-State: AOAM530K/NjwIg0PTHud7DTSS8pFlvra+L6/8M2vObEJ4MvBsWrHAYVs
 M/SCQGA6HwMylCOxLovR/XrFmCKqmG/gkw==
X-Google-Smtp-Source: ABdhPJyRb644MV2maV8+xV2bexIXxFo8Rsjr8Y3Fo9JWjRg5SQwmMvvgiSloyILu8J1JaBYeZnbxNg==
X-Received: by 2002:a1c:dd41:: with SMTP id u62mr1198353wmg.78.1604958263841; 
 Mon, 09 Nov 2020 13:44:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e3sm14913252wrn.32.2020.11.09.13.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:44:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC 1/2] docs: Mark rst files in the top level directory as orphan
Date: Mon,  9 Nov 2020 21:44:19 +0000
Message-Id: <20201109214420.32131-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109214420.32131-1-peter.maydell@linaro.org>
References: <20201109214420.32131-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a handful of rst files currently in the top level docs
directory. These need to be moved into their proper places in the
new manual framework, possibly involving splitting them into
multiple pieces.

In the meantime, to avoid warnings about these documents being
orphaned if you build a single Sphinx manual rooted in docs/,
mark each of them as being deliberate orphans.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/cpu-hotplug.rst         | 2 ++
 docs/microvm.rst             | 2 ++
 docs/pr-manager.rst          | 2 ++
 docs/virtio-net-failover.rst | 2 ++
 docs/virtio-pmem.rst         | 1 +
 5 files changed, 9 insertions(+)

diff --git a/docs/cpu-hotplug.rst b/docs/cpu-hotplug.rst
index d0b06403f19..d5fe2c7db1a 100644
--- a/docs/cpu-hotplug.rst
+++ b/docs/cpu-hotplug.rst
@@ -1,3 +1,5 @@
+:orphan:
+
 ===================
 Virtual CPU hotplug
 ===================
diff --git a/docs/microvm.rst b/docs/microvm.rst
index fcf41fc1f6f..8de8cea1864 100644
--- a/docs/microvm.rst
+++ b/docs/microvm.rst
@@ -1,3 +1,5 @@
+:orphan:
+
 ====================
 microvm Machine Type
 ====================
diff --git a/docs/pr-manager.rst b/docs/pr-manager.rst
index 9b1de198b1b..87a2f237f52 100644
--- a/docs/pr-manager.rst
+++ b/docs/pr-manager.rst
@@ -1,3 +1,5 @@
+:orphan:
+
 ======================================
 Persistent reservation managers
 ======================================
diff --git a/docs/virtio-net-failover.rst b/docs/virtio-net-failover.rst
index 6002dc5d96e..9d50d457e72 100644
--- a/docs/virtio-net-failover.rst
+++ b/docs/virtio-net-failover.rst
@@ -1,3 +1,5 @@
+:orphan:
+
 ======================================
 QEMU virtio-net standby (net_failover)
 ======================================
diff --git a/docs/virtio-pmem.rst b/docs/virtio-pmem.rst
index 4bf5d004432..aab35489851 100644
--- a/docs/virtio-pmem.rst
+++ b/docs/virtio-pmem.rst
@@ -1,3 +1,4 @@
+:orphan:
 
 ========================
 QEMU virtio pmem
-- 
2.20.1


