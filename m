Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF928C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 03:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72471214AE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 03:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Pmb0L2u2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72471214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50592 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJV8B-0004TF-NQ
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 23:33:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJV6n-0003v7-42
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJV6m-0008QY-04
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:31:37 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hJV6l-0008OM-N1
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:31:35 -0400
Received: by mail-pf1-x443.google.com with SMTP id z5so10394019pfn.3
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 20:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
	h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
	:content-transfer-encoding;
	bh=j1bdBX9DR+a2UlKdjzSodQr+4tFLxRnCT8oGf6airtM=;
	b=Pmb0L2u2Ffhb3Hm5XnqnV20SVMdfuviL3+Ec1svlyuoYZxoIV0oRgEoUbO8OzJakUk
	ApRaLYBiwySYuFEvTV4hSlPMhXkRJZRVh5FFVEYj1lqIkesg97NOTTot4LqLoJoLWlOO
	JQ70Sv+jWbTnDEC2e+cKbEStY+j2DwUlxXRklrJaQFiqP3M3Bsl6NTRiIIOFgUWfkWfG
	Yagjk9bZ4j6bSOjQQAoRyjCpW4lXYrnwvIiDpHwYV3yqF3tcBTXv5Iwq7m5T+Xx0z460
	ATE3w2wQLZipnojTGQ2jfJyJZk2EgPEWGO+AS87eGXwj4A7xyYQXVwFG7xspMaj6oZVG
	uFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=j1bdBX9DR+a2UlKdjzSodQr+4tFLxRnCT8oGf6airtM=;
	b=WLzxIm8CXRf3DpHgplyhRwY8pGwfTjG8cvR2F95uzteLSgkn/0ioJeKKWghQ+NYrw0
	J3rdz8fIc9v/gVgbio3AqF1OucsIec8l/p+c+1FKFCGJKCTWa6oCR8+swdtIDJOjROhu
	XboX0QE2+8TyD5arZHo/JO+O6mGiZyOZOZbg8aOA1r9ixQmTdPqM+itTwmN5QyAXOlaj
	lRdC76GXY2KqzhoIUO6Fr1/3LgLMG3YnaVvtNQYZ6oWjYoSdi1dUcVyMr4S+JkE8xeuP
	XQiLJlohsemGTkX6PNgZ+yMGrI1Baw250oQVHr1ey9fOyaCKzTKf1Ck+Ixp9JIe5mhc8
	+lEw==
X-Gm-Message-State: APjAAAXYhmlXua27QTZV3pyvcQ7YuGpsnRTUB8Nzisg/n1X8vUCNdvzU
	eWui9DXaMIq8Cw6++sd0Zs6KnKxFNOzSug==
X-Google-Smtp-Source: APXvYqzpnrVXT/VtZ5K/2gMhHnvPQCP4Y0ak9DIIAlm25HRQBtR9Cz2sY/jyzmEB/nfUni7NffoUUw==
X-Received: by 2002:aa7:83d1:: with SMTP id j17mr37569076pfn.78.1556163093368; 
	Wed, 24 Apr 2019 20:31:33 -0700 (PDT)
Received: from localhost ([67.51.191.132]) by smtp.gmail.com with ESMTPSA id
	b7sm39531840pfj.67.2019.04.24.20.31.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 20:31:32 -0700 (PDT)
Date: Wed, 24 Apr 2019 20:31:32 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Apr 2019 16:39:54 PDT (-0700)
In-Reply-To: <20190401031155.21293-2-richard.henderson@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: richard.henderson@linaro.org
Message-ID: <mhng-4fc40e41-5464-469e-9334-1edc4f8294e3@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH for-4.1 1/8] target/riscv: Name the
 argument sets for all of insn32 formats
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425033132.u1chwhm1PNST_pMrFfLHLNVVli_AJimkpF5__GTUaMo@z>

On Sun, 31 Mar 2019 20:11:48 PDT (-0700), richard.henderson@linaro.org wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/insn32.decode | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 6f3ab7aa52..77f794ed70 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -34,9 +34,13 @@
>  %imm_u    12:s20                 !function=ex_shift_12
>
>  # Argument sets:
> +&empty

If I understand decodetree correctly, this isn't used until patch 5.
Otherwise,

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

I don't care enough about this to make you re-spin the patch set, so I'm OK
taking it as it stands unless there's anything else that crops up as I look
through the rest of the patches...

Thanks!

>  &b    imm rs2 rs1
>  &i    imm rs1 rd
> +&j    imm rd
>  &r    rd rs1 rs2
> +&s    imm rs1 rs2
> +&u    imm rd
>  &shift     shamt rs1 rd
>  &atomic    aq rl rs2 rs1 rd
>
> @@ -44,9 +48,9 @@
>  @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
>  @i       ............    ..... ... ..... ....... &i      imm=%imm_i     %rs1 %rd
>  @b       .......   ..... ..... ... ..... ....... &b      imm=%imm_b %rs2 %rs1
> -@s       .......   ..... ..... ... ..... .......         imm=%imm_s %rs2 %rs1
> -@u       ....................      ..... .......         imm=%imm_u          %rd
> -@j       ....................      ..... .......         imm=%imm_j          %rd
> +@s       .......   ..... ..... ... ..... ....... &s      imm=%imm_s %rs2 %rs1
> +@u       ....................      ..... ....... &u      imm=%imm_u          %rd
> +@j       ....................      ..... ....... &j      imm=%imm_j          %rd
>
>  @sh      ......  ...... .....  ... ..... ....... &shift  shamt=%sh10      %rs1 %rd
>  @csr     ............   .....  ... ..... .......               %csr     %rs1 %rd

