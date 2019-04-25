Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4039BC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826722088F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CqA8UpBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826722088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60013 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJgtL-00028w-A6
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:06:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJgrR-0000sU-Mb
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJgrO-0002Kx-OL
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:33 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hJgrK-0002Aj-Pw
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:28 -0400
Received: by mail-pl1-x641.google.com with SMTP id x15so10859pln.9
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
	h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
	:content-transfer-encoding;
	bh=hbMQ4FSCnBHERd/qG1GdGJuyGJ/ZShaDwSzsRdmQTiQ=;
	b=CqA8UpBbjWnuH44g2YHPzKYVPgrybZaxWUPxtOCpmO69nL45pUUfIw2TwC/+9PDCAx
	DPT1G7uRjCME2FIp5070wwh5PXLa/e62zvvGH9aqrR6EMap+VLZdtb2EkpdDiGBrHYci
	mvMvUqLscelog88jCxBsZnxVc7fZLohymn+rYVKINX+cgiBeuCPIJrIlnsFVORZPIXiG
	lDyiOetPvO4zGLwVhxCC7C8fKn9PvwiMq0/3aIUrrcZPsX0S3Io9yWEw+nxbcUgd1jLR
	BdzlAiwN8UoWd5364ySkth7Ga+UfKHGyR9I5Ely0OTSb/W7ETTgMdhzXDmHpKilOPLVe
	tllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=hbMQ4FSCnBHERd/qG1GdGJuyGJ/ZShaDwSzsRdmQTiQ=;
	b=G+b7d5Hm0NfaEl52gjXRcFOVdjTvOHE3U4Of5ST2hyJhd7HoWPdLD0pUPuk+Xvu5sW
	Rpy/y57SFIEzmAkkb15MZjUveYnmxwgRlYXeBb0QGS4equoatSSFsxra2Gf3kXx8J2b9
	J7+SrsyBa81pnnwGbo3FIlUFZGqCL9bwhOAeyov4rVxdipTS+9IukDRlmBRpYhMmzQMM
	BBXt0RqxyqxvIsmUCWMTErcMS3W/sYazgsdeomM2BmdeMjTkkkPx2xi5u/EsGhmxS6Ij
	xmQ1K66R7LCEHRgqvrakpKk/4NmZYdt1IsM+f44yZutsGY5FY+LoGimhgzLjMmU7pB6N
	CEsA==
X-Gm-Message-State: APjAAAWVpikaIQmf57KVm82ZiIv3ZfYaTz/W6/vRsoHMAEXWnU9W5sGb
	Ry2Jm6urPoUKR8Y6C3DLdUoM5o69N+w=
X-Google-Smtp-Source: APXvYqyW/myEZ/iKAutmmOeKPlPAkiRbLSlIJjwPjbG+ZMwKurqL3URMtgR12nSe535njgFx1qUf1Q==
X-Received: by 2002:a17:902:bd4b:: with SMTP id
	b11mr39673495plx.68.1556208265104; 
	Thu, 25 Apr 2019 09:04:25 -0700 (PDT)
Received: from localhost ([134.134.139.92]) by smtp.gmail.com with ESMTPSA id
	a10sm29566912pfc.21.2019.04.25.09.04.23
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 09:04:24 -0700 (PDT)
Date: Thu, 25 Apr 2019 09:04:24 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Apr 2019 08:51:08 PDT (-0700)
In-Reply-To: <20190401031155.21293-9-richard.henderson@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: richard.henderson@linaro.org
Message-ID: <mhng-a0bb1fb9-5aa1-4354-8935-43c8b85dec5b@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH for-4.1 8/8] target/riscv: Remove spaces
 from register names
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
Message-ID: <20190425160424.mf3d397G2pdF9sK6-_eWwc2w0EnoIJLAuQXTX40ikiQ@z>

On Sun, 31 Mar 2019 20:11:55 PDT (-0700), richard.henderson@linaro.org wrote:
> These extra spaces make the "-d op" dump look weird.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/cpu.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d61bce6d55..624528efb5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -29,17 +29,17 @@
>  static const char riscv_exts[26] = "IEMAFDQCLBJTPVNSUHKORWXYZG";
>
>  const char * const riscv_int_regnames[] = {
> -  "zero", "ra  ", "sp  ", "gp  ", "tp  ", "t0  ", "t1  ", "t2  ",
> -  "s0  ", "s1  ", "a0  ", "a1  ", "a2  ", "a3  ", "a4  ", "a5  ",
> -  "a6  ", "a7  ", "s2  ", "s3  ", "s4  ", "s5  ", "s6  ", "s7  ",
> -  "s8  ", "s9  ", "s10 ", "s11 ", "t3  ", "t4  ", "t5  ", "t6  "
> +  "zero", "ra", "sp",  "gp",  "tp", "t0", "t1", "t2",
> +  "s0",   "s1", "a0",  "a1",  "a2", "a3", "a4", "a5",
> +  "a6",   "a7", "s2",  "s3",  "s4", "s5", "s6", "s7",
> +  "s8",   "s9", "s10", "s11", "t3", "t4", "t5", "t6"
>  };
>
>  const char * const riscv_fpr_regnames[] = {
> -  "ft0 ", "ft1 ", "ft2 ", "ft3 ", "ft4 ", "ft5 ", "ft6 ",  "ft7 ",
> -  "fs0 ", "fs1 ", "fa0 ", "fa1 ", "fa2 ", "fa3 ", "fa4 ",  "fa5 ",
> -  "fa6 ", "fa7 ", "fs2 ", "fs3 ", "fs4 ", "fs5 ", "fs6 ",  "fs7 ",
> -  "fs8 ", "fs9 ", "fs10", "fs11", "ft8 ", "ft9 ", "ft10",  "ft11"
> +  "ft0", "ft1", "ft2",  "ft3",  "ft4", "ft5", "ft6",  "ft7",
> +  "fs0", "fs1", "fa0",  "fa1",  "fa2", "fa3", "fa4",  "fa5",
> +  "fa6", "fa7", "fs2",  "fs3",  "fs4", "fs5", "fs6",  "fs7",
> +  "fs8", "fs9", "fs10", "fs11", "ft8", "ft9", "ft10", "ft11"
>  };
>
>  const char * const riscv_excp_names[] = {

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

