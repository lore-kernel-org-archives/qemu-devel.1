Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91988C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19696207D4
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ybIsQBRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19696207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juJ0e-000820-3i
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 13:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIyU-0003Qs-8e
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:42 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:37237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIyS-0006hd-NL
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:41 -0400
Received: by mail-wr1-x436.google.com with SMTP id a6so8983416wrm.4
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 10:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QZgACP9mcgOL9A6hGvRHJisqOakSnkvmaCw7DGKHJB4=;
 b=ybIsQBRgp71vot6Tcww53CagwK95DArefenBsVpoKA3c4qFUdhBEnMnYFusxgBZkB4
 QxN+pQQo+qBoQFyVssUzbI56K4QNRg7aT+Qn73CjKKxt321K3pITpYPkL2QvbJgjZ09p
 wwDw0h2XNfFxItbBE/eVYzhMgd7TJEUYKbcahgWwXQMomvf+3LXTL+4UX8jPBe76m/U6
 3DGCuJ/4iHkMRxf1oPQVk6ixp1c2rWvnvmL6/pg1hcq0SSnkdXgj5cXnyLsTgU8M/Vfy
 qRn0NIrHnaZ6ItRPIZT35lkiZTdVLBUEmx+Lcys0ILEj31wwLqXJgr5mgCxM91hAz/VR
 lfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QZgACP9mcgOL9A6hGvRHJisqOakSnkvmaCw7DGKHJB4=;
 b=tj9rcnzS/88VHgaDb2ZhGeoIVJ16hEgna8CIszaeBp7XDuhLKOEOqenp0uvM0hm69t
 JLHVr/mk/T65qWP0uq3o6vB8RpSM0t7FyovkfJUMTES8e0X7m7H1KtK76TWOiy955KhJ
 wLGrad3YCGW9H4a9LOwvLFlSqFS6b2Ll9HVj5VhWf+ZUEeU20rTmczQAV5bRhExVKRzu
 AAEjFQ0pBCXXV7+UAROmWYusZroN7QrHAtVuU1oxhGM2c2snvOMoPgJet4dNEuCaQdte
 qx+B30eMzhjye8w+/xK43DR85rwlmwtyngDWIHCuhp9yY4rvqUXzyxgue90c/otbNjQz
 ADxw==
X-Gm-Message-State: AOAM530gpaahRBrInI+IYG6vBn70RbW9yA8R7zCKCPqMpbCvXmAq+BeQ
 cWwHnrWziUpqrHWo/9H6ZXXAXQ==
X-Google-Smtp-Source: ABdhPJyN9kJJtG4mxW5e+r+aC2ybmMoBCZxM3pxwfhgGhAvzeq9qh2lUfxyhXtIVM/86XgTQpG0qIA==
X-Received: by 2002:adf:e850:: with SMTP id d16mr75672889wrn.426.1594487259405; 
 Sat, 11 Jul 2020 10:07:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g144sm28904932wme.2.2020.07.11.10.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 10:07:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7CF761FF90;
 Sat, 11 Jul 2020 18:07:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 44/50] docs: Add to gdbstub documentation the PhyMemMode
Date: Sat, 11 Jul 2020 18:07:26 +0100
Message-Id: <20200711170732.26213-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711170732.26213-1-alex.bennee@linaro.org>
References: <20200711170732.26213-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jon Doron <arilou@gmail.com>

The PhyMemMode gdb extension command was missing from the gdb.rst
document.

Signed-off-by: Jon Doron <arilou@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200601171609.1665397-1-arilou@gmail.com>
Message-Id: <20200709141327.14631-4-alex.bennee@linaro.org>

diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
index a40145fcf8..abda961e2b 100644
--- a/docs/system/gdb.rst
+++ b/docs/system/gdb.rst
@@ -87,3 +87,23 @@ three commands you can query and set the single step behavior:
       (gdb) maintenance packet Qqemu.sstep=0x5
       sending: "qemu.sstep=0x5"
       received: "OK"
+
+
+Another feature that QEMU gdbstub provides is to toggle the memory GDB
+works with, by default GDB will show the current process memory respecting
+the virtual address translation.
+
+If you want to examine/change the physical memory you can set the gdbstub
+to work with the physical memory rather with the virtual one.
+
+The memory mode can be checked by sending the following command:
+
+``maintenance packet qqemu.PhyMemMode``
+    This will return either 0 or 1, 1 indicates you are currently in the
+    physical memory mode.
+
+``maintenance packet Qqemu.PhyMemMode:1``
+    This will change the memory mode to physical memory.
+
+``maintenance packet Qqemu.PhyMemMode:0``
+    This will change it back to normal memory mode.
-- 
2.20.1


