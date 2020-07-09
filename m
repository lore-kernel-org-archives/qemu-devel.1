Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C03C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255572073A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wx4Q8ApL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255572073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXK4-0001v5-EU
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXIt-0000CS-L1
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXIr-0001K6-3c
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id q15so1987979wmj.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 07:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mziYoPJMSKM1jWfzpm/IJS+/PwzoS5VrAh2yuJs4L08=;
 b=Wx4Q8ApLdOhGKHMMsOwxI5oQI2isap65v/PDZoSWpAKWJMIjygOHcVXkndbmNR4DHh
 FKPIxCszkTq+Vu14+NX/AIzK2pxHxSgapj46374SF9xhKglS3H3nTeI7sjD7CqwhWkkf
 SqMH7U+eyLHhs4Dn6P11MzRnGWi14n0wVwQGmzgGS0Gc9lYVb1ls3veqkwcHOZt9PmMR
 dRhEyiyQlWpHr9Vkgg6GGJjt1TyNYO2e2i3jOyyPJWL4U9s7uzvXxe021TWKuKLpw1ZI
 lqBrcxBUe7Qeqt3re+D8tNMDgYRsIzx+famleELpXhoIZEpKrCL96cf/aBDIIplVszeH
 da5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mziYoPJMSKM1jWfzpm/IJS+/PwzoS5VrAh2yuJs4L08=;
 b=IF1/oBWg0GDpVsO67JeTI0lXKb9fexxX/eGQbb0hLw7p7m6BGs0qI9HljVIi8ts4gH
 tBOFcTy7k943QM4eU8VHeoFAMbeMoWwb4+voZx/MQ5yXtErgllMEanUPE7YLExbsRrR6
 VXYMElO2xAPdRNWlRkKDyAEGkzvaC3Fb8Mxl7rUyFmDpklHsWAhuXm9LO3qb3bMpfCr4
 XR4E/45P9nbl2N/qKrQk20bTzxBJ237HFigNSMcPnIM3mD6DeNeqejxsqQRoYha3J1cH
 xqC9VG5KHha1PAdOAg5hNlsVm2nYv5RVriBDqNHEhlLEOkO1pHI1UuagbR6R+xVoJ/a8
 AgpQ==
X-Gm-Message-State: AOAM532vVqebKiob0W7LtKteM4tMiLIj/8DmI7pBfJvduS57HQKHHN6u
 aJAOsC9Js161TQZkbPZyr507Hw==
X-Google-Smtp-Source: ABdhPJwjPdFvZyJl910qg2vn9X7ofcuOSXqfDYLM/yL3UvDCpUTaZT2OxHPIR7eLizMARxNvSMB02A==
X-Received: by 2002:a1c:1bc6:: with SMTP id b189mr214566wmb.166.1594304011717; 
 Thu, 09 Jul 2020 07:13:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k185sm5002369wmk.47.2020.07.09.07.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 07:13:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A3B981FF8F;
 Thu,  9 Jul 2020 15:13:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 03/13] docs: Add to gdbstub documentation the PhyMemMode
Date: Thu,  9 Jul 2020 15:13:17 +0100
Message-Id: <20200709141327.14631-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200709141327.14631-1-alex.bennee@linaro.org>
References: <20200709141327.14631-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, aurelien@aurel32.net, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jon Doron <arilou@gmail.com>

The PhyMemMode gdb extension command was missing from the gdb.rst
document.

Signed-off-by: Jon Doron <arilou@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200601171609.1665397-1-arilou@gmail.com>
---
 docs/system/gdb.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
index a40145fcf849..abda961e2b49 100644
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


