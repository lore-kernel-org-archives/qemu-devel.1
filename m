Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B71C2D0C2
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 18:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D72C20848
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 18:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uR/ux/fy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D72C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in562-0000My-5C
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 13:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1in53i-0005Ru-O7
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 13:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1in53h-0004cH-Pl
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 13:18:58 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1in53h-0004bP-76
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 13:18:57 -0500
Received: by mail-pl1-x642.google.com with SMTP id bd4so18106821plb.8
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 10:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=8/UtJceMs0L0bIvjsUea6PHw4Nfc3N9+FixIAyrOB/0=;
 b=uR/ux/fy8g6rIfxBcWBjvuQlFDjNNo9Y5F7TtZ3/WMMIAgiVUe4TZfU62gKd07wvp+
 bp4JIF/PtA+iZalFN7fHJrxZS9dhUhqzuygcIC3gOgqSFmwJyPRUjpw8NCoUdNlFa0se
 9Y+6tZO052dVfKslRIP/sDDtKlcbDrg1yg+FA3yTXLHC8DaiqdjstHA/mBWiv7qCzxat
 CWH1xPXwiRpkRQU7oqPnyn4kiu3hsNv1CEfnztanpK0LUSCx0vdnBec2obPk/Gx4DacX
 z8FJRUSWjyKjPwOsFPJ9ad4jFQxLHHV/YG9+HbwDZ9hV3gsKStu8cSD9ro8geFX5CUJ0
 fmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=8/UtJceMs0L0bIvjsUea6PHw4Nfc3N9+FixIAyrOB/0=;
 b=eNthoM6gKmnFb+XI2C4XY9kGceONxD6ASGzdoGYc8ak7YnoTuByYxE4jVxbKeu0hz0
 rIwZl3QhOccQLEa825KGCVXTWceOE+qfB/mHlDh0udv+RyJvp+di04B3ot+lHNify5ER
 6q+aB76RkklaTJlmf0dM/fSkx/eDiAYRUAgz3NF34Rfje7nzAcLjxJprX44XqtHEt7vT
 vTWEIWR/27XlarxDpGAs19gJUyNx1eiivHZ338ccUZ1JwqRnU9NKsQiQlxK9H49+8kZf
 suyO0a/dhmIL00o6SjJjcBGQYs8hUy+2z12oBOr6VaV75lbdRnnOh6quKxSMcNVe/FIL
 Hnxw==
X-Gm-Message-State: APjAAAWlSLLUSjj+l6bS/Ik5SWIIDangB7HfEXJH0yslHp5nQ3SivyLG
 3f2xd/mXApRzTCSbIo3YK4mlmUolB/M=
X-Google-Smtp-Source: APXvYqxuvYfnJLqofQZf9RhkEGiiHGicQnAYfChR8NKhvF0s1rZZmNk7QQK8LISDqHff2CzX3nsN7g==
X-Received: by 2002:a17:90a:77c1:: with SMTP id
 e1mr21529172pjs.134.1577989134853; 
 Thu, 02 Jan 2020 10:18:54 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id b42sm12005265pjc.27.2020.01.02.10.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2020 10:18:54 -0800 (PST)
Date: Thu, 02 Jan 2020 10:18:54 -0800 (PST)
X-Google-Original-Date: Thu, 02 Jan 2020 09:58:24 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 01/36] target/riscv: Convert MIP CSR to target_ulong
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <aa8557d53c1f6d3265e2b2c9bc4e127eddb995ea.1575914822.git.alistair.francis@wdc.com>
References: <aa8557d53c1f6d3265e2b2c9bc4e127eddb995ea.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-7890ef29-2f3d-4600-8bd5-5ad839f404a0@palmerdabbelt-glaptop>
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

On Mon, 09 Dec 2019 10:10:43 PST (-0800), Alistair Francis wrote:
> The MIP CSR is a xlen CSR, it was only 32-bits to allow atomic access.
> Now that we don't use atomics for MIP we can change this back to a xlen
> CSR.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 2 +-
>  target/riscv/cpu.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d37861a430..e521ebe2e1 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -224,7 +224,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>  #ifndef CONFIG_USER_ONLY
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
> -    qemu_fprintf(f, " %s 0x%x\n", "mip     ", env->mip);
> +    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ", env->mip);
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mideleg ", env->mideleg);
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "medeleg ", env->medeleg);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index e59343e13c..f889427869 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -121,7 +121,7 @@ struct CPURISCVState {
>      target_ulong mhartid;
>      target_ulong mstatus;
>
> -    uint32_t mip;
> +    target_ulong mip;
>      uint32_t miclaim;
>
>      target_ulong mie;

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

