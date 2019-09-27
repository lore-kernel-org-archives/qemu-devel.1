Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE45C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B3320863
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2IWkm1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B3320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDw8E-000516-US
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 15:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5U-00038l-V9
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5T-0006AD-Lp
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:32 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:35286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDw5T-00069Q-Gj
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:31 -0400
Received: by mail-pf1-x42b.google.com with SMTP id 205so2144673pfw.2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=uVOnbhioaYsnQN3Ll1pqy0ykodubYSgngJSQbbBP1Xo=;
 b=F2IWkm1UeQrlBIq7ovW4cNuadsk8Zz/5n3E3Z8VzW9DRp8ieHY414xdg2rRXGnY7GT
 e1mqQOKgYa0RYpwcncXvYx6xv4tyXvdI1F5p+EiCl8W5olV9yOLYX4BPisNWPU0Mx5ov
 b0KNipRhKV9EQqwUzk/ppC3h8r1ln0UauEUvgPwywOC/Ut6O/6Y7Bu1ZTtbmNKJ5/3T8
 +hURps7lX9La6WUogyqtbohHSOf01DgW9ThlQ4bqHTQagNelnkXpYKS2gOoLIS+XFWET
 vfwAZutUqIA29ZQuNBvzH2vmgN1q6eolAJqmm64wmUqj6dNaokIwmlnnDhvIs5gLhXco
 eFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=uVOnbhioaYsnQN3Ll1pqy0ykodubYSgngJSQbbBP1Xo=;
 b=hWg5otUGgaIm7/JqP8NqYhXYR+loyMJ/sjvUba9Mu64ScQJNYDcmx1RVzKkONfhQqf
 E8kKvrOD+rpjJCFyILmuhboviZotTKq9gZiFIN7HrMSSLw6wQHK0YyhrZEaJ/ON07yy3
 j3/TitAf2nxP8jdXCq1gS1Q/oM8ZWUSh5y2/MbfuGpD10CcxhkB7tsTqQTCcycLbQ+/K
 RMZLM5Q/itcKhNhbV2nfpgRZ8Qgrlt/nCEmzjZMzWeE5aREjpe3HhH1YdqA67eum/fv6
 ZEGELdy1wNrKjab8tV448U2VpVAVMyFvyajjrboDmxtLK/YkU8rd2GDXsLmUlz1naoZ1
 Pkpw==
X-Gm-Message-State: APjAAAXPvP9b5IQZDiKGgB8Rto+7Zvwa/SBFdylmm4qaezLyQnvN0ioj
 WF/c62pOMz5i5Lo7QJV++uvEs4O2dGw=
X-Google-Smtp-Source: APXvYqygqO8wN7v2HZxALulGJ9p68WBWW6r/OMT868zO2EhjXDJRNGPDDiXMPDfY/fxToP75kHbG/Q==
X-Received: by 2002:a62:3444:: with SMTP id b65mr6328165pfa.247.1569613169937; 
 Fri, 27 Sep 2019 12:39:29 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id 192sm3676403pfb.110.2019.09.27.12.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 12:39:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/18] target/s390: Use tcg unwinding for ilen
Date: Fri, 27 Sep 2019 12:39:07 -0700
Message-Id: <20190927193925.23567-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42b
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Based-on: <20190925125236.4043-1-david@redhat.com> \
  ("s390x/mmu: DAT translation rewrite")

Based-on: <20190926101627.23376-1-david@redhat.com> \
  ("s390x/mmu: Implement more facilities") \
  With the suggested follow-up for patch 2 re ilen.

Which should mean that this applies on top of David's
current s390x tree.  ;-)

Changes since v3:
  * Dropped the unrelated psw.addr wrapping patch.
  * Set ilen to 2 for breakpoints, which means that we can make
    the assignment within restore_state_to_opc unconditional.
  * Remove ILEN_UNWIND.  After the penultimate patch, we nowhere
    play odd games with ILEN.  Yay!

Patches without review or ack:

0001-target-s390x-Add-ilen-to-unwind-data
0009-target-s390x-Return-exception-from-mmu_translate
0018-target-s390x-Remove-ILEN_UNWIND (new)


r~


Richard Henderson (18):
  target/s390x: Add ilen to unwind data
  target/s390x: Remove ilen parameter from tcg_s390_program_interrupt
  target/s390x: Remove ilen parameter from s390_program_interrupt
  target/s390x: Use tcg_s390_program_interrupt in TCG helpers
  target/s390x: Push trigger_pgm_exception lower in s390_cpu_tlb_fill
  target/s390x: Handle tec in s390_cpu_tlb_fill
  target/s390x: Return exception from mmu_translate_real
  target/s390x: Remove exc argument to mmu_translate_asce
  target/s390x: Return exception from mmu_translate
  target/s390x: Return exception from translate_pages
  target/s390x: Remove fail variable from s390_cpu_tlb_fill
  target/s390x: Simplify helper_lra
  target/s390x: Rely on unwinding in s390_cpu_tlb_fill
  target/s390x: Rely on unwinding in s390_cpu_virt_mem_rw
  target/s390x: Remove ILEN_AUTO
  target/s390x: Remove ilen argument from trigger_access_exception
  target/s390x: Remove ilen argument from trigger_pgm_exception
  target/s390x: Remove ILEN_UNWIND

 target/s390x/cpu.h           |  7 +---
 target/s390x/internal.h      |  6 +--
 target/s390x/tcg_s390x.h     |  4 +-
 hw/s390x/s390-pci-inst.c     | 58 +++++++++++++-------------
 target/s390x/cc_helper.c     |  4 +-
 target/s390x/crypto_helper.c |  7 ++--
 target/s390x/diag.c          | 14 +++----
 target/s390x/excp_helper.c   | 60 ++++++++++++---------------
 target/s390x/fpu_helper.c    |  6 +--
 target/s390x/int_helper.c    | 15 +++----
 target/s390x/interrupt.c     |  9 ++--
 target/s390x/ioinst.c        | 40 +++++++++---------
 target/s390x/mem_helper.c    | 61 +++++++++++++--------------
 target/s390x/misc_helper.c   | 27 ++++--------
 target/s390x/mmu_helper.c    | 80 +++++++++++++++---------------------
 target/s390x/tcg-stub.c      |  4 +-
 target/s390x/translate.c     | 20 +++++++--
 17 files changed, 199 insertions(+), 223 deletions(-)

-- 
2.17.1


