Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6347C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0381620EDD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iuy1AVBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0381620EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTUiW-0002Ij-Rk
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 14:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgD-0000SW-NS
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:18 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:44445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUg8-00024n-Lx
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:17 -0400
Received: by mail-pg1-x533.google.com with SMTP id o3so1941680pgr.11
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I0n3SezFuJzE05AkRQW/o6Jz2n22t2TpjyOtThyQzb4=;
 b=iuy1AVBNvqbPAtssMl2XSpXJJmGsZsvrDj50t+B8BVPDbhn7ojirv0cUjuZnoOIpkL
 DgZwUiHARdrv9AZQX8F5b5+OO0VPpVHTQ9JNTBMMyR9QpHR62+JP8G0Sn7fSV3ea6f2e
 +hI7439b59gwbmeEILgXbwIti72lkhMBnGltKyy8K9JY8UbrywOjrqL1d5PphKjc367y
 J2kBOHlkpGvMSeoBVEchzpULqgFScr2jYNa3iE9CrDo3uTVQdm7GDESkR7/wNl048fZm
 fI/PBhmxxiFOzgvTSExG/cdVX4wuNy+aRNUREOu9Es84Ccnkwt7qaz0FpCYDXEbdDGU/
 mvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I0n3SezFuJzE05AkRQW/o6Jz2n22t2TpjyOtThyQzb4=;
 b=VAGFkAX6jdKi7j7lAmYo8qcoYDXBoXbPQKGoF2ihL3++zrpJjiiawvnhA/HiPJHPSg
 xZ5zPJPGftBS68tzPGr5i+u8GOi3mHO2kjmcwFtNpbZZpOaO/e1u7kMO7xexbgnwECYc
 8oa17o6wJCg36PoVXwd4s8nUI8EcRepmmH3bj6R0AQjAay2dTV71Wl1i4MBtQwuREBdj
 lGbBp65wyxQ3nGz2b5UPQC+wxCxhMvYqTAp1uRlFcm8z9SFZN7nw1myAkk7kaptNieJt
 mifY4r7FH0qpaT/XVFhQvkOACiohluxlO9T7PHMy2isa+dHGYssRsg3tNPqZh01nUr0z
 DTQA==
X-Gm-Message-State: AOAM5328bg3LKcpajfNGFLjVsEHoPsvio5ArEbXXDUgjNQMU9QD9x5Gi
 0Ol9QXeyJf7OY6Cwsjrp5yCu4BNVLxJnCA==
X-Google-Smtp-Source: ABdhPJzIpFPgg5j6S3Obbh3WqLNDyBhiTBbeEYhFm73Qm2hlwrT64pTiPgqOpqxu+tx12g/LyTyUIg==
X-Received: by 2002:a63:5f97:: with SMTP id t145mr4358892pgb.115.1602873729909; 
 Fri, 16 Oct 2020 11:42:09 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c15sm3426011pgg.77.2020.10.16.11.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 11:42:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 00/12] linux-user: User support for AArch64 BTI
Date: Fri, 16 Oct 2020 11:41:55 -0700
Message-Id: <20201016184207.786698-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel abi for this was merged in v5.8, just as the qemu 5.1
merge window was closing, so this slipped to the next dev cycle.

Changes from v10:
  * Include Phil's plug of interp_name memory leak.
  * Convert error reporting to Error api.
  * Mirror the kernel's code structure for parsing notes
    (though Error means that it's not exactly the same).
  * Split aarch64 stuff from basic note parsing patch.

Changes from v9:
  * Split what is now patch 7 into 3 more (pmm).
  * All prerequisites are now upstream.


r~


Philippe Mathieu-Daudé (1):
  linux-user/elfload: Avoid leaking interp_name using GLib memory API

Richard Henderson (11):
  linux-user/aarch64: Reset btype for signals
  linux-user: Set PAGE_TARGET_1 for TARGET_PROT_BTI
  include/elf: Add defines related to GNU property notes for AArch64
  linux-user/elfload: Fix coding style in load_elf_image
  linux-user/elfload: Adjust iteration over phdr
  linux-user/elfload: Move PT_INTERP detection to first loop
  linux-user/elfload: Use Error for load_elf_image
  linux-user/elfload: Use Error for load_elf_interp
  linux-user/elfload: Parse NT_GNU_PROPERTY_TYPE_0 notes
  linux-user/elfload: Parse GNU_PROPERTY_AARCH64_FEATURE_1_AND
  tests/tcg/aarch64: Add bti smoke tests

 include/elf.h                     |  22 ++
 include/exec/cpu-all.h            |   2 +
 linux-user/qemu.h                 |   4 +
 linux-user/syscall_defs.h         |   4 +
 target/arm/cpu.h                  |   5 +
 linux-user/aarch64/signal.c       |  10 +-
 linux-user/elfload.c              | 326 +++++++++++++++++++++++++-----
 linux-user/mmap.c                 |  16 ++
 target/arm/translate-a64.c        |   6 +-
 tests/tcg/aarch64/bti-1.c         |  62 ++++++
 tests/tcg/aarch64/bti-2.c         | 108 ++++++++++
 tests/tcg/aarch64/bti-crt.inc.c   |  51 +++++
 tests/tcg/aarch64/Makefile.target |  10 +
 tests/tcg/configure.sh            |   4 +
 14 files changed, 569 insertions(+), 61 deletions(-)
 create mode 100644 tests/tcg/aarch64/bti-1.c
 create mode 100644 tests/tcg/aarch64/bti-2.c
 create mode 100644 tests/tcg/aarch64/bti-crt.inc.c

-- 
2.25.1


