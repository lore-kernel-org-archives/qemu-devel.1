Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC885C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F97D206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5psLchS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F97D206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iotck-0001Oe-86
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 13:30:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iotai-0007jX-BO
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iotah-0003VJ-45
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:28:32 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:32820)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iotag-0003SE-VL
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:28:31 -0500
Received: by mail-pl1-x642.google.com with SMTP id ay11so30736plb.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 10:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=tjnPToxzH35dkt51Mt0Z9aB+X5UsaKioUuHEUhQveRE=;
 b=b5psLchSBh5VbIHy9pPtCyglQospEb9TVxMBr9cOBvhJo1xqHmyLYAQHd9aMh2/rkk
 fe75rAjpS0Qq8urq0q3ZZXjZG4dOHpDIFj6pal9ZIhHGuVK2H6/TIG/CYkj5kZ323wDx
 VORN4bEf3h/pIsXjwdMxGrVLrY8R2OsEvI8N/Az3wZAIl4u/R7A9Mzpdmr2nFBHiSfSq
 1tcSW0bbZbtHy6OGUB2pgOJNfkLO93AIpXJTjzm9PwJV9+2pRbaRuOVUvF5eavddW1ud
 oX+Ccklh/ZHNggI/z6yRAVspb9k3gHPMWXRBa5PHdTlin70QG5CF+irQLmbcZjgRF3mY
 jBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=tjnPToxzH35dkt51Mt0Z9aB+X5UsaKioUuHEUhQveRE=;
 b=jcLMgP9ZUm3sAsQD3EXzE7yYkYj1mOFPOJ8W/Uz98lp13q4noBqrDHvR4YwFpgcUB6
 1T/4995oGkI8x5xE5DUdQAeW0m0U2aP5IU4JNICS0U10IcoBSQMtzDSeAHMydQ8q4t58
 kDfFP6M1W/koFINRvXg2piodLdamhYnGAOnrHNtgF2st3JKoTfYVD3Ds74oXM25TaG2g
 HqOVMUOETZzgGoEd/90RK9SRQjndOS451lAxnZGvD89AUfEA96MD8TbT0Q8+iD7WAFF5
 mIfGAFAQ/5v5Fiz1GlkSF1HUSGysN9axFyyO+ctXvJtA85t+tDEh6xWFLd3Iu3aENp8y
 I4Fg==
X-Gm-Message-State: APjAAAUIrvLHfn4gWgsrnNMObpCYbQm9mlhxydOAL2z+OQ8IJO5xHEMh
 uqk+XLXnRkmWq4ABKiKZ9mMOE5mw198=
X-Google-Smtp-Source: APXvYqw3DfjroWgwKA1TFw9koubRZeWxlLUEKO+nM/sz15YlvlF+zFnv/Ygp0exasQGfIJNZ/pSzEw==
X-Received: by 2002:a17:902:8f85:: with SMTP id
 z5mr1023921plo.43.1578421706743; 
 Tue, 07 Jan 2020 10:28:26 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id w6sm248338pfq.99.2020.01.07.10.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 10:28:26 -0800 (PST)
Date: Tue, 07 Jan 2020 10:28:26 -0800 (PST)
X-Google-Original-Date: Tue, 07 Jan 2020 10:25:41 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 04/36] target/riscv: Add the Hypervisor CSRs to CPUState
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <4b2d4e889d460e27d8f674d110fd1561768cd035.1575914822.git.alistair.francis@wdc.com>
References: <4b2d4e889d460e27d8f674d110fd1561768cd035.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-85e3faed-06a1-495e-9a5e-3d995ced2b73@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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

