Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5F6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F4121835
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzJZkbsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F4121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv97u-0000dG-C5
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 20:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jv96A-0005ql-9D
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:47:06 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:45298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jv968-0000TP-FR
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:47:05 -0400
Received: by mail-il1-x144.google.com with SMTP id o3so12820925ilo.12
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 17:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H+hudOttfDclAnxM2JLa3xf5XAEG1u+Ej4AzrhEiGxc=;
 b=gzJZkbscQ0thti5SuRZsOGl6rsKx0bwCiVzkBnyec5G9QFxCjkfNtE6+fhxV4USwBS
 BWENthY/LAfi5ZWlZlfP4+Wt2zC7JeEMFPkMWghIF1Nkvp3IzsoCd+88+s1PSBdh8h6l
 fIAxdVF03gjFNYKzrg3WygzSd/C3+4MXC95KcnQq8K89PpXqXKZBYu/9yOroXXOpw4NR
 iSGsttVBCMUWp77N/liJmDFwR+IGXLMVfg9MhpcPLK1VTXJ0Yd3FdAxEozTZEaX1epCC
 rJOjr/SeDWf3APJqhg0U9iq4VDHeBFndmYLjWeqJm/tl5Oq0P6j1cWNoGZuWPJDQDKN1
 b09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H+hudOttfDclAnxM2JLa3xf5XAEG1u+Ej4AzrhEiGxc=;
 b=LukjA23xs+0Q46XwJdSt/L7TwNM20yVelKZHVMBYPhSaTFDLt8d8VsdjlYXMzz5I5H
 Hx6IrGPaZ2+HJHHmP0jgHr4C72M0ru8Oj3J/4kFveW8rmNfE/g270Iqx6k9/jcRewvBf
 KUgnu0dN4I4WWxAsB6zzn5UH1MohVYgPYVtiC211iR6y82QU4fqviQ6TnbmsrsW1l8Bv
 zBwRKUnyTt0AWUQCU6wb3/Cv83eZ09kChbgf6nLk/6FrPiubXsv7J9Zka8QL3VtdmgnO
 AzfcQW9Hje2mSFnmxAqp7ssI7Zpb16jB0lvOI4VOs5NuaGNl4D6yDLfEfbZFXySgafWr
 4Z4w==
X-Gm-Message-State: AOAM533BqkBENovb+XLW916eswzbrJsP2uOSYkZAqnw+WK6m8dqYW98G
 zYJH7Z2BpgsOd9xCIhanPlcjnBgieZoSbMDSTCMh38Op
X-Google-Smtp-Source: ABdhPJwcnMc3s2JUw7Altr4V0MRl2TkuEJzcumfVaSvrGHTAQgJXBMQl4Vh35ZRYXWYwydhKiKBlAhNesr1tSXGqlFg=
X-Received: by 2002:a92:c213:: with SMTP id j19mr2570473ilo.40.1594687623217; 
 Mon, 13 Jul 2020 17:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200714003254.4044149-1-alistair.francis@wdc.com>
In-Reply-To: <20200714003254.4044149-1-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Jul 2020 17:37:04 -0700
Message-ID: <CAKmqyKP+bRqky7YB6Gv-1uybvZfGnH2sRh0g_9mLoh=1+03GcA@mail.gmail.com>
Subject: Re: [PULL 00/15] riscv-to-apply queue
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 5:43 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> The following changes since commit 20c1df5476e1e9b5d3f5b94f9f3ce01d21f14c46:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200713-pull-request' into staging (2020-07-13 16:58:44 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200713
>
> for you to fetch changes up to cfad709bceb629a4ebeb5d8a3acd1871b9a6436b:
>
>   target/riscv: Fix pmp NA4 implementation (2020-07-13 17:25:37 -0700)

Sorry these are a little late, I was hoping to send them out last week
but I was chasing down some bugs and waiting on a few patches.

Alistair

>
> ----------------------------------------------------------------
> This is a colection of bug fixes and small imrprovements for RISC-V.
>
> This includes some vector extensions fixes, a PMP bug fix, OpenTitan
> UART bug fix and support for OpenSBI dynamic firmware.
>
> ----------------------------------------------------------------
> Alexandre Mergnat (1):
>       target/riscv: Fix pmp NA4 implementation
>
> Alistair Francis (2):
>       hw/char: Convert the Ibex UART to use the qdev Clock model
>       hw/char: Convert the Ibex UART to use the registerfields API
>
> Atish Patra (4):
>       riscv: Unify Qemu's reset vector code path
>       RISC-V: Copy the fdt in dram instead of ROM
>       riscv: Add opensbi firmware dynamic support
>       RISC-V: Support 64 bit start address
>
> Bin Meng (3):
>       MAINTAINERS: Add an entry for OpenSBI firmware
>       hw/riscv: virt: Sort the SoC memmap table entries
>       hw/riscv: Modify MROM size to end at 0x10000
>
> Frank Chang (4):
>       target/riscv: fix rsub gvec tcg_assert_listed_vecop assertion
>       target/riscv: correct the gvec IR called in gen_vec_rsub16_i64()
>       target/riscv: fix return value of do_opivx_widen()
>       target/riscv: fix vill bit index in vtype register
>
> Liao Pingfang (1):
>       tcg/riscv: Remove superfluous breaks
>
>  include/hw/char/ibex_uart.h             |  79 ++++++++--------
>  include/hw/riscv/boot.h                 |   7 ++
>  include/hw/riscv/boot_opensbi.h         |  58 ++++++++++++
>  target/riscv/cpu.h                      |   2 +-
>  hw/char/ibex_uart.c                     | 158 ++++++++++++++++++--------------
>  hw/riscv/boot.c                         | 107 +++++++++++++++++++++
>  hw/riscv/sifive_u.c                     |  53 ++++++-----
>  hw/riscv/spike.c                        |  59 ++++--------
>  hw/riscv/virt.c                         |  63 ++++---------
>  target/riscv/insn_trans/trans_rvv.inc.c |   9 +-
>  target/riscv/pmp.c                      |   2 +-
>  tcg/riscv/tcg-target.inc.c              |   2 -
>  MAINTAINERS                             |   7 ++
>  13 files changed, 387 insertions(+), 219 deletions(-)
>  create mode 100644 include/hw/riscv/boot_opensbi.h
>

