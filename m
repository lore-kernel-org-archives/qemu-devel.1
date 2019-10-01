Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4070BECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00EC12133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qjZPrS/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EC12133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLnJ-0002xL-FJ
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLl5-0001Q4-Jh
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLl4-0005Rm-6j
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:19 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:42548)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLl3-0005RY-W3
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:18 -0400
Received: by mail-pf1-x42e.google.com with SMTP id q12so8463501pff.9
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=wazOTrI1oInzBfsRKSMnAYvSuC0K9PZwuk6LXSrTPZo=;
 b=qjZPrS/1hJroLFIU0kolpjkCeIV3mFiqlaS/AvXNAh65voLvcnf6vNemyAUoxwqAyR
 7xQ7l4+uBGCrUvHoDV73Zwgm8Fa3lj9JWNgaW5Kgs8oDtItHPQnyrv2bfpXjp5PYJ9Ll
 NX00BNV2UxDHueQ8l8jsg6EqrniD/cgjyDbCdwx36x3LRzG0pWIRwPBL208NsVN/gHye
 COtWZfkQSEZbItrB+RqTFKKThSr47ojpxi3rXDz9IrCNCNv411FPBmm+f6gqJy9Lj7xi
 3Vct+WB2TQC5ev7u/m+KO0w5LsfOCTw37eJJ6QXtGKlG0eTQxLHBKpbB7CV1N7vP7QfT
 ojNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wazOTrI1oInzBfsRKSMnAYvSuC0K9PZwuk6LXSrTPZo=;
 b=HpIQJk0rNnzYky62pFcSB25SY6Lg82KaF5qh4DIzV0Q1p9JXDkrbEEcDoSFNHr07vX
 lDEi/ljP3a0q7Nh5IXQekfptJffarGit5wtec8AoAKLsRADDtUG07h9I44Y0qVXAEZFZ
 ZM7UPinLX3shwIrIr/JduRCvUgVA1XY4Vwz9rc1miBagYFmRcrmPiSXE1+Wd9QqfhqYd
 9VZF6vBxTDA9yITPZ4pTbqGb896I7CtKAQVzxHRTK35psxL8mdok3Zq4BXH8vxfouwd2
 r56w3CxE3RY5KM+zujg15Uu8UJR1Si8eJlyc4Ij5htk12Qb3puuYFqCoDri2xOa1J/uN
 +fDA==
X-Gm-Message-State: APjAAAVo+WTTmonW4heMTwKOQvduCW068vxXfqW9NdfeM7cmK72u+xf5
 2hrUaSvs2GDOfLpH0mSJBZ8NxjmfM9o=
X-Google-Smtp-Source: APXvYqx3HCukr9bgXWXHrteela6Sowse2nLMq4ue9TnXEUfwksnimufEUCoO2Tt93EweVIw5OkVQgg==
X-Received: by 2002:a63:1222:: with SMTP id h34mr32523506pgl.344.1569950176164; 
 Tue, 01 Oct 2019 10:16:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/18] target/s390: Use tcg unwinding for ilen
Date: Tue,  1 Oct 2019 10:15:56 -0700
Message-Id: <20191001171614.8405-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42e
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes since v4:
  * Fix a rebase error in patch 2.
  * Fix s390_cpu_get_phys_page_debug in patch 9.
  * Rebased on David's tree.

Based-on: https://github.com/davidhildenbrand/qemu/tree/mmu


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
 target/s390x/excp_helper.c   | 60 ++++++++++++--------------
 target/s390x/fpu_helper.c    |  6 +--
 target/s390x/helper.c        |  3 +-
 target/s390x/int_helper.c    | 15 +++----
 target/s390x/interrupt.c     |  9 ++--
 target/s390x/ioinst.c        | 40 +++++++++---------
 target/s390x/mem_helper.c    | 61 +++++++++++++--------------
 target/s390x/misc_helper.c   | 27 ++++--------
 target/s390x/mmu_helper.c    | 81 +++++++++++++++---------------------
 target/s390x/tcg-stub.c      |  4 +-
 target/s390x/translate.c     | 20 +++++++--
 18 files changed, 202 insertions(+), 224 deletions(-)

-- 
2.17.1


