Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3C0C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE0E206D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PTOA8PAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE0E206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWOrk-0000II-FX
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 14:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOo3-0004M5-G8
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:07 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:44981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOo2-0002ml-7I
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:07 -0400
Received: by mail-pl1-x631.google.com with SMTP id b8so716832plm.11
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0XxHIH+aU72cGC8v9gqVLYCoVm5TOqhICJXBWXKkOj0=;
 b=PTOA8PAnd08YdgbwfBuPUzBldh7XN/mytekkfLmPIP/dJdqkZMP+XW4BeGzYROae8T
 FViEcE65/0gcVkfnq6F88+d/31rDeDy/JqPfSUv7QFT+Jm7S9aInWmCgAHrpQAlDrPN6
 QjZVbS/BzZyFjiJ+caaZ77D+RV8qm21R0tHUtvZT42VebcXR2DSN7cS7UFvHp9ZsD2Ka
 stIkalhyc3gCEtd45f6wmhQm8prKKtnlGH5zS2DhPLkW6juR7zMNNlbqENpOsDzU/HXR
 aX0mtxU2bmjcRz+BzG55UCKhd+QeAvazffNhYosDOHy5EXJCIURJR9klnT7yaovqauZG
 CZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0XxHIH+aU72cGC8v9gqVLYCoVm5TOqhICJXBWXKkOj0=;
 b=SqaEtr9am8bzrDl4zSP+rw9QYdCxiKtmfTxgmuZ2LDEogSSxDDq1VO30ZbJkr98Ill
 d44hpbs8RGulIKG7raa8bC4g/q7e+gBYHbkuL/ujYVdQCH41c2IeeqdvVk0H6xfiCKAU
 UiC/as8xWLk3K8iCbXuU3aN5jBGDfAhFCvqoWKu0ftyRvBmWWzzg+Yn5kViEg4492Akf
 JipzhqOF7aTdqOt3ZUadB9g6acU3Cg/pupoaRzUZr96Dp/J5v6ZxIQHJaNkziPx58W3h
 cHwvxIv5uEv72hYGIUyQhDdX2o43kGr+oAuwsMl06qdQrjMBzh9ZCndYo8HjhCfmhS+L
 HLow==
X-Gm-Message-State: AGi0PubvMch81uOc1rX3/eOqJcG0DNiI/HQRtMSMOa/0HecytBnlc66N
 K6vExcAzkKtFswfw6w/Z3WQMHU389bk=
X-Google-Smtp-Source: APiQypIPMFOBKk1PvhZdOgKoAJrWmHEdAq7f+rwZ78M8eeQbTUW/PTmlNpiu0DiLM5ATwn3WHX+p5w==
X-Received: by 2002:a17:90a:20ea:: with SMTP id
 f97mr10764274pjg.157.1588789803709; 
 Wed, 06 May 2020 11:30:03 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w11sm2572589pfq.100.2020.05.06.11.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 11:30:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] tcg patch queue
Date: Wed,  6 May 2020 11:29:52 -0700
Message-Id: <20200506183002.3192-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a36d64f43325fa503075cc9408ddabb69b32f829:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-gdbstub-060520-1' into staging (2020-05-06 14:06:00 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20200506

for you to fetch changes up to 07dada0336a83002dfa8673a9220a88e13d9a45c:

  tcg: Fix integral argument type to tcg_gen_rot[rl]i_i{32,64} (2020-05-06 09:25:10 -0700)

----------------------------------------------------------------
Add tcg_gen_gvec_dup_imm
Misc tcg patches

----------------------------------------------------------------
Richard Henderson (10):
      tcg: Add tcg_gen_gvec_dup_imm
      target/s390x: Use tcg_gen_gvec_dup_imm
      target/ppc: Use tcg_gen_gvec_dup_imm
      target/arm: Use tcg_gen_gvec_dup_imm
      tcg: Use tcg_gen_gvec_dup_imm in logical simplifications
      tcg: Remove tcg_gen_gvec_dup{8,16,32,64}i
      tcg: Add tcg_gen_gvec_dup_tl
      tcg: Improve vector tail clearing
      tcg: Add load_dest parameter to GVecGen2
      tcg: Fix integral argument type to tcg_gen_rot[rl]i_i{32,64}

 include/tcg/tcg-op-gvec.h           |  13 ++-
 include/tcg/tcg-op.h                |   8 +-
 target/arm/translate-a64.c          |  10 +--
 target/arm/translate-sve.c          |  12 ++-
 target/arm/translate.c              |   9 +-
 target/ppc/translate/vmx-impl.inc.c |  32 +++----
 target/ppc/translate/vsx-impl.inc.c |   2 +-
 target/s390x/translate_vx.inc.c     |  41 ++-------
 tcg/tcg-op-gvec.c                   | 162 +++++++++++++++++++++++-------------
 tcg/tcg-op.c                        |  16 ++--
 10 files changed, 166 insertions(+), 139 deletions(-)

