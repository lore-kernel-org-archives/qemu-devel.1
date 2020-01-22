Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5022FC2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C57F217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z3cIyndf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C57F217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu67A-00076J-TZ
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65Y-0005J6-IQ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65X-0002gK-FC
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:49:52 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:41730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu65X-0002g4-8y
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:49:51 -0500
Received: by mail-pf1-x435.google.com with SMTP id w62so2558460pfw.8
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TWEwx1WaYVt3ALbdRTeHKigxuTma/dXhlhyk2P4O2Xc=;
 b=z3cIyndfGM8FG78cuGiwvnqTJNlH51X+uNAXvcTrnefQr3NH4PJxTYDrtfScbGik3Q
 PVA1dyxMii0RHI4KgeaqiFMNsPHg4MI0Yy1hrHcByBWbX0HIf2YrTk0B4hQIhLqauMoV
 5s/OCzWkb8XzEdZizIdjMeWLpdFOBxipxw8ow8pJW5llv2/cvvV6ucbYlFp+FShsT/yQ
 R5oGJeFGwKe7vlhQhSeo37J2eHRbOiyKJayv99bXXxByxreDmLuxNSANKdq05Jv8C5R+
 uv7IZK8m7wOfuxIT2t4xEcPWVWj2R5Ak73YVdkh9CXvbZ9YiFy3sOhAcbrhUqDutz8WL
 cBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TWEwx1WaYVt3ALbdRTeHKigxuTma/dXhlhyk2P4O2Xc=;
 b=QDXoflx+DG8IgdCyAQX6vzl4aFEP4ixamKfoISPIiH76YeIsRLQfXGmlxrr7ZL70sD
 x+raEK2ZlOt82OyG+tnPfFPLdUYNVyl8OQZZesWeFgwk5Q8VqkFvqF/DUz0gIKIDf6ip
 wcdeVGsVZLTkqwbMZelIhzjgpY/gc0iCfZxmLCqRhvCYcz3vch7ZiLunI5c9l9xw0YP5
 FCeiswsBraxybS/adsDcl3y/XelhpHsjAo6Yto56QkQB7+I+2a6YkBP8jyrIsqeaoyhI
 3Ev1ncNfK5Arw1CGWi3FcmxiW/iJUS0AnplJhH1W5GtCiVtnlaiOtvHQbK3D+f7ERgFt
 IERA==
X-Gm-Message-State: APjAAAUcKRSkxsYZ38hSnBEHgsc6wBDu3G+57mk6GmD+DTrjFbUb05zQ
 KRoVVCl2EUlUFpBCiP3tFmv/iaOF0R0=
X-Google-Smtp-Source: APXvYqxvSXFDqJbpyHSeUMw1KESyByfJ+Anau6mGyHxQgHtIcR6bmw3TdKfCqdpayVr4x/JcS2RIRw==
X-Received: by 2002:a63:6d8d:: with SMTP id i135mr8852947pgc.90.1579661389745; 
 Tue, 21 Jan 2020 18:49:49 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id c22sm44149883pfo.50.2020.01.21.18.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:49:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] tcg patch queue
Date: Tue, 21 Jan 2020 16:49:30 -1000
Message-Id: <20200122024946.28484-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::435
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

The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd40:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-20200121' into staging (2020-01-21 15:29:25 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20200121

for you to fetch changes up to 75fa376cdab5e5db2c7fdd107358e16f95503ac6:

  scripts/git.orderfile: Display decodetree before C source (2020-01-21 15:26:09 -1000)

----------------------------------------------------------------
Remove another limit to NB_MMU_MODES.
Fix compilation using uclibc.
Fix defaulting of -accel parameters.
Tidy cputlb basic routines.
Adjust git.orderfile for decodetree.

----------------------------------------------------------------
Carlos Santos (1):
      util/cacheinfo: fix crash when compiling with uClibc

Philippe Mathieu-Daudé (1):
      scripts/git.orderfile: Display decodetree before C source

Richard Henderson (14):
      cputlb: Handle NB_MMU_MODES > TARGET_PAGE_BITS_MIN
      vl: Remove unused variable in configure_accelerators
      vl: Reduce scope of variables in configure_accelerators
      vl: Remove useless test in configure_accelerators
      vl: Only choose enabled accelerators in configure_accelerators
      cputlb: Merge tlb_table_flush_by_mmuidx into tlb_flush_one_mmuidx_locked
      cputlb: Make tlb_n_entries private to cputlb.c
      cputlb: Pass CPUTLBDescFast to tlb_n_entries and sizeof_tlb
      cputlb: Hoist tlb portions in tlb_mmu_resize_locked
      cputlb: Hoist tlb portions in tlb_flush_one_mmuidx_locked
      cputlb: Split out tlb_mmu_flush_locked
      cputlb: Partially merge tlb_dyn_init into tlb_init
      cputlb: Initialize tlbs as flushed
      cputlb: Hoist timestamp outside of loops over tlbs

 include/exec/cpu_ldst.h |   5 -
 accel/tcg/cputlb.c      | 287 +++++++++++++++++++++++++++++++++---------------
 util/cacheinfo.c        |  10 +-
 vl.c                    |  27 +++--
 scripts/git.orderfile   |   3 +
 5 files changed, 223 insertions(+), 109 deletions(-)

