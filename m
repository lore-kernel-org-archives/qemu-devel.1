Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D68C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78C1215A5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyxA31ST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78C1215A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iah1V-0001DR-3f
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 09:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iagqp-00022Y-A7
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iagqm-0003Ls-W3
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:27 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:53950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iagql-0003AM-04
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:24 -0500
Received: by mail-wm1-x333.google.com with SMTP id u18so14303099wmc.3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 06:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=unO0AhiSffm5fivkmBiYQ+YrTXmYNV33KVgfzx6rDvU=;
 b=dyxA31STwqLSNudN0MNrbdRrTijK1iVacrACxDesD2vIkeL5OTDhpaZ9VEs3csMdcV
 6WqF1vHjz6ya6pHNevP6GLM5k16QLjV8U8ke8oOE2tGrksxmSyd/Cc2MODjuCRaSWGWW
 tDx44NWpd5N8rVNoUbhXj0HU1PpNy/KKFGq3vORadP55QgmgbVhQgx9m4BAEwNLF7Yr+
 PhSfSUBYa6tVMRbLyRfrut2ICubXL6fVI5++7I8Uvc1KnxMGSiwuMKj6rPZZ3zkldybI
 XmagfHzsxaVSpfQvnrs0dvvZC8L49eVlgK2Irii8N7l34GnkCgQgjzHi4hGfEQwcjtqo
 dkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=unO0AhiSffm5fivkmBiYQ+YrTXmYNV33KVgfzx6rDvU=;
 b=TyJC+zOkA8x6Lca4N5f2vxoBGjX+p6PCeSCyo6wZU14S8pftc/cGymow6Ubo8MXk4q
 GIXRhm7QGt1OYmrU4zLd/YGeyktSuN1GwYP3lat6ApK/N6Nxk5h5vw1wmqCJIoTaowcd
 ii0l3QS4Kt2GB4/Q/VD4yQclMHnSpezQEBuYZ38155V17EH2en9SOAdhu4fhVytoK9QG
 kwa7mcWvutgRhNpIm5SvCru1AtINhRJ2Lh3F4a0zW34+Exa7YpdqYs9mSYaVehspVU9e
 G0euTejVyO9YGIoCASzAABpxO/n9xJobCh5wkNOMFTi6gUO72yOzJkvRpmlegbW4ND1g
 xsqg==
X-Gm-Message-State: APjAAAVmM7UAgqX6ld8e/IpXAAbQk3Aq/U64rlRY0ZZjj2EEXezKkiBF
 X7OJ2ILEZiVHpTF4FpKJP/GOLmoL
X-Google-Smtp-Source: APXvYqwism2Ph8gr/4IaAQw5eWydvSwcY99X9CS+726m94I9AxkfsH77cKGTasDHWYW+MZHouqaqtw==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr15676908wmc.9.1575036139000;
 Fri, 29 Nov 2019 06:02:19 -0800 (PST)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
 by smtp.gmail.com with ESMTPSA id
 e7sm14190030wrp.43.2019.11.29.06.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2019 06:02:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 0/8] docs: integrate doc comments with Sphinx build
Date: Fri, 29 Nov 2019 15:02:09 +0100
Message-Id: <20191129140217.17797-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

This merges my series and Peter's into one.  Both the memory API and bitwise
operation APIs are covered.

Paolo Bonzini (4):
  docs: import Linux kernel-doc script and extension
  docs: tweak kernel-doc for QEMU coding standards
  memory.h: Silence kernel-doc complaints
  docs: add memory API reference

Peter Maydell (4):
  docs/conf.py: Enable use of kerneldoc sphinx extension
  Makefile: disable Sphinx nitpicking
  bitops.h: Silence kernel-doc complaints
  docs: Create bitops.rst as example of kernel-docs

 Makefile                 |    2 +-
 docs/conf.py             |    7 +-
 docs/devel/bitops.rst    |    8 +
 docs/devel/index.rst     |    1 +
 docs/devel/memory.rst    |    5 +
 docs/sphinx/kerneldoc.py |  172 +++
 docs/sphinx/kernellog.py |   28 +
 include/exec/memory.h    |   16 +-
 include/qemu/bitops.h    |   52 +-
 scripts/kernel-doc       | 2236 ++++++++++++++++++++++++++++++++++++++
 10 files changed, 2499 insertions(+), 28 deletions(-)
 create mode 100644 docs/devel/bitops.rst
 create mode 100644 docs/sphinx/kerneldoc.py
 create mode 100644 docs/sphinx/kernellog.py
 create mode 100755 scripts/kernel-doc

-- 
2.21.0


