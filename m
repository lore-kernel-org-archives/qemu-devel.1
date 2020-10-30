Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2617C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480DD2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v59OOn2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480DD2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYJ0i-00027B-6x
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 21:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbi-00045U-CJ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:30 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:33860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbd-0001ox-Ve
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:29 -0400
Received: by mail-pf1-x42e.google.com with SMTP id o129so3819903pfb.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 17:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b5gnJAS1l+4jnmdD5nsVkdxxSwkjVYUjQYYOYKHGitw=;
 b=v59OOn2hz41Tequgu7ohrWmjtiufLJPyL8zd8bHTp43D3eHjPcPACofu3f4fZ7xzOL
 3xjFEsTE8cUNQtSQl1AuTTEyo0lEOUaScLy2fJvGeIHaYIlUzWBZ1bn7/pHi7Az0GYnL
 imZe0EWel7+S3etWoi8KjpDNkM5GNBqk3YXOEbiwNvV+3Hgy49lV7RLWlHCKu23g+uTy
 bZjU96XJHdXRkZI2rGge85YMG2ZRElqJWPEeHVOdgMI8evR6BnJuLYHYZ6/5VltVZSBj
 XkYopnOj2c+4oCpe2zFIZkDzhvzJgj1wWDTE6Gsvsf1VQCoNeN+s501nxhBocbqxBsF2
 RrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b5gnJAS1l+4jnmdD5nsVkdxxSwkjVYUjQYYOYKHGitw=;
 b=PPpAkJmfFmi52+sklAX3VqKIAWEnkjRZtKPeqk0Ldp8tjyTNKPhm8bEN0Eu+Y7Feuz
 Q+iY4vcFh34kk0Aef5tgVGUS0DqkDZ2WcvEKovMxGEJpR0JEZjScUutsCtiKyTLmh0TW
 g6K6mPi4kOMmCI0G6Bzr0qENFhiqhTR5h2LZZtUgw8nouliQzz7NmO48hEFdOU+RpeKJ
 AwlTY92bpuzTRiqFQ87HhEXUg6tXoVH85FsqFaWmLZrOAIbKSrO6GVY5wuW5/rvkrDl7
 /qPGwCQKeE5r16xRohQLqy5U3+Y1WbKf1qa0Kfglv1UctBQOCjuH3msfn9IjlHl0pj52
 Vf5Q==
X-Gm-Message-State: AOAM531weWkapjLdjqGaFppBxlcWPN/hEkE2yD5i+90YiVFbiTyWc9ht
 /bx/9XJxwJMEd4q88XGXlhh+df+VAx/niw==
X-Google-Smtp-Source: ABdhPJyLVaQEEW11j7u+sdNkBRiu/NuNYaAtRpbGSRy/XqYkzUNKiQeqLyMnukgrCtlQ7nF39HHqjw==
X-Received: by 2002:a17:90a:3485:: with SMTP id
 p5mr2471562pjb.161.1604018963193; 
 Thu, 29 Oct 2020 17:49:23 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm3557264pgq.58.2020.10.29.17.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 17:49:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/19] Mirror map JIT memory for TCG
Date: Thu, 29 Oct 2020 17:49:02 -0700
Message-Id: <20201030004921.721096-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
Cc: pbonzini@redhat.com, j@getutm.app, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is my take on Joelle's patch set:
https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg07837.html

First, lots more patches.  For the most part, I convert one interface
at a time, instead of trying to do it all at once.  Then, convert the
tcg backends one at a time, allowing for a backend to say that it has
not been updated and not to use the split.  This takes care of TCI,
for one, which would never be converted, as it makes no sense.  But I
don't expect to ever try to convert mips either -- the memory mapping
constraints there are ugly.

There are many more places that "const" could logically be pushed.
I stopped at several major interfaces and left TODO comments.

I have only converted tcg/i386 and tcg/aarch64 so far.  That should
certainly be sufficient for immediate darwin/iOS testing.

Second, I've taken the start with rw and offset to rx approach, which
is the opposite of Joelle's patch set.  It's a close call, but this
direction may be slightly cleaner.

Third, there are almost no ifdefs.  The only ones are related to host
specific support.  That means that this is always available, modulo
the actual tcg backend support.  When the feature is disabled, we will
be adding and subtracting a 0 stored in a global variable.

Fourth, I have renamed the command-line parameter to "split-rwx".
I don't think this is perfect, and I'm not even sure if it's better
than "mirror-jit".  What this has done, though, is left the code
with inconsistant language -- "mirror" in some places, "split" in
others.  I'll clean that up once we know decide on naming.

