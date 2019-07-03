Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025FCC5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C304121871
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmkhNe0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C304121871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hinns-0007oA-2y
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 18:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52915)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hinmu-0006mL-Sf
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 18:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hinmt-0006Me-01
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 18:31:40 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:32990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hinmo-0006Gz-Vc; Wed, 03 Jul 2019 18:31:35 -0400
Received: by mail-lf1-x144.google.com with SMTP id y17so2888956lfe.0;
 Wed, 03 Jul 2019 15:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H3YlCU/NHXEmFzhWxkb+3ZDtqrD+MnnjrDMSNBzFpMM=;
 b=jmkhNe0RHvXyV99VukYGsOnPxe7Cw7fwZwX3QOLfXhV4+vzudTYex4SKGD77SeexRd
 uNd/PqPERI6udd8RnD9qSOwLuSx+tSKr641f0v90fqcCgTZj//Pk8XI8pu8+4JTdNnDF
 jYRpvx/VUrvNuh5wr5Dfa+IyiEZVWOrElzRNc9DcSDX8siMZA4AJ9Q4GqYShehtz5ieE
 lxPkhP9zXF92PtZq/6i9wAfVrvxvTh09zY9mnxE+q/wQLJIUs6if2PvdHxSJlSQ1MuB9
 qDMfPZY9BPeHBryJPbmhTmXApaPYWzqpj0909QykF4TTIfjX+I9tVBQKd5tV2zwyiRzF
 QmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H3YlCU/NHXEmFzhWxkb+3ZDtqrD+MnnjrDMSNBzFpMM=;
 b=XfQ90Gl1GjhJbbploZ5WT1EwfKr7i8HxQppRNnp1CNAquDvJiJg8bXw61VbNngdj4t
 LRCGdmbzs0oG3MCoXtc/D2LgAtShuCxKlyYHlC/M1EKJ1NZE6vKMJx+D12eZ7UMo9xU1
 rbruQcBCTxlgxOeYB4/t3MepBAi8suLm822GpyUMP4/XqtGcsQbPv7CdHYMLypt7jyKC
 9TCUzntuEYhUDkTwAhICQ2Ngre8I0/f9XWpeJ7mwktBNND0RjWqzHg8cRvjfQKDKBXXa
 TBmbY1lPU8cEq1fc3VfQ4qVkINNbY33O01YA6MyOwM+buk1/ompxnKNqoO0QkvBbKcyL
 6RWg==
X-Gm-Message-State: APjAAAWB3yBjfaCVZJtAn7xcEDmVgPolRM4U5H5x25O1WODOJCO4HtWT
 M1FUsu7uiysuENhons+0WEOGDpmBKYIur/eEp0k=
X-Google-Smtp-Source: APXvYqxRrrXSDpS2KfQqftlIiyrwoPl+oGr7qNnVmskVkCshLFR0K4RuBREM0B87fAvI/G61GmzBEyPZpJNp9u12d94=
X-Received: by 2002:ac2:4990:: with SMTP id f16mr18646996lfl.93.1562193092432; 
 Wed, 03 Jul 2019 15:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190703190715.5328-1-jonathan@fintelia.io>
In-Reply-To: <20190703190715.5328-1-jonathan@fintelia.io>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2019 15:28:27 -0700
Message-ID: <CAKmqyKOmF_bpDuXRh2euT29QouTv=7i-b=6RXvU7LerznqMCgg@mail.gmail.com>
To: Jonathan Behrens <jonathan@fintelia.io>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Disallow WFI instruction
 from U-mode
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 3, 2019 at 12:07 PM Jonathan Behrens <jonathan@fintelia.io> wrote:
>
> Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>

From the text in the spec it sounds like it should be an illegal
instruction exception, at least for now (see below). Maybe it's worth
mentioning in the commit that WFI in U-Mode is allowed if it completes
within some time limit?

"
When S-mode is implemented, then executing WFI in U-mode causes an
illegal instruction excep-
tion, unless it completes within an implementation-specific, bounded
time limit. A future revision
of this specification might add a feature that allows S-mode to
selectively permit WFI in U-mode.
Such a feature would only be active when TW=0.
"

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/op_helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 331cc36232..2e5a980192 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -129,10 +129,10 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
>  void helper_wfi(CPURISCVState *env)
>  {
>      CPUState *cs = env_cpu(env);
> -
> -    if (env->priv == PRV_S &&
> -        env->priv_ver >= PRIV_VERSION_1_10_0 &&
> -        get_field(env->mstatus, MSTATUS_TW)) {
> +    if (!(env->priv >= PRV_S) ||
> +        (env->priv == PRV_S &&
> +         env->priv_ver >= PRIV_VERSION_1_10_0 &&
> +         get_field(env->mstatus, MSTATUS_TW))) {
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      } else {
>          cs->halted = 1;
> --
> 2.22.0
>

