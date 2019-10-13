Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B6EC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8248220673
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1d3Ki3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8248220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmL8-0008Hq-5e
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJC-0006Xy-7r
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJA-0000oe-Oy
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:49 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:42304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJA-0000oL-JQ
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:48 -0400
Received: by mail-pl1-x636.google.com with SMTP id e5so7127648pls.9
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M9R3OnmWTj4pP1yFiSVngG2aJy6lC36iJTj89+hW20g=;
 b=H1d3Ki3Y6L+kJyS8K7HatN1cLw/fmUyVFUEAYZvWizoPPbUCy6ZRKz0Fr8e+qT3ufv
 QS4UL/yWYk0f465peiGeWL4zbb1Pnc4tUXR5kUXy3zAdPwVUF3SaW/S+FnhK+mUzLxkG
 oeCnsN4GF78/PscdXYRjLKgTNPwGToYgUbJN0kXb6V+LUz8cqW5nP2L6gi7C8jWD53lD
 gMDmoiPdMiyYOH0bqqGqZKGpuMM6sybLWSoYp6gi5fMQdL4MWKE+AGJfyTgeKADsM6xo
 GSxs7iQboKXXkWaP1LXYNmeyRW8AdLhZVDwJA2bYmIls8JMeayZtfb4hcG4VXC4xWTRZ
 s/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M9R3OnmWTj4pP1yFiSVngG2aJy6lC36iJTj89+hW20g=;
 b=ExudNmSlFD0yHLpX4dxVj5UzxiVJbs+2JC5eKfvOAmmCZe8X3y9RJ37Ps0FxnQMBJd
 b74FV1XsyttER0j6z5TXJOZGHsUO7Eef48bTqGwkq340wB1E7pKUieMqC0C4ajOMO3oC
 f3Bb9D+qvfjTmWPZF6SZ/JmIXu47Xelhl4ceuFrcbQ9j7ZR/Jn4vij5obGnQIYaOfhnT
 atI1Eiil1IvGdHUuU/vdF0C3ol72j8Va6WzrDqaj3vGmXK7SvGVK4+oWb7tGXOwW5BJW
 TLpZdEu7J15eSiL5C0wTkoYzWHrjKzjxIrGrKZ/dsccBWmtopdN3jWET7r/1vIn9IfMj
 lx2w==
X-Gm-Message-State: APjAAAXSE7WU+Xr4QscHIbdI382eKFtyCZS6euk7IHVVDN9ZTq+DKPM2
 doKgT/n+rgH304CL7S6vLXVLUU8gNhs=
X-Google-Smtp-Source: APXvYqymW9wLyXI/IeHB8psDwNX1BhvLAAqnznJlWkGQ5eBTF2MPjeY98nlMGKry5IpihJvSRFtYGw==
X-Received: by 2002:a17:902:7d92:: with SMTP id
 a18mr22491631plm.102.1571005546662; 
 Sun, 13 Oct 2019 15:25:46 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:25:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/23] tcg patch queue
Date: Sun, 13 Oct 2019 15:25:21 -0700
Message-Id: <20191013222544.3679-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::636
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

The following changes since commit 9e5319ca52a5b9e84d55ad9c36e2c0b317a122bb:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2019-10-04 18:32:34 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20191013

for you to fetch changes up to d2f86bba6931388e275e8eb4ccd1dbcc7cae6328:

  cpus: kick all vCPUs when running thread=single (2019-10-07 14:08:58 -0400)

----------------------------------------------------------------
Host vector support for tcg/ppc.
Fix thread=single cpu kicking.

----------------------------------------------------------------
Alex Bennée (1):
      cpus: kick all vCPUs when running thread=single

Richard Henderson (22):
      tcg/ppc: Introduce Altivec registers
      tcg/ppc: Introduce macro VX4()
      tcg/ppc: Introduce macros VRT(), VRA(), VRB(), VRC()
      tcg/ppc: Create TCGPowerISA and have_isa
      tcg/ppc: Replace HAVE_ISA_2_06
      tcg/ppc: Replace HAVE_ISEL macro with a variable
      tcg/ppc: Enable tcg backend vector compilation
      tcg/ppc: Add support for load/store/logic/comparison
      tcg/ppc: Add support for vector maximum/minimum
      tcg/ppc: Add support for vector add/subtract
      tcg/ppc: Add support for vector saturated add/subtract
      tcg/ppc: Support vector shift by immediate
      tcg/ppc: Support vector multiply
      tcg/ppc: Support vector dup2
      tcg/ppc: Enable Altivec detection
      tcg/ppc: Update vector support for VSX
      tcg/ppc: Update vector support for v2.07 Altivec
      tcg/ppc: Update vector support for v2.07 VSX
      tcg/ppc: Update vector support for v2.07 FP
      tcg/ppc: Update vector support for v3.00 Altivec
      tcg/ppc: Update vector support for v3.00 load/store
      tcg/ppc: Update vector support for v3.00 dup/dupi

 tcg/ppc/tcg-target.h     |   51 ++-
 tcg/ppc/tcg-target.opc.h |   13 +
 cpus.c                   |   24 +-
 tcg/ppc/tcg-target.inc.c | 1118 ++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 1119 insertions(+), 87 deletions(-)
 create mode 100644 tcg/ppc/tcg-target.opc.h

