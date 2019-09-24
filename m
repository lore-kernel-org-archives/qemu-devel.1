Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E8CC432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D1F2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qdvsAEEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D1F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCo8x-0002ET-95
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCn20-0007Zx-RX
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCn1y-0002oz-An
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:47:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53357)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCn1w-0002lW-H8
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:47:10 -0400
Received: by mail-wm1-x341.google.com with SMTP id i16so720818wmd.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rajj7ERgNsJfTJ1XcjplnlEd80wvTLAPfsECKLoJRZw=;
 b=qdvsAEEGc063MfCJqUDYB0mP8Iyqg28x8kRNb5vlaFElVxbpbwltI3Gyux/Oi8VTqQ
 Ho4a0xlNC5z2atnbOASZX8BejyMZqp2866cRNNZ6WR0xIESfw/ZMbjmG/EZf0n9PtdKu
 ZA0HzG+KGf6vXtS8MziYOx8FtKCtHCPJh82WJQFemghK4+sZjP/brZENnRDbaMiJfRaO
 C5joN6BlAsNcZQ9qsIEf8AwLbkFMp6fvFOdDtA3hSAosWJYiQx5/zv9UUHl5dO7JLqyq
 7b6CQHFlQauSZ16iSekk+b96+VFjHr3aJx2sqnM0rsvTCbAkMnt+HSLTRKsmSVJ3aS6o
 jH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rajj7ERgNsJfTJ1XcjplnlEd80wvTLAPfsECKLoJRZw=;
 b=Q3YA5oOziwodYAFyLy4SzLs5CZ1KReqK9PoFXgk0GeASwSiqr3fu5epnch3i8hIPiF
 T6YMgmE6GpVLWiCx0GIbdxcNP/1pc2Eljqg56feg0aA6bZGBCKd4fO1x35A9kM7yUpVj
 LSrmJiz7h+bjEaVOXPNJujdH7b8vPIxbSa5lKRMuzYz1qCh9rhAw+aEcC3g7WSfAfyMd
 2dhFqmoVFE1LliR7Se9ROfAgLOqm83DwyQcVWynfeBmL0y02UTE6jH6sxCM3PUPoi2Wn
 Zo+xusGdoYvxO+emalJgo42K6OCoa2b3G0VqDuhEEDwOubmNvLzhgXtN7jrRGC8mepWI
 Qmqg==
X-Gm-Message-State: APjAAAWttx8RHVTilH+VFRWJ+mVGUUUZOQqiWVmHk2uHZALbG3GH7t9o
 2MC0oGsnRgciaVNORMD1T9usfw==
X-Google-Smtp-Source: APXvYqzx/bKYBerosd8vWClefP5fCPvxu0kaRzOtVi+Macp7rcTpPuR50miX1WYHIccoufu2kpFDZA==
X-Received: by 2002:a1c:4946:: with SMTP id w67mr768135wma.131.1569340022287; 
 Tue, 24 Sep 2019 08:47:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n18sm455079wmi.20.2019.09.24.08.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 08:47:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F337A1FF87;
 Tue, 24 Sep 2019 16:47:00 +0100 (BST)
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-4-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 03/16] qemu/compiler.h: Add optimize_away
In-reply-to: <20190923230004.9231-4-richard.henderson@linaro.org>
Date: Tue, 24 Sep 2019 16:47:00 +0100
Message-ID: <874l11bssr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Use this as a compile-time assert that a particular
> code path is not reachable.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/qemu/compiler.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 20780e722d..6604ccea92 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -221,4 +221,19 @@
>  #define QEMU_GENERIC9(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC8(x=
, __VA_ARGS__))
>  #define QEMU_GENERIC10(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC9(=
x, __VA_ARGS__))
>
> +/**
> + * optimize_away()
> + *
> + * The compiler, during optimization, is expected to prove that a call
> + * to this function cannot be reached and remove it.  If the compiler
> + * supports QEMU_ERROR, this will be reported at compile time; otherwise
> + * this will be reported at link time, due to the missing symbol.
> + */
> +#ifdef __OPTIMIZE__
> +extern void QEMU_NORETURN QEMU_ERROR("code path is reachable")
> +    optimize_away(void);
> +#else
> +#define optimize_away()  g_assert_not_reached()
> +#endif
> +
>  #endif /* COMPILER_H */


--
Alex Benn=C3=A9e

