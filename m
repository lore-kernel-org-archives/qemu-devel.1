Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066B7C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD87520705
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmVhAu67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD87520705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNuY-0004TP-Rs
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNsq-0002m4-Ur
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNso-0005qY-TX
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:16 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:37482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipNso-0005mP-It
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:14 -0500
Received: by mail-pj1-x1036.google.com with SMTP id m13so471366pjb.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z/0Cg0FCKhSbnvXHVUSJNPEc7zMFmpnggi/jIrklhkg=;
 b=GmVhAu67BauoajXfSlQewwat5SENMY+6hKde+/hWhPBajQw01QigWwRDXwYwQOLi1I
 zs5ZpzYtd+pOlKrkYklxdGR/vAOEWDT/bAdW8/j9zEi5XY8kKidocyXXKigtHccH4yT2
 UVBLbBXKzKnzempv5fvQKIFyZnBElMyE2ZzCgioYbvQVzMnrbpc9mRzFsrDyeZngHE2a
 LBMiOH4Zi/sdH5XkHdt1i1lYLZeuWC5jPY6SqKJ3aq28QMe43VyobQu7xfccrIpCmuyM
 klUbf744bkDMPNmPp6BSEizt5uA4MKFgKKN/dc/Cx3V0/ZBDvCocC3xx8R6k7XGPCSEZ
 Mrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z/0Cg0FCKhSbnvXHVUSJNPEc7zMFmpnggi/jIrklhkg=;
 b=f4PqDLqCPUXJxYsMqx6YrnQ6BuWdA1jIYpwev+CBDa652/XR6Aw9FMBY3v20kHvhAB
 VQPLDXzrSqHC6C97/wP3xbkvBNM1ao94UY0MzkLtYZ2a/nRj5/jLYCVjRqzw9iNGysl3
 WpgJ2Nic2oVpszapktgul3dI7rjAItl5d1TmULzdBPZYywq+JDY0xSEMcubHVD99VJ6G
 BdDZou9pd5UWwOZtTcoWTjzuovO/wD7UurCwiZx6H3jWdYKMLbuDlh5bnMyFbpdebV89
 S4ULIzmESqiPbONe7OFah1MCOmcIbsC0CiuCrEquVYs+wCD50paAgMjNxIMFvetBfOOg
 ohlw==
X-Gm-Message-State: APjAAAUuZ4z0r6R37AMVsAB3nB9/W4fPi+T9HLWHztqnxPUoFs9OCu6c
 RCNfuDS53rWCqghiSys1U0BD4GcB0XhkOQ==
X-Google-Smtp-Source: APXvYqwyXfFdvqf6dgI5DFpo0Bh2vOJIfEdMq38NeJb6o0c15TaPrTs4lL17JJAWYxToUjY0iZ7fpw==
X-Received: by 2002:a17:90a:8912:: with SMTP id
 u18mr2402149pjn.21.1578538152679; 
 Wed, 08 Jan 2020 18:49:12 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id b4sm5337844pfd.18.2020.01.08.18.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 18:49:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/9] cputlb: Various cleanups
Date: Thu,  9 Jan 2020 13:48:58 +1100
Message-Id: <20200109024907.2730-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1036
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
Cc: alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I had a conversation with Alistair Francis at KVM forum about
being able to represent ASIDs "properly".  This lead to the idea
that target-specific code might be able to cache TLBs outside of
the "main" NB_MMU_MODES -- possibly thousands of them.

This goes nowhere near that far.  But it does begin edging toward
the possibility of having a

    struct CPUTLBSaved {
        CPUTLBDesc d;
        CPUTLBDescFast f;
    };

by moving some of the most basic routines to use CPUTLBDesc and
CPUTLBDescFast directly instead of always using an mmu_idx.

I'm not sure how much time I'll have to go further along these
lines, but what I have so far still looks like a cleanup.


r~


Richard Henderson (9):
  cputlb: Merge tlb_table_flush_by_mmuidx into
    tlb_flush_one_mmuidx_locked
  cputlb: Make tlb_n_entries private to cputlb.c
  cputlb: Pass CPUTLBDescFast to tlb_n_entries and sizeof_tlb
  cputlb: Hoist tlb portions in tlb_mmu_resize_locked
  cputlb: Hoist tlb portions in tlb_flush_one_mmuidx_locked
  cputlb: Split out tlb_mmu_flush_locked
  cputlb: Partially merge tlb_dyn_init into tlb_init
  cputlb: Initialize tlbs as flushed
  cputlb: Hoist timestamp outside of loops over tlbs

 include/exec/cpu_ldst.h |   5 --
 accel/tcg/cputlb.c      | 120 +++++++++++++++++++++-------------------
 2 files changed, 64 insertions(+), 61 deletions(-)

-- 
2.20.1


