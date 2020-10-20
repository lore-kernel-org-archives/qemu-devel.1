Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446D5C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 03:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C5D222E9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 03:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thtxZtyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C5D222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUiFC-0004N5-CO
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 23:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kUiA1-0007Vg-1q; Mon, 19 Oct 2020 23:18:05 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:36253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kUi9w-0007DX-Vb; Mon, 19 Oct 2020 23:18:04 -0400
Received: by mail-yb1-xb44.google.com with SMTP id f140so600575ybg.3;
 Mon, 19 Oct 2020 20:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SSAlBJvmnb9l6h4y8x9yUgigt7ohOFgtsYS7nWixtnE=;
 b=thtxZtySis3+5AxUz052A60skhJSVuZYK24zjTWJ1JsR3Dfib2lruIvRkeZOChj7h2
 hV1n7GbdZQlT2H5oDiVFOiPH8PLvRMAw6o5Y+FYUKRgqrEQmOpmKHFxcxSSvFGXk0RX6
 qMeGaybtCiC3WMcbFw5xog5ypjglz2MbDYr4Hh/Sni8/e+usmDyxyeGcYisBzuQSMfRq
 Bievh82k01uXJ9PWmBgedUPzSoWOqH2jsQdI+Twa+m26st/MJUpM/uxdTzxEYW8ZH5bS
 J0ihkYM1ncDEizpfdISOyWGQU+vfqFHvcHpgD6xJpsCH3e72RL5eawg+I93TXwnL9glU
 pELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SSAlBJvmnb9l6h4y8x9yUgigt7ohOFgtsYS7nWixtnE=;
 b=DfNeE8FPdeo33uBf9dQYMP5aLAoJidFbF/iyeqpPid3ZrVJxrTMiNr25cb3r6z9Qzc
 enpYH0gVvdw5i8YQ7JWeroP8LrHZKZoGATC5aOgsqhMgtH9rr9Chq9BQQcy8eO7jADiK
 6rS/vrpSTQiaKO+mVHPrZ4QHg5Z88c1VJHoqc8xhhJzZxHBOdchtLNm/HiagMhYbgtai
 0kL22YLRdKl/LOZpZqVYK95QqgvP+7JWwdyyYRIOkutCzlfMWP1gTdKocP8wyxPryTEg
 HB9190uvnOtc7ud2SH15YVewelaUQ7kpQO8M0YTPvzlawSEJHWd1hYEXGdRqD9dtMkRs
 VlwA==
X-Gm-Message-State: AOAM533SCbPbemuvwfeLlGZc0CYZz4+LD1U6lQ7uq7c3NPixauBTjdBa
 OeblHc0ihzjh1Nxvm87+XBTjsX/EvHy298C4EGifI7LW
X-Google-Smtp-Source: ABdhPJykk/+OygvOTuMvQfTs9o7+7MwagKPwLP6ezyWm8PDZUJjTJWnx9MbNgj0M3OvE878TYCeg4v8LkVuI4W5DOFs=
X-Received: by 2002:a25:f81e:: with SMTP id u30mr1350994ybd.332.1603163879088; 
 Mon, 19 Oct 2020 20:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602634524.git.alistair.francis@wdc.com>
 <558cf67162342d65a23262248b040563716628b2.1602634524.git.alistair.francis@wdc.com>
In-Reply-To: <558cf67162342d65a23262248b040563716628b2.1602634524.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 20 Oct 2020 11:17:47 +0800
Message-ID: <CAEUhbmV26nFAKWSbJNuKDrL9drYZN+G=WKkgmBKULo5-eKExOw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] hw/riscv: Return the end address of the loaded
 firmware
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
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

On Wed, Oct 14, 2020 at 8:28 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Instead of returning the unused entry address from riscv_load_firmware()
> instead return the end address. Also return the end address from
> riscv_find_and_load_firmware().
>
> This tells the caller if a firmware was loaded and how big it is. This
> can be used to determine the load address of the next image (usually the
> kernel).
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  include/hw/riscv/boot.h |  8 ++++----
>  hw/riscv/boot.c         | 28 +++++++++++++++++-----------
>  2 files changed, 21 insertions(+), 15 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>

