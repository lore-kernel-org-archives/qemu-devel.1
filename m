Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DE0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6284F22CED
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6284F22CED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5CHP-0000sp-BV
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 13:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5CGT-00009j-J5
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5CGR-0002fB-G7
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:06:45 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5CGR-0002et-AX
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:06:43 -0400
Received: by mail-yw1-f66.google.com with SMTP id k200so1829292ywa.7
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 10:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X4KRvxQ/zWMLbFnPV8JYXiE1ckTI08fRyRRG0+y7IEA=;
 b=jRs93c/rWCuO7lFYdAgfEi5+iguk7WKd8Uc4lisn17gRgUo07O/5TDMmGcUbhnAonY
 Mg0VNnaoTAAJzAFpt4/uJMVyuM0Y/FAbcVItykBe52+zsEXi2Oa+g1mcFakf1DmIK7a8
 ux0ztmxPoSVrytusUs93mKwJsH5eygGDXzHH5SPywOQZ021tViIagV0vkONCCR1b3EQS
 GS5fWnRlmU+a9XPyadhEsnTjn42Q95v9wUG0zN9CxYKKYDEUjRKzHB92kO8OZww7Hfjn
 +6t47kuvXWo1LKNzau8lfx3P1S5svZItvogIpJRdsol6KXtEuC0hagkmVqHeUhZ7v8t4
 8IrQ==
X-Gm-Message-State: APjAAAXRvP/1ajnGlXyovkBJI5ypPbaEVJ2DPoOa7WiWNCInWok7Yxpk
 PdSN++niG62zygfs8h+XhW7vRgy+FVLK+BbMiu8=
X-Google-Smtp-Source: APXvYqw5A8TVtZDbg5nJXPsfhqKRrq8xqU7BLc0C0ndLiKW9rbz0Ot1RS7axVPT9iEeshMfbTYD3JS/uhUp5zHjNr6s=
X-Received: by 2002:a0d:c401:: with SMTP id g1mr24896498ywd.37.1567530402537; 
 Tue, 03 Sep 2019 10:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190903160858.5296-1-richard.henderson@linaro.org>
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 3 Sep 2019 19:06:29 +0200
Message-ID: <CAAdtpL53wBZ14Af8CROW4eabsxDwJjRAiiSijFnKROC+9aHR4Q@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.66
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 00/36] tcg patch queue
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"PATCH" -> "PULL" in subject :)
I wonder if Peter's script works too, I guess it does.

Le mar. 3 sept. 2019 18:37, Richard Henderson <richard.henderson@linaro.org=
>
a =C3=A9crit :

