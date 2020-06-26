Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D91C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7348A2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRH7vjGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7348A2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jooDB-0005H9-PB
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jooCU-0004SW-1Q
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:15:26 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jooCS-00085l-Eb
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:15:25 -0400
Received: by mail-wm1-x342.google.com with SMTP id o8so8796889wmh.4
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 06:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=Lzo8DF7L2AGCx7xKZv/HuEOUiEGp1DIK+PvRtQEFOt8=;
 b=IRH7vjGRFhw5oKdiQGpjt0uLq8oFkwB2VrjT465ilXt8b4duiMqKWJqmomTNs8BObQ
 KcN4DD6NcDG5hrC3+lHf/K34mZ4JXEorQbGhxMSAmqYRwivn5NBnI+1LVG+GmXxF3XEp
 VQGf8wYOiKQ0P5+0oSZnFQ2uxjlEMIZFANdzMY02HX8QykEzZlBKJvGZsakcOd/L191z
 90Vj4J+37U752RVel97NZ2XxlAL4Cx/hQqNhg3nwg05saaEXb+RLORovddLAgMG53NnY
 XEsVci37MgL5z0lzK4WQNpvFdJJ+U43Xokkau0qqSOaSQ/FGSiJo+6tK8x7oeckMu9nW
 lcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=Lzo8DF7L2AGCx7xKZv/HuEOUiEGp1DIK+PvRtQEFOt8=;
 b=UqaAmSjZqN92LTby4LOfB+S8ha5aQHMwNFsb1e4oaJtfWopx8b3BFh7aEsSAXNIgks
 OetieeZ3T4hrrNheihwJkMoUCwfCFNiREBevDDDTPU/gICcTpcj1sV2vqc6QDGoB97PU
 IwjUCJgZ2YasdQHhmF67y9r/wmWG8Lc20PMftz3cdNByNV4/gM2AiubxKU9Qv8mARDiY
 /QZ+VDLiw86ldl3mxfnRLCYkzMCjdA90iAoa22ZeowutABnQUykNZpeyNFXdOsjSOrox
 QtnZQ2G5lA7B9JkCMaCXpKYdi/22ytv6DPxzvmtyIaWEMR8cFTQrCp1L0PPcR+OluCb7
 AJbw==
X-Gm-Message-State: AOAM531ledziGIBbk59j1P5bfPXQaYhhnxqQzuaINBMBD6eVyRCvnmPE
 nqypJ+SkT6DFILJC/UV99Sw=
X-Google-Smtp-Source: ABdhPJykHvpAmLF1LVvaRWN+tG8SulksT2oQ3tVSccwwI5TejU/O5QYAV1bgBzUq2B3q4sF+ru9fNA==
X-Received: by 2002:a7b:cf21:: with SMTP id m1mr3527425wmg.71.1593177322426;
 Fri, 26 Jun 2020 06:15:22 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id h142sm7670640wme.3.2020.06.26.06.15.20
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 26 Jun 2020 06:15:21 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Add an entry for OpenSBI firmware
Date: Fri, 26 Jun 2020 06:13:40 -0700
Message-Id: <1593177220-28143-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

List me as the maintainer for OpenSBI firmware related files.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b40446..b0e2dd2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2609,6 +2609,13 @@ F: tests/uefi-test-tools/
 F: .gitlab-ci.d/edk2.yml
 F: .gitlab-ci.d/edk2/
 
+OpenSBI Firmware
+M: Bin Meng <bmeng.cn@gmail.com>
+S: Supported
+F: pc-bios/opensbi-*
+F: .gitlab-ci.d/opensbi.yml
+F: .gitlab-ci.d/opensbi/
+
 Usermode Emulation
 ------------------
 Overall usermode emulation
-- 
2.7.4


