Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83EEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 00:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF612080D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 00:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnW/MvTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF612080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaTAz-0000v3-JJ
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 19:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kaT9o-00082o-SE
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 19:29:40 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:37016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kaT9n-0002PT-7G
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 19:29:40 -0500
Received: by mail-pf1-x42c.google.com with SMTP id 13so85228pfy.4
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 16:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5+tbNTLX38jQE/9MC0OU2YCs71NLGdHnzypugDJ2CaY=;
 b=rnW/MvTHC6t9+CvW8B6ls3918W9EmOYNbvBMIMD4Ny9y3RtDiQhj9dSER7pNgQaxg1
 dK7XD8eIocWfoIlEpgeyu8IdJHnSf/hhPiRGxGx3iTT9Ad9qTBa3zCrEo8+dr7nLufyr
 3ZEE0OdgVcWxKz9a9V4IMWE02rgLfFNnY+89O+aL9HLl1jz02v1zfgkBMWs+198e9vmF
 aE2d25UY/oXIqBPwNKYLDgjynSWKVdKB7FYKp2ufivBLWjtK1trOJxb9wdHxepjCvZeQ
 ek6qMsGHb1Y7pCy1OTBJSw9ZFJjzApLXCdYZKxNfQLKbseZxKof0UYTr3tVYevYiycje
 aAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5+tbNTLX38jQE/9MC0OU2YCs71NLGdHnzypugDJ2CaY=;
 b=Sm/ImUQr5MZV76B+iXMaZVkqfkPkm4DeWhexiWwuQ3r3PFUdBD/AIq4zAZiGUfnAzo
 k9TNptAFMjHomfvHNyJVEp6C0ezSpqcqWs5cBo0JNO01jc6cNw1N/jk17HSixL6vZg8d
 buDALPX62kTroa3lAr4DV5HSGGp3mNCBhuzxRk9D+4L665X1uegcKIw65crvLVLnEHLM
 7MdRMXabVgm0YuAuBBdVjmbCYLiBvVfc9vXSfGt3TJJ2xIMPWBIYH9IOKin8QZYI2fGB
 HfcZHrhfjKGLrmInEb0NgXVVfaCnfFDUNFK7i3/FjWQcta25bI08Q1jIlOi97oXLBn36
 G09Q==
X-Gm-Message-State: AOAM533tUBO4VENhJqVe6pBBOWmkci+f7zWlOiC9gGBarRwYs5abrguO
 QDjMlDEQhijhHsYnCKYKcVGwCasRZC2iOg==
X-Google-Smtp-Source: ABdhPJwEQZXihvOBHQL+3VruSRaioJT7VkPjLA0CKfHdAuGOvW4tALc0TEAGN8XvNbyzCmNtrzwGKA==
X-Received: by 2002:a62:5293:0:b029:18b:5c86:7ad0 with SMTP id
 g141-20020a6252930000b029018b5c867ad0mr374050pfb.51.1604536177192; 
 Wed, 04 Nov 2020 16:29:37 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id z17sm3438528pga.85.2020.11.04.16.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 16:29:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.2 0/2] tcg patch queue
Date: Wed,  4 Nov 2020 16:29:33 -0800
Message-Id: <20201105002935.680486-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3c8c36c9087da957f580a9bb5ebf7814a753d1c6:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20201104-pull-request' into staging (2020-11-04 16:52:17 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20201104

for you to fetch changes up to c56caea3b2a4ef5d760266f554df0d92c5a45f87:

  tcg: Revert "tcg/optimize: Flush data at labels not TCG_OPF_BB_END" (2020-11-04 10:35:40 -0800)

----------------------------------------------------------------
Fix assert in set_jmp_reset_offset
Revert cross-branch optimization in tcg/optimize.c.

----------------------------------------------------------------
Richard Henderson (2):
      tcg: Remove assert from set_jmp_reset_offset
      tcg: Revert "tcg/optimize: Flush data at labels not TCG_OPF_BB_END"

 tcg/optimize.c | 35 +++++++++++++++++------------------
 tcg/tcg.c      |  9 +++++----
 2 files changed, 22 insertions(+), 22 deletions(-)

