Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09D5C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 23:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2282080D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 23:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MudMBVu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2282080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxf7n-0003GX-NT
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 19:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jxf7E-0002on-G6; Mon, 20 Jul 2020 19:22:36 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:35492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jxf7D-0002JT-0B; Mon, 20 Jul 2020 19:22:36 -0400
Received: by mail-io1-xd44.google.com with SMTP id v8so19458046iox.2;
 Mon, 20 Jul 2020 16:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ta75hUPSBkV25WbsUkQb5J9+4eYLyyNH3h88+yxf5jM=;
 b=MudMBVu3oO3qjCanYAUFv3wbF4b6lcqKxdm8QuKZt65kN3fsznjKkO3ZK0vS+j2erE
 TCR8n4df4v0F66/nDf+NAmfGKA2ZsxCCxBFhane3y6XS6rbpVzQilRcHF/SrXVhU0Hpg
 aOgK8cV+N3/xDt/m2jPUJ+bjYnHnrZTgX6Szd7poKNlTt3fHslek2I8tBpxqkCHjAdSF
 IAsq3koWBe9dvDVlSNgCNyQFdwno23i4+iXW6fJm32cr1vdduqnoSvRdQ6i86HwY01ep
 vvOLoBxLhrRT2Y+h2BxZNCPPcup8KFUT+7y9M/N86XVPT7nAN2GmiaL+SI6AFviRq3tP
 2s+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ta75hUPSBkV25WbsUkQb5J9+4eYLyyNH3h88+yxf5jM=;
 b=bFQA9/HyPoD2imn83pSgGh1Arfk0cZeg8XRGa5WLrLMn8XRLXFLNKEI1qtkQcBRleX
 cp7unVzBkZ8xztep3Zj4XF39Vvo5NBh5qIsHDLsXKle3OQrSpNCNbCn/YK+UDDLQBNWS
 +R+dXA2Xhx7FUvb4B2okSDkxXyfqITZP9jt6HuDp5CPS2y24YWn+ycq5PEJubfksVa25
 l4bn18sw8DhmYtdpDWO2wq5o00M2wklyBpxVsSUaQgIPPSfMinOnQLBSSL4cKU5IqLo0
 4NX5iGKQ9KfVyvYl3zAoo8zjEY1+sSJ93My9f7+HxLrl9/MOTgZap636NfGBH0LQb/sU
 V2Kw==
X-Gm-Message-State: AOAM530SEa3jERZgCJg7nRhkXjFWlMi/9G4mt21kipUVse1k3649o5pp
 lsKKhZtqQUSMxVyOfmom5QJZ5geVn398aP/z56U=
X-Google-Smtp-Source: ABdhPJxbNyKtFY+6ELCQpDmUMd8TwWpA9zAhpD46sRv9upHH6zP2ujK3FZVqCOEGXBEhy/TZcTYXrdqOhTeto1vea8w=
X-Received: by 2002:a5d:97d9:: with SMTP id k25mr25261256ios.42.1595287353228; 
 Mon, 20 Jul 2020 16:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595234208.git.zong.li@sifive.com>
 <c01aa428c0b4dc9c3e5b24a3d04040a1253bb3a5.1595234208.git.zong.li@sifive.com>
In-Reply-To: <c01aa428c0b4dc9c3e5b24a3d04040a1253bb3a5.1595234208.git.zong.li@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Jul 2020 16:12:28 -0700
Message-ID: <CAKmqyKPi=80Ktf8fKdvAJV396wjpYdd3keBpJTj8+6FDBrturA@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: Fix the range of pmpcfg of CSR funcion
 table
To: Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 20, 2020 at 2:48 AM Zong Li <zong.li@sifive.com> wrote:
>
> The range of Physical Memory Protection should be from CSR_PMPCFG0
> to CSR_PMPCFG3, not to CSR_PMPADDR9.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index ac01c835e1..6a96a01b1c 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1353,7 +1353,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>      [CSR_MTINST] =              { hmode,   read_mtinst,      write_mtinst     },
>
>      /* Physical Memory Protection */
> -    [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
> +    [CSR_PMPCFG0  ... CSR_PMPCFG3]   = { pmp,   read_pmpcfg,  write_pmpcfg   },
>      [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
>
>      /* Performance Counters */
> --
> 2.27.0
>
>

