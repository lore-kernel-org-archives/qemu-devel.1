Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0B6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 01:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B1E20748
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 01:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPh/qorq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B1E20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrAOg-0004WL-PQ
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 21:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jrAMW-00015n-DY; Thu, 02 Jul 2020 21:19:32 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:34228)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jrAMU-0005Mv-UY; Thu, 02 Jul 2020 21:19:32 -0400
Received: by mail-yb1-xb41.google.com with SMTP id l19so1832445ybl.1;
 Thu, 02 Jul 2020 18:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GJYRLJU1nGbebkdEaZI1GrtzuGIGfHc8B6xnBzBoyeE=;
 b=CPh/qorq3t+omt0z6ifBqdnEy2sc8a7hBFoXoEvOLxf3i5u0YkDopB6TWZnxPmJIBZ
 wAATUQqc6ioNdaqIvU0fiATD8vdXANgfYh799pK+9a9u8bUy9h1yjoOnXXnXgg35F3Wr
 4rgwPK2raCzcf0CAerMwvZxlnYd3JoI9B8TzEqdCP8qMnNd6ndoD+U9iOWhV5/dVZMcw
 kwJIMWo1XT2kxU3EtE+unCCucuKQ2OjItnNM76tiOZPBIgm8kE6q+pcutiO5MgKoZCzy
 ortVt8y2MrbiRsDj23Bj1V5piKrz5A7NDQpWyIaec2L6Tw53j/PHT0UFWmgSGiLI5G23
 mjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GJYRLJU1nGbebkdEaZI1GrtzuGIGfHc8B6xnBzBoyeE=;
 b=Xni0kd+T8yv6sj6hA34fuVAnDcs89oScc036TIC50sbf8VnyDw0/htyMfPqQ3lEksb
 UU4saS316QGoXKF0c4+5x3g6t45fd7w0BI05WRVWDI1QO7Rm+gywwzNDOY7ycS7bGm+A
 930sZSbETkEarlNwVu9epY2zwqNHvVecuHcOxkmHz9XuMhAGMOeqmINmpOT+ItJpTsgR
 6JBGhzGJA2VjEdGm1M2OrDK1hf39l14Kxl2MrET7gvtKZREBiRVEQnFtU3+FQVEQJhmN
 ZF2w4GGHGpgxR3HTe7qHM3CT1tFDcrAYQKn8chwyNng/CMO/SOy/ozh2L8xdRXYinhdG
 L4nw==
X-Gm-Message-State: AOAM533NPS6Fmck8hB7y3tvVekN237lLE0txRPYa+yEZhsgt9SWDiwmx
 FHNFUe6h6YB0MAhx6gkpLfzFaecnpAuzzaXBclk=
X-Google-Smtp-Source: ABdhPJwPk+8MN2r+y8rlxM47hHb1B0YViRYGUUEwABz65QU9F5CJX3R49M+3JMiXMPWbmAK4txaC/EzjkwlBy4lE/Zg=
X-Received: by 2002:a25:800c:: with SMTP id m12mr56637950ybk.239.1593739169906; 
 Thu, 02 Jul 2020 18:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200701183949.398134-1-atish.patra@wdc.com>
 <20200701183949.398134-5-atish.patra@wdc.com>
In-Reply-To: <20200701183949.398134-5-atish.patra@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 3 Jul 2020 09:19:18 +0800
Message-ID: <CAEUhbmXea4nf9pq-6bumtK-rE8b0B7EF-agptnX5T_Hpm5EfgA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] RISC-V: Support 64 bit start address
To: Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alexander Richardson <Alexander.Richardson@cl.cam.ac.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 2, 2020 at 2:39 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Even though the start address in ROM code is declared as a 64 bit address
> for RV64, it can't be used as upper bits are set to zero in ROM code.
>
> Update the ROM code correctly to reflect the 64bit value.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  hw/riscv/boot.c     | 6 +++++-
>  hw/riscv/sifive_u.c | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>

