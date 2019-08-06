Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7905C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82EDC2147A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TC0/4oct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82EDC2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1humzF-0005eN-O1
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 20:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33608)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1humyW-0003vO-Vr
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1humyV-0008De-Q0
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:05:12 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1humyV-0008Cj-Ic
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:05:11 -0400
Received: by mail-pg1-x542.google.com with SMTP id d1so7730305pgp.4
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 17:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R+6Mvp82E0p6yB/libxbibUQjbVuKcqpL4edZewcAUM=;
 b=TC0/4octsAFEwyWOWZmMJbyVxDCiiIZz70lFfhc1WCV07Ovs0pP11cEe3JrS1zXb6j
 vPIcOREW7ql4OIafmbgxzRU0q2BdMkBlRTbSAXUY19yIwDVpD8RpJet4hg+ZQWeRxN51
 ZQ6fKszWHIlzqE20SZknMNC5EMJoAtSIszRvJ+j17VxPhAYsP6iR3fI7r4dht+xNt8fi
 Ibsbk4APXOPfYMHY9QEN6HeNzK29a88S3HQ5aAptO918BiG+d8F/go1z5UgkSe7x+UgL
 JbkdmofWVQRG7SDrFsRsapeSaZ0tWnzaYmX00IU0N7XgMrCGsWrHvdOirUiEhQYmJKNP
 Iqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R+6Mvp82E0p6yB/libxbibUQjbVuKcqpL4edZewcAUM=;
 b=HYtsYZYe8x/QicHkQXwYEOkzls2u2TQB38QjVzNWy8kznhkVDflBspjsAY9cBc6J6z
 X2eRniHw0pa+yHA4h4VycM24SuoWAEFDNz/ojgN9IYY91ctKuA9MVSVOGWtpJIpZQLOZ
 ylC22gY1v7rGRBLhEZAtk/zHre/90/nr7JVccUFrBqcCc3i+IvEq6QIQizk2DI/OlAdn
 fygJuBZgkSnoAKJrH84YlukUct95xjvms4oTxZhNBo7Mxqpejsqhu6C42mXiedED4kbV
 gBLRmLr7LJ/y0vtTX5JvSiaCLAWqHa8bGAC8AmJp2XjFbxSjQUKS8SMRnS+iqDwWMBWs
 RVeQ==
X-Gm-Message-State: APjAAAUTO8gzCu/gk+MroyeCU4BFZPLRqhgIPZES1ieBtkH/CbvvWAol
 AVr+7wUyp/VJOTHiktWr5rTYq0ZphIs=
X-Google-Smtp-Source: APXvYqxYpCnPp1BkbyIS4W04ASGt8dvWZB61o0QJserZ5yJSRonkVwEq7JXkFRX8k3G5uXKiqVa1yQ==
X-Received: by 2002:a17:90a:fa07:: with SMTP id
 cm7mr289075pjb.138.1565049909624; 
 Mon, 05 Aug 2019 17:05:09 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id i3sm92149782pfo.138.2019.08.05.17.05.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 05 Aug 2019 17:05:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 17:05:03 -0700
Message-Id: <20190806000506.10833-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v4 0/3] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Version 3 was back in February:
https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg06002.html

Changes since v3:
  * Rebase.
  * Do not cache XSCALE_CPAR now that it overlaps VECSTRIDE.
  * Leave the new v7m bits as uncached.  I haven't figured
    out all of the ways fpccr is modified.

Changes since v2:
  * Do not cache VECLEN, VECSTRIDE, VFPEN.
    These variables come from VFP_FPSCR and VFP_FPEXC, not from
    system control registers.
  * Move HANDLER and STACKCHECK to rebuild_hflags_a32,
    instead of building them in rebuild_hflags_common.

Changes since v1:
  * Apparently I had started a last-minute API change, and failed to
    covert all of the users, and also failed to re-test afterward.
  * Retain assertions for --enable-debug-tcg.


r~


Richard Henderson (3):
  target/arm: Split out recompute_hflags et al
  target/arm: Rebuild hflags at EL changes and MSR writes
  target/arm: Rely on hflags correct in cpu_get_tb_cpu_state

 target/arm/cpu.h           |  35 ++--
 target/arm/helper.h        |   3 +
 target/arm/internals.h     |   3 +
 linux-user/syscall.c       |   1 +
 target/arm/cpu.c           |   1 +
 target/arm/helper-a64.c    |   3 +
 target/arm/helper.c        | 334 ++++++++++++++++++++++---------------
 target/arm/machine.c       |   1 +
 target/arm/op_helper.c     |   1 +
 target/arm/translate-a64.c |   6 +-
 target/arm/translate.c     |  14 +-
 11 files changed, 254 insertions(+), 148 deletions(-)

-- 
2.17.1


