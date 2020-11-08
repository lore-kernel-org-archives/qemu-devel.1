Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A08C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 03:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C3E20760
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 03:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C3E20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbbZ8-00015m-01
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 22:40:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kbbXZ-0000F4-Rh
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 22:38:53 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:36884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kbbXY-0001DA-0p
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 22:38:53 -0500
Received: by mail-il1-f196.google.com with SMTP id y17so5177567ilg.4
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 19:38:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4ARqr2IB0/g1PM4D5Ue1W3hToT8sspDHLR0vTL+bpLI=;
 b=gccm+uqoDBBapQkHqp2g5qgROU54wkMfDTQd+yvhRiRerDusptGbXY6EtPXOz9jw4m
 i2GSa6/Q+sk6+wXbXmbicFob4j7El5DyxaGJrtbFpjfKjK9JuCu9u0mgJjBjgQn/sBDN
 k8+1LL4os7uLBU+/dXSHsnF5ITdvzaY/InYUY+zWxIzZ3rprN/ZFL2zOWipprr5Nw7sS
 GrAE7iG8RYorbyMtvw592RZMJT9ObnrnqjMDsYg+Z7pkHwGexQoZu3xq9Jof/tam4xfz
 kcTeEtJlfbyxH4FDoCMVabr5Q7st93/Yf5Y7zgtJrFMxv3IEsQYkNioHkBTTjwORHMnN
 jS1g==
X-Gm-Message-State: AOAM530w6rCTBM3T0mPb3t9kX3NUKdPGZsgK4kkOx1T/F4tl4k2jjsh+
 VOA7ai9mcxiZgbRB4egQYGfO9qMWnY0=
X-Google-Smtp-Source: ABdhPJxaOYNYElJAL4IadqbKChHqtXUfW64cjMk/p6wJ7cCrzxSKIVE9FgR/S5RNjRo1KFWhiw96Lg==
X-Received: by 2002:a92:4442:: with SMTP id a2mr5849718ilm.220.1604806730759; 
 Sat, 07 Nov 2020 19:38:50 -0800 (PST)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com.
 [209.85.166.48])
 by smtp.gmail.com with ESMTPSA id b15sm2760272ilg.83.2020.11.07.19.38.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Nov 2020 19:38:50 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id s24so6315356ioj.13
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 19:38:50 -0800 (PST)
X-Received: by 2002:a6b:b24b:: with SMTP id b72mr6222202iof.32.1604806730447; 
 Sat, 07 Nov 2020 19:38:50 -0800 (PST)
MIME-Version: 1.0
References: <20201106032921.600200-1-richard.henderson@linaro.org>
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
From: Joelle van Dyne <j@getutm.app>
Date: Sat, 7 Nov 2020 19:38:39 -0800
X-Gmail-Original-Message-ID: <CA+E+eSAXpPj0v2jfnUDAaUD1ZOot8us91jq0wStYG-Sw8j5+aw@mail.gmail.com>
Message-ID: <CA+E+eSAXpPj0v2jfnUDAaUD1ZOot8us91jq0wStYG-Sw8j5+aw@mail.gmail.com>
Subject: Re: [PATCH v3 00/41] Mirror map JIT memory for TCG
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.196; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 22:38:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

LGTM, tested and working on iOS.

-j

