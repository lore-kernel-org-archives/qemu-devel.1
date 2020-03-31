Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C75C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7D32072D
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lPyu/ewk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7D32072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ80P-000694-BE
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 23:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7zS-0004YL-AC
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7zQ-00085u-Vh
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:01 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:46129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jJ7zQ-00085H-Id
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:00 -0400
Received: by mail-pl1-x635.google.com with SMTP id s23so7599697plq.13
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 20:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UMJ5rP4/AhqOnU8ytGj+LRCSD2lPIcURsLCVP9COfKE=;
 b=lPyu/ewks3d+UbO7RhinHc+VSqvqFpTkRylkWJMcHBujLKx98QQ6Dj7ym1YFZydmoJ
 k0IdhEkUzT3QzgtMalwydogh5PKrSgdddDUzBARHzlEEhwRTHbf6mIEB8LbJeYS7etBW
 o/At2v11y+1QN5KmPwPZIKXGxUkm1J8QHCoibLpChnStC4UIfKC3O/Z0OvPB+8vVgb0r
 RFyhZKzmngC3nguo9PbemukqMpzpEEdkfRhHgqkIEAxlMPyAmcyfSlS9deMDyKCLU1gG
 qrTHCAgOxbp0Bj5d5Vd0FK/LusQ3Grk6iwr2ZCkPFbYb1ePuLteWUtpZPW4elmTPYGBO
 GSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UMJ5rP4/AhqOnU8ytGj+LRCSD2lPIcURsLCVP9COfKE=;
 b=ZJEPdTUIqmD7c98KaWE68CNdi/mYDk1546uWG6nP5UFLbtba4oJPhiXmTt74bVvbB6
 k2ht25MpjQtPQv+R3hJajQBiTFecbzMfDSYYICxe2hQhZfOFeusYTaX4xV0pivdEMO7y
 xjKzr09VPPOvegeMmtl/P3m3en90JieNCnsoR/pSkGQ/FV5RIw78bdjtVHRctDuhrngy
 Zl23nhd0E+98QIIda/O0fAU8czCLMRuiivrHa17KWzJ+LsZmAAvyTbuHcT8dPKyEThU1
 4JuEnyWGNR5LjXDpLXMOHTcbTy4+4ScGzZp34x3PjB68hYh3FmDCtXhe70Idmdmdj6/B
 hUwQ==
X-Gm-Message-State: ANhLgQ2fwM2NKNPQ+acxZR0D5ALZ9xLgDUDZ75JTDPJVROkAkAjRe6gQ
 1IQDGn/w98pzNyBcDw+xOzpLZ/EDrt4=
X-Google-Smtp-Source: ADFU+vtrhfyz/TdM4g6FkjRvmUEH1GaLoNQxeKBuaV/b6X1jOh7PrVZ62rY3qkR6S71R5AAwD53HNw==
X-Received: by 2002:a17:902:6b48:: with SMTP id
 g8mr15420403plt.149.1585626898667; 
 Mon, 30 Mar 2020 20:54:58 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h11sm11386174pfq.56.2020.03.30.20.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 20:54:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 00/10] tcg patch queue
Date: Mon, 30 Mar 2020 20:54:45 -0700
Message-Id: <20200331035456.6494-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::635
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

My tcg patch queue, plus one mips patch on request of Aleksander.


r~


The following changes since commit 5acad5bf480321f178866dc28e38eeda5a3f19bb:

  Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2020-03-28 00:27:04 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20200330

for you to fetch changes up to b412378785c1bd95e3461c1373dd8938bc54fb4e:

  decodetree: Use Python3 floor division operator (2020-03-30 11:44:04 -0700)

----------------------------------------------------------------
Improve PIE and other linkage
Fix for decodetree vs Python3 floor division operator
Fix i386 INDEX_op_dup2_vec expansion
Fix loongson multimedia condition instructions

----------------------------------------------------------------
Jiaxun Yang (1):
      target/mips: Fix loongson multimedia condition instructions

Philippe Mathieu-Daudé (1):
      decodetree: Use Python3 floor division operator

Richard Henderson (8):
      configure: Drop adjustment of textseg
      tcg: Remove softmmu code_gen_buffer fixed address
      configure: Do not force pie=no for non-x86
      configure: Always detect -no-pie toolchain support
      configure: Unnest detection of -z,relro and -z,now
      configure: Override the os default with --disable-pie
      configure: Support -static-pie if requested
      tcg/i386: Fix INDEX_op_dup2_vec

 configure                 | 116 +++++++++++++---------------------------------
 Makefile                  |   2 +-
 accel/tcg/translate-all.c |  37 ++-------------
 target/mips/translate.c   |  35 ++++++++++++--
 tcg/i386/tcg-target.inc.c |  10 ++--
 scripts/decodetree.py     |   4 +-
 6 files changed, 78 insertions(+), 126 deletions(-)

