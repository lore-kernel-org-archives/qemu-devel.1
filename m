Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2E2C73C66
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 11:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09FE20820
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 11:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aw3YDFEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09FE20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmcRR-0006TA-CA
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 07:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60296)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hmcR3-0005TX-Tw
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hmcR2-0006Lt-SK
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:12:53 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:38950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hmcR2-0006Ku-Ka
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:12:52 -0400
Received: by mail-wr1-x433.google.com with SMTP id x4so14130989wrt.6
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 04:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PwAQHiL125SUFXLsSqVjmRNmmIGb7JwNhWKz70/cdKk=;
 b=Aw3YDFEo+GhQ5wWixQMqqYCDMKq+yTYBvwfXQ0fnTZKzByF+f/qvQ+qxxrG+wC2vWk
 YGi4010WOd//h+YPXpCGHdkjdeg4Hj2Qlibo+fnKlTYD1lySrBkM+/IFfstZIZG1k3I/
 19UWzOtNzMMYG0CFY4SfaSh7rTdC0RyohdtC01/j6vKhGTHyLAXLPoA+5rXJbQ47YT79
 TAKtzFB1lu+zfIvBAHr/CBPAIaGMkC/+lzHepMmMgV4DAUXWtzRILntC6RmOdBa2D0mR
 YMEmdDirrt32h7jzPN83nRm+GvOmtgm7GRMO9Oo14rxVQwfwW+gYK7JaAImG63r6dNvi
 aFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PwAQHiL125SUFXLsSqVjmRNmmIGb7JwNhWKz70/cdKk=;
 b=Se+7bTrwZz6YUiaBVREcVkgyPj2Z2EBI0wtq5mvFtvZz3e/RnobAhOej9/t7B0Y+y0
 SJqpqMeeUFFogQjQFAvppxrcnvS6xYgzVeUBeqIZNTravumGNX/m+A6G6AO0HB4d4Knt
 TD+w5ZNhKjv2Z2/Ofk1hhgBJiAJ5PB74wXgaxYn/V08q3w3QS6oaIYGcdnN7dltcv4wn
 /l7AqQv7iKQpxGaW/XtdtssdXQI5bxo8NQCCSOoE9XDWR+mgdsWW4NVZwM864lpEuwj3
 0zz/bJjfl3iqEqisPi7VduSLGhGyiCBQimJbmvTV/lxCAJmuZSm5i2LjAEx34ziUKFED
 5l0g==
X-Gm-Message-State: APjAAAWAPS8E/whh67fngRFu9ffla9bYlpzkAnsL8c/B35eDLgiGGyug
 LGqRGZiPJ8IhTlLiDcHr9qVAqJex0vKx2g==
X-Google-Smtp-Source: APXvYqxpbwU741wtNhNlBOP2+QVB6J5Idfd7Y2QwxJYQwYayCt0IS0Z+HKQ3ys4Ii7d+jXnMOFsVLA==
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr23504798wrk.229.1563102770857; 
 Sun, 14 Jul 2019 04:12:50 -0700 (PDT)
Received: from localhost.localdomain ([194.144.248.241])
 by smtp.gmail.com with ESMTPSA id f17sm12675795wmf.27.2019.07.14.04.12.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 14 Jul 2019 04:12:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 14 Jul 2019 11:12:42 +0000
Message-Id: <20190714111249.13859-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PULL for-4.1 0/7] tcg patch queue
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


The following changes since commit 1316b1ddc8a05e418c8134243f8bff8cccbbccb1:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-07-12 15:38:22 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20190714

for you to fetch changes up to 52ba13f042714c4086416973fb88e2465e0888a1:

  tcg: Release mmap_lock on translation fault (2019-07-14 12:19:01 +0200)

----------------------------------------------------------------
Fixes for 3 tcg bugs

----------------------------------------------------------------
Richard Henderson (7):
      tcg: Fix constant folding of INDEX_op_extract2_i32
      tcg/aarch64: Fix output of extract2 opcodes
      include/qemu/atomic.h: Add signal_barrier
      tcg: Introduce set/clear_helper_retaddr
      tcg: Remove cpu_ld*_code_ra
      tcg: Remove duplicate #if !defined(CODE_ACCESS)
      tcg: Release mmap_lock on translation fault

 include/exec/cpu_ldst.h                   | 20 ++++++++
 include/exec/cpu_ldst_useronly_template.h | 40 ++++++++++------
 include/qemu/atomic.h                     | 11 +++++
 accel/tcg/user-exec.c                     | 77 +++++++++++++++++++++----------
 target/arm/helper-a64.c                   |  8 ++--
 target/arm/sve_helper.c                   | 43 +++++++++--------
 tcg/aarch64/tcg-target.inc.c              |  2 +-
 tcg/optimize.c                            |  4 +-
 8 files changed, 139 insertions(+), 66 deletions(-)

