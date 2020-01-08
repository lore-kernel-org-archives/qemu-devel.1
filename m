Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6274DC33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 00:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 270692070E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 00:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BrQNVZu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270692070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioysD-0002IF-9T
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 19:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1ioyrV-0001qF-U1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1ioyrU-0002nk-Rx
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:06:13 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1ioyrU-0002mH-KY
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:06:12 -0500
Received: by mail-pf1-x443.google.com with SMTP id 2so648847pfg.12
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 16:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=z+in7Qiu0uJOVVZsPIL5WgzbcNDpsMijJxT+AW8sdZM=;
 b=BrQNVZu88EFfymKgzroYyrXsw2TosEf2+zRufJYJKCqgLpdPNKTYkzgG1zU9bLoISD
 1p9F+2m2uXY0kXCz66mWRKvevzY8Et3XKLPKEBNKAyNFxlyVWwnELJSfpA5EhYYbZ5vB
 YtYpLJpASk2aJYnynIgvhLoydJkv4IeksJJqBBUHBhsLSR9wA6Fq73oZuEKJPS6YGNGI
 WLWFeFQfA2vzRJ0xhe4EmAbma80DKQlSCAMbUWOz/fNt+/ZW8J7xt6UiUv4cz+nGGZaf
 AOd3Bj9IacPCGtD7QYsiu6NdlMyMC+4SEI2sP/qlNXckiO5sUJdM03/8E4T0kkfXQz3m
 zgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=z+in7Qiu0uJOVVZsPIL5WgzbcNDpsMijJxT+AW8sdZM=;
 b=IMeDkvmSi3cIVNApEbKwSTj4TsYf4GBg4iADEGXG0tAGEDR6DC/qm9imitcHHIgiNi
 3EcyVUXZ3Rmy3IqioQuBKxeD7gR5Ql7pOSdv5OnRMZqRc+/stPgOYQPTLrLjehZIXLha
 0wbgzgyf6pWpXm1LqNo6tuCykJGnitv9gtOPihAFa3CpS16k+cGBDQeJs/F6Na4DqUlC
 o++GiaGmgfHQVeASNj3aldxH3K7gOwKuskzXPBc9sEN+v1jQIDfrNvW3qIRUliKsuLXS
 QCm9+0hmvitECtV0+hhFRm64kFTwZrMlqNyMDeyqc4QcMpuFS/ccjseW3vUDzKYW7upH
 tvew==
X-Gm-Message-State: APjAAAUDSt6P95sH8xlZe77Ln3klHUypgH4Z3BVBO907I21VMGWZliml
 rvOfHmYBoTVoJMLvymonwlCxC9xDFRQ=
X-Google-Smtp-Source: APXvYqx+1ovn6xo4uVYCkbhllZpCoqrzAy2ljQI00lVFpWWjLRMWfHvTe+3fYRFsvf/Dfa6jRFu80g==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr2069468pfh.92.1578441971106; 
 Tue, 07 Jan 2020 16:06:11 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id a16sm912684pgb.5.2020.01.07.16.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 16:06:10 -0800 (PST)
Date: Tue, 07 Jan 2020 16:06:10 -0800 (PST)
X-Google-Original-Date: Tue, 07 Jan 2020 16:06:08 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 09/36] target/riscv: Fix CSR perm checking for HS mode
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <72b377cf058f6d159a40301b6880f017404ef9cd.1575914822.git.alistair.francis@wdc.com>
References: <72b377cf058f6d159a40301b6880f017404ef9cd.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-304917e2-e6ff-4bca-8479-d71b5c13aff6@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

On Mon, 09 Dec 2019 10:11:04 PST (-0800), Alistair Francis wrote:
> Update the CSR permission checking to work correctly when we are in
> HS-mode.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/csr.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 6a0a59edfd..eebfc1823d 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -802,12 +802,22 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
>
>      /* check privileges and return -1 if check fails */
>  #if !defined(CONFIG_USER_ONLY)
> -    int csr_priv = get_field(csrno, 0x300);
> +    int effective_priv = env->priv;
>      int read_only = get_field(csrno, 0xC00) == 3;
> -    if ((!env->debugger) && (env->priv < csr_priv)) {
> -        return -1;
> +
> +    if (riscv_has_ext(env, RVH) &&
> +        env->priv == PRV_S &&
> +        !riscv_cpu_virt_enabled(env)) {
> +        /*
> +         * We are in S mode without virtualisation, therefore we are in HS Mode.
> +         * Add 1 to the effective privledge level to allow us to access the
> +         * Hypervisor CSRs.
> +         */
> +        effective_priv++;
>      }
> -    if (write_mask && read_only) {
> +
> +    if ((write_mask && read_only) ||
> +        (!env->debugger && (effective_priv < get_field(csrno, 0x300)))) {
>          return -1;
>      }
>  #endif

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

