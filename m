Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B80AC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 06:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB08C24656
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 06:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0eeMYRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB08C24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ircEz-0001Y2-27
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 01:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1ircD0-0007xn-23
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1ircCz-0002VZ-3A
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 01:31:17 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:37319)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1ircCr-0002On-3U; Wed, 15 Jan 2020 01:31:09 -0500
Received: by mail-lj1-x243.google.com with SMTP id o13so17202433ljg.4;
 Tue, 14 Jan 2020 22:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fT4DwVAI/XW7iNya/ESjlANaFxvSSdI9/CPID1PVCf8=;
 b=P0eeMYRkJEyAlW7HdptlfN+hSTvc2SxMZKpY9rY7KNoy6hkpEHK3rTp6w9SUbaTEn2
 iECsLSJJ7gzWOzwYXLthxbgEFRHs1/OYBFl219AEaDiD0NZvUoQj7YH3H0JAtUgP7w9c
 zbne4Ck4mmTGP9X5p71clJ/MIv+6SPjUn65taY90bS9KldAI/cg9UvnAGpUs2vYpOgcT
 htPweawp+R3a3T37nIyGpu27Qp/6aFyEh2gSPEjsWm5ACwIM0ReAtMHtaFCGqr3Q34LF
 8SUjjpHqA7HyD4GHcoiIfqcZUlRQgUwal9sm4MEqKB9LC8oMHrljHmJxFMD1dcAnUILe
 xU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fT4DwVAI/XW7iNya/ESjlANaFxvSSdI9/CPID1PVCf8=;
 b=RjAtJu1sP8xvDi6SD6dlHwAPTOUZwr+WtpiMNlRJ0/A9tD9bf2a5sNw1enVfLNRivR
 QP7qaAWNp1HsbLBGfVFjZClUddutqTtPYW/bTCC4r6fqF/wagA+b+NZgTUr/rcoHmftG
 AKM+wJRFst8rxmnpJ5KAaceviYm2uKc3q1Y73Dx5Eag+VU0luLRXKarnse6M7Ug6Eotb
 LtPsowlWAtLB5hhQwqpEeMnki0KJzPwtIaAQwtUdrASNVfaPwVjxHQPJn9JNa8Uu2Bd4
 lqnbLMfiiGwBekWHgayHNht0p/0o3OBQGqC2iVjPk8vEHvtVN5AkoRuYWsuqZtMza5CH
 9ksQ==
X-Gm-Message-State: APjAAAWf+EwM9p3KXvSzcDTfHCTYX/whC5WUBoI2+b4ZRfYTXwpfLWfq
 vqIpYsSWCWLNNIHAJG+PwlKZ+QnlE4TiRhmNafQ=
X-Google-Smtp-Source: APXvYqysio9N7NP4msiHzlak3JGQ29K2MRiodbD/wLaUNmaBD28PSwPRGt73y9oIc+jw7V9xcTvGFLc7zTd+Yo0CTCk=
X-Received: by 2002:a2e:9157:: with SMTP id q23mr816611ljg.196.1579069866433; 
 Tue, 14 Jan 2020 22:31:06 -0800 (PST)
MIME-Version: 1.0
References: <1579069053-22190-1-git-send-email-shihpo.hung@sifive.com>
 <1579069053-22190-3-git-send-email-shihpo.hung@sifive.com>
In-Reply-To: <1579069053-22190-3-git-send-email-shihpo.hung@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 15 Jan 2020 16:30:40 +1000
Message-ID: <CAKmqyKPuuKXPwPoZ7dWQ9QR0zN2RkcXXCwFhKLV8jVSmX84Oxw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] target/riscv: update mstatus.SD when FS is set
 dirty
To: shihpo.hung@sifive.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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

On Wed, Jan 15, 2020 at 4:19 PM <shihpo.hung@sifive.com> wrote:
>
> remove the check becuase SD bit should summarize FS and XS fields
> unconditionally.
>
> Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c       | 3 +--
>  target/riscv/translate.c | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index da02f9f..0e34c29 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -341,8 +341,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
>
>      mstatus = (mstatus & ~mask) | (val & mask);
>
> -    dirty = (riscv_cpu_fp_enabled(env) &&
> -             ((mstatus & MSTATUS_FS) == MSTATUS_FS)) |
> +    dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
>              ((mstatus & MSTATUS_XS) == MSTATUS_XS);
>      mstatus = set_field(mstatus, MSTATUS_SD, dirty);
>      env->mstatus = mstatus;
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index ab6a891..8e40ed3 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -394,7 +394,7 @@ static void mark_fs_dirty(DisasContext *ctx)
>
>      tmp = tcg_temp_new();
>      tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
> -    tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
> +    tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS | MSTATUS_SD);
>      tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
>      tcg_temp_free(tmp);
>  }
> --
> 2.7.4
>
>

