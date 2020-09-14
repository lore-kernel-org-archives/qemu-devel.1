Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDEBC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 00:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE8E20796
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 00:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZUqFLex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE8E20796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHbxI-0003wZ-4u
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 20:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHbwV-0002UT-BJ
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 20:01:59 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:35225)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHbwT-0004BR-Gb
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 20:01:59 -0400
Received: by mail-pf1-x434.google.com with SMTP id o68so11179403pfg.2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 17:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=INOIZZ1UU6wjUvExIBY5xZEUID/bFlB32HgebiDeLvo=;
 b=RZUqFLexb/mvoAA1++MJGs1AUjxM/wRxFM/AbTSd3aRw3UitS7Wz1BYn3AnkCZVEnj
 FDuum2D71e0SKqKqBlb8NTZmAnrkeiheu9UO7SPdqZQb37ucVgOE6siCuwhhpYIYeC60
 xIgRRa2XnosMabb04VA4FGuNTIg5OiHaBjNoDhD/B56KnEf5jqX6Bh+Eo4Gyt7WRBp8e
 eE8VmSAALc2pNsLCifm2UxLTQnCDhjRZmxkGGWITXxRhy3a46yRU3qeUE35hiCqHasvI
 L9avhW4dAVETwPDdpt600M93VQnRrYXoLzcOc8DblQ7oouXhwAooGAjUON20Qsen+mP/
 B5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=INOIZZ1UU6wjUvExIBY5xZEUID/bFlB32HgebiDeLvo=;
 b=p1gymoVhfCixWy6H75hSQnAwCl5iVbLrSdZ9JInHCmbToGLb8P/FourOBFPAsZt/WF
 abSRL6WcJNUN1p5YtGexrDCCmbIyORQRM7Pn1vM6wI8GQ9zS06jgu2Hftc+wkG8Nfm7b
 1HmNH+BQRUmXgrBnaBMDgs/2QchXUXCzJSCJ5NVfwhNssjTVU8U6s1g+53MoGDPj4PNU
 nOCdWaPPty8uZc+4tXw/z8W+tkxAJJw2PVai4nE7e+6jYyekfjHrYCBojkObPA59xQ+M
 YnWkTBBSD1rApRZ45FQpsWtXJuaGFHzxnLlZj8ogIbLTDHs8o81dSPZpVEO8megBc9it
 MroQ==
X-Gm-Message-State: AOAM53116Xz24VTxDOx0xNVjzpauIOjn/h64arAZcCQWKglIbBo2AANj
 fw4frw5gdl87ATgkTKK02lI0sBF0xlKaEA==
X-Google-Smtp-Source: ABdhPJxzp8Jq255Gh7TCBleCy3l7F8De1+0V73rp7fZfIHZbHVQLSoW1WR28gUBI9NmpTT443hUZiQ==
X-Received: by 2002:a17:902:b586:b029:d1:bb0f:2644 with SMTP id
 a6-20020a170902b586b02900d1bb0f2644mr8292015pls.34.1600041715069; 
 Sun, 13 Sep 2020 17:01:55 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 31sm6538252pgs.59.2020.09.13.17.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 17:01:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/11] capstone + disassembler patches
Date: Sun, 13 Sep 2020 17:01:42 -0700
Message-Id: <20200914000153.1725632-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: luoyonggang@gmail.com, alex.bennee@linaro.org, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The primary change here is the update for capstone to meson.
This bypasses capstone's build system entirely.  There's more
commentary on that subject with the first patch.

Plus a collection of other fixes and cleanups in the area.

There are a couple of other targets that could use capstone:

The current capstone branch has a fatal bug affecting RISC-V.
I have submitted a fix upstream for that, and have the minimal
patches required to enable it here.

There is capstone support for m68k, but it doesn't look like
there's coldfire support.  So capstone is a subset of what we
have in disas/m68k.c.  There's probably no point changing here.

There is capstone support for mips, which might be good enough
to replace disas/mips.c.  It wouldn't replace disas/nanomips.c,
and there's no support at all for the micromips isa.


r~


Richard Henderson (11):
  capstone: Convert Makefile bits to meson bits
  capstone: Update to upstream "next" branch
  disas: Move host asm annotations to tb_gen_code
  disas: Clean up CPUDebug initialization
  disas: Use qemu/bswap.h for bfd endian loads
  disas: Cleanup plugin_disas
  disas: Configure capstone for aarch64 host without libvixl
  disas: Split out capstone code to disas/capstone.c
  disas: Enable capstone disassembly for s390x
  disas/capstone: Add skipdata hook for s390x
  disas: Enable capstone disassembly for sparc

 configure                 |  24 +-
 Makefile                  |  16 -
 include/disas/dis-asm.h   | 102 +++---
 include/disas/disas.h     |   2 +-
 include/exec/log.h        |   4 +-
 accel/tcg/translate-all.c |  24 +-
 disas.c                   | 702 +++++++++-----------------------------
 disas/capstone.c          | 326 ++++++++++++++++++
 target/s390x/cpu.c        |   4 +
 target/sparc/cpu.c        |   4 +
 tcg/tcg.c                 |   4 +-
 capstone                  |   2 +-
 disas/meson.build         |   1 +
 meson.build               | 112 +++++-
 meson_options.txt         |   3 +
 15 files changed, 672 insertions(+), 658 deletions(-)
 create mode 100644 disas/capstone.c

-- 
2.25.1


