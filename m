Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590ACC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 20:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C85207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 20:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dlJ0ZBMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C85207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9wm2-0002YZ-B2
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 15:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j9wlE-0001am-CU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 15:06:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j9wlD-0000NS-8x
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 15:06:24 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:40337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j9wlD-0000MB-0w
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 15:06:23 -0500
Received: by mail-pj1-x1035.google.com with SMTP id gv19so42571pjb.5
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 12:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to; bh=SjkABZPI4KAtufXS32+txuVZk28FWhEFjtGst2XQOX8=;
 b=dlJ0ZBMj71hUL3RZmZBGGhfTCD29yWLBtEwWfealWIo/ZNef8xh7/K6grBHqa7tUjO
 oqUZdql4eGocSCCaOiOFdxzXUFKLjtCWBbtcQLX5hPe7EncfjVYX6larV/5sqF3WOoGh
 IpShU/q01BL+AXKsdf0g/1ysS1Bt50uLYnv+rt+Bgzg74bNBq1COeNMCzAozhPUX/YAg
 ZWm6oCO8vXfBlOESccVNXByG/jGRDC5SXsKiHCH6mA1jgq8mB3GWEF1LF1TL3MXwwXi0
 T3o5onWJKxThZzrDLJtP5keaICInsfEaLVibMs8EPb/AXSaXHJcV8P9ikCXq9fPjaOz7
 j6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=SjkABZPI4KAtufXS32+txuVZk28FWhEFjtGst2XQOX8=;
 b=TXPOu8hkp8PFDJbynsG8NfY8Bohk6tofp//xGF3RzsB+Gxb4jWMNGhVc9gU7Ror4GU
 obLzfVZej549gF8dqWmevym7s4a7N4rmCXDTliE8wvVRLuRLvPP0ky87sLQUU91a/w8V
 /tEV1XWLrP0+4SKaYuh+8WUCjkardq2i/2zWi1QFGds1DJoUcmUFm6yyIqZcF3st9Y1q
 fgKrna41XlhmzIS9+ZoXhmpC+7APSS6WDulMBzwHcJFSp9gZIBLmIrbJ9elDIjgplfkp
 MgYhjgI+IT0+BCqsZ5olH+XLy78h2hP2hMipZO9hvuCk+U4i1rRHBWTupu3unOrcZpmm
 4g2A==
X-Gm-Message-State: ANhLgQ1J98FlE9Suf6hwxGkiAoBkwBiNxX53cniwbTfJds2CWmgbA0Ws
 X8qF5TkZt1fg5wSrUn2egxRo2HjH2FddCA==
X-Google-Smtp-Source: ADFU+vs8d4D2nzeVxRfc+eqWbYIP3d07ZBQSGzliMCM5Uj1QoMabuCF6S+S2bYWhK3PxwBbcT27jvw==
X-Received: by 2002:a17:90b:1953:: with SMTP id
 nk19mr327254pjb.98.1583438781514; 
 Thu, 05 Mar 2020 12:06:21 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id b2sm6890898pjc.40.2020.03.05.12.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 12:06:21 -0800 (PST)
Subject: [PULL] A single RISC-V fixup
Date: Thu,  5 Mar 2020 12:05:57 -0800
Message-Id: <20200305200558.71104-1-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1035
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

merged tag 'pull-target-arm-20200305'

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200305' into staging (2020-03-05 16:47:37 +0000)

are available in the Git repository at:

  git@github.com:palmer-dabbelt/qemu.git tags/riscv-for-master-5.0-sf4

for you to fetch changes up to fd990e86a7c99f5c99d430160243a3bcc64b0dea:

  RISC-V: Add a missing "," in riscv_excp_names (2020-03-05 12:01:43 -0800)

----------------------------------------------------------------
A single RISC-V fixup

This is just a single patch, which fixes a bug found by Coverity.

----------------------------------------------------------------
Palmer Dabbelt (1):
      RISC-V: Add a missing "," in riscv_excp_names

 target/riscv/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


