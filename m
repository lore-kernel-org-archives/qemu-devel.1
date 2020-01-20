Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580AAC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231A52077C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tp6QlNkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231A52077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itSuo-0007Dm-N8
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 04:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ianjiang.ict@gmail.com>) id 1itStX-0005vP-Dw
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ianjiang.ict@gmail.com>) id 1itStW-0005ry-Ft
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:58:51 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ianjiang.ict@gmail.com>)
 id 1itStW-0005rU-An
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:58:50 -0500
Received: by mail-pg1-x541.google.com with SMTP id x7so15209882pgl.11
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 00:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=MFJ2qpZ8zHnGiukRnHYrH2nGWXWt0vSnyJjz650iuoE=;
 b=Tp6QlNkOwxCw5FaK6mlQuf6/dDh5oeJ47hZJax7Xi7EVJf0yrmx8KCr65rvSMzEjJq
 Xr4uPV3lnP8VGAUzTLB81yf0ZwNTgCtyikgXJFeOJtlLAs/gIGO/l7lBbVmirHBAncv2
 XPfZEeMi/5R3E+Or87daa6RXbKq95Adl4eCIB92RjpopOiGX6YwfU4gei5g7Ii1H+L9u
 IZLJzrXkyyfSOW4p3hSfkaAoKYnNIPDkHdK2Rs+5nPFn+WyJaUcj7lFPBPQC9MrDXt5j
 BO4IG//hk0kDGe7d9VzqG68KEEo9StfTSF2+YghQDmHHwRPmCmIdqdvkpLBQ7X6vuAXl
 FMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=MFJ2qpZ8zHnGiukRnHYrH2nGWXWt0vSnyJjz650iuoE=;
 b=kp5Oq2IzxqKPm981C+iaFftGLGrje7qaUAFU4kSN2SYkZEG9cJfPicbmnr3bils8Vy
 3vI3mRHMncvgICx2TnylooblCfCQzml0qGhy9E66+TkTqDDFoUCDgOqQpqMJBpPm2WJZ
 nOVTI31N3bIDJLsJtotUcPjxrFvr+b7GsQ4LESBLhDFdTBNJGphU8f/GbepdngXesWks
 cuXrw3AAlzCAgUyY+saBF2dZanAph1bYEWI1fiH+F7FEApCd+2F7q7h93uQtb1p8j67L
 MAwFefWMxaTNzL/gYCp/FYNuJJjJCu+lSK0sXQK/dVKU5bwmgC4NgVCUddQ3tNjuXsfk
 u2BQ==
X-Gm-Message-State: APjAAAWpBBRBDRTbHoNPrYlwuj9NtSt7F1xSi/z1te1YKOez8XjaUOxR
 hRY55TBzS8WMRt7u/PPLk8nfqD9Ezc1RG0cP
X-Google-Smtp-Source: APXvYqxh0pu1DLXpjoUzCDu5aZhBWO2y0JPyvLKj+CPsFX/CVkGvFhhs/WfTrnQNl89wvZhWVBYCEQ==
X-Received: by 2002:a62:cd81:: with SMTP id
 o123mr16781176pfg.110.1579510728974; 
 Mon, 20 Jan 2020 00:58:48 -0800 (PST)
Received: from localhost.localdomain ([111.196.189.80])
 by smtp.googlemail.com with ESMTPSA id e1sm38637307pfl.98.2020.01.20.00.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 00:58:48 -0800 (PST)
From: Ian Jiang <ianjiang.ict@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] riscv: Fix defination of TW bits in mstatus CSR
Date: Mon, 20 Jan 2020 16:58:17 +0800
Message-Id: <20200120085817.7000-1-ianjiang.ict@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com,
 Ian Jiang <ianjiang.ict@gmail.com>, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The origin defination of TW bits in mstatus is not correct.
This patch fixes the problem.

Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
---
 target/riscv/cpu_bits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index e99834856c..fb2e0b340e 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -349,7 +349,7 @@
 #define MSTATUS_MXR         0x00080000
 #define MSTATUS_VM          0x1F000000 /* until: priv-1.9.1 */
 #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
-#define MSTATUS_TW          0x20000000 /* since: priv-1.10 */
+#define MSTATUS_TW          0x00200000 /* since: priv-1.10 */
 #define MSTATUS_TSR         0x40000000 /* since: priv-1.10 */
 #define MSTATUS_MTL         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
-- 
2.17.1


