Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4884C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E0E4206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCnClEKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0E4206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz0jd-00023u-OF
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 12:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz0ip-0000Xx-O9
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:38:59 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz0io-0001Tk-49
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:38:59 -0400
Received: by mail-pf1-x444.google.com with SMTP id f185so540718pfg.10
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 09:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4aBcC4w6SG44oGtHtWrUXgQKLmEbrKr/r9+YPAa/F24=;
 b=cCnClEKPR9fZ4Li9UbGq+IDLzG+9xX6FDINP7P3REXRWGgV+gwnRXzvjpfOvW5QIgk
 us5fINJILKxkzf3ubyQzsJphHYrKwctUGg/IYv+oBIUdl8KTNdT6JaojIxjk+ls40f0k
 IPzpKo0fBjl1Xakyqpwy8cAYfEjtw9dStsimwbK2MLfE2rhHpQozaeKbrvJyXyomp399
 WBbvdL3WfUryb4S/1daElJAr1gagsuMUD8UEhRpLbPWk006zOZJsaU/N58j2mKYzzk9z
 inwlCnwPiYAADNoVMeYsgZVQX2OoMSmviy9KHPa6Uedh02bXlsGWBXZvI+xBgl05CmHU
 hyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4aBcC4w6SG44oGtHtWrUXgQKLmEbrKr/r9+YPAa/F24=;
 b=BWMs5MUHkbWgz4iC4ym4T4bLTblpPTPQnQ7RTBUgGTDIxXDgJV6wv4qIDtZ8u/6ty7
 j+7ftHHjevJwg821HNYkEGkxTDH3F0NsipTB9Ejh8IJaGA9Ldp+JbSUkWBcd1zocqn/D
 obcV4TuhK+0jELYEarP1Vi7mrAY1Z2R4yBZmxWgH7ywPvPxB85x+8T+Gj7UU1T/1DgA3
 rATPDsk9nFCFyUJesQBMmFQjSglecMtSKMj6vbLYpSNZHv2ud71sbsIKQdX4OBfPN4Pl
 Y+2fH4AupRJX/O3JiS4epX0K0Fg7D15igMs+Vm/PNL78akoT7TxnLBTyO12oLD6ai83J
 gdYg==
X-Gm-Message-State: AOAM533T7wSx5XmaahODuUSO6L18TGs0DgFS354gyye5+9Cf495WuMWr
 oQazTMI1wxlV0UvOnVhUYd61SmK9CPs=
X-Google-Smtp-Source: ABdhPJxkEr/kn7BYLokcZo+niVfluZ0JVNyJRVb5pnmKLa6Esy+VJFaPMoqQQmAgZJgZafXT1g1ggA==
X-Received: by 2002:a63:f90f:: with SMTP id h15mr9110948pgi.53.1595608735674; 
 Fri, 24 Jul 2020 09:38:55 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id r191sm7261663pfr.181.2020.07.24.09.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 09:38:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 0/3] target/arm: mte+pauth fixes
Date: Fri, 24 Jul 2020 09:38:50 -0700
Message-Id: <20200724163853.504655-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: peter.maydell@linaro.org, vincenzo.frascino@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A couple of last minute fixes for MTE:

 (1) Peter pointed out that EL3's SCR.ATA needs to be set when
     we're booting a kernel directly.  Similarly for API & APK.

 (2) Vincenzo pointed out that with RRND=1, we can't rely on
     RGSR having being initialized.

     I suppose the only follow-on question here is whether it is
     better to minimize the number of calls to qemu_guest_getrandom,
     or instead to name that our IMPDEF algorithm and use it for
     every call to IRG.  We already have other user-space available
     RNG instructions that can drain the entropy pool, so this is
     not really different.


r~


Richard Henderson (3):
  hw/arm/boot: Fix PAUTH for EL3 direct kernel boot
  hw/arm/boot: Fix MTE for EL3 direct kernel boot
  target/arm: Improve IMPDEF algorithm for IRG

 hw/arm/boot.c           |  6 ++++++
 target/arm/mte_helper.c | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 7 deletions(-)

-- 
2.25.1


