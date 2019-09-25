Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AC4C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E68321D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CX5LTRes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E68321D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD60r-00026I-Je
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 08:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoren@kernel.org>) id 1iD5yW-0000a0-Ad
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoren@kernel.org>) id 1iD5yP-0002Lm-O9
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36186)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoren@kernel.org>)
 id 1iD5yP-0002LP-IY; Wed, 25 Sep 2019 08:00:45 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2BC3A21D80;
 Wed, 25 Sep 2019 12:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569412844;
 bh=CrIPP8jWVqmUE9qIbPtDWntJH0XmvvmNn57dcDhpEZA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CX5LTResy9SpIpIKNbVuQpcdQN+VwbaYc12e0R/LjRsMU/QXYou5HXf17VT8vASua
 tiwd45dvIZTr/LCXAr0341hkPoPmACnI1isDxJHrEIXNasv/Vv14iXSDKoYEUTntyZ
 XAxIhpeVLg0G1l+ljNH943aCG4TohhzBM75JRkPE=
Received: by mail-wr1-f48.google.com with SMTP id i18so6530587wru.11;
 Wed, 25 Sep 2019 05:00:44 -0700 (PDT)
X-Gm-Message-State: APjAAAXiPxqV5m/5MOK6wi2NrA1M6VzO9BAIWa1InK7vNMMAPICBfhIp
 fqYQvX/kZrkzRh3MtD6fCGbyLAORqijp4uw8av4=
X-Google-Smtp-Source: APXvYqxpUkiSFYYOrUEaYziySpYtC9UhtN20JKo6kOfGss/vLwuCcIU2rRR0Sb68xTGewKgh2st4tYrajgdgYwp/BuU=
X-Received: by 2002:adf:fac3:: with SMTP id a3mr8515979wrs.24.1569412842670;
 Wed, 25 Sep 2019 05:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <1569403262-23523-1-git-send-email-guoren@kernel.org>
 <CAEUhbmUb=KOBje_X_hnmHz9LFDLyE+eb7iJhGkns2WMAsBRCpQ@mail.gmail.com>
In-Reply-To: <CAEUhbmUb=KOBje_X_hnmHz9LFDLyE+eb7iJhGkns2WMAsBRCpQ@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 25 Sep 2019 20:00:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT3LdxR=oY5zEbAVMgGLVKRY6F=W7WBu4pA0TmWBtv=oA@mail.gmail.com>
Message-ID: <CAJF2gTT3LdxR=oY5zEbAVMgGLVKRY6F=W7WBu4pA0TmWBtv=oA@mail.gmail.com>
Subject: Re: [PATCH V4] target/riscv: Ignore reserved bits in PTE for RV64
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 198.145.29.99
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Guo Ren <ren_guo@c-sky.com>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thx

On Wed, Sep 25, 2019 at 5:58 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Wed, Sep 25, 2019 at 5:21 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so we
> > need to ignore them. They cannot be a part of ppn.
> >
> > 1: The RISC-V Instruction Set Manual, Volume II: Privileged Architecture
> >    4.4 Sv39: Page-Based 39-bit Virtual-Memory System
> >    4.5 Sv48: Page-Based 48-bit Virtual-Memory System
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Reviewed-by: Liu Zhiwei <zhiwei_liu@c-sky.com>
> > ---
> >  target/riscv/cpu_bits.h   | 7 +++++++
> >  target/riscv/cpu_helper.c | 2 +-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > Changelog V4:
> >  - Change title to Ignore not Bugfix
> >  - Use PTE_PPN_MASK for RV32 and RV64
> >
> > Changelog V3:
> >  - Use UUL define for PTE_RESERVED
> >  - Keep ppn >> PTE_PPN_SHIFT
> >
> > Changelog V2:
> >  - Bugfix pte destroyed cause boot fail
> >  - Change to AND with a mask instead of shifting both directions
> >
>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> Tested-by: Bin Meng <bmeng.cn@gmail.com>



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

