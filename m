Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5C3C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2FF22CED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZL6rLwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2FF22CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2zk4-0008GZ-J6
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 11:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2zj1-0007nr-4z
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2zj0-0007Fs-3T
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:19:07 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51616)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2ziz-0007FW-T7
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:19:06 -0400
Received: by mail-wm1-x344.google.com with SMTP id k1so491608wmi.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Oxzk18NFntYWQGsx62htSWbOLaVegiQxJmu/0qmLf+g=;
 b=eZL6rLwRZrALkAcTecJF/yrq0F05Ocri6GaDPE3ZT5b2nPe/qn4q2YAMQ6qBbiiynP
 Yg9FCY7XGAGSPFRfIK3ybV/HhyIS3TehHRP7C4+Rw4bq/0ZYPSdZri9E9M2H3oTyLNQ9
 uqOKl05xnPej9hhulmO7q9tP066hPL5lYUs3nGwZDVj1qEuRG2lKKUS/SXZnfdEICb9p
 ewAPkdS3cCGzw+8TrEM4wVEk5wQ3efFeCKNfZe/a2kbsEDYu9igCdaTV5g1dYKULyB79
 AeMdDrAnAdMPuDpjmY7R/IIA1GNhqI3JTeo8S7Yhf1XP9L/LuWtBrCHcBa8B/Ecph+rV
 laDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Oxzk18NFntYWQGsx62htSWbOLaVegiQxJmu/0qmLf+g=;
 b=WprukvVu/8MHTcpj2IYe5PTEk1ueX/d0bwp7R+B5iui/tN22woVTxOoWSOwl5YVsQM
 Sqp7EnZdvzWC6GV0SaqXo2nHqMLRb3ZQRtKSDmlCNEiAJo+ISKVXcqteFrToC6xqnWLV
 aAEBywNMsi5KW+xeK6Wu3rzL4OrJvEM2EUjjzklDGqmqxuBnrgTL8nNeHOCxsr5QJMzh
 WHC2OIxbFb8sijFXufMz+GuTXFGBCmNmEoiCtfk96zl7b39aB95OsK3NRqdVsDs9pKzP
 OF5UCMtWa859OFk/jTR5ejbwQHwwYWOD8j8zO9NSORgO/v4UZOMZbUooivJkQfAzEO5x
 TN9g==
X-Gm-Message-State: APjAAAXhKZDu/7EMlLLi+PBiQ7uzEMs5wYri8axLaSmw09qf5MloIkTt
 mEoy6eVevIB8of+cENNaleAjsA==
X-Google-Smtp-Source: APXvYqzm+okQ3pflIki3YCgwOPV2y3r2DAF6/CuRLGBUXYcL6VR8fmIKwhPCxWweOVKF2R2LN0/02g==
X-Received: by 2002:a7b:cf11:: with SMTP id l17mr5417262wmg.158.1567005544398; 
 Wed, 28 Aug 2019 08:19:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k9sm3930729wrq.15.2019.08.28.08.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 08:19:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2DFD41FF87;
 Wed, 28 Aug 2019 16:19:03 +0100 (BST)
References: <20190827140241.20818-1-marcandre.lureau@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190827140241.20818-1-marcandre.lureau@redhat.com>
Date: Wed, 28 Aug 2019 16:19:03 +0100
Message-ID: <877e6x5ndk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 1/2] build-sys: build ui-spice-app as a
 module
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
Cc: Laurent Vivier <lvivier@redhat.com>, peter.maydell@linaro.org,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Mar?= =?utf-8?Q?c-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> This reverts commit 45db1ac157 ("modules-test: ui-spice-app is not
> built as module") and fixes commit d8aec9d9f1 ("display: add -display
> spice-app launching a Spice client").
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/modules-test.c | 3 +++
>  ui/Makefile.objs     | 4 +++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tests/modules-test.c b/tests/modules-test.c
> index f9de3afdb7..a8118e9042 100644
> --- a/tests/modules-test.c
> +++ b/tests/modules-test.c
> @@ -52,6 +52,9 @@ int main(int argc, char *argv[])
>  #endif
>  #ifdef CONFIG_SDL
>          "ui-", "sdl",
> +#endif
> +#if defined(CONFIG_SPICE) && defined(CONFIG_GIO)
> +        "ui-", "spice-app",
>  #endif
>      };
>      int i;
> diff --git a/ui/Makefile.objs b/ui/Makefile.objs
> index cc2bf5b180..ba39080edb 100644
> --- a/ui/Makefile.objs
> +++ b/ui/Makefile.objs
> @@ -49,7 +49,9 @@ curses.mo-objs :=3D curses.o
>  curses.mo-cflags :=3D $(CURSES_CFLAGS) $(ICONV_CFLAGS)
>  curses.mo-libs :=3D $(CURSES_LIBS) $(ICONV_LIBS)
>
> -common-obj-$(call land,$(CONFIG_SPICE),$(CONFIG_GIO)) +=3D spice-app.mo
> +ifeq ($(CONFIG_GIO)$(CONFIG_SPICE),yy)
> +common-obj-$(if $(CONFIG_MODULES),m,y) +=3D spice-app.mo
> +endif
>  spice-app.mo-objs :=3D spice-app.o
>  spice-app.mo-cflags :=3D $(GIO_CFLAGS)
>  spice-app.mo-libs :=3D $(GIO_LIBS)


--
Alex Benn=C3=A9e

