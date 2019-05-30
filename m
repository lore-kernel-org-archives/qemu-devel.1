Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1892C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 12:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3A62590D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 12:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QevhJZRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3A62590D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53659 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWKXr-0003fK-Sf
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 08:52:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hWKX6-0003OI-FQ
	for qemu-devel@nongnu.org; Thu, 30 May 2019 08:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hWKX5-0001gT-Ad
	for qemu-devel@nongnu.org; Thu, 30 May 2019 08:51:48 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hWKX4-0001ei-VF
	for qemu-devel@nongnu.org; Thu, 30 May 2019 08:51:47 -0400
Received: by mail-oi1-x243.google.com with SMTP id 203so4788085oid.13
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=WpapVoqIj3ygdX0ysmxrSDNnoQcZKd4aOtbsCubzLGw=;
	b=QevhJZRhaP0dIyfua6w44pMIoxg6BshT2ovB057/8Bhjt+YzrYH9ysjGeK67ei87XW
	wg0jlzCL6uXGVijxSgIbCf9727Ru+SGi9U33MOjkOtzxC8m/+2IayKfDx0950p00DpkS
	XbFvlxy+9PGRioOcvl+QAbOe+ammpIXNOPDjscKmR0uFnjsnENqpmV/5RG0oFbXTlnvd
	4J/iOPn97exMSOLIvtwNaPpq9DqY8VyQQtKgauICfqj8b+BPqaMnWwAU0bbKnDhLpLbZ
	uQzTFpveIQnzy6GIZSn5YP+yghKs1RUmLmUmMmMSi38Du8OpYxRoG92tXy6x0SB1FNx0
	os1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=WpapVoqIj3ygdX0ysmxrSDNnoQcZKd4aOtbsCubzLGw=;
	b=SV898irLWeTIoHdhZ7OaprNKrHzMdWLRjx8398NDBf9rLqLaL0g3HzUrM8ktfIKN/u
	fB7EXSy2OEZWfrdkYBxnKdnMafMssiPGO5flcg28jwxBiFJbOcS32bb15LY+v4c6Er5u
	gn5xeJ7EG+yd60M1dpaJLRX8CEVTar2mm8Prh8DxNjlK38d56rWLZsdUXzNXpUqHV9uV
	IT2c2j95j7YKQmHg0tAPlgIxPnlWuyo6sNzx7DvGsguSQ/jq8H7RfwIVwgbeSdLZmD/R
	ajyb0exCAIMA8ZadzehM4Yb6fWdf2OEm4rcgMb4dGXNWw8WCUjBjA3XzTp/jXrVJflwk
	6kOg==
X-Gm-Message-State: APjAAAWrOFcei+lK4kIgRtlD/esGO2i/ZfAQ3HqKU3u+HNChVfC8Cb0U
	BxeWw/a0UzkorgbBowZJL5ry/002v/8csAWUheY=
X-Google-Smtp-Source: APXvYqyeHnZmYDgHAiTOh100KPejndI+7YKRrf4xyIU2MDpAq6d6XV5ypQWEDgb3MKbq4aCaSPLEQcP0aD+xVO+k8J4=
X-Received: by 2002:aca:330b:: with SMTP id z11mr2224902oiz.148.1559220705533; 
	Thu, 30 May 2019 05:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190529072144.26737-1-kraxel@redhat.com>
	<20190529072144.26737-5-kraxel@redhat.com>
In-Reply-To: <20190529072144.26737-5-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 30 May 2019 14:51:33 +0200
Message-ID: <CAJ+F1C+u9mojgn40JUMN975jf3WsJxnWtd_O0gwDYKtTAauTCA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v3 4/4] egl-helpers: add modifier support
 to egl_dmabuf_import_texture()
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
Cc: Alex Williamson <alex.williamson@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, May 29, 2019 at 9:24 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Check and use QemuDmaBuf->modifier in egl_dmabuf_import_texture()
> for dmabuf imports.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/egl-helpers.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index 0c9716067cfb..edc53f6d3464 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -229,20 +229,36 @@ int egl_get_fd_for_texture(uint32_t tex_id, EGLint =
*stride, EGLint *fourcc,
>  void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
>  {
>      EGLImageKHR image =3D EGL_NO_IMAGE_KHR;
> -    EGLint attrs[] =3D {
> -        EGL_DMA_BUF_PLANE0_FD_EXT,      dmabuf->fd,
> -        EGL_DMA_BUF_PLANE0_PITCH_EXT,   dmabuf->stride,
> -        EGL_DMA_BUF_PLANE0_OFFSET_EXT,  0,
> -        EGL_WIDTH,                      dmabuf->width,
> -        EGL_HEIGHT,                     dmabuf->height,
> -        EGL_LINUX_DRM_FOURCC_EXT,       dmabuf->fourcc,
> -        EGL_NONE, /* end of list */
> -    };
> +    EGLint attrs[64];
> +    int i =3D 0;
>
>      if (dmabuf->texture !=3D 0) {
>          return;
>      }
>
> +    attrs[i++] =3D EGL_WIDTH;
> +    attrs[i++] =3D dmabuf->width;
> +    attrs[i++] =3D EGL_HEIGHT;
> +    attrs[i++] =3D dmabuf->height;
> +    attrs[i++] =3D EGL_LINUX_DRM_FOURCC_EXT;
> +    attrs[i++] =3D dmabuf->fourcc;
> +
> +    attrs[i++] =3D EGL_DMA_BUF_PLANE0_FD_EXT;
> +    attrs[i++] =3D dmabuf->fd;
> +    attrs[i++] =3D EGL_DMA_BUF_PLANE0_PITCH_EXT;
> +    attrs[i++] =3D dmabuf->stride;
> +    attrs[i++] =3D EGL_DMA_BUF_PLANE0_OFFSET_EXT;
> +    attrs[i++] =3D 0;
> +#ifdef EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT
> +    if (dmabuf->modifier) {
> +        attrs[i++] =3D EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT;
> +        attrs[i++] =3D (dmabuf->modifier >>  0) & 0xffffffff;
> +        attrs[i++] =3D EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT;
> +        attrs[i++] =3D (dmabuf->modifier >> 32) & 0xffffffff;
> +    }
> +#endif

Shouldn't there be at least a warning for #else?

> +    attrs[i++] =3D EGL_NONE;
> +
>      image =3D eglCreateImageKHR(qemu_egl_display,
>                                EGL_NO_CONTEXT,
>                                EGL_LINUX_DMA_BUF_EXT,
> --
> 2.18.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

