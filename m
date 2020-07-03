Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2566C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 01:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0F4207E8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 01:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9M+fZsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0F4207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrASg-000603-0R
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 21:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jrAS1-0005Rp-QW; Thu, 02 Jul 2020 21:25:13 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:44862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jrAS0-00067F-1U; Thu, 02 Jul 2020 21:25:13 -0400
Received: by mail-yb1-xb43.google.com with SMTP id p204so10884734ybc.11;
 Thu, 02 Jul 2020 18:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IgVCY6njpbs+8brTd4/i59ExrVWYmfVlgdFpyCSHicQ=;
 b=m9M+fZsvJPOIt/cpWrvS1n+MREQ3nUR+r//BWfSTq1uhOhhMCjSKicFBKnGcPSF8JF
 yQwCWUbniJuB9JCp2oqcik5VrcazRoVJAZoBrVD/HFEeXQiU1GDtwn7P3jbbwfyOCh0z
 PWIIKFCXKQBT9Ly4WozN7JAD9UeDk3XLcSrQxbkFFJiNczPqbKDExKBP0joRknQe9pkd
 qxUDak9MX8NgZaUISRcrxnQhfOyvSnfNJl4h0Qi3gfdsLUm5oLimf02JExkmXYUmklzR
 qY/fZn96ruBYDBDO8wARfVlATU7fQ/TezWmHx8kp5I0qKR4qnjIMohQzGaltQyn86HDU
 sJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IgVCY6njpbs+8brTd4/i59ExrVWYmfVlgdFpyCSHicQ=;
 b=QMDpAdKUCj/tbza0NbhXdEYC8pJrJJA1GMyNaykXpYKmsPfxbnTCTXB3nlO747JwT+
 7p8bEYyjZyKc50tA7BgwaUOWeYNtl9x7F8ruEHHo4BOQm7J8zmnyUCMgbC5OPu8JQEQ5
 eNHQMmqR6qMDzMonmoJlv1fEoua8yn/1fflbwkxOUUE0UO7cZiD/OOcKC4Wm7VHQnHS1
 kgQ4Mzgnbj8fJmPyfHjkqG9cOv5A6LHPIgS73tO2R6JYAYgslcrikt241cqy0irckIdn
 bESnujSZrq6gXsFt0r8KzkRXOFrVF/KIKdkAQDydm6EnxT0LoYg9EPKKI293CTMYlMzw
 L3Xw==
X-Gm-Message-State: AOAM532nDoxSqaKGPXhay76ODogNKUVj1NK5i0JpFJZJDANw4ik4Bcj/
 1WU97mR+77MhuGrQWQZu8XltrIObZSsIpghqQPk=
X-Google-Smtp-Source: ABdhPJycpbc2If/GpgyWIbZPhpD4Wyl1HksviNoBPJcD71WCgJqvFL5VKN0mdZ130uRhLDG4gaozMvgXHq3p2TxhkSo=
X-Received: by 2002:a25:afca:: with SMTP id d10mr51009157ybj.517.1593739510148; 
 Thu, 02 Jul 2020 18:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593547870.git.alistair.francis@wdc.com>
 <ea4f280e6f77e734c8e555e3c98d10085ce9f5b6.1593547870.git.alistair.francis@wdc.com>
In-Reply-To: <ea4f280e6f77e734c8e555e3c98d10085ce9f5b6.1593547870.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 3 Jul 2020 09:24:59 +0800
Message-ID: <CAEUhbmVsQX+es-xw5Omj+-dsU1Km2kKNAZa_NJ6PipE4ZAEucA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] target/riscv: Regen floating point rounding mode
 in dynamic mode
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Wed, Jul 1, 2020 at 4:23 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> When a guest specificies the the rounding mode should be dynamic 0b111
> then we want to re-caclulate the rounding mode on each instruction. The
> gen_helper_set_rounding_mode() function will correctly check the
> rounding mode and handle a dynamic rounding, we just need to make sure
> it's always called if dynamic rounding is selected.
>
> Fixes: 1885350 ("RISCV dynamic rounding mode is not behaving correctly")

I can't find this commit id.

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Regards,
Bin

