Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FBAC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297052075E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SYISy6pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297052075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37391 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLswj-000362-5H
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 13:23:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hLsvL-0002WW-MN
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hLsvJ-00050Q-OC
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:21:39 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hLsvH-0004sV-8u
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:21:37 -0400
Received: by mail-pl1-x641.google.com with SMTP id a59so1093091pla.5
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
	h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
	:content-transfer-encoding;
	bh=awUbgiBwCOuo5v2kLAF55+iiqa/t6gk717cmEDo7Rek=;
	b=SYISy6pf43QjNYvygg6ngkS5aNZ8yh9CchAcOaha7n+OdMeY6+7XS+/2r7mov9LGnb
	XL7qMhTHHfrSowtLSDl6OXvXGVKLacOfhfsWZ2f5TD5uyb+X3p2muSvkILbtPidguVnZ
	lFzrRpL+NcON3uSNZIW6YwdaumOyA56P/kH/dYhY/9C22J7CGush439m4eC0xsdfiUAB
	jxk3DR433p2YqlHqWQnIbrQbCDCkD1H4N6lhm6o7jqQUAHdbZyN6HCc4Or4qLXhQ9e7V
	lnCof2a3ZBLRCanYRgK/wXRDNJH8oEXXelaBUgO+2Ds5Hf/+Iujy5+RuFDPyl26T5XPh
	gc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=awUbgiBwCOuo5v2kLAF55+iiqa/t6gk717cmEDo7Rek=;
	b=aXJv3z9S0lBshGQRqv5Z1dlsDtsvMw/k/F7Ld+S+Nvkbh/PMydBWxxhjLXi+WuAtfJ
	PIBzT/QA3zLjzJhVXiZ8DIRwRQULypO+8XzrkJEQqzod1wHcKmyLSaJ60aiKHN8NKnm9
	Ck0GQGBNdU3X27zOh0LxI4PfGJRjguT/wTabyZarmwpEzwX1obKCwgAYMvPdTMSpzo9a
	AuNQnRB19z7GnF5H6ZOtryujeB+7ye542ySm0XhUN/CZcmc8pOZ/GQGLYr7NUEv7xRI+
	7qys6y5LR3iaDZU/QAqAc0USxVksqdXvOSH6088jTHnPB/99nY0FtrYyB53cfVOiOUzQ
	oBeg==
X-Gm-Message-State: APjAAAXmGRCnzmdtfszif6ZgLw2qCgevcAgGW72lsRaILWCs0fI+C6X3
	/i+1na4Lb0VU41Dv+59zGcgdatX2OOM0qw==
X-Google-Smtp-Source: APXvYqxDaxeCcgaqNIaeMbwN+uskvs5bFUEkeFdaoEssT4FjUrrwfXS3r7vtSa0DtEwZEQCADCVSMA==
X-Received: by 2002:a17:902:7b97:: with SMTP id
	w23mr71090313pll.335.1556731292344; 
	Wed, 01 May 2019 10:21:32 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	p20sm51021653pgj.86.2019.05.01.10.21.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 10:21:31 -0700 (PDT)
Date: Wed, 01 May 2019 10:21:31 -0700 (PDT)
X-Google-Original-Date: Wed, 01 May 2019 10:21:08 PDT (-0700)
In-Reply-To: <20190425172636.11128-2-richard.henderson@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: richard.henderson@linaro.org
Message-ID: <mhng-6fa8c1f8-fe4c-4d72-b0ea-c9809704637e@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501172131.BwaoU4Vzf0Pb-1Y25wW7ynobVH5bZSlt5zD2wNNNCCw@z>

On Thu, 25 Apr 2019 10:26:35 PDT (-0700), richard.henderson@linaro.org wrote:
> ---
>  target/riscv/translate.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
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

I've attemeted to fixup the patch on my for-master, let me know if I've screwed
something up!

