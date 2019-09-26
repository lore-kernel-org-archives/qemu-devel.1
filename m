Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADB6ECE589
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:35:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7437521655
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qyhgjTF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7437521655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDWjw-0001gZ-Vu
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWby-0002T5-HI
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWbw-0004a8-0B
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:21 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:40893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDWbv-0004Zn-Rl
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:19 -0400
Received: by mail-pg1-f170.google.com with SMTP id w10so1833954pgj.7
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=gWWGSTfYrzYkzLZawcn3q2Ja4PFRns9a4fWpQZIcwHM=;
 b=qyhgjTF1LMsMlb4y37zkYiM7/3hiKYWsPijb6POezQWq59JYNgT8Xw9H12sTTR6+EI
 mLhPJWtNs9TcrUeOy59707FyfDqsFd6l/UKP+4HrUCHTRrk1e1o7BoI1mgTHojH4nFZo
 CpXaH8DC6ByIxUJ1Xsh49cFHLeC2T2ulvXm6zZ+4ZWkCw0X3BAKcDKMKU1bc7tk+8Ulj
 eP00CqnN9neET8mz4XlpQgR6jsKQWOQ1ODCGgr/N5/Npqwnp99muoD29bbgfjKAy4kP/
 +0TzTCvQATHwOf+bbr7O+RFb/oOn/brrlR+5Nop38rLzsBQjzb3K//2CApjTqGG61sHO
 eCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gWWGSTfYrzYkzLZawcn3q2Ja4PFRns9a4fWpQZIcwHM=;
 b=nTSkNU0f6UQmC7l7LR429IdCwbZC3grBe6BXdbJMfwB8YvBBEWRbSMp37zM9TO9vk4
 cHILdCV+yrmFl7WFJrFrUYG2igqXB9rfKJZlvqbO7RARODdsS6wqz2b7GdH2fcMndreM
 WPju3rMdEiR3iUD5AvAPZbwD9jOJ/KNk43DGh84V6Ca+rW8l8f2rjNK00F2PVvxA63fz
 sKk3qzo+Zyw42gmRm6prsCL8l/jMZXphb3WHLK11mFkMj/MZJoDrVLa77pL0/Vaso0TP
 57EQF2UeL/wb2bpEUOeR7eYN7sOSk5ZkLF88ebS4/CGGRtA9auz9zvWhnGtm5tWVSEAZ
 i4eA==
X-Gm-Message-State: APjAAAV0tgs5DQWCpdEDwK8yUzkqSUr8BZPB+UTbCu7RzQaH7Hfi4gZi
 BFrCh6NLMYju9v18cT7lIBR07W5U0hg=
X-Google-Smtp-Source: APXvYqwxT1bzMmo4EKFWhcdr6xTtbe/we8gdaLLggYqVPBY+Ao7gcKrx4e1xfREoKWxcuO6gljtIYQ==
X-Received: by 2002:a63:1a5a:: with SMTP id a26mr4314274pgm.178.1569515178114; 
 Thu, 26 Sep 2019 09:26:18 -0700 (PDT)
Received: from localhost.localdomain ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 64sm4453169pfx.31.2019.09.26.09.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:26:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/18] target/s390: Use tcg unwinding for ilen
Date: Thu, 26 Sep 2019 09:25:57 -0700
Message-Id: <20190926162615.31168-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.170
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

David's cleanup of some of the mmu code reminded me of an old branch
that I have laying around.  His new code allowed me to finish this
idea up to completely transition away from ILEN_AUTO.

V1 was posted back in 2017:
   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07607.html
V2 was posted back in April:
   https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg00063.html

Based-on: <20190925125236.4043-1-david@redhat.com> \
  ("s390x/mmu: DAT translation rewrite")


r~


Richard Henderson (18):
  target/s390x: Truncate 32-bit psw_addr before creating TB
  target/s390x: Add ilen to unwind data
  target/s390x: Remove ilen parameter from tcg_s390_program_interrupt
  target/s390x: Remove ilen parameter from s390_program_interrupt
  target/s390x: Use tcg_s390_program_interrupt in TCG helpers
  target/s390x: Push trigger_pgm_exception lower in s390_cpu_tlb_fill
  target/s390x: Handle tec in s390_cpu_tlb_fill
  target/s390: Return exception from mmu_translate_real
  target/s390x: Remove exc argument to mmu_translate_asce
  target/s390: Return exception from mmu_translate
  target/s390: Return exception from translate_pages
  target/s390x: Remove fail variable from s390_cpu_tlb_fill
  target/s390x: Simplify helper_lra
  target/s390x: Rely on unwinding in s390_cpu_tlb_fill
  target/s390x: Rely on unwinding in s390_cpu_virt_mem_rw
  target/s390x: Remove ILEN_AUTO
  target/s390x: Remove ilen argument from trigger_access_exception
  target/s390x: Remove ilen argument from trigger_pgm_exception

 target/s390x/cpu.h           | 35 ++++++++++++++-------
 target/s390x/internal.h      |  6 ++--
 target/s390x/tcg_s390x.h     |  4 +--
 hw/s390x/s390-pci-inst.c     | 58 +++++++++++++++++-----------------
 target/s390x/cc_helper.c     |  4 +--
 target/s390x/crypto_helper.c |  7 ++---
 target/s390x/diag.c          | 14 ++++-----
 target/s390x/excp_helper.c   | 60 ++++++++++++++++-------------------
 target/s390x/fpu_helper.c    |  6 ++--
 target/s390x/int_helper.c    | 15 ++++-----
 target/s390x/interrupt.c     |  9 +++---
 target/s390x/ioinst.c        | 40 +++++++++++------------
 target/s390x/mem_helper.c    | 61 +++++++++++++++++-------------------
 target/s390x/misc_helper.c   | 27 ++++++----------
 target/s390x/mmu_helper.c    | 60 +++++++++++++++--------------------
 target/s390x/tcg-stub.c      |  4 +--
 target/s390x/translate.c     | 27 ++++++++++------
 17 files changed, 214 insertions(+), 223 deletions(-)

-- 
2.17.1


