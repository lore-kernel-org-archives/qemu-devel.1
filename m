Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7A0C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 00:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159092173E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 00:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fND2jL3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159092173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi6VM-0000uH-Rm
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 20:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39947)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hi3lT-0000Pi-3V
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hi3Qd-0001SZ-CK
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:01:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hi3Po-00071g-O9; Mon, 01 Jul 2019 17:00:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id u10so9698801lfm.12;
 Mon, 01 Jul 2019 13:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rQl7b5/lYljuXHUAO72puZ1yIfg9PcR17utAbY0/wi8=;
 b=fND2jL3D3U03eJWDiAfZUwjKUM1ZVuA/ezvZPkksaU0IsJUQN6aXH8NnM/K12EpapD
 FsEyee7Bpy9YQKxFcLXjXOwVPuvhbbssf30vI/xMwTfvMQZV/KllU53dQh1qNm7k8tUJ
 +OfyuKidMmgOSwgexILmesvkX8MNsoXXfBd8I3LCjA8eKbPKjmJHsbVKq5cQs2DB+dNN
 vULPtIOppvkkJbwllUQmN/43wrbi2vFnEdRsb/8QKZfzAv1s2p61lLkIB+AuIzwNIm1I
 ILH1fVN5xrPNRkLKOw8WsRTf1+Ot45b8K03mse4lH5UZsoKGmCNMJzsqVuSuemwyYXly
 rIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rQl7b5/lYljuXHUAO72puZ1yIfg9PcR17utAbY0/wi8=;
 b=pwkASSoMZv/toW//RVlzyKbDcVw6AMCsc4+geU3Fk2/5yXeI2QS3lwtf9/T4l59sRn
 Y50ZLf8UyZPDx4xeoJbK9YNCz+aZ31sNbjuzRMgNAB/Td1q0Jgxag6y6UQqTCmbb5kFB
 UeXLwDYnvecPbQDiaoLHacOkYa5OdfC+QFAa9G5dDJDIhszzuCpMm7/GKcF9RBHCvo5x
 ZpGCDNjTz2gS8POEX1qsgD3fRqj3RVP5p9VHaV3zM7OtG78mnTEO5w1xxGZqBbW6Eity
 aimeFSdCQ66xUP8nzvJW8xLHyhjBvQTihLmOOJ7AQakXYDWbgew2qnQkqSCMbc+c3zwx
 OWNQ==
X-Gm-Message-State: APjAAAWPyhjZy3GqP0wy0dZm+J4CAGiFOSaEZCg3JFCfHv24Gl3DJWGr
 ji8no2jv8Z4elllpDKQsTTXMneRZ32oVTnJgAlw=
X-Google-Smtp-Source: APXvYqy3xjMhfwhgmYtRnpNYzZDkiaICxg+D7t1jvHI1peL/2vaAcQ+WVzK3i7gSnoJETX/Rhu8xD6OmoDZxFqSGUcI=
X-Received: by 2002:a19:4c05:: with SMTP id z5mr12433731lfa.5.1562014674062;
 Mon, 01 Jul 2019 13:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190701154617.22908-1-jonathan@fintelia.io>
In-Reply-To: <20190701154617.22908-1-jonathan@fintelia.io>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 1 Jul 2019 13:54:52 -0700
Message-ID: <CAKmqyKOsMO7SvvDfiqhywxb=oaqo=NDjw==reVpU9sLh+3dGuw@mail.gmail.com>
To: Jonathan Behrens <jonathan@fintelia.io>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.67
Subject: Re: [Qemu-devel] [PATCH v2] target/riscv: Hardwire mcounter.TM and
 upper bits of [m|s]counteren
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
 Palmer Dabbelt <palmer@sifive.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 1, 2019 at 8:56 AM <jonathan@fintelia.io> wrote:
>
> From: Jonathan Behrens <jonathan@fintelia.io>
>
> QEMU currently always triggers an illegal instruction exception when
> code attempts to read the time CSR. This is valid behavor, but only if
> the TM bit in mcounteren is hardwired to zero. This change also
> corrects mcounteren and scounteren CSRs to be 32-bits on both 32-bit
> and 64-bit targets.
>
> Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h      | 4 ++--
>  target/riscv/cpu_bits.h | 5 +++++
>  target/riscv/csr.c      | 2 +-
>  3 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 0adb307f32..2d0cbe9c78 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -151,8 +151,8 @@ struct CPURISCVState {
>      target_ulong mcause;
>      target_ulong mtval;  /* since: priv-1.10.0 */
>
> -    target_ulong scounteren;
> -    target_ulong mcounteren;
> +    uint32_t scounteren;
> +    uint32_t mcounteren;
>
>      target_ulong sscratch;
>      target_ulong mscratch;
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 11f971ad5d..0ea1e1caf5 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -532,4 +532,9 @@
>  #define SIP_STIP                           MIP_STIP
>  #define SIP_SEIP                           MIP_SEIP
>
> +/* mcounteren CSR bits */
> +#define MCOUNTEREN_CY                      0x1
> +#define MCOUNTEREN_TM                      0x2
> +#define MCOUNTEREN_IR                      0x4
> +
>  #endif
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index e0d4586760..8425a6d2bd 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -473,7 +473,7 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
>      if (env->priv_ver < PRIV_VERSION_1_10_0) {
>          return -1;
>      }
> -    env->mcounteren = val;
> +    env->mcounteren = val & ~MCOUNTEREN_TM;
>      return 0;
>  }
>
> --
> 2.22.0
>

