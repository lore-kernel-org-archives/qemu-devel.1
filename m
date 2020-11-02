Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25FBC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FCBF21D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxpliuVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCBF21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZe15-0007wZ-5R
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kZdza-0006uI-0L; Mon, 02 Nov 2020 12:51:42 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:36591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kZdzY-0003CN-DU; Mon, 02 Nov 2020 12:51:41 -0500
Received: by mail-il1-x141.google.com with SMTP id p10so13726231ile.3;
 Mon, 02 Nov 2020 09:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gnK39zMRX750DqIj3DHvskbasklpdwswcibNrvwH+7Y=;
 b=bxpliuVtXeh0N4AXOdQ3T731dynaCRHKY7pIIsW/cfFitBG+PNevwYMIWlJwzXXmLR
 mR04MA+7YqJfqkAjwpdJP6EvkzrFoOPtZOWUvPYuELhka5woG7+NiKjtfFHhKWR+R1KC
 0Lt3UXBms2NPjHvY+JRscnYC+avURjd8MaMyHkxLbwaxwzhKgClnLdRj6oz++f455eMm
 DM9C4TD6qVHOquQMRQLLL1q1j77l30uwlqMWUHyhzqDuGeVUg+5QO4+sRiVNKaQtrmt+
 IhpGk29jYj1gsT7AJBG8LKMKfxRxJRwsTSyB65uxgQFQUeKFe0R0ojWeEPCj3hl57KrV
 5wLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gnK39zMRX750DqIj3DHvskbasklpdwswcibNrvwH+7Y=;
 b=IktX9mmThcx7i48+2pOdEUYXkDDrMhnUDNTOtvz+DYLECZ4YsA4ThTUVwx6QE/E5mP
 gqWhxHS2vhqkMkaRt5W/sgr+44sk65fRK7zRHlQ7MIQaVBTdtAt9j4QW/2zepKBnrEVS
 xPSfc6kjIFqywhTPuGng0I1glBs/URS2WXYFtUVhcWPOZHL8r3ujFe8S9b8kyNmx/MGb
 P5e7KY9EGJnGYO8lp/1V+LFrGhLEZbTAYgbNnxkfzHyUiNfr8eqLQrbdsvULzC/sBQYm
 /L2O9RISIei84CDKxmkg8LkfHagKkNhdga2J+9Ycqyq+1MWhWoI53WT3CIWYjZIK1fLq
 jLJw==
X-Gm-Message-State: AOAM5333swjW2KEDJ4tBeS7BzRS9jh8ISK58KSxS/lGW7539mIKIPK2j
 saQoCN94DwXWpNjk11nB7up5nC5lIutCcHXyEKs=
X-Google-Smtp-Source: ABdhPJwCNH3tH2f7gDkqadpi+5CMACZg7/b5UMdjeH3mwh0K3yVFQ4/U8Q3tRrVdgMJtFM8sb08T+QYteDV0mptD240=
X-Received: by 2002:a05:6e02:f41:: with SMTP id
 y1mr12054296ilj.267.1604339498902; 
 Mon, 02 Nov 2020 09:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20201030004815.4172849-1-zhangxinhao1@huawei.com>
In-Reply-To: <20201030004815.4172849-1-zhangxinhao1@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Nov 2020 09:39:43 -0800
Message-ID: <CAKmqyKNiyTTWHOdgxsoQoFoDX7XN2Vdjz7oXyMtx8JEXiFwpcw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/csr.c : add space before the open
 parenthesis '('
To: Xinhao Zhang <zhangxinhao1@huawei.com>
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 alex.chen@huawei.com, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 29, 2020 at 5:56 PM Xinhao Zhang <zhangxinhao1@huawei.com> wrote:
>
> Fix code style. Space required before the open parenthesis '('.
>
> Signed-off-by: Xinhao Zhang <zhangxinhao1@huawei.com>
> Signed-off-by: Kai Deng <dengkai1@huawei.com>
> Reported-by: Euler Robot <euler.robot@huawei.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index aaef6c6f20..e8b149f0d2 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -881,7 +881,7 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
>          if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
>              return -RISCV_EXCP_ILLEGAL_INST;
>          } else {
> -            if((val ^ env->satp) & SATP_ASID) {
> +            if ((val ^ env->satp) & SATP_ASID) {
>                  tlb_flush(env_cpu(env));
>              }
>              env->satp = val;
> --
> 2.29.0-rc1
>
>

