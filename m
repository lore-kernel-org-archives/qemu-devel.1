Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEA7C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A3521726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ay8TcTV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A3521726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cYS-0000Wx-8w
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9Q-0005x4-Ho
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9P-0006f5-9N
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:12 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:41255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5c9P-0006eN-1q
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:11 -0400
Received: by mail-pg1-x52b.google.com with SMTP id x15so63333pgg.8
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=WLSDFQUCkqM7061s/ajWo6nIAdaEYh/nXuIw+ucQ/cY=;
 b=ay8TcTV54/sy4d8ilpOrnTfng7qF/1gvh1o7877NFpGGXHnfayjYGzeAhvkpdLjuk1
 2heBL6Hp5LzW5xF9Fm5pXMDQxmr33V7/W1oTB6NCo+AiKpmCADG+wWVoXbgC80cIF8bx
 Er/6nfHFeL9gB2+f/WEDpPAn92D2lFi38NaNM5Udj8ojD3PbwMmoP3CnPE5EJUFMaElV
 CIuUVr2OntOe9bFmcx4Vpxq92SEhWpO6ePuP33TngWqH0wkcguxL9UxfJKgwCfhtb2n8
 wRqpGPFm5MUPQ1630wHsf8CcBcHsqYzbLee6vK+vYtqi+O7oahImf3oViof95WI5WojR
 j9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=WLSDFQUCkqM7061s/ajWo6nIAdaEYh/nXuIw+ucQ/cY=;
 b=omg5bwuBUoMMenH+j+0SRDFPk/hqjurkiFhS3Y6nNwgYG5Ut3IIvWVYCwkSRVTWANQ
 ELNvTxNpQaCU46bj9w9KyCLFYGHXEtrmnK/up9R3hA8dqPZe3To9wMKBdrBOC2rJ5IC/
 CU6W7bDhxw0LGndxGdVKM54zc47hJit4wO6ibRcSrnF5MkxmlmNJzpIGXlR1WTTWLQsp
 wZbzfej2i2rqgtc5DaW3l1QyQBh5Ryi4cYuKOp2ekDC7Rxx35Jm+pVfP6kHag6zia1gz
 rb2TSM8HKNmLflFIWbliJ4jbt5qpnlZbSeeWfPOGcB9FyaidsMhd9Se9Oz1AeJkOmfgx
 ONlQ==
X-Gm-Message-State: APjAAAUn5sOnx/GERouOSN37TZ2GGnme0ROc/32HWF1ytb4hgOtfc3W4
 I94t7KrWpMokcW9n3orVh8kiloYxqXQ=
X-Google-Smtp-Source: APXvYqzcRVT/HULwD2WIBsDt9RXso00uhzNmXkjq+fhvqcehaE88aagRv9RO3qWNb0bEogQjoJqxZQ==
X-Received: by 2002:a65:4c4d:: with SMTP id l13mr69015pgr.156.1567629909042;
 Wed, 04 Sep 2019 13:45:09 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n66sm8104610pfn.90.2019.09.04.13.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:45:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 13:44:54 -0700
Message-Id: <20190904204507.32457-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52b
Subject: [Qemu-devel] [PULL 00/13] target/openrisc updates
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

The following changes since commit a8b5ad8e1faef0d1bb3e550530328e8ec76fe87c:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-09-04 17:22:34 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-or1k-20190904

for you to fetch changes up to 9e3bab08d3e3f5808cc35a59af1912bfb6fe96fd:

  target/openrisc: Update cpu "any" to v1.3 (2019-09-04 13:01:56 -0700)

----------------------------------------------------------------
Updates for arch v1.3.

----------------------------------------------------------------
Richard Henderson (13):
      target/openrisc: Add DisasContext parameter to check_r0_write
      target/openrisc: Replace cpu register array with a function
      target/openrisc: Cache R0 in DisasContext
      target/openrisc: Make VR and PPC read-only
      target/openrisc: Move VR, UPR, DMMCFGR, IMMCFGR to cpu init
      target/openrisc: Add VR2 and AVR special processor registers
      target/openrisc: Fix lf.ftoi.s
      target/openrisc: Check CPUCFG_OF32S for float insns
      target/openrisc: Add support for ORFPX64A32
      target/openrisc: Implement unordered fp comparisons
      target/openrisc: Implement move to/from FPCSR
      target/openrisc: Implement l.adrp
      target/openrisc: Update cpu "any" to v1.3

 linux-user/openrisc/target_elf.h |   2 +-
 target/openrisc/cpu.h            |  24 +-
 target/openrisc/helper.h         |   6 +
 target/openrisc/cpu.c            |  30 +-
 target/openrisc/disas.c          |  81 +++++
 target/openrisc/fpu_helper.c     |  49 ++-
 target/openrisc/machine.c        |  11 +
 target/openrisc/sys_helper.c     |  38 ++-
 target/openrisc/translate.c      | 716 +++++++++++++++++++++++++++++----------
 target/openrisc/insns.decode     |  45 +++
 10 files changed, 774 insertions(+), 228 deletions(-)