> The following changes since commit
> fec105c2abda8567ec15230429c41429b5ee307c:
>
>   Merge remote-tracking branch
> 'remotes/kraxel/tags/audio-20190828-pull-request' into staging (2019-09-0=
3
> 14:03:15 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190903
>
> for you to fetch changes up to c25c283df0f08582df29f1d5d7be1516b851532d:
>
>   tcg: Factor out probe_write() logic into probe_access() (2019-09-03
> 08:34:18 -0700)
>
> ----------------------------------------------------------------
> Allow page table bit to swap endianness.
> Reorganize watchpoints out of i/o path.
> Return host address from probe_write / probe_access.
>
> ----------------------------------------------------------------
> David Hildenbrand (11):
>       exec: Factor out core logic of check_watchpoint()
>       tcg: Check for watchpoints in probe_write()
>       s390x/tcg: Use guest_addr_valid() instead of h2g_valid() in
> probe_write_access()
>       s390x/tcg: Fix length calculation in probe_write_access()
>       tcg: Factor out CONFIG_USER_ONLY probe_write() from s390x code
>       tcg: Enforce single page access in probe_write()
>       mips/tcg: Call probe_write() for CONFIG_USER_ONLY as well
>       hppa/tcg: Call probe_write() also for CONFIG_USER_ONLY
>       s390x/tcg: Pass a size to probe_write() in do_csst()
>       tcg: Make probe_write() return a pointer to the host page
>       tcg: Factor out probe_write() logic into probe_access()
>
> Richard Henderson (6):
>       exec: Move user-only watchpoint stubs inline
>       cputlb: Fold TLB_RECHECK into TLB_INVALID_MASK
>       exec: Factor out cpu_watchpoint_address_matches
>       cputlb: Fix size operand for tlb_fill on unaligned store
>       cputlb: Remove double-alignment in store_helper
>       cputlb: Handle watchpoints via TLB_WATCHPOINT
>
> Tony Nguyen (19):
>       tcg: TCGMemOp is now accelerator independent MemOp
>       memory: Introduce size_memop
>       target/mips: Access MemoryRegion with MemOp
>       hw/s390x: Access MemoryRegion with MemOp
>       hw/intc/armv7m_nic: Access MemoryRegion with MemOp
>       hw/virtio: Access MemoryRegion with MemOp
>       hw/vfio: Access MemoryRegion with MemOp
>       exec: Access MemoryRegion with MemOp
>       cputlb: Access MemoryRegion with MemOp
>       memory: Access MemoryRegion with MemOp
>       hw/s390x: Hard code size with MO_{8|16|32|64}
>       target/mips: Hard code size with MO_{8|16|32|64}
>       exec: Hard code size with MO_{8|16|32|64}
>       memory: Access MemoryRegion with endianness
>       cputlb: Replace size and endian operands for MemOp
>       memory: Single byte swap along the I/O path
>       cputlb: Byte swap memory transaction attribute
>       target/sparc: Add TLB entry with attributes
>       target/sparc: sun4u Invert Endian TTE bit
>
>  include/exec/cpu-all.h                  |   8 +-
>  include/exec/exec-all.h                 |  10 +-
>  include/exec/memattrs.h                 |   2 +
>  include/exec/memop.h                    | 134 +++++++++++
>  include/exec/memory.h                   |  12 +-
>  include/hw/core/cpu.h                   |  37 +++
>  target/arm/translate-a64.h              |   2 +-
>  target/arm/translate.h                  |   2 +-
>  target/sparc/cpu.h                      |   2 +
>  tcg/tcg-op.h                            |  80 +++---
>  tcg/tcg.h                               | 101 +-------
>  trace/mem-internal.h                    |   4 +-
>  trace/mem.h                             |   4 +-
>  accel/tcg/cputlb.c                      | 414
> ++++++++++++++++++--------------
>  accel/tcg/user-exec.c                   |  32 +++
>  exec.c                                  | 177 +++-----------
>  hw/intc/armv7m_nvic.c                   |  13 +-
>  hw/s390x/s390-pci-inst.c                |  11 +-
>  hw/vfio/pci-quirks.c                    |   7 +-
>  hw/virtio/virtio-pci.c                  |  15 +-
>  memory.c                                |  58 +++--
>  memory_ldst.inc.c                       |  81 ++-----
>  target/alpha/translate.c                |   2 +-
>  target/arm/translate-a64.c              |  48 ++--
>  target/arm/translate-sve.c              |   2 +-
>  target/arm/translate.c                  |  32 +--
>  target/hppa/op_helper.c                 |   2 -
>  target/hppa/translate.c                 |  14 +-
>  target/i386/translate.c                 | 132 +++++-----
>  target/m68k/translate.c                 |   2 +-
>  target/microblaze/translate.c           |   4 +-
>  target/mips/op_helper.c                 |  13 +-
>  target/mips/translate.c                 |   8 +-
>  target/openrisc/translate.c             |   4 +-
>  target/ppc/translate.c                  |  12 +-
>  target/riscv/insn_trans/trans_rva.inc.c |   8 +-
>  target/riscv/insn_trans/trans_rvi.inc.c |   4 +-
>  target/s390x/mem_helper.c               |  13 +-
>  target/s390x/translate.c                |   6 +-
>  target/s390x/translate_vx.inc.c         |  10 +-
>  target/sparc/mmu_helper.c               |  40 +--
>  target/sparc/translate.c                |  14 +-
>  target/tilegx/translate.c               |  10 +-
>  target/tricore/translate.c              |   8 +-
>  tcg/aarch64/tcg-target.inc.c            |  26 +-
>  tcg/arm/tcg-target.inc.c                |  26 +-
>  tcg/i386/tcg-target.inc.c               |  24 +-
>  tcg/mips/tcg-target.inc.c               |  16 +-
>  tcg/optimize.c                          |   2 +-
>  tcg/ppc/tcg-target.inc.c                |  12 +-
>  tcg/riscv/tcg-target.inc.c              |  20 +-
>  tcg/s390/tcg-target.inc.c               |  14 +-
>  tcg/sparc/tcg-target.inc.c              |   6 +-
>  tcg/tcg-op.c                            |  38 +--
>  tcg/tcg.c                               |   2 +-
>  MAINTAINERS                             |   1 +
>  tcg/README                              |   2 +-
>  57 files changed, 918 insertions(+), 865 deletions(-)
>  create mode 100644 include/exec/memop.h
>
>
