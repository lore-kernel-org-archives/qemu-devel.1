Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EAEC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 189FD20679
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gk+Hrn0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189FD20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i37DY-0005qI-Ri
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 19:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i37BQ-0004AK-De
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i37BP-0008F5-6M
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:16:56 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i37BO-0008Ez-W8
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:16:55 -0400
Received: by mail-pl1-x644.google.com with SMTP id bj8so660125plb.4
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 16:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=+7ek5yyanNbWwpydzYMNQsQs/w7ABBrAnwWJJRR1ihI=;
 b=gk+Hrn0/DSkSUjCAwWyKbsq3I3Hqnk22PZOhzaYIMsulgu1TO7ueIRRAyyCziwdiwO
 DbPFqAkI6UtL+m95xqNNfouQV48lP6R09OIgprVAj2PhbidYrutVDLwnJnsqHUaPkmXc
 a0guKQYSoyU0T5yLtvGYYfLJuZp14hK/xAfSm0kCkGsA8qAZIOTp8fHE9kFKIrMTLhOJ
 3u1wlhdbuMp/TQQ4J3vLlLeLZV97pXHYgeUgMICPkaTBXQFUmoCxi/XbT3qSC6R/d5yd
 cDEMGJPmeH4Fvj/tWt4Sx0yu/zjochh4gc+GcgSZXZb65nKXTfic5s/E45wwj2ZWbyqZ
 CWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=+7ek5yyanNbWwpydzYMNQsQs/w7ABBrAnwWJJRR1ihI=;
 b=KNLwM3xu+yO5po6792rxSnl9ItdAfxmREt0hjmITCR4dTslhqlNoqd2OlSfkbwy0f+
 sjJHCOlEzu1HMOapSaNyAdy+uu+MIPrI6lCl5rDGFWx2pSS9/bg1NJAxsyoTr0m4Ti1e
 VPyUXsI9F84ApwzgFsbXFcyDPPIWbgMhoMqRqpEazjVGBJDsE0JUeXAXm7qDw82wk0jY
 vN8YqDzV9uQ3Z1IqjPRuhSAypkNnYbrpt4gzoxTIBJovlI8zlEIrWJoI+ykSQjplOKgj
 GJUwKXh0TFUldjb4HsdzXISPZ1m8CB+TVn42XGp9Y5cIgCZXmLFn6/30GRWY3o2ZhYq3
 6CEA==
X-Gm-Message-State: APjAAAVKCJNmkoYLruIlM1xyovTQiRyJgQQv3mrtBqi6INkDZG0Xufl5
 mKXWhGWAeju1sZ4/AC+8l9iVhMw41Kg=
X-Google-Smtp-Source: APXvYqyDx7q52s8Jjxx/b2vkwFPvQcMRB6bXDdIK3jVWjIEfsYU0ebLIZbYpuZqu2vvhErHbgc41/w==
X-Received: by 2002:a17:902:4303:: with SMTP id
 i3mr7170334pld.30.1567034213584; 
 Wed, 28 Aug 2019 16:16:53 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s5sm485197pfm.97.2019.08.28.16.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 16:16:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 16:16:43 -0700
Message-Id: <20190828231651.17176-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v2 0/8] exec: Cleanup watchpoints
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

Changes from v1:
  * Split out some minor fixes to separate patches.
  * Reload tlb_addr2 after tlb_fill for page2 in patch 7.

Blurb from v1:
As discussed with David earlier this week, the current implementation
of watchpoints cannot work, at least reliably.  We are raising an
exception out of the middle of the i/o access path which does not
even attempt to unwind the guest cpu state, nor does it have the
information required to do so.

This moves the implementation to the cputlb helpers.  This is a point
at which we can and do raise exceptions properly.

In addition, this fixes a bug in that unaligned stores were detecting
watchpoints in the middle of the byte-by-byte operation, which means
that we didn't signal the watchpoint early enough to avoid state change.


r~


David Hildenbrand (2):
  exec: Factor out core logic of check_watchpoint()
  tcg: Check for watchpoints in probe_write()

Richard Henderson (6):
  exec: Move user-only watchpoint stubs inline
  cputlb: Fold TLB_RECHECK into TLB_INVALID_MASK
  exec: Factor out cpu_watchpoint_address_matches
  cputlb: Fix size operand for tlb_fill on unaligned store
  cputlb: Remove double-alignment in store_helper
  cputlb: Handle watchpoints via TLB_WATCHPOINT

 include/exec/cpu-all.h |   8 +-
 include/hw/core/cpu.h  |  37 +++++++++
 accel/tcg/cputlb.c     | 166 +++++++++++++++++++++++++---------------
 exec.c                 | 167 +++++++++--------------------------------
 4 files changed, 179 insertions(+), 199 deletions(-)

-- 
2.17.1


