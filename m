Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EE6C49ED6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C18F2084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C18F2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7g3C-0001gt-FU
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 09:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7g0a-0008RK-0f
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7g0Y-0006cZ-QA
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:16:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7g0Y-0006cB-K2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:16:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so15461652wrx.10
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 06:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=sv6tDhPr4WFwtN9t14YkhLPoyaBEz7Va5oGN2aKOC3w=;
 b=Pl9E5/YUNcOVlQtSkn+9RpLeI3YdOirpWzcKRR4TIGVU0mcFMpaGPwOIvxgjZtYE4/
 MXuZnEZQhYEcEYZhVtFlvV3/LjgnM/puzD5vvGnZB8OFC2A1n2yRQWbDvBeHti6HaTKN
 QjnTNTPfQjWx563a0mUd2vgMovidpLX0VwFDT0ytYoqkkQYaKctS9t5gfxPVs7TUZxHQ
 kD/m0ReWMtYhNJtRab/a3XP4gQChM4GTDlBdW07Ll4PgZBQOcox7C59d78ZyRHujCMp4
 dklDH3lmcHGr1zeV+cNhQ3Dx9PEB5NPJObcQtvTm/gAJ7zXvwyzE0ZfNMU+PBkW0V/BN
 11IQ==
X-Gm-Message-State: APjAAAWPSZsKn6YIvXwLKZqUJFfl7mv7gwNfCr4Uuk2un1I1xHyIcYpO
 LWZ+z/QQZJF0xId/d+1Ld4utV2x/kwdakQ==
X-Google-Smtp-Source: APXvYqyHvwc6MbUwBf+AC/8+MthAGyGldETGjW8hg11vBWN/qPaHGqgqweSZ/TjBerCiZNHTl/UmGQ==
X-Received: by 2002:adf:cc84:: with SMTP id p4mr6720977wrj.201.1568121393109; 
 Tue, 10 Sep 2019 06:16:33 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id d9sm21430637wrf.62.2019.09.10.06.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 06:16:31 -0700 (PDT)
Date: Tue, 10 Sep 2019 06:16:31 -0700 (PDT)
X-Google-Original-Date: Mon, 09 Sep 2019 10:14:10 PDT (-0700)
In-Reply-To: <066a2c520c38b0c175c052d6a3385d5661764833.1566573576.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-a8e09e2d-e0a4-4de5-88f6-d47db22fb1e8@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v4 7/7] target/riscv: Use
 TB_FLAGS_MSTATUS_FS for floating point
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, bmeng.cn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 08:21:25 PDT (-0700), Alistair Francis wrote:
> Use the TB_FLAGS_MSTATUS_FS macro when enabling floating point in the tb
> flags.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index eb7b5b0af3..0347be453b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -301,7 +301,7 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
>  #else
>      *flags = cpu_mmu_index(env, 0);
>      if (riscv_cpu_fp_enabled(env)) {
> -        *flags |= env->mstatus & MSTATUS_FS;
> +        *flags |= TB_FLAGS_MSTATUS_FS;

I thought this was a functional change, but it's not: fp_enabled() checks 
mstatus already.

>      }
>  #endif
>  }

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

