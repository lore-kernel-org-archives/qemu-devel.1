Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E990EC3A5A7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15BD22CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15BD22CF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5CGP-0008Bl-ON
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 13:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1i5CAl-0001na-FM
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1i5CAj-0007gh-Kp
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:00:51 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:40802
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1i5CAj-0007fv-EK
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:00:49 -0400
Received: from host86-168-80-252.range86-168.btcentralplus.com
 ([86.168.80.252] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1i5C8h-0000Cj-1H; Tue, 03 Sep 2019 17:58:45 +0100
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190903160858.5296-1-richard.henderson@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <6b27210e-a4b3-a8be-77a1-717e26de1747@ilande.co.uk>
Date: Tue, 3 Sep 2019 17:58:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.168.80.252
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: No (on mail.default.ilande.uk0.bigv.io); Unknown failure
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/2019 17:08, Richard Henderson wrote:

> The following changes since commit fec105c2abda8567ec15230429c41429b5ee307c:
> 
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20190828-pull-request' into staging (2019-09-03 14:03:15 +0100)
> 
> are available in the Git repository at:
> 
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190903
> 
> for you to fetch changes up to c25c283df0f08582df29f1d5d7be1516b851532d:
> 
>   tcg: Factor out probe_write() logic into probe_access() (2019-09-03 08:34:18 -0700)
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
>       s390x/tcg: Use guest_addr_valid() instead of h2g_valid() in probe_write_access()
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
>  accel/tcg/cputlb.c                      | 414 ++++++++++++++++++--------------
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

Is this a pull request rather than just a queue update? I'm just wondering if I
should wait for this to get merged first before I start testing the
do_transaction_failed hook patches?


ATB,

Mark.

