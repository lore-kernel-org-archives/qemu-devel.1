Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D76C432C2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8785720820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDDWv5j2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8785720820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCXML-0007Fp-B6
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 19:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJT-0005Q5-U5
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJR-0007tm-HH
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:11 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:33846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCXJR-0007sB-Au
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:09 -0400
Received: by mail-pg1-x530.google.com with SMTP id y35so441pgl.1
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8/hX23yLRxMIHSb6BM/Tb9ngaY0hFIkGRxY//0dFwRI=;
 b=qDDWv5j2KeSRf5Lmm1JZ6BMJ9AIbF/YSmHKaLbpyNoeE4fSmtRqBd4Cu8Sm2vv4TFD
 Gf1HPg0e5XAPlT4A/3S5dn1jdILvJcTi4NBIOXhFHueUiqrN5W5ROi1hGIdiGJSiWIEI
 SaYAAFKe6U/nrO4elYNyPincNTpVSofHpwT1NjUkIkAPTN0EsagzARelbHmMErI3Fdol
 XXHG61bSubyddeiMmvWNrgxWM2baUK1MnxpBLdtAHCk4V42vvyVOo+q/VZCaKnSjL3xZ
 nULDoiTTywokN4rnZPTSmOEUgmGcYQW+aGHrwMezXcJNXjHn4QUxf4K0uieul2sAN6tn
 Bqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8/hX23yLRxMIHSb6BM/Tb9ngaY0hFIkGRxY//0dFwRI=;
 b=IcoAYDlMf8XIgW1pj0RQBKkC+EpyNClQHSRIyLn2gWMeU+YcPkbVd1t/IJsxDti/j3
 3Qr8FDEG2jqTZxHh+CMm/xmrqzW9Yj8vByjTwIhmWmY7A7hp5uGB4MXjE4TRFRmc/j+Z
 8Vi5uZj1cx1IS8cOYehpaQE6Gu1hPVFH0ZhWxV4ZTxKf0S4F08r3nWg04QO6pogR5zsW
 ZfzCZmwI6lTbR6byMXYPi+xvXsshvUpNiGGNjjeTi4u5AaCcHJJKfTyJTza8KbeZu3v1
 QEFdN7ku8Uh14QY/jZ7OwKB+z+qzOmV3ENl1kB713Jm0CxSpNmpE+vhfTJYQNIH2rdrD
 oIwQ==
X-Gm-Message-State: APjAAAVvfLUWOSXFokQ/GZFRu4Hx8WBrV4u66M+un1WYNRnqUmdZXvxn
 KYPQl0BHChYz88pgSasp8ok/TDM6980=
X-Google-Smtp-Source: APXvYqyGa2LHWPIfuw5NHIxCAqUrWqwMCPfhciwIS/3z5Yb4b8PqaGZ447PvaA9I9HggC4uT1xtpfQ==
X-Received: by 2002:a63:2b01:: with SMTP id r1mr2134219pgr.19.1569279607425;
 Mon, 23 Sep 2019 16:00:07 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id 74sm11674810pfy.78.2019.09.23.16.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 16:00:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/16] Move rom and notdirty handling to cputlb
Date: Mon, 23 Sep 2019 15:59:48 -0700
Message-Id: <20190923230004.9231-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::530
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes since v3:
  * Don't accidentally include the TARGET_PAGE_BITS_VARY patch set.  ;-)
  * Remove __has_attribute(__always_inline__).
  * Use single load/store_memop function instead of separate small wrappers.
  * Introduce optimize_away to assert the code folds away as expected.

Patches without review:

0003-qemu-compiler.h-Add-optimize_away.patch
0004-cputlb-Use-optimize_away-in-load-store_helpers.patch
0005-cputlb-Split-out-load-store_memop.patch
0010-cputlb-Partially-inline-memory_region_section_get.patch
0011-cputlb-Merge-and-move-memory_notdirty_write_-prep.patch
0012-cputlb-Handle-TLB_NOTDIRTY-in-probe_access.patch


r~


Richard Henderson (16):
  exec: Use TARGET_PAGE_BITS_MIN for TLB flags
  cputlb: Disable __always_inline__ without optimization
  qemu/compiler.h: Add optimize_away
  cputlb: Use optimize_away in load/store_helpers
  cputlb: Split out load/store_memop
  cputlb: Introduce TLB_BSWAP
  exec: Adjust notdirty tracing
  cputlb: Move ROM handling from I/O path to TLB path
  cputlb: Move NOTDIRTY handling from I/O path to TLB path
  cputlb: Partially inline memory_region_section_get_iotlb
  cputlb: Merge and move memory_notdirty_write_{prepare,complete}
  cputlb: Handle TLB_NOTDIRTY in probe_access
  cputlb: Remove cpu->mem_io_vaddr
  cputlb: Remove tb_invalidate_phys_page_range is_cpu_write_access
  cputlb: Pass retaddr to tb_invalidate_phys_page_fast
  cputlb: Pass retaddr to tb_check_watchpoint

 accel/tcg/translate-all.h      |   8 +-
 include/exec/cpu-all.h         |  23 ++-
 include/exec/cpu-common.h      |   3 -
 include/exec/exec-all.h        |   6 +-
 include/exec/memory-internal.h |  65 -------
 include/hw/core/cpu.h          |   2 -
 include/qemu/compiler.h        |  26 +++
 accel/tcg/cputlb.c             | 340 +++++++++++++++++++--------------
 accel/tcg/translate-all.c      |  51 +++--
 exec.c                         | 158 +--------------
 hw/core/cpu.c                  |   1 -
 memory.c                       |  20 --
 trace-events                   |   4 +-
 13 files changed, 279 insertions(+), 428 deletions(-)

-- 
2.17.1


