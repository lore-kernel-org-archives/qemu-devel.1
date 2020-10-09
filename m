Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA8FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05A82226B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRaLNvCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05A82226B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpGM-00064L-D8
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kQpFP-0005MF-JX; Fri, 09 Oct 2020 06:03:35 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:44744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kQpFN-00084P-Td; Fri, 09 Oct 2020 06:03:35 -0400
Received: by mail-yb1-xb42.google.com with SMTP id h6so6801296ybi.11;
 Fri, 09 Oct 2020 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xgIVgcSvNiq9ko2zl0VAm8q6i/rdbH6kO6NGC+2Rj0Q=;
 b=BRaLNvCd7ycZEZO0nC5jCKb6A5IokQZCtQn34B5JKR1/djOVB8xlqXLufvb1ucCJWO
 ls5lJ1RV9QG4FCrszYf3GQh0b8X11hu/y8TeN472nfD8OQ0nnRhbjYwr8JlU5KRIe7PN
 BlUd+n5eYFaGNaP3R3xuOia60R5Hs8QtMdKDsW40Rhok/WIcSG+weWOLrdrNX0T0gZDG
 n9DajwUVnfoFFzC6M9kEL2w1khs3h1rGh8ztZwlVol21jz5zvgqzw1ivUMtoAO6Fekd7
 GsZjhhtc1Lnb8xT7f0szGbcvibzTY1+U4qQniBPOg341DdO+KHt214YhlBvFz9RTekiv
 JiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xgIVgcSvNiq9ko2zl0VAm8q6i/rdbH6kO6NGC+2Rj0Q=;
 b=YnEP3qH461S5+2O9j3PPaCphIvITMl+RkMuqmxHM1/9cCp58wlUAI415WB0w3iD6rn
 ojx9X3Io5bMvjGWXoUgzccxrUEa6GALTKjxBjYhVnrymFIUR3PQIeMsHlZb3+EXGCgOG
 WMD5NolrB7gydh75DSX5339hSC/OuSRTQyhM3pXf0+iCASASLIR5evK9rw+HnD0MC1x+
 vH/yc1wxW9P118c3sGrZG1tWdIMryxosunhIAUhAoeXXKWqV6Ixj1TfXk/nyZCzfTp78
 ackjFOankDznffT5SQxxIya679OfsJMJucGgv7SCfMzIai8K5181mnQ+Ggiorvj9AghV
 wPag==
X-Gm-Message-State: AOAM533Rgv20C+PrB0GAp8ui/DPl6d/GyAuiBjIebLuHMnqSUkOr9hUV
 v6D6AL7H1Hws4Ec2/7403cGou1cRJkoPll5rOGg=
X-Google-Smtp-Source: ABdhPJyOlqvpeHFpPZ9e9JWF82+O3wbi77D092lX71aYZT4hNz/OC3lD7YiERsBlVb3QTb3R35uGFuYH/FxXonda7fo=
X-Received: by 2002:a25:b78d:: with SMTP id n13mr16710774ybh.152.1602237812665; 
 Fri, 09 Oct 2020 03:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601652616.git.alistair.francis@wdc.com>
 <3b114129fbe4416dce88c454b03c31d8405cc141.1601652616.git.alistair.francis@wdc.com>
In-Reply-To: <3b114129fbe4416dce88c454b03c31d8405cc141.1601652616.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 9 Oct 2020 18:03:21 +0800
Message-ID: <CAEUhbmU77T5XCtj0hLbpKVqYqurPA-XQOSsy2NeCpx3BBqZm7Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] hw/riscv: sifive_u: Allow specifying the CPU
To: Alistair Francis <alistair.francis@wdc.com>
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 2, 2020 at 11:52 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Allow the user to specify the main application CPU for the sifive_u
> machine.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  include/hw/riscv/sifive_u.h |  1 +
>  hw/riscv/sifive_u.c         | 18 +++++++++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>

