Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA6CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 22:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643BB206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 22:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAOSrENo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643BB206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5GVq-0002pL-L9
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 18:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k5GVJ-0002O4-Ag; Mon, 10 Aug 2020 18:42:53 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:33009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k5GVG-00080u-IO; Mon, 10 Aug 2020 18:42:53 -0400
Received: by mail-il1-x144.google.com with SMTP id p16so9003207ile.0;
 Mon, 10 Aug 2020 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cZN9tB7NZtV/+vDauo/ieLjVL8IFlfbUkPQBnezhcdA=;
 b=CAOSrENozZU0RrWkqPV+yuPa2flXVEZvSWcGIxsc+h2tGNOR0S3TCP966zucNM/GUq
 2lFcI2s3GHab7bIc5oY7qpcPUiUNSLO5oOwp06PXXcesvxdftn+aY+uiD36hSgiZJ0si
 8DQTEpZE17NC/DNLScDADlfv/wTywU01CuSFG803S+CA6ZJyw/ZFoJvItAW8AgMqpKIZ
 HGc85Wq9z1TprGDdC+SB3cKYDntCTVeakMhClrlc7/FV6Maa8NJnU8AZwsZV3t2SWOtE
 D5hFRqmTGaL9U6u0HyfsKK1AHqxDuvA0V2sEAyB43OJ4vtYIK/tFsNTI/553EcevUeEM
 CMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cZN9tB7NZtV/+vDauo/ieLjVL8IFlfbUkPQBnezhcdA=;
 b=b/brltyQww0adqM2PA+nPjEDJ4zjH13gyrRfl0AvWiYPAqDV+GIoO4NwSFotjdeyst
 3pFaDJGMp4+to7eWKQAtTPQ4zzMTUP1umbGc4gTPuxsdD9TsWRfnSZbtnJQlcPqtOWXS
 fiaX25NXRnfUHSMsjTBQWqJ+iS/dIiChhkv0vwMrpa2eQlRY0RHZ/Ar/bPJDlYn/4aC/
 G3M6cL7fY62bRa6gyqUZHs/n9ewl/Xnx//6oYBJ/+zez1z3qb9OxBr4qQBmIBK5q62PW
 F1U3jGkB6kjB1TknlR72nQGg/fi0evpSWuGpjvBAqJd0ShFs7GGhSEea4ZTGwawzUW1l
 ZOBg==
X-Gm-Message-State: AOAM533ajUH35Enm6ZnLrDTvNia28UDj0rbcnYNvtzimo2dXznsN4G+V
 53o8aB0yk68k7oMLl10gddz0h+BxvM437zVIxC8=
X-Google-Smtp-Source: ABdhPJzLhGiqIFiaKtzT7QQykwhjglDySehgvQHgghsdt/hFGhI6yDelQ3y0MlYtfKyxRQjLKDLeLANCgGQy3kSsSME=
X-Received: by 2002:a05:6e02:f07:: with SMTP id
 x7mr20313385ilj.40.1597099368875; 
 Mon, 10 Aug 2020 15:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <SG2PR02MB26341FE46F5C60B6FC71BC1893460@SG2PR02MB2634.apcprd02.prod.outlook.com>
In-Reply-To: <SG2PR02MB26341FE46F5C60B6FC71BC1893460@SG2PR02MB2634.apcprd02.prod.outlook.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Aug 2020 15:32:25 -0700
Message-ID: <CAKmqyKNY_gYoBFX6Xv6g2H7MXQpdrPxZPogPNX=4pY_rKGw-og@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix bug in setting pmpcfg CSR for RISCV64
To: Hou Weiying <weiying_hou@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Hongzheng-Li <Ethan.Lee.QNL@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Myriad-Dreamin <camiyoru@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 8, 2020 at 6:05 AM Hou Weiying <weiying_hou@outlook.com> wrote:
>
> First, sizeof(target_ulong) equals to 4 on riscv32, so this change
> does not change the function on riscv32. Second, sizeof(target_ulong)
> equals to 8 on riscv64, and 'reg_index * 8 + i' is not a legal
> pmp_index (we will explain later), which should be 'reg_index * 4 + i'.
>
> If the parameter reg_index equals to 2 (means that we will change the
> value of pmpcfg2, or the second pmpcfg on riscv64), then
> pmpcfg_csr_write(env, 2, val) will map write tasks to
> pmp_write_cfg(env, 2 * 8 + [0...7], val). However, no cfg csr is indexed
> by value 16 or 23 on riscv64, so we consider it as a bug.
>
> We are looking for constant (e.g., define a new constant named
> RISCV_WORD_SIZE) in QEMU to help others understand code better,
> but none was found. A possible good explanation of this literal is it is
> the minimum word length on riscv is 4 bytes (32 bit).
>
> Signed-off-by: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
> Signed-off-by: Hou Weiying <weiying_hou@outlook.com>
> Signed-off-by: Myriad-Dreamin <camiyoru@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/pmp.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 2a2b9f5363..b14feeb7da 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -320,8 +320,7 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
>
>      for (i = 0; i < sizeof(target_ulong); i++) {
>          cfg_val = (val >> 8 * i)  & 0xff;
> -        pmp_write_cfg(env, (reg_index * sizeof(target_ulong)) + i,
> -            cfg_val);
> +        pmp_write_cfg(env, (reg_index * 4) + i, cfg_val);
>      }
>  }
>
> @@ -336,7 +335,7 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
>      target_ulong val = 0;
>
>      for (i = 0; i < sizeof(target_ulong); i++) {
> -        val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
> +        val = pmp_read_cfg(env, (reg_index * 4) + i);
>          cfg_val |= (val << (i * 8));
>      }
>      trace_pmpcfg_csr_read(env->mhartid, reg_index, cfg_val);
> --
> 2.20.1
>
>

