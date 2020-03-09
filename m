Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE83C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 21:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A372253D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 21:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSMFt2rM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A372253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBQQl-0004Ug-DC
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 17:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBQPo-0003AB-0d
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 17:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBQPm-0005cR-IU
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 17:58:23 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:53675)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBQPm-0005b4-BI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 17:58:22 -0400
Received: by mail-wm1-x32f.google.com with SMTP id g134so1192854wme.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 14:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I+5a9zEgMMFR0bDZiCYRjxV9Bygk+g13EGfEiLMSujY=;
 b=NSMFt2rMi1DKZ+ESjSQfMbWSAEKiLzndHEKXIUCvpzHXfcaObj11OHNMyaBsdwbsQW
 jKblpArBHezoNI88URb0UcTDaUBt6Q4od9/f6sezMdIoxTax7pPncCML7IOt2zSslATB
 1nkJ5CcowWJNyy/bIiBlEl5bQMoG0AwSuuNYxdknVVY6pYuRcYvM8qHs5eeP5PEqnXzt
 ZjwkSwdtfPQ4nD4VHqSXPBPoLjTox291yD7N9WBZEs21LYNulVj2lIZ/FQ+LZM7wrUYv
 M/nyMAtj7UiQofFisu2D6IAXv3DwQe4pMVNPI22hqlbcnqoOIYmKTwlJXLllUZw3lQdx
 WDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I+5a9zEgMMFR0bDZiCYRjxV9Bygk+g13EGfEiLMSujY=;
 b=dLZM5zV/KAz5FLLt9Or6kOSP1mb8FXofnQVZoS9ycTJhUh6K3Aq8l0/DQm4qHy+iO8
 iWe01qM0nMDi8+/82NGY+crNdaf43AziCSRIyDa1CEwGpvXpP1kW5VDja5gLdcHqTgaS
 fdmzsul5S7yG8gKsj6bS6SKK59LME2naiB58TW1649u4gN0vkMAYZnkUNjMsIa/JNjS8
 CtVjiKOtVh3HsIakBweY8o+VlCGeXsdX08FsZnGt0gjK5UVh8FR9Ngac0qk3CSbp1o52
 ucTF8bzu2IKkWapHEM81WBNRtfHQxHYuRq13RlowP8JOjPKVZO0BzOdhGkDWCouyLC3w
 +Wgg==
X-Gm-Message-State: ANhLgQ1UGTGKfi5N8E5YZ4iL4o0wqWqgUcr9ePOnbuwhFHrra/LcneSX
 6L7wjsq21zcajmuLzRkBkNVc5Q==
X-Google-Smtp-Source: ADFU+vtJsABeKC1IcC999OiFGQ01Ke8zQkZNgoo+eYELE3BosTC/Ihe39cDUmYa8JLDKwU4rKfwcDQ==
X-Received: by 2002:a1c:e442:: with SMTP id b63mr1267839wmh.174.1583791101100; 
 Mon, 09 Mar 2020 14:58:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f17sm42207068wrm.3.2020.03.09.14.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 14:58:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/5] docs/system: Split target-arm.rst
Date: Mon,  9 Mar 2020 21:58:13 +0000
Message-Id: <20200309215818.2021-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchseries splits the 'target-arm.rst' file in the System
manual into one file per board or family of boards.  It's not
sensible for us to document all 50-odd boards in a single enormous
page, and the split will encourage more detailed and useful per-board
information.

The impetus for doing this split is that it gives somewhere for the
documentation for the upcoming Orangepi board model to live.  It also
means we can move arm-cpu-features.rst out of being an orphan unused
file in the docs/ directory.

I've also added some of the text I originally wrote for the wiki as a
general introduction to the Arm system emulation and to how to choose
a board model, plus some apologetic text about how most of our boards
are undocumented.

The last patch in this series smooths out an inconsistency in how we
spell 'Arm' (there was a corporate rebranding back in 2017, so we
have a mix of old-style 'ARM' and new-style 'Arm'); I don't feel very
strongly about this but the inconsistency did look a bit odd in some
of the docs that this series moves around, and it was 5 minutes work
to make docs/ consistent on one style.

Side notes:
 (1) I still think it would be nice to be able to generate some of
this from doc comments and/or the board declaration macros; that
would be definitely not 5.0 material, though

 (2) Anybody want to tackle the target-x86 part?  There's a
docs/microvm.rst which would naturally live in
docs/system/x86/microvm.rst if target-x86.rst was restructured along
the same lines as this series, but it would need something
writing for the other x86 machine types...

thanks
-- PMM


Peter Maydell (5):
  Makefile: Allow for subdirectories in Sphinx manual dependencies
  docs/system: Split target-arm.rst into sub-documents
  docs/system/target-arm.rst: Add some introductory text
  docs: Move arm-cpu-features.rst into the system manual
  docs: Be consistent about capitalization of 'Arm'

 docs/can.txt                                  |   2 +-
 docs/devel/atomics.txt                        |   2 +-
 docs/devel/multi-thread-tcg.txt               |   8 +-
 docs/replay.txt                               |   2 +-
 docs/specs/fw_cfg.txt                         |   2 +-
 Makefile                                      |   2 +-
 MAINTAINERS                                   |   9 +
 docs/devel/kconfig.rst                        |   2 +-
 docs/devel/loads-stores.rst                   |   2 +-
 docs/devel/tcg.rst                            |   2 +-
 docs/specs/tpm.rst                            |   6 +-
 .../arm/cpu-features.rst}                     |  12 +-
 docs/system/arm/integratorcp.rst              |  16 +
 docs/system/arm/musicpal.rst                  |  19 ++
 docs/system/arm/nseries.rst                   |  33 ++
 docs/system/arm/palm.rst                      |  23 ++
 docs/system/arm/realview.rst                  |  34 ++
 docs/system/arm/stellaris.rst                 |  26 ++
 docs/system/arm/sx1.rst                       |  18 ++
 docs/system/arm/versatile.rst                 |  29 ++
 docs/system/arm/xscale.rst                    |  29 ++
 docs/system/target-arm.rst                    | 295 +++++-------------
 docs/user/main.rst                            |   8 +-
 23 files changed, 340 insertions(+), 241 deletions(-)
 rename docs/{arm-cpu-features.rst => system/arm/cpu-features.rst} (98%)
 create mode 100644 docs/system/arm/integratorcp.rst
 create mode 100644 docs/system/arm/musicpal.rst
 create mode 100644 docs/system/arm/nseries.rst
 create mode 100644 docs/system/arm/palm.rst
 create mode 100644 docs/system/arm/realview.rst
 create mode 100644 docs/system/arm/stellaris.rst
 create mode 100644 docs/system/arm/sx1.rst
 create mode 100644 docs/system/arm/versatile.rst
 create mode 100644 docs/system/arm/xscale.rst

-- 
2.20.1


