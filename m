Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACEEC49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6EE21479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6EE21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hY0-00082i-V5
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7hR9-0000Ip-1s
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7hR8-0006NV-2a
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7hR7-0006N4-SJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id q17so16145742wrx.10
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=9r/tsin+WnzvHfmEc7iVPUi/buDct7somnXFCcxsN4M=;
 b=E0eKKq+C9H+NL0TCPGFKqjBp16BbBZe+cBtJbOMVMDzrMbe0LmrkppQQ6i6deuHBUe
 xgraZNtlcvD1+2/mjKNRTkdxp0AZob2LxV4KqUeKbF/ndVSwa05L7EibMSASScnJEIVv
 5kyWDPvn1bNC0+p3OdUSJYtegseyYF7E0pZjza5/x9FP8ldXN7MbQrmPlWaxxLYvjHam
 YpVC7ffXPtyYdtFRGluD0dyfMnlOscJy5CzGSf+K8tG9mg/sYn+IQWJaPOzWzbXbgoxt
 M+W9L6kq0hp+69rHCHht/rWNT2t/hSvf/l0q6lPhOIFYwJODKwS3g9aCtAbaZxDpoD9w
 QUAg==
X-Gm-Message-State: APjAAAULX0K2Y/MW0rWsja/3WRTGuZru49giAEhu1mtJnzhYLrwQ6JQG
 Jrd7tqvSR3b95vJYrvxBVTa4HYiL5Bu8zQ==
X-Google-Smtp-Source: APXvYqx+MMVn21LPEsYVh4ZdCTqfuyQUbh76195ywvIFJ5C3yTWkYyr5hoeGjchAictUvs1bD59zqA==
X-Received: by 2002:a5d:4ac5:: with SMTP id y5mr21240676wrs.179.1568126884538; 
 Tue, 10 Sep 2019 07:48:04 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id a144sm5175207wme.13.2019.09.10.07.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:48:04 -0700 (PDT)
Date: Tue, 10 Sep 2019 07:48:04 -0700 (PDT)
X-Google-Original-Date: Tue, 10 Sep 2019 07:40:13 PDT (-0700)
In-Reply-To: <a090bc437bf412c279b1254d05eae5c2d67225db.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-afa69c9b-17b7-4043-b204-512c92cf618a@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v1 04/28] target/riscv: Fix CSR perm
 checking for HS mode
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
Cc: qemu-riscv@nongnu.org, Anup Patel <Anup.Patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 16:38:00 PDT (-0700), Alistair Francis wrote:
> Update the CSR permission checking to work correctly when we are in
> HS-mode.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/csr.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index f767ad24be..471f23a1d0 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -799,9 +799,15 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
>
>      /* check privileges and return -1 if check fails */
>  #if !defined(CONFIG_USER_ONLY)
> -    int csr_priv = get_field(csrno, 0x300);
> +    int csr_priv = env->priv;

This isn't really "csr_priv" (ie, the priv needed to access the CSR) any more, 
it's really the effective priv of the machine.  Leaving the variable with the 
same name makes this hard to read, but I think it is correct.

>      int read_only = get_field(csrno, 0xC00) == 3;
> -    if ((write_mask && read_only) || (env->priv < csr_priv)) {
> +
> +    if (riscv_has_ext(env, RVH) && !riscv_cpu_virt_enabled(env)) {
> +        /* Plus 1 as we are in HS mode */

The comment is useless, it doesn't say why we increment it.  Also, I don't 
think this is correct: doesn't it allow U mode to access S CSRs when H is 
present and V is disabled?

Something like

    riscv_effective_priv(CPURISCVState *env)
    {
        if (riscv_has_ext(env, RVH) && env->priv == PRIV_S && !riscv_cpu_virt_enabled(env)) {
            return PRIV_HS;
        }
    
        return env->priv;
    }

would probably be used in a handful of places, and would be a drop in for
env->priv here.

> +        csr_priv++;
> +    }
> +
> +    if ((write_mask && read_only) || (csr_priv < get_field(csrno, 0x300))) {
>          return -1;
>      }
>  #endif

