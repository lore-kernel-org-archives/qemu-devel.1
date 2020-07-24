Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BF6C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C3B2067D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks9OfA5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C3B2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz0x9-0000fU-2N
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 12:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jz0wT-0008Jm-SI; Fri, 24 Jul 2020 12:53:05 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jz0wS-00049r-Cz; Fri, 24 Jul 2020 12:53:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id q5so8910362wru.6;
 Fri, 24 Jul 2020 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bAVTZOupnGMYvubPUriAuW0Htk+wYR8jr99gkQhkeZA=;
 b=Ks9OfA5yYhMuqBEwuQJIgcb76xljJ97YRKE5QHWCMk1A9a6iDPXNxHcFcFaIp91JpU
 pRwOMXwWDO82mfkkLfsFhVIvlyPPqY8992bUco4RCL+DBsJFxGdFP0N5lDR9dMOhOMv4
 fB7PNIMcnpD0o9Cg276zg7dN7mxKVym3qWjYGUWaeJbuV8+SbrAFU59E/ESA5K70+/TU
 eV+iqEqZUaW8Q0D7nCTpWjgxvVWkAK4bcnposnZQgQgmHOymHr4pQi0oAKmnG85CHfkv
 4HaDZ2I7MuzvH6XI8BGypZAhkorhbL5jQ006MMPsrkXYrfUvg0/Q2NaGAixqMTEjtyow
 3Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=bAVTZOupnGMYvubPUriAuW0Htk+wYR8jr99gkQhkeZA=;
 b=audPu2FObcdWDYuj0cspJVON26/a5vXo6l7XohB/hURc8khRHfh8ecoHQ6seDIlROt
 ymZuDFM6XKYtNs7BML96qtUmVSaGz2TW8Yn1qMGHBsJ8gnOYWbmPnlg6H0t+XWcWe+Ls
 t2O56SuZxf5v/CQ7MDP4q8N2fbIYMjUUS2qcq8kWEiUEVF9BvBmYL8h/rQTEfDG5MjSa
 R0qzeXbQN2wb1oE6JNdQRgEkz03XCrcgSKoAXG6pB9c+ri47DmUs4JzIVOt2sRGxgXAW
 R0VZc4DQzYEOPKTJSqJbelQ8cSHEK11FxHlzAUzXR+9nbd5C1PdEA9xSkYD7v4oMOvgN
 CWKw==
X-Gm-Message-State: AOAM533zDGX2SAqvgSt91qTkj4N4Ggydi2l9AiMZtQa3fbeVTtB3yNaw
 z0Fj01IsZeown6QGM5c5Yu5ToZwI
X-Google-Smtp-Source: ABdhPJwpWcNJatZcmykOrr2S+Cevrs3GdkZx71id3d3Akx1uXNZibqLXRvQzeM6CZEmZRaxKQvHeuA==
X-Received: by 2002:adf:e704:: with SMTP id c4mr10200699wrm.81.1595609582252; 
 Fri, 24 Jul 2020 09:53:02 -0700 (PDT)
Received: from localhost.localdomain (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id t3sm2164830wre.41.2020.07.24.09.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 09:53:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] default-configs: Remove ACPI_CPU_HOTPLUG from MIPS
 machines
Date: Fri, 24 Jul 2020 18:52:59 +0200
Message-Id: <20200724165259.19939-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No MIPS machine uses the ACPI cpu-hotplug feature
(QEMU implementation is X86 specific).

Fixes: 135a67a692 ("ACPI: split CONFIG_ACPI into 4 pieces")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 default-configs/mips-softmmu-common.mak | 1 -
 1 file changed, 1 deletion(-)

diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index da29c6c0b2..e9c208da3d 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -21,7 +21,6 @@ CONFIG_ACPI=y
 CONFIG_ACPI_X86=y
 CONFIG_ACPI_MEMORY_HOTPLUG=y
 CONFIG_ACPI_NVDIMM=y
-CONFIG_ACPI_CPU_HOTPLUG=y
 CONFIG_APM=y
 CONFIG_I8257=y
 CONFIG_PIIX4=y
-- 
2.21.3


