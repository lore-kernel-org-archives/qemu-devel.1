Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2A8C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1463A22CF8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6vZPyQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1463A22CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i35en-0006uQ-9K
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 17:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i35e2-0006OH-Bj
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i35e1-00025v-5B
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:38:22 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:37327)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i35e0-00025P-SS; Wed, 28 Aug 2019 17:38:21 -0400
Received: by mail-lj1-x244.google.com with SMTP id t14so998136lji.4;
 Wed, 28 Aug 2019 14:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X5wk+8gVakk2QaHZrElhQHkVAKujHeUPl9eJtj2HmYM=;
 b=O6vZPyQDkZDP8nKlBGDwDcsSUz3xGmVSaBbGWvIvANtnOQBVbbldKaqaQt/38tJ50u
 Pvdhlq00zUvDfo24a4QEzA9r3SJJpPMlsrgerQZMxj0HOATrEJ2zNq9YmcoIWCL4dEID
 t/WUKDBsLXflqkkqm4fZPAv+H2pAIUYzIcGpU0tILetKUjBUL7B0H6TtU9LJLTY7lMLr
 7Cr28NpKP0J7tUvyGen1FeRSLD4tz0t6IgQl4xbJvIzf5fBkazX2g0+kvfecXiJPayim
 TNjywpUK2sae6xImiwWOpkQjYCp68dOqSOZNm86yc9T88nQ9z1ky+9nYOVXzBTv6/OgM
 d9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X5wk+8gVakk2QaHZrElhQHkVAKujHeUPl9eJtj2HmYM=;
 b=ksMdBNUyuYCFxZIRlSDyqQhLXiaMbkBvrYfYb8hrAhgFsR8Idbo/kHjcJiYwk2WaQG
 F3u47Zx3E/9cseBKYNn+E4oIyfosgQB8W6ehnTS3rqQkuU/lpzSFQBza+eO8fw+TRhT5
 3RdxAgbjy7dm/ysxQRQe3+i719TFkCHm9ZSdkhwgnalpmPdJMB0dhWtCm37u2rxx/FcT
 ynU0vGYBComyFcLu9SzuwePwNf2T1eS2OQlsz2c8NTEXcqUGQPflxCbCNNPZK458ROBl
 IPPH1wGDqnRGOs0INQN7gH8zy7AkIHN39O/Nk5MMxBvRlPpi+Ffw+Zu8qZyh2NPpnD88
 RItw==
X-Gm-Message-State: APjAAAXsZxiDtxKIhgPOW+0e9848qjZRm0O9Bvjy4kdg4kNRTPIhmFVY
 NyVJHxEHOcMCFhNJDM/e3i4AyR6KR4Yn0xtxniE=
X-Google-Smtp-Source: APXvYqxL3799NS+8JcPRdfitOqMkrk2GfdoAebfMJIGyuaA1KRv3JPJGmuD9sFPCCkA/P24kixwtQuhmi3ga7CgctF0=
X-Received: by 2002:a05:651c:109:: with SMTP id
 a9mr3239364ljb.33.1567028299301; 
 Wed, 28 Aug 2019 14:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
In-Reply-To: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 28 Aug 2019 14:34:11 -0700
Message-ID: <CAKmqyKMDmaABGWyLZD2R-4J8=jM6hry6Bfmu498+UZzQtxsTMA@mail.gmail.com>
To: liuzhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH] RISCV: support riscv vector extension 0.7.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 28, 2019 at 12:04 AM liuzhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Change-Id: I3cf891bc400713b95f47ecca82b1bf773f3dcb25
> Signed-off-by: liuzhiwei <zhiwei_liu@c-sky.com>
> ---
>  fpu/softfloat.c                         |   119 +
>  include/fpu/softfloat.h                 |     4 +
>  linux-user/riscv/cpu_loop.c             |     8 +-
>  target/riscv/Makefile.objs              |     2 +-
>  target/riscv/cpu.h                      |    30 +
>  target/riscv/cpu_bits.h                 |    15 +
>  target/riscv/cpu_helper.c               |     7 +
>  target/riscv/csr.c                      |    65 +-
>  target/riscv/helper.h                   |   354 +
>  target/riscv/insn32.decode              |   374 +-
>  target/riscv/insn_trans/trans_rvv.inc.c |   484 +
>  target/riscv/translate.c                |     1 +
>  target/riscv/vector_helper.c            | 26563 ++++++++++++++++++++++++++++++
>  13 files changed, 28017 insertions(+), 9 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
>  create mode 100644 target/riscv/vector_helper.c
>

Hello,

Thanks for the patch!

As others have pointed out you will need to split the patch up into
multiple smaller patches, otherwise it is too hard to review almost
30,000 lines of code.

Can you also include a cover letter with your patch series describing
how you are testing this? AFAIK vector extension support isn't in any
compiler so I'm assuming you are handwriting the assembly or have
toolchain patches. Either way it will help if you can share that so
others can test your implementation.

Alex and Richard have kindly started the review. Once you have
addressed their comments and split this patch up into smaller patches
you can send a v2 and we can go from there.

Once again thanks for doing this implementation for QEMU!

Alistair

