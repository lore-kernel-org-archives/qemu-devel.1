Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA98C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32AFB2089F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32AFB2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hn1-0000Bq-Aq
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7hRF-0000OT-2B
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7hR9-0006OQ-MF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7hR9-0006Nz-HV
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id w13so20844033wru.7
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=62DKnnZ3R2aQjTeCpvnqwbJlIX89ZfIbEuBSBRs6M78=;
 b=sI848YWPhVw0RqcP+Dhh0rwvu74ulZs/KFBvPDbCaZqL6Q4g1LOau3mw4vw29CQw8P
 0o7p9NkcsfpnOWxq53wWODjs6a+9wozGBnbjEoLrNJ+T5EXqzP4hdOA+uUyj2XQlVQJj
 AbOiAZoA7hGunSLsBChrhxmMk88vYJBRagCBc7XSpjLRXgB2Xp0yD102WN7nKoD94lDA
 2ylpS8n4PN8k4GjoJF1J6tvdSlscpV8LMH5PSrLJI39BYTnHd3Sh/J8g4sCK2VQ7+AxZ
 y+kFMgpe184vNzAeZJhIOdez/2eGlc9dWrSz77b/zigzwuZPVvDQFsloFwYJZJYE/UWj
 8Srw==
X-Gm-Message-State: APjAAAWs+cGNAmerGdu0t8uHUP7qr4370XXRD25Vd7krdmrAp25WzBPV
 dxuQveQeZl6U3Zj1aUTCdlL+FY2VRbVtVA==
X-Google-Smtp-Source: APXvYqweODaLB/2nQGD5iozLW2AcB/NxHwY68xJWogAwgxdAYIyKvBm20JFinAI1KYkXdSnLcd4oqA==
X-Received: by 2002:adf:e986:: with SMTP id h6mr27558802wrm.59.1568126886071; 
 Tue, 10 Sep 2019 07:48:06 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id d193sm5796622wmd.0.2019.09.10.07.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:48:05 -0700 (PDT)
Date: Tue, 10 Sep 2019 07:48:05 -0700 (PDT)
X-Google-Original-Date: Tue, 10 Sep 2019 07:42:56 PDT (-0700)
In-Reply-To: <e959ee81e5121c74678d2383a28665e44db9e31d.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-91f54d04-62bd-44b7-a4ce-d7f3631181c0@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v1 05/28] target/riscv: Add the Hypervisor
 CSRs to CPUState
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

On Fri, 23 Aug 2019 16:38:02 PDT (-0700), Alistair Francis wrote:
> As the MIP CSR is 32-bits to allow atomic_read on 32-bit hosts the vsip
> is 32-bit as well.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 3a95c41428..4c342e7a79 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -154,6 +154,23 @@ struct CPURISCVState {
>      target_ulong mcause;
>      target_ulong mtval;  /* since: priv-1.10.0 */
>
> +    /* Hypervisor CSRs */
> +    target_ulong hstatus;
> +    target_ulong hedeleg;
> +    target_ulong hideleg;
> +    target_ulong hgatp;
> +
> +    /* Virtual CSRs */
> +    target_ulong vsstatus;
> +    uint32_t vsip;
> +    target_ulong vsie;
> +    target_ulong vstvec;
> +    target_ulong vsscratch;
> +    target_ulong vsepc;
> +    target_ulong vscause;
> +    target_ulong vstval;
> +    target_ulong vsatp;
> +
>      target_ulong scounteren;
>      target_ulong mcounteren;

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

