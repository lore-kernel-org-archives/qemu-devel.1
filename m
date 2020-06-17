Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3338DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 04:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34C32082F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 04:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P8UfVtZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34C32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlPqw-0007tx-8s
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 00:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlPpr-0006jp-4g
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 00:38:03 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlPpp-0001SK-G2
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 00:38:02 -0400
Received: by mail-pg1-x544.google.com with SMTP id u128so633493pgu.13
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 21:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CXl6F5jJ1B481FFdPmle4K0LcgFs46dtSTWleIyiAg4=;
 b=P8UfVtZHkTeSR/9L1qY00M0x7PIvYuQlN88G7ywO210JSPs6uTxb6LOdYp1pShldQY
 X1/UdrWHgAkcyq76Tzdy4Nn0mKezSt94uszgW2/SgRg3ldnfJnhJiaTG3q7zAUcymdHW
 zXTcbI53TapVoTHHABwmrw4eERsHMDJLEKeFgyvLy+H7bSirsTpDXrD8lqScu4J4noVE
 O7YvpG3JypCucTPkkrrzl0gJCNV+MdVvjkfUtXuAuW+RQIxdn4BhtTGjMWL2MuneMRyz
 IlmXbzxbqM+LntzWXW3dqbi3dcsVn+DBddjb5WzQ/PunuocNi/FB8WdHMraT4hnQ48Ua
 Mfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CXl6F5jJ1B481FFdPmle4K0LcgFs46dtSTWleIyiAg4=;
 b=DCSNQqDljWkTjF6LwDIdebwVPSuQ+rriMiUfpG53uPluTkyjpXfJdKRUMXEoT8qJH3
 sD0wb3oVB9MVlNyCaAy+8PdAi+MdXFpGXQLirVtEoXWF2PjucMjDfRwBSgzBobPksh3Z
 mZtbJgQVtqmLB6r15QCoMAO1zbkQ2eANLyrrGFraaIjA5TgOEEWExYLF1ky6pqHUCB76
 69lCdrnzy8KQ8DtFROaORym0g3hiZcPRFrH3g4thXXVOzow0cuhosk/joxsZEXxaV6GQ
 RhLl+ZtbcSdf3k/Ki03m2Y0/HPuZzkO4S0mVzPyo6JPxEQH2zv3ijm6kewiGIc4mdzVv
 KsdQ==
X-Gm-Message-State: AOAM531tZEqDDyfhd2GXd0y4ewjeriNzYgus5/eRtpJVAD0xBNjPPiEq
 dRm4xtYAXkk9tqqgFGdKY5bzJJs018Y=
X-Google-Smtp-Source: ABdhPJyEmCU1UQh2UdsZ97+ZeHxRT+9lkSGGaeagZpewoSFfLSauhzJj3o33El6HZc4q6+AGUtAkVA==
X-Received: by 2002:a65:614b:: with SMTP id o11mr4701481pgv.443.1592368679245; 
 Tue, 16 Jun 2020 21:37:59 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x3sm18585808pfi.57.2020.06.16.21.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 21:37:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/5] Vs clang-10 and gcc-9 warnings
Date: Tue, 16 Jun 2020 21:37:52 -0700
Message-Id: <20200617043757.1623337-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Three of these patches are for cleaning up warnings vs clang-10.

The -Wtautological-type-limit-compare patch has been improved
as suggested by Eric Blake.

The final patch is for a "new" warning from gcc-9 on aarch64 hosts.
Our build box has been upgraded from bionic, so the warning is new
to me, anyway.

Changes since v2:
  * Adjustments to "Clean up warning flag lists" (eblake).
  * Add -Wpsabi to tests/plugins (ajb).


r~


Philippe Mathieu-Daudé (1):
  fpu/softfloat: Silence 'bitwise negation of boolean expression'
    warning

Richard Henderson (3):
  configure: Clean up warning flag lists
  configure: Disable -Wtautological-type-limit-compare
  configure: Add -Wno-psabi

Wei Wang (1):
  migration: fix xbzrle encoding rate calculation

 configure             | 44 +++++++++++++++++++++++++++++++++----------
 fpu/softfloat.c       | 33 +++++++++++++++++++++++---------
 migration/ram.c       |  4 +---
 tests/plugin/Makefile |  2 +-
 4 files changed, 60 insertions(+), 23 deletions(-)

-- 
2.25.1


