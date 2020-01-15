Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C60DC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 06:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E8A2467C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 06:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbTTAeVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E8A2467C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ircBk-0006P2-IL
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 01:30:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1ircB6-0005x6-Jw
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1ircB5-0001C4-Fs
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:29:20 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:44709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1ircB3-00019q-6U; Wed, 15 Jan 2020 01:29:17 -0500
Received: by mail-lj1-x244.google.com with SMTP id u71so17154347lje.11;
 Tue, 14 Jan 2020 22:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aPYlWvR1kMSzcynGgqr+LzY4iTJnzV+PHkEXXyNR5aI=;
 b=TbTTAeVbZwLPGeJUMwvMlip+qLgmcm83NnKJyHyG7JgyljQc6yjuD/d5f8zupPp2On
 E9sn05AhCKFmCDzmdcXIuJCDxGqzfKPz+rYjJH6JYYjhrmLYcSmVJy/EDbGhahEmnxlP
 Jpef5bXSKXvHplhwDJ5CYXlYg3EgglGCGLD2PpjCn3/FTXMqFMqK3YhkrouvX7m5ObFu
 Y5BNkZ1LrQ1A8wER56jAwsfk+4+zW6slhWVS+ZPVgnJPho9qcLGu0iBH5LbWzl+Ww44U
 K0hQmGaxarE9CBwX1jFrjD7PgGaF7Gqovs8+pN3vm1t5ny4IFiRi+T92wxRwKDnvLQw/
 21mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aPYlWvR1kMSzcynGgqr+LzY4iTJnzV+PHkEXXyNR5aI=;
 b=Yk0MeHsPLLj2E1Imnfqm7JyDQn9mV0OQLCAVXojAG/NGz74NS045dY6c5mq7bEPyIP
 GIufZAsaQ2waRkhIJjXYHVPmjVea5bLtnHR1IuRImLXRIAPwK9Y/cMvSVVLGG/6Orczl
 0S5u565nIDgFrdfSHQRdVSdVVAwHV8dVWmQLpQrH4ojPKQHUovIu2KhWV0mW1s7o3PSQ
 YsjGxz5wserNKNcM4dHYnJcVqY17gvrcCLZgiXBxgJw5taHpdDBbrM2tZEJBSkHJ5JOf
 lzQInPiQmfwAi+26H9IxO2CozkHeigOLJn9kLkrOMxz3XnlRhOM2j+V6BdbJQltLccjH
 OC1Q==
X-Gm-Message-State: APjAAAUmyYNqWfuR+53OFYTw4QRDRI0j0OP+zJklqJTGFtIqCJ5MMlN+
 Id0hNPN3gyLSukDrRU25sIfV8vZAw++DPQKi78Q=
X-Google-Smtp-Source: APXvYqxmx9+1vnPdnwcCVPFWBRtzlzCcVjrPd77aEHn+32gyKx+w3fBIhYnQ6z0L4GDUnNZicjJQ8vqRZigvPsxTKvg=
X-Received: by 2002:a2e:461a:: with SMTP id t26mr770648lja.204.1579069755200; 
 Tue, 14 Jan 2020 22:29:15 -0800 (PST)
MIME-Version: 1.0
References: <1579069053-22190-1-git-send-email-shihpo.hung@sifive.com>
In-Reply-To: <1579069053-22190-1-git-send-email-shihpo.hung@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 15 Jan 2020 16:28:48 +1000
Message-ID: <CAKmqyKNeAFRP7eCLtw1b0P53ub3k--+dROpPRynzCwM8DF15ng@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] target/riscv: Fix tb->flags FS status
To: shihpo.hung@sifive.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 4:18 PM <shihpo.hung@sifive.com> wrote:
>
> It was found that running libquantum on riscv-linux qemu produced an
> incorrect result. After investigation, FP registers are not saved
> during context switch due to incorrect mstatus.FS.
>
> In current implementation tb->flags merges all non-disabled state to
> dirty. This means the code in mark_fs_dirty in translate.c that
> handles initial and clean states is unreachable.
>
> This patch fixes it and is successfully tested with:
>   libquantum
>
> Thanks to Richard for pointing out the actual bug.
>
> v3: remove the redundant condition
> v2: root cause FS problem
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/cpu.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index e59343e..de0a8d8 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -293,10 +293,7 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
>  #ifdef CONFIG_USER_ONLY
>      *flags = TB_FLAGS_MSTATUS_FS;
>  #else
> -    *flags = cpu_mmu_index(env, 0);
> -    if (riscv_cpu_fp_enabled(env)) {
> -        *flags |= TB_FLAGS_MSTATUS_FS;
> -    }
> +    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);

I don't think this is right, you should use the riscv_cpu_fp_enabled() function.

Right now it's the same as env->mstatus & MSTATUS_FS but when the
Hypervisor extension goes in riscv_cpu_fp_enabled() will be more
complex.

Alistair

>  #endif
>  }
>
> --
> 2.7.4
>
>

