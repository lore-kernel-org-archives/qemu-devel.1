Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CBFC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B79B2242F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wxexDAus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B79B2242F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIGs-0002Lc-Ux
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3u-0006XF-B5
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:10 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:54872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3j-0006Rc-2h
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:05 -0400
Received: by mail-pj1-x1031.google.com with SMTP id az3so1514834pjb.4
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RWsMXGKyEk1eHtmX0ja7euL/DCUMqSl+fI54xHCZl8I=;
 b=wxexDAuse5548oe1HDBe8pEgV6XPtv1uAW6dMToHrPdFmS/HP4l0WL6KiSXdxsGtSa
 +W28yqOcNcxRKs02Rd+m7mAI1pCzOvMfqFSf7wjlJfF8xjaXC7mV6QaG8J0ozaBtWTBO
 e+p0ZEMsnjmEljZ4YaWNV7mv/jJBFNMrm2mvCySTpuimWH3vuuT0ZBL/nO2VHBMm88BH
 KLRulNgOCZrLaeOWwH/QoDcccuEEGfgs/SUT/jNyL0IpNzmu/G90zaGZl76HiEEVwk3a
 ZNGBMGAWVmxUQ2j+qR3/cbLlZt21EaXiZen17AZ/rqy+QPhlBJi54+lh7J6Ft0ZsV5N3
 vLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RWsMXGKyEk1eHtmX0ja7euL/DCUMqSl+fI54xHCZl8I=;
 b=obDqpXywtpEmhgaSQhtXlPQ5eGDtqkpmHnWbPL3NQ7atBtCRex1curm4tS8WrCkiho
 oXC+gvR1Pi6vR77MGA8njTKnRqnwVWwhS83PnVm6r8I+8iYxenANuhxg5fr32JG0wi5N
 OuAMFEhHPEDQ3sRM4IRwd7MjRzet+cmsn64lQKQ9YMbqeOQJlEbLimsUFdzUxkKNuSah
 ia1uM9NlFGOauniMtpW4OivgsAM6xdD705bCBnYzCvabNVwY7I/dZo8CqdYOSYupHM0M
 dZ4IggsoSinxFQYCy+lUIHv4rw7sM0F6j4Qsf25SLa4wb3kn38GRcYLbOMqDRtWYDBNK
 kKxw==
X-Gm-Message-State: AOAM532ORXzGYCEiy4+1LcLXFAyIHhZXBdFy4Iz8in7Lp2FtBSu9N2N3
 6eMk+zLiwQcITO688OnsD0FGesjD8OXEAA==
X-Google-Smtp-Source: ABdhPJwz0/yaz9fQpSZvcNhVqj6XSZQURGe2alM9h5MA7UbhWznNPAZqcEklot0nk0/F98Geu7pwhg==
X-Received: by 2002:a17:90a:c388:: with SMTP id
 h8mr4418417pjt.100.1603301871479; 
 Wed, 21 Oct 2020 10:37:51 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h5sm2928829pfh.9.2020.10.21.10.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:37:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v12 00/12] linux-user: User support for AArch64 BTI
Date: Wed, 21 Oct 2020 10:37:37 -0700
Message-Id: <20201021173749.111103-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel abi for this was merged in v5.8, just as the qemu 5.1
merge window was closing, so this slipped to the next dev cycle.

Changes from v11:
  * Fix the reported bti-2 crash.
    Work around a bug in ld from binutils 2.34 (in our docker image,
    and Linaro's aarch64 ubuntu 20 host), which has been fixed in
    binutils 2.35 (in my laptop's cross-compiler installation).

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
 tests/tcg/aarch64/bti-2.c         | 116 +++++++++++
 tests/tcg/aarch64/bti-crt.inc.c   |  51 +++++
 tests/tcg/aarch64/Makefile.target |  10 +
 tests/tcg/configure.sh            |   4 +
 14 files changed, 577 insertions(+), 61 deletions(-)
 create mode 100644 tests/tcg/aarch64/bti-1.c
 create mode 100644 tests/tcg/aarch64/bti-2.c
 create mode 100644 tests/tcg/aarch64/bti-crt.inc.c

-- 
2.25.1