On Thu, Nov 5, 2020 at 7:29 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is my take on Joelle's patch set:
> https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg07837.html
>
> Changes for v3:
>   * Even more patches -- all tcg backends converted.
>   * Fixups for darwin/ios merged (Joelle).
>   * Feature renamed to splitwx (Paolo).
>
>
> r~
>
>
> Richard Henderson (41):
>   tcg: Enhance flush_icache_range with separate data pointer
>   tcg: Move tcg prologue pointer out of TCGContext
>   tcg: Move tcg epilogue pointer out of TCGContext
>   tcg: Add in_code_gen_buffer
>   tcg: Introduce tcg_splitwx_to_{rx,rw}
>   tcg: Adjust TCGLabel for const
>   tcg: Adjust tcg_out_call for const
>   tcg: Adjust tcg_out_label for const
>   tcg: Adjust tcg_register_jit for const
>   tcg: Adjust tb_target_set_jmp_target for split-wx
>   tcg: Make DisasContextBase.tb const
>   tcg: Make tb arg to synchronize_from_tb const
>   tcg: Use Error with alloc_code_gen_buffer
>   tcg: Add --accel tcg,split-wx property
>   accel/tcg: Support split-wx for linux with memfd
>   accel/tcg: Support split-wx for darwin/iOS with vm_remap
>   tcg: Return the TB pointer from the rx region from exit_tb
>   tcg/i386: Support split-wx code generation
>   tcg/aarch64: Use B not BL for tcg_out_goto_long
>   tcg/aarch64: Implement flush_idcache_range manually
>   tcg/aarch64: Support split-wx code generation
>   disas: Push const down through host disasassembly
>   tcg/tci: Push const down through bytecode reading
>   tcg: Introduce tcg_tbrel_diff
>   tcg/ppc: Use tcg_tbrel_diff
>   tcg/ppc: Use tcg_out_mem_long to reset TCG_REG_TB
>   tcg/ppc: Support split-wx code generation
>   tcg/sparc: Use tcg_tbrel_diff
>   tcg/sparc: Support split-wx code generation
>   tcg/s390: Use tcg_tbrel_diff
>   tcg/s390: Support split-wx code generation
>   tcg/riscv: Fix branch range checks
>   tcg/riscv: Remove branch-over-branch fallback
>   tcg/riscv: Support split-wx code generation
>   accel/tcg: Add mips support to alloc_code_gen_buffer_splitwx_memfd
>   tcg/mips: Do not assert on relocation overflow
>   tcg/mips: Support split-wx code generation
>   tcg/arm: Support split-wx code generation
>   tcg: Remove TCG_TARGET_SUPPORT_MIRROR
>   tcg: Constify tcg_code_gen_epilogue
>   tcg: Constify TCGLabelQemuLdst.raddr
>
>  accel/tcg/tcg-runtime.h      |   2 +-
>  include/disas/dis-asm.h      |   4 +-
>  include/disas/disas.h        |   2 +-
>  include/exec/exec-all.h      |   2 +-
>  include/exec/gen-icount.h    |   4 +-
>  include/exec/log.h           |   2 +-
>  include/exec/translator.h    |   2 +-
>  include/hw/core/cpu.h        |   3 +-
>  include/sysemu/tcg.h         |   3 +-
>  include/tcg/tcg-op.h         |   2 +-
>  include/tcg/tcg.h            |  56 +++++--
>  tcg/aarch64/tcg-target.h     |   8 +-
>  tcg/arm/tcg-target.h         |  10 +-
>  tcg/i386/tcg-target.h        |   9 +-
>  tcg/mips/tcg-target.h        |  10 +-
>  tcg/ppc/tcg-target.h         |   4 +-
>  tcg/riscv/tcg-target.h       |  10 +-
>  tcg/s390/tcg-target.h        |  11 +-
>  tcg/sparc/tcg-target.h       |  10 +-
>  tcg/tci/tcg-target.h         |  11 +-
>  accel/tcg/cpu-exec.c         |  41 +++--
>  accel/tcg/tcg-all.c          |  26 ++-
>  accel/tcg/tcg-runtime.c      |   4 +-
>  accel/tcg/translate-all.c    | 307 +++++++++++++++++++++++++++--------
>  accel/tcg/translator.c       |   4 +-
>  bsd-user/main.c              |   2 +-
>  disas.c                      |   2 +-
>  disas/capstone.c             |   2 +-
>  linux-user/main.c            |   2 +-
>  softmmu/physmem.c            |   9 +-
>  target/arm/cpu.c             |   3 +-
>  target/arm/translate-a64.c   |   2 +-
>  target/avr/cpu.c             |   3 +-
>  target/hppa/cpu.c            |   3 +-
>  target/i386/cpu.c            |   3 +-
>  target/microblaze/cpu.c      |   3 +-
>  target/mips/cpu.c            |   3 +-
>  target/riscv/cpu.c           |   3 +-
>  target/rx/cpu.c              |   3 +-
>  target/sh4/cpu.c             |   3 +-
>  target/sparc/cpu.c           |   3 +-
>  target/tricore/cpu.c         |   2 +-
>  tcg/tcg-op.c                 |  15 +-
>  tcg/tcg.c                    |  86 ++++++++--
>  tcg/tci.c                    |  60 ++++---
>  accel/tcg/trace-events       |   2 +-
>  tcg/aarch64/tcg-target.c.inc | 139 ++++++++++++----
>  tcg/arm/tcg-target.c.inc     |  41 ++---
>  tcg/i386/tcg-target.c.inc    |  36 ++--
>  tcg/mips/tcg-target.c.inc    |  97 +++++------
>  tcg/ppc/tcg-target.c.inc     | 105 ++++++------
>  tcg/riscv/tcg-target.c.inc   | 125 +++++---------
>  tcg/s390/tcg-target.c.inc    |  91 +++++------
>  tcg/sparc/tcg-target.c.inc   |  58 +++----
>  tcg/tcg-ldst.c.inc           |   2 +-
>  tcg/tcg-pool.c.inc           |   6 +-
>  tcg/tci/tcg-target.c.inc     |   2 +-
>  57 files changed, 917 insertions(+), 546 deletions(-)
>
> --
> 2.25.1
>

