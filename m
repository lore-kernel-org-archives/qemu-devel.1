Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B851DC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 20:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43AE206A3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 20:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELQwndSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43AE206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34783 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJl6X-0000HY-PS
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 16:36:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hJl4V-0006pT-Tq
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hJkrE-0000A7-Ik
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:20:37 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hJkrE-00007d-9B
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:20:36 -0400
Received: by mail-lj1-x243.google.com with SMTP id q10so813437ljc.6
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 13:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=h+gW3PDLQnZ2I0cKY7nhPoMPcw6puJKOiHTL3OaZNS4=;
	b=ELQwndSDvyN3S04VfriP7yfKE/JNiwatdHWBbvaCeqx0LygsxjNC/4y3js0Je7KPYp
	A/yvu6nHvzk2TN4mewhmmICfF7MwCFtqVxO8O60PT7N3rK/2bhM0HcKNglt3aaRAWmsv
	TE3yAL5jtp/jhzxyezdOz7cxub/9navRMKDrkqpBpcJW/WcpFIHRwokh8cDV6yiJ1bDG
	5cHOsOI20ogFPONoGwTkzFQjvtq7i48LaabQVfCIjCs64YCrvRuuw8bpdsiwhNo/VzMs
	/oYhnrzr/RrTuV2ASDG/Ci3DIwXQ4PunClKdhA919Nr2C7yKqXjXACJD/5x5/juRMnZg
	fyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=h+gW3PDLQnZ2I0cKY7nhPoMPcw6puJKOiHTL3OaZNS4=;
	b=StJYtfK+cR4Oc+Abvxh9An9oS3ntF5song5aG8Bb2eNY+Dou9VoFNFG4G7TscX+I89
	+p4G281gihbpQXc9rwbhTYPi9eFWUomXYO88TYDBQEJ3tOtBfjxuCuCmzTVbHzlDjJth
	fyfAP6JSn3532ynAoxgKZz6AskSozEHOvPqh1ezD6Ecn69R6zCS5GnYh4TlhnZmhlgwC
	DhYkCisbDE83/Nx55CyGqJbsIfeh1Nc30iHRDB6v27Yoe/I3qyr4FdZKaJIpWBwqNchs
	tljPwOCTW6PyIYx72CVr8k9X/RULbz8dvY/m4VhPq+zjXfRwN9jD3hCJYLVRuxtlLD5E
	7C0g==
X-Gm-Message-State: APjAAAXe7B/AqjhEAzWjR8t/CDtBUMODB2a3a2820Rau5+yIUTlFkbYn
	YbMmdVocRkarsQgIaJf0w1qpkc9DGY2BGANpcpQ=
X-Google-Smtp-Source: APXvYqz/lUGgiTI+twp+/nVgRTXfBj6RqPbxOYFF2fOeb3WsMmr9S76DWIongJbkQwaPLeeJ2883R4kZVPB/qePlXpA=
X-Received: by 2002:a2e:864f:: with SMTP id i15mr20165549ljj.99.1556223634498; 
	Thu, 25 Apr 2019 13:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190425172636.11128-1-richard.henderson@linaro.org>
	<20190425172636.11128-2-richard.henderson@linaro.org>
In-Reply-To: <20190425172636.11128-2-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 25 Apr 2019 13:18:44 -0700
Message-ID:
 <CAKmqyKObPbN9P_o7rwsd9=7mW+eohAt_cJrGC_gJwf8jmCfWyg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH 1/2] fixup! target/riscv: Name the argument
 sets for all of insn32 formats
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425201844.1J0q0-tFRQrr0ps8nJMcRA_pZiS7cL1CxDmAYXq5Oy4@z>

On Thu, Apr 25, 2019 at 10:28 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> ---
>  target/riscv/translate.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Not sure how this will work with a fixup, but still:
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index d1f599a92d..009c146e8f 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -713,12 +713,19 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
>   * initially declared by the 32-bit decoder, which results in duplicate
>   * declaration warnings.  Suppress them.
>   */
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wredundant-decls"
> +#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
> +# pragma GCC diagnostic push
> +# pragma GCC diagnostic ignored "-Wredundant-decls"
> +# ifdef __clang__
> +#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
> +# endif
> +#endif
>
>  #include "decode_insn16.inc.c"
>
> -#pragma GCC diagnostic pop
> +#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
> +# pragma GCC diagnostic pop
> +#endif
>
>  static void decode_opc(DisasContext *ctx)
>  {
> --
> 2.17.1
>
>

