Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD70C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 09:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAEC8218B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 09:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0FKUetq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEC8218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38347 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJDwI-0006vj-1Z
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 05:11:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJDut-0005vH-OU
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJDus-0005Kw-Kz
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:10:11 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hJDus-0005E5-CO
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:10:10 -0400
Received: by mail-ot1-x343.google.com with SMTP id m10so15500911otp.2
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 02:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Fmc2ddR5a0H1Cp8oPdUcD/hOoad/YZdjPUimPq9/mp8=;
	b=V0FKUetqCamSo54XKydWwWh3MhfyJgCRi5VAmDy8hXyZ7jbXgbkRynH09gwcyc93Gg
	FtzyKBWsy8+pHBvJBiOTLLNntsANUwc+RVlXILeIHzobGsgVNxMzSzn+1p/VTi+WKFuo
	FgfjLYXl2OlJcSaapsLGzAiEh9meBRiycRd6mO0m8VxAbwaposYAqBXydUsgTy63MOHW
	bwpWu0dKHo1p5tTxYXiNXupCkepmiqTn7H1FGIwSDaCGag0ehOb2LZYJ6hBENzmuE6ya
	ApvbA1GnT3EkVzE101R9HMcOQfyvbs4fzJPc2jlTAgp9iZxfOAwY/KvrfB1EyemKVInr
	SeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Fmc2ddR5a0H1Cp8oPdUcD/hOoad/YZdjPUimPq9/mp8=;
	b=jGcPV61qmbpu1A/YfiEJar83f3FbeNi3uQIho8sSeM+MINCyBqEZsmuStNrUkQAkbU
	E+5suHtMYL8TmlNFArV6AieoOBUVqvzBzYv6yxqcsR9yfWn2kdNOxT6rcfg8Gmzb3t2l
	1sO405Mqbz06larnmMW+PnoIWC9KxVvgL5l7Im5ZlBMM7RCDF07kTc/SetyucyZKJ1JH
	GxZV++QytIZ170RQkwwfIPHol122Od4KonmkYLdM3HbfIEOZb67gwWWG1sy2AkR+7OQV
	Gh07RNw9gTZuxNMeHz943qi5s3rpkI6XzcY0qTDa6gyuK/B7LGEAf6k8zSUUPbj58Xb6
	e1IA==
X-Gm-Message-State: APjAAAX9HzynLPloldjdvUW97O1y0S9uFCkzESSJf4BrRaeimfW3b+aD
	ov0JxkrT+GSoTprPr9sR0oSmuysC1z2ugov2AVbNeg==
X-Google-Smtp-Source: APXvYqzS0ajw9TOjIp3DhkhTL98MoZKcVgtgw5VrLdZIhUJRFMezrGdSUvmyB2COKPqGgJbtjBRPPUb8gDnCbaP9ggU=
X-Received: by 2002:a9d:67:: with SMTP id 94mr18971493ota.238.1556097008234;
	Wed, 24 Apr 2019 02:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190423222005.246981-1-ek@google.com>
In-Reply-To: <20190423222005.246981-1-ek@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Apr 2019 10:09:56 +0100
Message-ID:
 <CAFEAcA_C4BQgYmZrzFZ_bwWVWcfcV1NF_PWp1wHsvqB9iPu0kQ@mail.gmail.com>
To: Erik Kline <ek@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH] The ioctl(SIOCGIFNAME) call requires a
 struct ifreq.
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
Cc: ek@loon.com, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424090956.LirnqbcSRM58zP_SdCtHAyUTitSMiEX9IxqIVHednCg@z>

On Tue, 23 Apr 2019 at 23:28, Erik Kline via Qemu-devel
<qemu-devel@nongnu.org> wrote:
>
> Signed-off-by: Erik Kline <ek@google.com>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1814352
> ---
>  linux-user/ioctls.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index ae8951625f..37501f575c 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -178,7 +178,7 @@
>  #endif /* CONFIG_USBFS */
>
>    IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
> -  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(TYPE_INT))
> +  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
>    IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
>    IOCTL(SIOCSIFFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
>    IOCTL(SIOCGIFADDR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
> --
> 2.21.0.593.g511ec345e18-goog
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

