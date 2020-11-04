Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBE0C4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70779206FA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/D2Dj3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70779206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaM2i-0004mB-9a
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kaM22-0003wN-G5
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:53:10 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:35093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kaM20-0003hA-1u
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:53:10 -0500
Received: by mail-wm1-x32a.google.com with SMTP id h22so2996553wmb.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 08:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e7hx2epu6TkDikGX2gTL44YNju92C6OybaHDlJuBm2o=;
 b=d/D2Dj3VWnk9U5kRCA3MaUZxxxKqDpxvB9w6h0+MMXwGgLKP0lu8TKVPtG04ljbHuP
 emGyciwaOUiJ+TA4v0w6ez2x6v/5jGG0bEmdUFTVIdxtX74ZUaqDUCHXWSaCdASgGDv6
 YwYdr8/hXVHXcOetVFgurRIQVQfK8TmPJye19bIcClZ+YdKOcVYc7fUb7DXWlDBTBvXR
 7N9MQNSaj7XL8a6odLKZaYuUZhdljK1OOT/6eMfF/IBYWFt0GjWlHArkqCgXxWOXcImX
 5fNUdUFkk+w7y4imGNYgk+dhtNGRRG6hbAZ0JeuOeQoa0ayhu9lzNCejSga8npPxK8hF
 pgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e7hx2epu6TkDikGX2gTL44YNju92C6OybaHDlJuBm2o=;
 b=n2UvuK63YyzBFXdDkm/curS29aOaA/lbUCf+KxfN8keyoKxRPYOW3P8QuABK4YHvrY
 r8NDmAKh+yz5vBVbKvU4z0cwKb5ict4rQlzk2HlfZ0RJAiCgegX3AfJ2ohKwg79eppOR
 6850YiCMVs0pHcNjPRXHxeJJAIZ0cQshueRPMpC3r2wp23tf2/rPKBqnWShgpHGJ2m8O
 cEZilbF8QX9ANmnAc4GIGy3/+sW82rmvLurTfWqMqr3WdKySNIYhTFkiJdz2NuNVvfXR
 TG+5Qvw1jtUOpJZfG4S6cqVL/1DskSCaYjKx1J+KrpwORpuzQJpQdftELI+bLIC9udk4
 3i1A==
X-Gm-Message-State: AOAM533q/MFw4e5IQzN4hnIiMkphhY8W+Ww8BiBKjNq7FbX/2PgLo+gL
 8zbzGWKQr2KnJjWVL89f+aMDjg==
X-Google-Smtp-Source: ABdhPJzSu/C/rdOgwkODsAyKxiC/EWRDRVwn9VH2QOq54S5Vx1/InP+0hbju4vNTGtnnDK8P/TOvUg==
X-Received: by 2002:a1c:3c44:: with SMTP id j65mr5838805wma.13.1604508786628; 
 Wed, 04 Nov 2020 08:53:06 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u3sm3509429wro.33.2020.11.04.08.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 08:53:05 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 600761FF7E;
 Wed,  4 Nov 2020 16:53:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] docs: add some notes on the sbsa-ref machine
Date: Wed,  4 Nov 2020 16:52:54 +0000
Message-Id: <20201104165254.24822-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
Cc: Graeme Gregory <graeme@nuviainc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shashi Mallela <shashi.mallela@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Leif Lindholm <leif@nuviainc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should at least document what this machine is about.

Reviewed-by: Graeme Gregory <graeme@nuviainc.com>
Cc: Leif Lindholm <leif@nuviainc.com>
Cc: Shashi Mallela <shashi.mallela@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - reworded command line bit as per Leif
  - s/cortex-a57 cpus/AArch64 CPUs/
  - dropped the trailing .'s
---
 docs/system/arm/sbsa.rst   | 32 ++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst |  1 +
 2 files changed, 33 insertions(+)
 create mode 100644 docs/system/arm/sbsa.rst

diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
new file mode 100644
index 0000000000..b8ecfdb62f
--- /dev/null
+++ b/docs/system/arm/sbsa.rst
@@ -0,0 +1,32 @@
+Arm Server Base System Architecture Reference board (``sbsa-ref``)
+==================================================================
+
+While the `virt` board is a generic board platform that doesn't match
+any real hardware the `sbsa-ref` board intends to look like real
+hardware. The `Server Base System Architecture
+<https://developer.arm.com/documentation/den0029/latest>` defines a
+minimum base line of hardware support and importantly how the firmware
+reports that to any operating system. It is a static system that
+reports a very minimal DT to the firmware for non-discoverable
+information about components affected by the qemu command line (i.e.
+cpus and memory). As a result it must have a firmware specifically
+built to expect a certain hardware layout (as you would in a real
+machine).
+
+It is intended to be a machine for developing firmware and testing
+standards compliance with operating systems.
+
+Supported devices
+"""""""""""""""""
+
+The sbsa-ref board supports:
+
+  - A configurable number of AArch64 CPUs
+  - GIC version 3
+  - System bus AHCI controller
+  - System bus EHCI controller
+  - CDROM and hard disc on AHCI bus
+  - E1000E ethernet card on PCIe bus
+  - VGA display adaptor on PCIe bus
+  - A generic SBSA watchdog device
+
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index fdcf25c237..9636f3fd00 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -79,6 +79,7 @@ undocumented; you can get a complete list by running
    arm/mps2
    arm/musca
    arm/realview
+   arm/sbsa-ref
    arm/versatile
    arm/vexpress
    arm/aspeed
-- 
2.20.1


