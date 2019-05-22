Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15A2C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A3B2089E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ph137EOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A3B2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52557 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZnk-0006rj-NS
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 18:33:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZin-0002vn-Po
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZil-0007IQ-Pi
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:29 -0400
Received: from mail-yw1-xc2f.google.com ([2607:f8b0:4864:20::c2f]:33906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTZik-0007HD-CQ
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:27 -0400
Received: by mail-yw1-xc2f.google.com with SMTP id n76so1497014ywd.1
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=sUJqt3JD+gd9m8xwvhsWFnhtBjPCY6u0efzkuW7MTho=;
	b=Ph137EOm7l+Tz1gykJyhksvjNPq/DG0kTI4bmBEh4EBM2dTaLlM6jXx8z8KHpESNrF
	wUm4ERB7MCFhugS/3mRaGBfbfOFCrfHfOsL0b1wmdNBU0BkWDGCWc+nh2KVr+yTOBH1k
	5qOUiXU0GnbAa0Md19CUg9c9wKVErKrBYAufks2kukRk2nqElG/Wsix4sQmE3/LcbqQY
	MaP4Ba6WwNYxZUmlw2vPvDWQrPfb3yDc58GVSuDRZNPWlBK5LqysIc1MMaabBKooIxz4
	nzBxqChH0UJsfbFNE1rnhOgJGcrJy2C1cq+aKoth6xb9umv+uwgJRBNY4ISSAHxgpW7K
	Mr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=sUJqt3JD+gd9m8xwvhsWFnhtBjPCY6u0efzkuW7MTho=;
	b=JWdBl08NRCi46fhJ+3W0TXjqYH100B9QAG8Kwls/Qf5rptqiGTKmdFZ0cKT2+BDk/C
	C1GBLQ85oPb3qARZVltO6uONZG4dwOnV79jL3lQYzOfMl+FW8jxODz9utD0pgU6s7/gU
	eE9lN2c4cczarB21gkKtAMYL5ES3z5d8Qb12KDnzJCx4+nbKa+Xaaku8LbFdbkqDH/yX
	MybW6InYfCzNn7yh52YtXMCVm6AxLEgX+XvwlcQFpsuBtQ+4JI8F6sgAJEReRni3vqoX
	s9CsO619VxUkcv+D3l5TKOQOESjfyxW0m1jwfHLAtTWO/noyecC6MVY6cyulU5sLmaGc
	0pCA==
X-Gm-Message-State: APjAAAXeXCCRgmSSsd0Kf3pPKY5kRahlTvwcKMSyZNHyzKEdTfErrI1i
	230mrrmbAYaSzY4VHJKksnY6KBJJUGc=
X-Google-Smtp-Source: APXvYqxLRe2v2NbfUXDtZLLt4Hyppz/MfHoi+uzMiicmInZjMqJwDajOgltOAIWxVY1zn5Re8q5X/g==
X-Received: by 2002:a81:b3c4:: with SMTP id
	r187mr16140627ywh.217.1558564104281; 
	Wed, 22 May 2019 15:28:24 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id q11sm2276453ywg.7.2019.05.22.15.28.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 15:28:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:28:05 -0400
Message-Id: <20190522222821.23850-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c2f
Subject: [Qemu-devel] [PULL 00/16] tcg queued patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a4f667b6714916683408b983cfe0a615a725775f:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' into staging (2019-05-21 16:30:13 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20190522

for you to fetch changes up to 11e2bfef799024be4a08fcf6797fe0b22fb16b58:

  tcg/i386: Use MOVDQA for TCG_TYPE_V128 load/store (2019-05-22 15:09:43 -0400)

----------------------------------------------------------------
Misc gvec improvements

----------------------------------------------------------------
Richard Henderson (16):
      tcg/i386: Fix dupi/dupm for avx1 and 32-bit hosts
      tcg: Fix missing checks and clears in tcg_gen_gvec_dup_mem
      tcg: Add support for vector bitwise select
      tcg: Add support for vector compare select
      tcg: Introduce do_op3_nofail for vector expansion
      tcg: Expand vector minmax using cmp+cmpsel
      tcg: Add TCG_OPF_NOT_PRESENT if TCG_TARGET_HAS_foo is negative
      tcg/i386: Support vector comparison select value
      tcg/i386: Remove expansion for missing minmax
      tcg/i386: Use umin/umax in expanding unsigned compare
      tcg/aarch64: Support vector bitwise select value
      tcg/aarch64: Split up is_fimm
      tcg/aarch64: Use MVNI in tcg_out_dupi_vec
      tcg/aarch64: Build vector immediates with two insns
      tcg/aarch64: Allow immediates for vector ORR and BIC
      tcg/i386: Use MOVDQA for TCG_TYPE_V128 load/store

 accel/tcg/tcg-runtime.h      |   2 +
 tcg/aarch64/tcg-target.h     |   2 +
 tcg/i386/tcg-target.h        |   2 +
 tcg/tcg-op-gvec.h            |   7 +
 tcg/tcg-op.h                 |   5 +
 tcg/tcg-opc.h                |   5 +-
 tcg/tcg.h                    |   2 +
 accel/tcg/tcg-runtime-gvec.c |  14 ++
 tcg/aarch64/tcg-target.inc.c | 371 ++++++++++++++++++++++++++++++++-----------
 tcg/i386/tcg-target.inc.c    | 169 +++++++++++++-------
 tcg/tcg-op-gvec.c            |  71 ++++++---
 tcg/tcg-op-vec.c             | 142 ++++++++++++++---
 tcg/tcg.c                    |   5 +
 tcg/README                   |  11 ++
 14 files changed, 620 insertions(+), 188 deletions(-)

