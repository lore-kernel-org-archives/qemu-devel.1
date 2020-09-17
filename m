Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2A6C43466
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 23:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE5520770
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 23:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gg3n0af5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE5520770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ3ng-0005UM-ET
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 19:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ3mL-0003kS-6K
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 19:57:29 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:44898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ3mH-0006da-BO
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 19:57:28 -0400
Received: by mail-pl1-x636.google.com with SMTP id j7so1982004plk.11
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 16:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PAoGDxgdRI2cTAcxVlRUCDHNuZhF/dJp7580Rsli9uI=;
 b=Gg3n0af5VRmxbh8h3oMb6DjYhCmKEXadXNdNeFf9VZdvGSDkK4dEol/DOLf4ulZ6NI
 Nh/Sl9HP3nVscScubqNcRd5k3B2WhCncaQQhsrIiUc27i8GWr9R1K0NqfSMlVEghfMHG
 fRvdO+WXASwwt8jdbjhNr0few7JqioEgP/q715qCZ0DmnKOH61u32QDttRWpN8jTmeaX
 npiHzbN5pkQBqLw9gSzeCby3F/XjdDeispdyz0uopTNqGTYy1aaGwTpMt6rGudwMpgOg
 t8//K98v6QIiUWqkqJI/+J9wsRot242n7AmAC5dH64N2B8VwlF+ai9N8k1CbM4ICBBXa
 xOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PAoGDxgdRI2cTAcxVlRUCDHNuZhF/dJp7580Rsli9uI=;
 b=EKZ7CqpArcp7OH2GCAMAsvU+RlT9XN5edHEovpTxblGvZgmEdeXz+hvlDbdPTChal7
 k/euqFxMMU+qtQXcowrHwgNjCnqkf+hCneK4xDIyBdMgbrbMEQ9cBmY4QYW0ZBewNKIi
 IfoK5/3pYwMKO67oTl4hUKijTt265QgtfCiRsY4/HFvvOf2DTPFKWI0cLCOxWC3D4WCu
 Mi1oxTQ3/ZGva5XjYPytjq7NBId/2Gw5jfiBv3ribKFzUEF8hozpB87AOD/19QFJySJC
 kCw0nL6R1Ja2BooZasT48FwBUEXLvmkN2OZoxTYp27nywBiNKyfpU+JcaCC+0nUsT9Jw
 krrA==
X-Gm-Message-State: AOAM531xlNX50y+9apqFDVd04Wm2NnRUGtWkNqQdnlGvq1jy33FoCEBR
 6JakVYYJr//x9kxu/3OXYWg12Kul/uThvA==
X-Google-Smtp-Source: ABdhPJx0wPlCNlnohzXOhArMGfikaMny8qqiXI0mFcWbqJr9o+0awpH1wHtmKKGT3gm3SE6lgnwwsg==
X-Received: by 2002:a17:902:b7c7:b029:d1:cc21:9c38 with SMTP id
 v7-20020a170902b7c7b02900d1cc219c38mr19729708plz.21.1600387042580; 
 Thu, 17 Sep 2020 16:57:22 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m13sm772699pfk.103.2020.09.17.16.57.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 16:57:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/10] capstone + disassembler patches
Date: Thu, 17 Sep 2020 16:57:10 -0700
Message-Id: <20200917235720.2685978-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The primary change here is the update for capstone to meson.
This bypasses capstone's build system entirely.  There's more
commentary on that subject with the first patch.

Plus a collection of other fixes and cleanups in the area.

Patches still without review/ack:

0001-capstone-Convert-Makefile-bits-to-meson-bits.patch
0002-capstone-Update-to-upstream-next-branch.patch
0006-disas-Cleanup-plugin_disas.patch
0008-disas-Split-out-capstone-code-to-disas-capstone.c.patch

Changes for v3:
  * Fix default value for capstone in meson_options.txt.
  * Add "Submodules" separator in meson.build (paolo).
  * Remove form-feed characters in dis-asm.h (thuth).

Changes for v2:
  * Several configury changes in patch 1, along the lines
    of that suggested by Paolo, but not exactly the same.
  * Drop sparc capstone enablement (I suddenly have a memory
    of doing the same thing last year).


r~


Richard Henderson (10):
  capstone: Convert Makefile bits to meson bits
  capstone: Update to upstream "next" branch
  disas: Move host asm annotations to tb_gen_code
  disas: Clean up CPUDebug initialization
  disas: Use qemu/bswap.h for bfd endian loads
  disas: Cleanup plugin_disas
  disas: Configure capstone for aarch64 host without libvixl
  disas: Split out capstone code to disas/capstone.c
  disas: Enable capstone disassembly for s390x
  disas/capstone: Add skipdata hook for s390x

 configure                 |  61 +---
 Makefile                  |  16 -
 include/disas/dis-asm.h   | 104 +++---
 include/disas/disas.h     |   2 +-
 include/exec/log.h        |   4 +-
 accel/tcg/translate-all.c |  24 +-
 disas.c                   | 703 +++++++++-----------------------------
 disas/capstone.c          | 326 ++++++++++++++++++
 target/s390x/cpu.c        |   4 +
 tcg/tcg.c                 |   4 +-
 capstone                  |   2 +-
 disas/meson.build         |   1 +
 meson.build               | 124 ++++++-
 meson_options.txt         |   4 +
 14 files changed, 678 insertions(+), 701 deletions(-)
 create mode 100644 disas/capstone.c

-- 
2.25.1


