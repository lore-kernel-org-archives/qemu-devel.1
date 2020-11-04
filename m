Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1611EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751F620BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDqtQCie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751F620BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaBA7-0000ll-FE
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kaAp4-00046m-KW; Tue, 03 Nov 2020 23:55:02 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:44705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kaAp2-0005jA-MK; Tue, 03 Nov 2020 23:55:02 -0500
Received: by mail-il1-x141.google.com with SMTP id z2so18188604ilh.11;
 Tue, 03 Nov 2020 20:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J4efl48tawioznZ2bjfbrXOXeSNn+t0icjBdX9B6f+U=;
 b=cDqtQCiebZkY7y+G8m8tJqiHZN+7SWja/wS4spxmlfG5FRn0lZ0M7qAQ84ws+G4N1f
 QN6LT8GHG4V7AKx8hRf0k4YNOepU49dr5O9ZyqtofW2PsE1CEU0uoc5LQ6l9hhry2SMY
 VjExQeflSrcEB6My1MNCH/RxCqQOud5NnX+iR4JgK2L+nriSLJZ1LUX1UZ4tEaGVIIwj
 LnSVmbpi/UqGAqCoco2wbEiaDLrPQYNYm5c+7QLAIJ605vFUg53U8FUjTv777pSQbWuK
 nQ7f4hy46Z6tPRJgyHzyhwOTBCNyg4pdqITwVUQnnNA21VKye8HixG6z9l7cETDxtoQ7
 0Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J4efl48tawioznZ2bjfbrXOXeSNn+t0icjBdX9B6f+U=;
 b=uVL7yD2OXZsasA7gHZAhnl3HiI4xa5Sh0QuXs4ecrnF3oUDeUJW9kMc0jD88G06qzw
 VlUoln+DLmp/xFn7USavmCubjzCh4KjUOiqVXqT7R/XOw6MNaDuiKPYz95HlyqBYvQP8
 hbVed3rC87bl7vA8zl1+j4L0aYSA0r8YkehE68gSdDBSzbD/LMsLGTo1xFcPv8iygrQX
 /GT7zSUhqzLFpfvQTjEQCm2CJU4C/OJG75jWnsa2AMlPVQtdcD4bEdQyATHcHiQ9U3HP
 OER7MiRLPr+BjVrCMVm9vMibRFL+slxMLJaTsF0eixoLCiX+3oajnalLY3C35aHnQKMI
 /Jjg==
X-Gm-Message-State: AOAM532cDJmrUnEOxqh7rGobIbycu2vhcG1CebgvTPz/dWBrAmm1v1Do
 PXokrYm51UZYlU0xJbF6wHW+hFiTwdhmMrEbOmk=
X-Google-Smtp-Source: ABdhPJyKwrnd+1hYzDRH/bDVmNKpJHO6MC7KXGBfAL9bySApLa6YbIXRlb+/0xKcv8cwWqe4x94zWH3kzT4WgMjbjxA=
X-Received: by 2002:a92:d991:: with SMTP id r17mr15433131iln.227.1604465695987; 
 Tue, 03 Nov 2020 20:54:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604432950.git.alistair.francis@wdc.com>
 <5f25069661040bb96f945358bd7fa047f5b462ce.1604432950.git.alistair.francis@wdc.com>
 <29320e1d-6abf-a6bb-fc6e-43a3b17fca36@linaro.org>
In-Reply-To: <29320e1d-6abf-a6bb-fc6e-43a3b17fca36@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Nov 2020 20:42:59 -0800
Message-ID: <CAKmqyKNmXR3bvf-Dvx6mfbxymwqppBEzPkAsY7A4utuEXE-t=w@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] target/riscv: Add a virtualised MMU Mode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 3, 2020 at 12:20 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/3/20 11:50 AM, Alistair Francis wrote:
> > @@ -30,6 +30,10 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
> >  #ifdef CONFIG_USER_ONLY
> >      return 0;
> >  #else
> > +    if (riscv_cpu_virt_enabled(env)) {
> > +        return env->priv | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
> > +    }
>
> Still setting this bit here, incorrectly.

Argh! I must have dreamed fixing it. Sending a new version now.

Alistair

>
>
> r~

