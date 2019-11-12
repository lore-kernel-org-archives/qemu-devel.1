Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA366C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C362196E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fegaXNL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C362196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUZbI-0007gq-Ln
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 12:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUZZa-00063q-30
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:03:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUZZX-0004Sg-14
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:03:20 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40664)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUZZW-0004Ru-Kg
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:03:18 -0500
Received: by mail-oi1-x244.google.com with SMTP id 22so15462206oip.7
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 09:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zj2qDhIY+Fnq6dqr5g8WMbqoi2/FB1bIBoTQLzbXcmI=;
 b=fegaXNL9AVVswiSx7UtFEZvq/1fI2cbzaroA14rb0U3uE+bNiOVy4t4cJy+CJ6dIsf
 BFlDu5TGbwvPjMJAzf31s4lq3kVg9+egM9ClaeXT8TS6rzjjzZLbq96WEhgdxWdxQJSH
 Ohp96j2uUkIxYveJT2zO+hGs9K1cReYRoXLZtTvl7nIxcr8re4hDfPcZP5H6HRaF3RCD
 MIQInHON0Ct6/I59Zo59vSrxWK+9+2AUYXdbY4NJFnxxmrGRplDhBCEiCAfnBqpbtd/U
 HveSKwpt057fU/w6fVYfp4XiwqcutW5ezmNN9Bt4p6eJoqSEESNDsNIwRkc1/MKvdtxg
 1ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zj2qDhIY+Fnq6dqr5g8WMbqoi2/FB1bIBoTQLzbXcmI=;
 b=uEB0sAQo9qfjI4Yv3SRD2AjDvlJtPmuiDmy6snhA3FcXkec1Q6KVkx3siWRY81ZOxV
 vK39pK3VkYN+CVEiLws7v337VBhzprQEdABBF4LGpX6hY2H4QdzeO2PGyF6shuMBnvI0
 EuNyCioiWWsPi5UnthgvkWvvRmuWlkGSvOrWMSWLhzHw0PUVS7uAVCdaf8P58x4KX2SS
 aGypslLtderUa5BdVUWfRMHSb8sNWU7OxUAW6+EA65jsc3IM+5qc99DwxEsHkXiAYrnQ
 o13L4W1kFzy1d821CVPthA7TUzClZTvDeVZglPZV8Pw40IwUibi0nyTNBUkpaRwUIm5Z
 mobA==
X-Gm-Message-State: APjAAAXFBf9yO6tSLCw6e0Y73TXcssbk6wnw5DA3B+HgVKwiZG2pzCnu
 wbF9po1n+ks+z7VKcN/y7zGSXwH5cmxfjtp8cBg7lA==
X-Google-Smtp-Source: APXvYqxFId7RZubqVAnobYGUknYFzaoHDh7rz+Itgve/WLUN2Vme+LzjhsqTtRZA072pooHM/+slQ5AmWamRexH5L+Y=
X-Received: by 2002:aca:451:: with SMTP id 78mr5048176oie.170.1573578197600;
 Tue, 12 Nov 2019 09:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20191112164051.16404-1-alex.bennee@linaro.org>
 <20191112164051.16404-3-alex.bennee@linaro.org>
In-Reply-To: <20191112164051.16404-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Nov 2019 17:03:06 +0000
Message-ID: <CAFEAcA8gjPKU8opRb=oTLmVMRBxoba5W+Of8RkqQZ2nH--Ck5w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] docs/devel: update tcg-plugins.rst with API
 versioning details
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Fam Zheng <fam@euphon.net>, "Daniel P. Berrange" <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 Nov 2019 at 16:41, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/devel/tcg-plugins.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
> index b18fb6729e3..8d619fd44ef 100644
> --- a/docs/devel/tcg-plugins.rst
> +++ b/docs/devel/tcg-plugins.rst
> @@ -25,6 +25,22 @@ process. However the project reserves the right to cha=
nge or break the
>  API should it need to do so. The best way to avoid this is to submit
>  your plugin upstream so they can be updated if/when the API changes.
>
> +API versioning
> +--------------
> +
> +All plugins need to declare a symbol which exports the plugin API
> +version they were built against. This is can be done simply by:

either "is" or "can be", but not both :-)

> +
> +::
> +    QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> +
> +The core code will refuse to load a plugin that doesn't export a
> +`qemu_plugin_version` symbol.

It also refuses to load a plugin which exports a qemu_plugin_version
specifying a version which the core code doesn't support, right?

> Additionally the `qemu_info_t` structure
> +which is passed to the `qemu_plugin_install` method of a plugin will
> +detail the minimum and current API versions supported by QEMU. The API
> +version will be incremented if new APIs are added. The minimum API
> +version will be incremented if existing APIs are changed or removed.
> +
>

thanks
-- PMM