Fifth, I have auto-enabled the feature for CONFIG_DEBUG_TCG, so that
it will fall-back to disabled without error.  But if you try to enable
it from the command-line without complete host support a fatal error
will be generated.  But this will make sure that the feature is
regularly tested.


r~


Richard Henderson (19):
  tcg: Enhance flush_icache_range with separate data pointer
  tcg: Move tcg prologue pointer out of TCGContext
  tcg: Move tcg epilogue pointer out of TCGContext
  tcg: Introduce tcg_mirror_rw_to_rx/tcg_mirror_rx_to_rw
  tcg: Adjust tcg_out_call for const
  tcg: Adjust tcg_out_label for const
  tcg: Adjust tcg_register_jit for const
  tcg: Adjust tb_target_set_jmp_target for split rwx
  tcg: Make DisasContextBase.tb const
  tcg: Make tb arg to synchronize_from_tb const
  tcg: Use Error with alloc_code_gen_buffer
  tcg: Add --accel tcg,split-rwx property
  accel/tcg: Support split-rwx for linux with memfd
  RFC: accel/tcg: Support split-rwx for darwin/iOS with vm_remap
  tcg: Return the rx mirror of TranslationBlock from exit_tb
  tcg/i386: Support split-rwx code generation
  tcg/aarch64: Use B not BL for tcg_out_goto_long
  tcg/aarch64: Implement flush_idcache_range manually
  tcg/aarch64: Support split-rwx code generation

 accel/tcg/tcg-runtime.h      |   2 +-
 include/disas/disas.h        |   2 +-
 include/exec/exec-all.h      |   2 +-
 include/exec/gen-icount.h    |   4 +-
 include/exec/log.h           |   2 +-
 include/exec/translator.h    |   2 +-
 include/hw/core/cpu.h        |   3 +-
 include/sysemu/tcg.h         |   2 +-
 include/tcg/tcg-op.h         |   2 +-
 include/tcg/tcg.h            |  37 +++--
 tcg/aarch64/tcg-target.h     |   9 +-
 tcg/arm/tcg-target.h         |  11 +-
 tcg/i386/tcg-target.h        |  10 +-
 tcg/mips/tcg-target.h        |  11 +-
 tcg/ppc/tcg-target.h         |   5 +-
 tcg/riscv/tcg-target.h       |  11 +-
 tcg/s390/tcg-target.h        |  12 +-
 tcg/sparc/tcg-target.h       |  11 +-
 tcg/tci/tcg-target.h         |  12 +-
 accel/tcg/cpu-exec.c         |  41 +++---
 accel/tcg/tcg-all.c          |  26 +++-
 accel/tcg/tcg-runtime.c      |   4 +-
 accel/tcg/translate-all.c    | 255 ++++++++++++++++++++++++++++-------
 accel/tcg/translator.c       |   4 +-
 bsd-user/main.c              |   2 +-
 disas.c                      |   4 +-
 linux-user/main.c            |   2 +-
 softmmu/physmem.c            |   9 +-
 target/arm/cpu.c             |   3 +-
 target/arm/translate-a64.c   |   2 +-
 target/avr/cpu.c             |   3 +-
 target/hppa/cpu.c            |   3 +-
 target/i386/cpu.c            |   3 +-
 target/microblaze/cpu.c      |   3 +-
 target/mips/cpu.c            |   3 +-
 target/riscv/cpu.c           |   3 +-
 target/rx/cpu.c              |   3 +-
 target/sh4/cpu.c             |   3 +-
 target/sparc/cpu.c           |   3 +-
 target/tricore/cpu.c         |   2 +-
 tcg/tcg-op.c                 |  15 ++-
 tcg/tcg.c                    |  85 +++++++++---
 tcg/tci.c                    |   4 +-
 accel/tcg/trace-events       |   2 +-
 tcg/aarch64/tcg-target.c.inc | 130 +++++++++++++-----
 tcg/arm/tcg-target.c.inc     |   6 +-
 tcg/i386/tcg-target.c.inc    |  38 +++---
 tcg/mips/tcg-target.c.inc    |  18 +--
 tcg/ppc/tcg-target.c.inc     |  45 ++++---
 tcg/riscv/tcg-target.c.inc   |  12 +-
 tcg/s390/tcg-target.c.inc    |   8 +-
 tcg/sparc/tcg-target.c.inc   |  22 +--
 tcg/tcg-pool.c.inc           |   6 +-
 tcg/tci/tcg-target.c.inc     |   2 +-
 54 files changed, 655 insertions(+), 269 deletions(-)

-- 
2.25.1


