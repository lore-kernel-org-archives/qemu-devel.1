Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB35C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0014325855
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQR/+oXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0014325855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52473 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWJLW-0008Cm-9p
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 07:35:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWJKY-0007ko-1x
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWJKX-0002Wr-4S
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:34:46 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWJKW-0002To-Tc
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:34:45 -0400
Received: by mail-oi1-x244.google.com with SMTP id t187so4629883oie.10
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 04:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=AQQweUR61HlqBxToyidtRoqbK7HpyTAc26D60BK/KNM=;
	b=mQR/+oXGrmQn0rrzLOYrA0tF6jYJflsEZJvhyPlX8fqzoZZpBpwpl/PqfP68a7fd5F
	twVCqqeZfVm5K1Yc0rpzUnYE/nUFf67ZN+eAY8amvKYzcqdIapdhQf/RT+6/hKv4BPFm
	9qJKt3cpiq3HZNmYWmVtCwhLc2sCgFiFs2pbf5JU9bzOqvHEEDlFzF4PfURwZI1VtUDG
	Z1H57fekXyi7WF8m9/tyl5bqXruqEPhQEU+jgpgaL96fIft2qo/onixvUT/gw9F8yoBg
	9KP4/pPGjztfOUQJNVlQnT8BFUuaqY6MdB4j8NdO91XEeaNbmIiC6olSMoH3Ze4g+fu2
	F96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=AQQweUR61HlqBxToyidtRoqbK7HpyTAc26D60BK/KNM=;
	b=ZOQiEJYw5AwUKh/RlBtjeGO8Axi/r3SkjXvioKgLI/H9szU5+XUIvv1WeuTe6hM8A0
	y+Ok9XDRkjA6eCs+w+A04wJzlK+cvovQMcsgpztgdZqC+D1WLLCK8gqCDSTgcDZBwdap
	WDKnfUpEXSjtbN/pFwfXHkxyoxivUZX+vC2HafcjENY7kiiMQQrqASqtCPW2OdbqJWcp
	f9iF7eU5c6pgwGwXfLgPEhabC1TMKWIuwSa0euQY3uv737clvry9B0zmS3Bp/WEluJUi
	hnXYp6qdltNjrUNJFLxwQN+njRtVKe+BnMw4rJsWRIt+SvtQOdWJrKnlgll71SuldEPI
	csfw==
X-Gm-Message-State: APjAAAViYdXeVIcAOL4fUIKkLpGEAU0CsbuIN2fvD1I7A6/sNz3gipCw
	n2AQgPc0EM/jVG6NjwRoZXqnQCmwiJlqNC3kgGEr0g==
X-Google-Smtp-Source: APXvYqySyrh1aQ8SZPPPiGXNcOAd7j26H51wFDWhJVReMnwJDoWMEu3SWxlvJWVl4XgmcUw+EnSVb7LGU1X2mPdwqow=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr2186236oif.98.1559216083834; 
	Thu, 30 May 2019 04:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190528094953.14898-1-alex.bennee@linaro.org>
	<20190528094953.14898-7-alex.bennee@linaro.org>
In-Reply-To: <20190528094953.14898-7-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2019 12:34:32 +0100
Message-ID: <CAFEAcA8Azc9g7MfWE1_WbRQCMejHXpE62bYojRw+B9maAX=+hQ@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PULL 06/28] target/arm: use the common interface
 for WRITE0/WRITEC in arm-semi
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"open list:ARM" <qemu-arm@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 May 2019 at 10:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Now we have a common semihosting console interface use that for our
> string output. However ARM is currently unique in also supporting
> semihosting for linux-user so we need to replicate the API in
> linux-user. If other architectures gain this support we can move the
> file later.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Hi; Coverity points out an issue in this function (CID 1401700):


> +int qemu_semihosting_console_out(CPUArchState *env, target_ulong addr, i=
nt len)
> +{
> +    void *s =3D lock_user_string(addr);
> +    len =3D write(STDERR_FILENO, s, len ? len : strlen(s));
> +    unlock_user(s, addr, 0);
> +    return len;
> +}

We call lock_user_string(), which can fail and return NULL
if the memory pointed to by addr isn't actually readable.
But we don't check for the error, so we can pass a NULL
pointer to write().

Also it looks a bit dodgy that we are passed in a
specific length value but we then go and look at the length
of the string, but we trust the specific length value over
the length of the string. If len is larger than the real
length of the string (including terminating NUL) then the
write() will read off the end of the string.

thanks
-- PMM

