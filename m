Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18582C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 23:08:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D821B2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 23:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D821B2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxJQa-0004E9-1X
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 19:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57725)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hxJQC-0003o4-AX
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 19:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hxJQB-0006nA-80
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 19:08:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hxJQB-0006ml-2v
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 19:08:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so50461110pfo.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 16:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=CEVg8P/y/l75HYO+60lvfORIzDf3u4MzaH+NYW8MspE=;
 b=AX6Kb+Z4xdOka/hxI7iOkqG32+8CfO3kRieSbMyVXeWepftEkqwDoPaKlZ09bjZRxu
 GtyojQxCA3SIO4Hi4n892mWZ16DOGS2W15OrScF0es5zRYlBfiHeoq0E0WOL14aIGvg3
 mclkWBi/Y4Ggyr1rOqLnOOV44gdkqJk2wa8NqMQEUUm1P/Qm9mqy2DdFHJLDhS4RK3Nl
 7HB7bXKlOz5vtucgyXqiiYWi4M/NnFAk9Kt7T/9eFkYdLvSc3aclIk82dPGC/4WebRnF
 PQcZmVr+eAIVpqj5etL+v0Hxn8F6XjPPgTPF/tbuQF/HeS45yMa4XibAyvGFYyNC7PS+
 y2lw==
X-Gm-Message-State: APjAAAUM0fEP1+qhQd1/mJQjwetI7lTvBgnm/77gPnjFaCtDXudxtbKe
 yk7ZT11iWHSSLr55GrNlHbtQTCbUbBc=
X-Google-Smtp-Source: APXvYqxz2C4HuF7ebCtXTTfXmwP3ut48yCC011DyS/9wDVjSdRpL6zbi27G4aENOHUZnaM7KRwcEiA==
X-Received: by 2002:a63:66c5:: with SMTP id
 a188mr31986453pgc.127.1565651289390; 
 Mon, 12 Aug 2019 16:08:09 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id q126sm68632894pfb.56.2019.08.12.16.08.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 12 Aug 2019 16:08:08 -0700 (PDT)
Date: Mon, 12 Aug 2019 16:08:08 -0700 (PDT)
X-Google-Original-Date: Mon, 12 Aug 2019 16:07:47 PDT (-0700)
In-Reply-To: <4dad98dcc3b6a3f3a5097922494b0521c60570c7.1564529681.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-41c1b372-8997-4180-b5d1-61625070690b@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.193
Subject: Re: [Qemu-devel] [PATCH-4.2 v2 5/5] target/riscv: Fix Floating
 Point register names
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 16:35:34 PDT (-0700), Alistair Francis wrote:
> From: Atish Patra <atish.patra@wdc.com>
>
> As per the RISC-V spec, Floating Point registers are named as f0..f31
> so lets fix the register names accordingly.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f8d07bd20a..af1e9b7690 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -40,10 +40,10 @@ const char * const riscv_int_regnames[] = {
>  };
>
>  const char * const riscv_fpr_regnames[] = {
> -  "ft0", "ft1", "ft2",  "ft3",  "ft4", "ft5", "ft6",  "ft7",
> -  "fs0", "fs1", "fa0",  "fa1",  "fa2", "fa3", "fa4",  "fa5",
> -  "fa6", "fa7", "fs2",  "fs3",  "fs4", "fs5", "fs6",  "fs7",
> -  "fs8", "fs9", "fs10", "fs11", "ft8", "ft9", "ft10", "ft11"
> +  "f0", "f1", "f2",  "f3",  "f4", "f5", "f6", "f7",
> +  "f8", "f9", "f10",  "f11",  "f12", "f13", "f14", "f15",
> +  "f16", "f17", "f18",  "f19",  "f20", "f21", "f22", "f23",
> +  "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31"
>  };
>
>  const char * const riscv_excp_names[] = {

I actually don't think this one is right: riscv_int_regnames uses the ABI 
names, so this should match.  I'd be OK switching both of them, but not just 
one.

I've queued the other four patches.

