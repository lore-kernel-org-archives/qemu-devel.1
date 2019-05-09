Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9B4C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49132053B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLtmJPt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49132053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52045 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOgJ6-0002Xu-UP
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 06:29:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hOgIJ-0002Fr-L1
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hOgIH-0005oC-GO
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:28:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hOgIG-0005nb-Lc
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:28:53 -0400
Received: by mail-wr1-x443.google.com with SMTP id v10so2282326wrt.6
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 03:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=I3/pxuVPhpZ/9WJhTrbdqQ0BRBt8LJMhaYcsvhaOMDI=;
	b=gLtmJPt9rgbKZwlKLCnel/o8vUEB01uy+1wMwuHDFjCHlbW2dpw9KQn6fUXE6JoHh1
	qvsbSJsVTVXXA60Y28PDG53iy3JC6R6tWHRQETX2Y0kcVt9nSvFWhIkgjWIs+1ZlaNQz
	O1yNv14rySgOkktJCQy13lkD6l3EJLWxZlfcIkKZHuYSSbcHgy2DWpk1e8Rv1Mmd16F9
	R0p3UDTPHruB6+gMXv9J9wAeNomhTTz9YRJH5pZ8GXO16fRN18XbJ7dHgXBNiIpigCOc
	x+yQyLIxh2UkwWRQ421vx3ld67Ljb3aeDhjlDCLFrJ+9v0WVs/yAp64Fm+Ni9bmPzNhZ
	bPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=I3/pxuVPhpZ/9WJhTrbdqQ0BRBt8LJMhaYcsvhaOMDI=;
	b=o8N5Wjxwt8beBFgaiq4eS00XUVS0ZJUNAM+PSh0UithgoDzQuPa9k1ANihy4XhjMrh
	jnGeklYXvX+LOAxHjSG+0tW8nbn3leh6yut77c2egQgE4sGo9tLvgrFYCrAdsn1UfRn7
	1WahrgpeN2mRi92gkxH/nPxui/vGM97dnVCUBf3l8AgTwdhIXnvqDdJ3g64AJ7g0ggtw
	proT3/YHK09eXKaHnLtDwUeAv3QmCSa7wwWlvo4kPC7HzlCx/iD1RFbTsiGZEI9aRwlg
	jbbyjzQtzImemsBMA68oVi4hwyhOf6SGoR+AeW5TthZPwqrMrBRJAMgXzYrmb4S3BByX
	mJcA==
X-Gm-Message-State: APjAAAUPtRYzw0jGu0qdwDsJ/XvUlr78fhGlez0Hyed7PNel7+r8g+4/
	XNd8cPNLoqmYSIJ2EWnQFuzhzTzrBvC59tg+ekY=
X-Google-Smtp-Source: APXvYqzsAK0mXa9r+Q4WErb9y73uiDdQ8X52bXk0UoJHP7yJpQ5Fbov2pk3iWbsUgkjfnkbQqT8xs5OpNOk4zXU1l7Q=
X-Received: by 2002:adf:b641:: with SMTP id i1mr2449255wre.288.1557397731325; 
	Thu, 09 May 2019 03:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190509093121.25974-1-kraxel@redhat.com>
	<20190509093121.25974-2-kraxel@redhat.com>
In-Reply-To: <20190509093121.25974-2-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 9 May 2019 12:28:35 +0200
Message-ID: <CAJ+F1C+e93w5dEnXidHOzemWdv1jAdEzfQLx=GFOY0BdY3QDNg@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-input: fix Kconfig dependency
 and Makefile
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 9, 2019 at 11:31 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Make VIRTIO_INPUT_HOST depend on VIRTIO_INPUT.
> Use CONFIG_VIRTIO_INPUT_HOST in Makefile.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/input/Kconfig       | 2 +-
>  hw/input/Makefile.objs | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/hw/input/Kconfig b/hw/input/Kconfig
> index 50e55e353847..889363d8aef1 100644
> --- a/hw/input/Kconfig
> +++ b/hw/input/Kconfig
> @@ -27,7 +27,7 @@ config VIRTIO_INPUT
>  config VIRTIO_INPUT_HOST
>      bool
>      default y
> -    depends on VIRTIO && LINUX
> +    depends on VIRTIO_INPUT && LINUX
>
>  config VHOST_USER_INPUT
>      bool
> diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
> index 3eddf00f2bba..d1de30770854 100644
> --- a/hw/input/Makefile.objs
> +++ b/hw/input/Makefile.objs
> @@ -9,9 +9,7 @@ common-obj-$(CONFIG_TSC2005) +=3D tsc2005.o
>
>  common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input.o
>  common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-hid.o
> -ifeq ($(CONFIG_LINUX),y)
> -common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-host.o
> -endif
> +common-obj-$(CONFIG_VIRTIO_INPUT_HOST) +=3D virtio-input-host.o
>  common-obj-$(CONFIG_VHOST_USER_INPUT) +=3D vhost-user-input.o
>
>  obj-$(CONFIG_MILKYMIST) +=3D milkymist-softusb.o
> --
> 2.18.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

