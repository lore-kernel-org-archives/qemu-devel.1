Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB267C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6790206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mrNLSTPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6790206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jleRe-0006jx-UF
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 16:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jleQu-0005fD-CM
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:13:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:35900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jleQs-0000GA-RJ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:13:16 -0400
Received: by mail-pl1-x62b.google.com with SMTP id j4so1452472plk.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 13:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vq5Wx5Dz/qKpaC1LVdsFp/8YtqQnkbr0fZ3yVJTrM0g=;
 b=mrNLSTPhcp2Qfx8vOruulgyOAtoYHpUagvefb9WclO8KxX0+fx19sTpmSWa0OqnRpG
 agLhu/lMUmvuTUU0oKPR2rS18kZx85iyc7FabU4kBccxJu24pCpXnuayatpquu4qqUE/
 zm5GPo4JqgCmDl+mVrQvqIOuHt9uGkxuoWhBxcI+K+WYM62MeS6PJmpaFU18md7s9MCn
 QijrGWY4beBVwUxS7qtSt3RXKZwmrARPbPA20211pIMFR+UOI5yQCTdDYoBhGAhzEKO+
 9P5qVi59XUppO7aiPbcvBUOkQYcSg5tU4Fyg6uaCuoYRHF3JQGGcXrngjFrTVP6FZ1bQ
 3VSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vq5Wx5Dz/qKpaC1LVdsFp/8YtqQnkbr0fZ3yVJTrM0g=;
 b=OHqUAED+sNrVkEnrAHIqH2ux+CF/qNusTQcmTk9WHEdXGpypJqxhYy71ZDfeAArcg5
 GJPOUhqijqRJzJAherYjM3+NhywMhUBVQn52pFOlUG9KMD57YDM9jqyCw13m4qFAjchx
 f19k2iep+/dAvMf3ihvLmDJetjGcOMgO3rLoA0/GV3tmyLNp+8BMtPEjgqYzTXHRKCaE
 c23gcLUKMgcuRFq/JCRlmXc6rW9D7cJtFpAZb+uuv8e4nLQ2tj6VJ/O6WeI3d7j1fR0m
 4PcwyYxnUbmVkq4A0gamCWZ1tQ+fHTAB7WNzqdO/hsg2UT8QXGGE0WY92r84GUZ7SL5C
 aoHA==
X-Gm-Message-State: AOAM530H3d5m/kuPUUw3FK0SR5pgY57XlMilQSgdtGYazWutOh2g18yM
 b60hdjTkv3lY+qffNHC499fDS3/niD8=
X-Google-Smtp-Source: ABdhPJywYxwVhuWE8F7c5krypSp1rP9y7UE8mnpdEf+kYBs84rqEA2bMf2sqVMICIdrS7bSl0uHUag==
X-Received: by 2002:a17:902:ac97:: with SMTP id
 h23mr762597plr.64.1592424792351; 
 Wed, 17 Jun 2020 13:13:12 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h9sm659259pfe.32.2020.06.17.13.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 13:13:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/6] Vs clang-10 and gcc-9 warnings
Date: Wed, 17 Jun 2020 13:13:03 -0700
Message-Id: <20200617201309.1640952-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
Cc: philmd@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Three of these patches are for cleaning up warnings vs clang-10.

All of the patches from v3 are reviewed.  The final patch is new,
fixing a problem in "make check" (which I was clearly lax in not
seeing before).


r~


Philippe Mathieu-Daudé (1):
  fpu/softfloat: Silence 'bitwise negation of boolean expression'
    warning

Richard Henderson (4):
  configure: Clean up warning flag lists
  configure: Disable -Wtautological-type-limit-compare
  configure: Add -Wno-psabi
  qht: Fix threshold rate calculation

Wei Wang (1):
  migration: fix xbzrle encoding rate calculation

 configure             | 44 +++++++++++++++++++++++++++++++++----------
 fpu/softfloat.c       | 33 +++++++++++++++++++++++---------
 migration/ram.c       |  4 +---
 tests/qht-bench.c     |  3 ++-
 tests/plugin/Makefile |  2 +-
 5 files changed, 62 insertions(+), 24 deletions(-)

-- 
2.25.1


