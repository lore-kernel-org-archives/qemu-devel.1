Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE5AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 08:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8B9208D5
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 08:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL7rxiYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8B9208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlpWC-00078F-52
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 04:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jlpVY-0006hH-7j; Thu, 18 Jun 2020 04:02:48 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:36295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jlpVW-0004oE-Hr; Thu, 18 Jun 2020 04:02:47 -0400
Received: by mail-yb1-xb42.google.com with SMTP id h39so2674139ybj.3;
 Thu, 18 Jun 2020 01:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c9iqjcZ3HUrr6j9CFZB2S3aFqgvAuCKHw4HxWnY1pZ0=;
 b=kL7rxiYHqgCQTTzrYU5d3PHW30nBfmQo8ybzObcn2oha1HFaiALQY/fr3di+GiplyJ
 +c/dP0aj1jMbLz7+2tVkLc5pvvwS6HJwYpgZrMm4/JYDVmsWJIxInWB2wTEVYXRej1CU
 EWpzQAo+2f2FuxKcciczhF7roCcZcWwAXlRGfcbLU2bqam9Bn+WoMtwd+qUy/NYFh6z4
 cIEZyf934gg2sPLTnCx9e50JI3x3oKZE9iIuWkuzsCPcaos75HyDfgY1/tNcV4xg4G5N
 9lsALU4tBJ9hs6aTBxTxDKn5sIsHVlPGHfM4FEqYQjeGGvCc5avjt4PGVYbO/GvCxGwl
 TClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c9iqjcZ3HUrr6j9CFZB2S3aFqgvAuCKHw4HxWnY1pZ0=;
 b=P55ILnrgJEThCSmW1bH3QQHa/EXhq+xgFm3vo3E82d4YQMrR74mnzJPl/zJlGIJXTX
 H/5UT8cTKFzPE0ydjgI1IkINrjv8cNGrKIweUuRN5KPyvJmi46KJ3WZE96TLDcVHrUul
 wk+hEK0oLamaZn7jIWxP74ddTQfz3TyPqzuttVIzQXi48Awyk2htHXxYXSkyYGRQS/Wu
 QwPwLPY9lirBoy/SM5Lg5q9meY/oLVgv2aEAGdiGuU0BJJsoijcfAupXrUE1vhPWVpMf
 CtHs/p2rorJHLQFWRD0AVoxvlWyyI6jbVCBg+glcs/7NzG5if21du+/ctvJnWVnbPE0R
 G98g==
X-Gm-Message-State: AOAM531Pk54MeubqJBDZVqHvQ2dqf7Q7cJb4bjPHsB3M1XlHE1d9BLc6
 wT91yTHeWEj0By5q7FtrdNwM6V/BtfixUE5IyGg=
X-Google-Smtp-Source: ABdhPJxl+l999DDT0fY5I9up1rKuKEGKVkchT7LRugTq08Ee7THi3r0GwfAFcbGac0GPtywOizZZUBoAYKPqdK4bxv0=
X-Received: by 2002:a25:38c5:: with SMTP id f188mr4667974yba.332.1592467365154; 
 Thu, 18 Jun 2020 01:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200616192700.1900260-1-atish.patra@wdc.com>
 <20200616192700.1900260-2-atish.patra@wdc.com>
In-Reply-To: <20200616192700.1900260-2-atish.patra@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 18 Jun 2020 16:02:33 +0800
Message-ID: <CAEUhbmV6jtFZuC=OeYn6GWijf-Q9Zzbj=YG6EDBTZoJy0QTC4g@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: Unify Qemu's reset vector code path
To: Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 3:30 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Currently, all riscv machines have identical reset vector code
> implementations with memory addresses being different for all machines.
> They can be easily combined into a single function in common code.
>
> Move it to common function and let all the machines use the common function.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  hw/riscv/boot.c         | 46 +++++++++++++++++++++++++++++++++++++++++
>  hw/riscv/sifive_u.c     | 38 +++-------------------------------

sifive_u's reset vector has to be different to emulate the real
hardware MSEL pin state.
Please rebase this on top of the following series:
http://patchwork.ozlabs.org/project/qemu-devel/list/?series=183567

>  hw/riscv/spike.c        | 38 +++-------------------------------
>  hw/riscv/virt.c         | 37 +++------------------------------
>  include/hw/riscv/boot.h |  2 ++
>  5 files changed, 57 insertions(+), 104 deletions(-)
>

Regards,
Bin