On Mon, 09 Dec 2019 10:10:50 PST (-0800), Alistair Francis wrote:
> Add the Hypervisor CSRs to CPUState and at the same time (to avoid
> bisect issues) update the CSR macros for the v0.5 Hyp spec.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h      | 21 +++++++++++++++++++++
>  target/riscv/cpu_bits.h | 34 +++++++++++++++++++++-------------
>  target/riscv/gdbstub.c  | 11 ++++++-----
>  3 files changed, 48 insertions(+), 18 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 91e1c56fc4..bab938103d 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -143,6 +143,27 @@ struct CPURISCVState {
>      target_ulong mcause;
>      target_ulong mtval;  /* since: priv-1.10.0 */
>
> +    /* Hypervisor CSRs */
> +    target_ulong hstatus;
> +    target_ulong hedeleg;
> +    target_ulong hideleg;
> +    target_ulong hcounteren;
> +    target_ulong htval;
> +    target_ulong htinst;
> +    target_ulong hgatp;
> +
> +    /* Virtual CSRs */
> +    target_ulong vsstatus;
> +    target_ulong vstvec;
> +    target_ulong vsscratch;
> +    target_ulong vsepc;
> +    target_ulong vscause;
> +    target_ulong vstval;
> +    target_ulong vsatp;
> +
> +    target_ulong mtval2;
> +    target_ulong mtinst;
> +
>      target_ulong scounteren;
>      target_ulong mcounteren;
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index e99834856c..25c0fb258d 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -177,8 +177,14 @@
>  #define CSR_HSTATUS         0x600
>  #define CSR_HEDELEG         0x602
>  #define CSR_HIDELEG         0x603
> -#define CSR_HCOUNTERNEN     0x606
> +#define CSR_HIE             0x604
> +#define CSR_HCOUNTEREN      0x606
> +#define CSR_HTVAL           0x643
> +#define CSR_HIP             0x644
> +#define CSR_HTINST          0x64A
>  #define CSR_HGATP           0x680
> +#define CSR_HTIMEDELTA      0x605
> +#define CSR_HTIMEDELTAH     0x615
>
>  #if defined(TARGET_RISCV32)
>  #define HGATP_MODE           SATP32_MODE
> @@ -191,6 +197,20 @@
>  #define HGATP_PPN            SATP64_PPN
>  #endif
>
> +/* Virtual CSRs */
> +#define CSR_VSSTATUS        0x200
> +#define CSR_VSIE            0x204
> +#define CSR_VSTVEC          0x205
> +#define CSR_VSSCRATCH       0x240
> +#define CSR_VSEPC           0x241
> +#define CSR_VSCAUSE         0x242
> +#define CSR_VSTVAL          0x243
> +#define CSR_VSIP            0x244
> +#define CSR_VSATP           0x280
> +
> +#define CSR_MTINST          0x34a
> +#define CSR_MTVAL2          0x34b
> +
>  /* Physical Memory Protection */
>  #define CSR_PMPCFG0         0x3a0
>  #define CSR_PMPCFG1         0x3a1
> @@ -313,17 +333,6 @@
>  #define CSR_MHPMCOUNTER30H  0xb9e
>  #define CSR_MHPMCOUNTER31H  0xb9f
>
> -/* Legacy Hypervisor Trap Setup (priv v1.9.1) */
> -#define CSR_HIE             0x204
> -#define CSR_HTVEC           0x205
> -
> -/* Legacy Hypervisor Trap Handling (priv v1.9.1) */
> -#define CSR_HSCRATCH        0x240
> -#define CSR_HEPC            0x241
> -#define CSR_HCAUSE          0x242
> -#define CSR_HBADADDR        0x243
> -#define CSR_HIP             0x244
> -
>  /* Legacy Machine Protection and Translation (priv v1.9.1) */
>  #define CSR_MBASE           0x380
>  #define CSR_MBOUND          0x381
> @@ -400,7 +409,6 @@
>
>  /* hstatus CSR bits */
>  #define HSTATUS_SPRV         0x00000001
> -#define HSTATUS_STL          0x00000040
>  #define HSTATUS_SPV          0x00000080
>  #define HSTATUS_SP2P         0x00000100
>  #define HSTATUS_SP2V         0x00000200
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 1a7947e019..6d606f0d90 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -130,6 +130,8 @@ static int csr_register_map[] = {
>      CSR_MCAUSE,
>      CSR_MTVAL,
>      CSR_MIP,
> +    CSR_MTINST,
> +    CSR_MTVAL2,
>      CSR_PMPCFG0,
>      CSR_PMPCFG1,
>      CSR_PMPCFG2,
> @@ -252,12 +254,11 @@ static int csr_register_map[] = {
>      CSR_HEDELEG,
>      CSR_HIDELEG,
>      CSR_HIE,
> -    CSR_HTVEC,
> -    CSR_HSCRATCH,
> -    CSR_HEPC,
> -    CSR_HCAUSE,
> -    CSR_HBADADDR,
> +    CSR_HCOUNTEREN,
> +    CSR_HTVAL,
>      CSR_HIP,
> +    CSR_HTINST,
> +    CSR_HGATP,
>      CSR_MBASE,
>      CSR_MBOUND,
>      CSR_MIBASE,

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

