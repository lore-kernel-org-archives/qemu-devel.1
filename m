Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C31AC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 21:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB99206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 21:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB99206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8t0p-0005xo-7t
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 17:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i8szp-0005Vh-OE
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 17:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i8szo-0005LL-FR
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 17:20:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i8szo-0005L0-9v
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 17:20:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id x3so13764130plr.12
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 14:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=/Fq7QcmmLLwNTeanlUU4aXQDyzZiHPkisBlI1lGIvVk=;
 b=DaNv6crDMuE1qjRRF43syoQ+Cf79us1gF+LInAGmUW6onDVnuwom6WZdr6CtLM9YuT
 fXbJsGCNEDYXh/h/CpK3eggQ7ZIWxmvSEaSWP30PrsY1pxvFF1q62OvxW5huVfDfR//g
 ++3AV1OcpVLt1+rwxtU/u1TnShEeEAoFKaj1BbSEwnUnkoNuMasn8Z44MjWwXy2YXEXy
 U+P/Go7tYrm4oYT8t8sEnUtIegy2m1tF8nZsAa4PUnoTnptiLPFa9e1Rym/NgYNvPpYD
 bbBYugruvhUKRTwRWcdUKsCyiUQnCiSdSuywOInv4gYx1d+AGGZle0KhfFWSYi1syaZo
 xk0Q==
X-Gm-Message-State: APjAAAU2zhqBMHT+rO8FfFXZf3JEQVZNsNWl0YB4PAxCHyyTPvUQFsod
 2KPVtjK+WET4ZRGNlwaMHm/W8naLF8vspQ==
X-Google-Smtp-Source: APXvYqw9AQJVJaHANAMOmw71j87KMC/B3mNgFPIfMnjY8PaWTUJ4nKnov6uId2tqccPYZqEMYp5Y6Q==
X-Received: by 2002:a17:902:8d81:: with SMTP id
 v1mr34370902plo.23.1568409646480; 
 Fri, 13 Sep 2019 14:20:46 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
 by smtp.gmail.com with ESMTPSA id x8sm28754237pfm.35.2019.09.13.14.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 14:20:45 -0700 (PDT)
Date: Fri, 13 Sep 2019 14:20:45 -0700 (PDT)
X-Google-Original-Date: Fri, 13 Sep 2019 14:14:14 PDT (-0700)
In-Reply-To: <1568103341-28636-1-git-send-email-frederic.konrad@adacore.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: frederic.konrad@adacore.com
Message-ID: <mhng-b33d5ee5-58d7-402f-ad7f-e79f58ed84f7@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.196
Subject: Re: [Qemu-devel] [PATCH v1] gdbstub: riscv: fix the fflags registers
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
 sagark@eecs.berkeley.edu, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 qemu-devel@nongnu.org, frederic.konrad@adacore.com,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Sep 2019 01:15:41 PDT (-0700), frederic.konrad@adacore.com wrote:
> While debugging an application with GDB the following might happen:
>
> (gdb) return
> Make xxx return now? (y or n) y
> Could not fetch register "fflags"; remote failure reply 'E14'
>
> This is because riscv_gdb_get_fpu calls riscv_csrrw_debug with a wrong csr
> number (8). It should use the csr_register_map in order to reach the
> riscv_cpu_get_fflags callback.
>
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  target/riscv/gdbstub.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 27be932..ded140e 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -313,7 +313,8 @@ static int riscv_gdb_get_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
>           * register 33, so we recalculate the map index.
>           * This also works for CSR_FRM and CSR_FCSR.
>           */
> -        result = riscv_csrrw_debug(env, n - 33 +  8, &val, 0, 0);
> +        result = riscv_csrrw_debug(env, n - 33 + csr_register_map[8], &val,
> +                                   0, 0);
>          if (result == 0) {
>              return gdb_get_regl(mem_buf, val);
>          }
> @@ -335,7 +336,8 @@ static int riscv_gdb_set_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
>           * register 33, so we recalculate the map index.
>           * This also works for CSR_FRM and CSR_FCSR.
>           */
> -        result = riscv_csrrw_debug(env, n - 33 + 8, NULL, val, -1);
> +        result = riscv_csrrw_debug(env, n - 33 + csr_register_map[8], NULL,
> +                                   val, -1);
>          if (result == 0) {
>              return sizeof(target_ulong);
>          }

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

I just tagged a fixed version of my PR, but I'll include this in the next one.

