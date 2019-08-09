Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B52C32756
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E2E208C4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKbKK+Kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E2E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw732-0001zk-7c
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50726)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hw71k-0000YJ-Ru
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hw71h-0008QJ-Ul
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:41:59 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hw71h-0008PR-DA
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:41:57 -0400
Received: by mail-pl1-x642.google.com with SMTP id c14so45029987plo.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 08:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=1N0mIyh5t8eVenXRm3PmSJuWeZ0AYiNkiWHu272Cug8=;
 b=JKbKK+KbdfXoV9FaeFHdlxOgEmWNEvRysMHVRs0Wa1QDVkXrz3sQrqVvmHzzaMgXf0
 KYciDrXlDWnD9uBKK8b3pGQfyfb2eb6rUGqEWzYx9gybZTzwWlzhLN4bvcDEH7fD61/Q
 3x+G+DCc+dhsZUt7tEOrW3J9QDbTsBsij0Ts4TmCwrXCdTNffwsI+UnL0FQa2/GXBmK7
 5ei22cJcv5BtL6kOEurdy9UmiLAhYNa/cxD9AXAVUW+bJL7+n4prVUh0R6ZPWmR6Cg9s
 YndGCQbgueEfxFJAgw44wifI92VKt4aaZQZOQ5TwP1TBOKS9ApahxIYI9mSWcfyJRN4M
 VisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=1N0mIyh5t8eVenXRm3PmSJuWeZ0AYiNkiWHu272Cug8=;
 b=q6Lk2SSiwTlxOiIukDbInCb85WqBQxuiU/a+17ZLgnRWBhbZgI5aOreP6j8vgQszBX
 ghXskcHlIzNp0VNy+MEQ76EB+Km3SOExQUF/skHUSVNdn4UkPOWNwhfhhVYiysMoks0Z
 /Ko5dYPN5jhEbWTWanntYuWpCApJMqPiXpf5ZCNFmTHdEc8Jx0vf0D8TWBATLU+RTBd+
 kHqbNnpGESHBDpLzoaD2uuaZ6VPuNtzTAnEVwMVtkAeo1Zf5LIIqydjDULHSPNiPA9OQ
 CfzgQQmLcUFFUqe3aKMA0VbjgzswJuWdAFw9iXq9lj6/zkXvp7KgbfgwpzXRumJ7Paln
 txSA==
X-Gm-Message-State: APjAAAWCUcTF4KCy+oHb9WC155srGp86OQe2b+z4ZqACIWKRz3i8aDgu
 z9oEYQ9+uvScWuQjr/XKjO66X++nWCs=
X-Google-Smtp-Source: APXvYqwOAbPFfPgZkrRJ7pinJJdA5PnXjFdRDhHy5X+G8pAZg6ZU6dtglfSpl/PJQhbeuzBZebuPVA==
X-Received: by 2002:a17:902:2be6:: with SMTP id
 l93mr19920795plb.0.1565365315993; 
 Fri, 09 Aug 2019 08:41:55 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 67sm80452179pfd.177.2019.08.09.08.41.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 08:41:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 08:41:50 -0700
Message-Id: <20190809154153.31763-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH 0/3] decodetree improvements
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
Cc: peter.maydell@linaro.org, Alistair.Francis@wdc.com, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are split out from my decodetree coversion of the AArch32
base instruction sets.

The first patch has been tidied per review from Peter.  I now
diagnose nonsense fields containing no bits.  I eliminated the
unused integer argument passed to the named function.  I improved
the documentation.

The second patch is new, a suggestion from Phillipe.  This then
enables the third patch, tidying up the existing usage in riscv.


r~


Richard Henderson (3):
  decodetree: Allow !function with no input bits
  decodetree: Suppress redundant declaration warnings
  target/riscv: Remove redundant declaration pragmas

 target/riscv/translate.c          | 19 +-------
 docs/devel/decodetree.rst         |  8 +++-
 scripts/decodetree.py             | 76 ++++++++++++++++++++++++++-----
 tests/decode/err_field6.decode    |  5 ++
 tests/decode/succ_function.decode |  6 +++
 5 files changed, 83 insertions(+), 31 deletions(-)
 create mode 100644 tests/decode/err_field6.decode
 create mode 100644 tests/decode/succ_function.decode

-- 
2.17.1


