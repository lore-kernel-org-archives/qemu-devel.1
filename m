Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64030C3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 21:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293B620870
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 21:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXOrtwFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293B620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1diT-0002G6-2H
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 17:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1dga-0001LU-UH
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1dgY-0002zm-NE
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:35:00 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:34038)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1dgW-0002wM-GV
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:34:56 -0400
Received: by mail-pl1-x629.google.com with SMTP id d3so7772575plr.1
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2019 14:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=zPthgjq3EApjczyIKc35H4LPep1TgUZB2P7mpwIR2W8=;
 b=OXOrtwFz+iS1F93vstxPv8KYrM6P19i14c4gDYAfGkuLaZRj8rJx2nh+js4YpZf4k0
 H0sAK0KgcPCsB7HnLkwtfLOXJrp3OIbXc1it5052lMZ6EC5OVfIqhakwaMQVnNo6h5Kg
 5P+YvywnvxQ7HY7XGaAQZ79m8MXbpV9YZfxx4/h8zC6DG3+qfOGEyoI7iMasb9uJn6JD
 vEjAHF9RsozWB7qBfAoWkuPYmFge1QJsEhJoq7AX4zfgWV4Kf5ILsGrusNF99+4TC1QI
 zVY3JmFtsX2kEShXr6beznnK6GtMp4xXOvqSIVUtXqp3oGDRd0fSLU8JEw+14tAtcktL
 3OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=zPthgjq3EApjczyIKc35H4LPep1TgUZB2P7mpwIR2W8=;
 b=mrnpoQKx9sAPLawV6BxkNFtOaGH1CAccKWxYI7IV+TUjDoU/1dVO0WTI9Qevm/myCs
 dzvX1ar0Q+Rf7NTidaPdFgUXyGYPXSXI4vZJ3grYHewLIKasQ+O5mBS+4YuWNUG/JGc+
 rQB6tUnXv63P1KH/9+Z1Xr+s/wH4DpHN52IL17sOWEfAykauXoiA9JLWtGGpvtEtF0MF
 B3V8dy3vycOHG7zCVGZwrVDm8KEnhYB2LUiYovWffBrdOHPMOIF2NYUu0i66cVpRWo0x
 22lS+QTsl3Vmi7Ry3x1e2Q7Zc0+PLSO6dn5S1T0hinrdESF3seLKYjfaXOTm6tseJqN+
 W5fw==
X-Gm-Message-State: APjAAAVO7NgOuFgc8Kn01o0MpsmYVB9ejqFd7JwkrEBmBixupwuTZEPi
 zoRYNcWkGGbuW02YuHGl1fmiuiAkKNg=
X-Google-Smtp-Source: APXvYqxh5w1hCGWPlVnhus3eA1VuDbbN7DsIAIKCei8Tlng2TthYxbXUEplN72FdMTQrBcZ34psM4A==
X-Received: by 2002:a17:902:ff02:: with SMTP id
 f2mr10742191plj.99.1566682494296; 
 Sat, 24 Aug 2019 14:34:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 81sm6325753pfx.111.2019.08.24.14.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Aug 2019 14:34:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 14:34:45 -0700
Message-Id: <20190824213451.31118-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::629
Subject: [Qemu-devel] [PATCH 0/6] exec: Cleanup watchpoints
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
Cc: peter.maydell@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

Richard Henderson (4):
  exec: Move user-only watchpoint stubs inline
  cputlb: Fold TLB_RECHECK into TLB_INVALID_MASK
  exec: Factor out cpu_watchpoint_address_matches
  cputlb: Handle watchpoints via TLB_WATCHPOINT

 include/exec/cpu-all.h |   8 +-
 include/hw/core/cpu.h  |  37 +++++++++
 accel/tcg/cputlb.c     | 156 ++++++++++++++++++++++++--------------
 exec.c                 | 167 +++++++++--------------------------------
 4 files changed, 173 insertions(+), 195 deletions(-)

-- 
2.17.1


