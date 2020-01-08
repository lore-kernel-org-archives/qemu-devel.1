Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556A6C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB2D20643
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ox49SkzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB2D20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipHtp-000892-9m
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 15:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1ipHt6-0007UK-O3
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1ipHt5-0001cf-J7
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:25:08 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54866)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1ipHt5-0001YV-Am
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:25:07 -0500
Received: by mail-pj1-x1041.google.com with SMTP id kx11so105944pjb.4
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 12:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=vCD0gNLjsZ1HX5BFdK6+0i47Hz9qh5wOkptLUWktIG8=;
 b=ox49SkzM9wH8gPUlsCaQ66Hjyp2pHkUACuSQY8W+jkZS3HSNUu07DR7m3Sw9cSvSMr
 DxhJp1cGYhymCYgUISpGDqGLWcMbjilmDBRfeTzcFVchZunSJANTkY/y+/cRgYNYyT3d
 TEjgPyXorAYpsMK3QjQPEoq+VfJ2demiLPPB/+RGdOi4YnKEOGH0yrusJl6lEV6rpnWu
 4a7mA9e9jRIu4+O2I6gLzmbg45+xTZtmZkND8iloVTk6m1p5CmDSQ5zbxcEXw24jC46X
 tAdSoUbv502EWevsxp7+OVjQYi/4KO7YBLszQz2V0Ck3JurcCv5tEoyryFJiw8HOR5jD
 0Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=vCD0gNLjsZ1HX5BFdK6+0i47Hz9qh5wOkptLUWktIG8=;
 b=kyYv58kuAsrW/XACYeT4+Ds1PYHpLcLCBvKazLSu72GJwTEIclBSZ86dLH6k91Gdrp
 kqmm1VD1sU5qwuDp9PgSfjVFemJENHvVfeZO1QpyK8ju43tbNc8S49vxSbrhYa4K8J4W
 nF6fYSgDO56m100f62HzMLJArUZKd5gAOLcvLZDtMZ/4kBpsLrSnFe6TabFvGDw213MD
 +y98OdqoNXTSYn+CxeVCGT0oXR9XrsdWwlCRlB/SLvd1Rf0Sjg80FMcE3HyHna5YG/L4
 zzccdmIlKhgee+kubDMoEDCqNoq3Ns37DV3aeSK1TrHZ4feARSyHgYQB5whugaMjKojT
 Ofyg==
X-Gm-Message-State: APjAAAVS5NQ/9r+N+SmQ2Tf2Dng9d9KON+cqYGCNdnYMfdwHCM6W1ZUQ
 cG2MK6zvGdIS6Xa5uR9C9cKoXDUt9Lo=
X-Google-Smtp-Source: APXvYqwYSwi/4Drsq6AyflNQMfKMlP47vRSQTj/SjyijdlVQY1Zs9VLhVhCKj3THlX00u/BouozSgA==
X-Received: by 2002:a17:902:7006:: with SMTP id
 y6mr7253333plk.84.1578515103273; 
 Wed, 08 Jan 2020 12:25:03 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id b19sm4514883pfo.56.2020.01.08.12.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 12:25:02 -0800 (PST)
Date: Wed, 08 Jan 2020 12:25:02 -0800 (PST)
X-Google-Original-Date: Wed, 08 Jan 2020 12:24:57 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 18/36] target/riscv: Extend the MIE CSR to support
 virtulisation
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <6ec43c1bf0886d917fcd88d3751d72def5507db2.1575914822.git.alistair.francis@wdc.com>
References: <6ec43c1bf0886d917fcd88d3751d72def5507db2.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-d2e58623-a1c9-433f-9a4a-0d3d49c07b7b@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 09 Dec 2019 10:11:27 PST (-0800), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/csr.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index fc38c45a7e..54edfb280e 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -244,8 +244,10 @@ static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
>  #define S_MODE_INTERRUPTS  (MIP_SSIP | MIP_STIP | MIP_SEIP)
>  #define VS_MODE_INTERRUPTS (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP)
>
> -static const target_ulong delegable_ints = S_MODE_INTERRUPTS;
> -static const target_ulong all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS;
> +static const target_ulong delegable_ints = S_MODE_INTERRUPTS |
> +                                           VS_MODE_INTERRUPTS;
> +static const target_ulong all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
> +                                     VS_MODE_INTERRUPTS;
>  static const target_ulong delegable_excps =
>      (1ULL << (RISCV_EXCP_INST_ADDR_MIS)) |
>      (1ULL << (RISCV_EXCP_INST_ACCESS_FAULT)) |
> @@ -631,13 +633,27 @@ static int write_sstatus(CPURISCVState *env, int csrno, target_ulong val)
>
>  static int read_sie(CPURISCVState *env, int csrno, target_ulong *val)
>  {
> -    *val = env->mie & env->mideleg;
> +    if (riscv_cpu_virt_enabled(env)) {
> +        /* Tell the guest the VS bits, shifted to the S bit locations */
> +        *val = (env->mie & env->mideleg & VS_MODE_INTERRUPTS) >> 1;
> +    } else {
> +        *val = env->mie & env->mideleg;
> +    }
>      return 0;
>  }
>
>  static int write_sie(CPURISCVState *env, int csrno, target_ulong val)
>  {
> -    target_ulong newval = (env->mie & ~env->mideleg) | (val & env->mideleg);
> +    target_ulong newval;
> +
> +    if (riscv_cpu_virt_enabled(env)) {
> +        /* Shift the guests S bits to VS */
> +        newval = (env->mie & ~VS_MODE_INTERRUPTS) |
> +                 ((val << 1) & VS_MODE_INTERRUPTS);
> +    } else {
> +        newval = (env->mie & ~S_MODE_INTERRUPTS) | (val & S_MODE_INTERRUPTS);
> +    }
> +
>      return write_mie(env, CSR_MIE, newval);
>  }

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

