Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136E6C18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D237B20856
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRiU3ISz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D237B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40024 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTOmn-0000ai-3B
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 06:47:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hTOks-0007GS-0U
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hTOkr-0000SW-06
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:45:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hTOkq-0000Ra-PH
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:45:52 -0400
Received: by mail-wm1-x342.google.com with SMTP id i3so1694414wml.4
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 03:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=0+13yaG2ah+3i4i3Stbfgc+We6OfIrfNdIP+J5PmzQ8=;
	b=bRiU3ISzThtMh6goyQzJ33ohnC2we9yuaeMSmJUQCEnYgRJQ2LtvyAsqwuooC9sDXU
	h2G/8Kqk2ptn4jSN4O1vgpQ3HUUm5jIWhtqovC5jCoHLSa0Tm9SpQZpnZrFYAApLH5xS
	tGkKX40pHE5+onlfANMqX189fBtdGau9gydSpXAGU3GYmw8q7vFRBwXCJuAKymWAmhFW
	z8gvXboo7xBvWbhNfDriIiO6afrz/7I2FH+PZSvs0PZBd1Nh/O/56E8pWPM8djACKGs8
	qtVsM5MLRDkamV3MJE7Rm9czlNC8DGyazl/J0DFWyHmdJA+6milBsrcM0EMpd0+e8MEc
	LC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=0+13yaG2ah+3i4i3Stbfgc+We6OfIrfNdIP+J5PmzQ8=;
	b=X6ziGxHgsRxmdGEERrLRilDY3I34y8c+XJchNeU/Gg+en3OAjCM2hLGNcRPFNsOVu7
	BSbJDg48rabMWoBJDdtBi6G/+FExVaX1cho9O94g3PVIjb8JRoxEmhlzJbri5+hxWWRs
	OimJjnJfCZrGL69Wn25d3p8LnYk8DQmAU/RK/TT5rZemY7jyJ30Qv6JupV34MgYtJHmI
	TC+H1TaSPESzdfnnXYRhH7BEyJA8ebsG47MdzN0BKJRntZukY2l31T1DFFJwe2MECZTT
	EJFjQf4i7vma1i7SixGkVgUb0TGr42t6o5fomEwm6JYOFd/4ayq3Va4yonwjkZ4U5oYi
	jY0Q==
X-Gm-Message-State: APjAAAWKRqGJfQlftoq40caOua4jU63rPsRe2zye2AKDAKrxKdHXiu9R
	/sKTV/FTG7Fmt00owLl1rER2+5v12czE7oecg00=
X-Google-Smtp-Source: APXvYqwXsAbbQdPxKOR3n2VNzYOTRkKCekNGNPi2GL5lL1jAAogSTdJAausBHnIHSalxDjSC5uW+dpfpUycq2aGMRLM=
X-Received: by 2002:a1c:e009:: with SMTP id x9mr6737416wmg.117.1558521951569; 
	Wed, 22 May 2019 03:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190522095821.15240-1-kraxel@redhat.com>
	<20190522095821.15240-3-kraxel@redhat.com>
In-Reply-To: <20190522095821.15240-3-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 May 2019 12:45:40 +0200
Message-ID: <CAJ+F1C+7sMizD2gqOtz5HykXhL-3qKAOiMm+pOUPpTcVECQBgg@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 2/3] vfio/display: set dmabuf modifier field
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

On Wed, May 22, 2019 at 12:05 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Fill the new QemuDmaBuf->modifier field properly from plane info.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/vfio/display.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index a3d9c8f5beac..13969180b2dd 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -248,6 +248,7 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDev=
ice *vdev,
>      dmabuf->buf.height =3D plane.height;
>      dmabuf->buf.stride =3D plane.stride;
>      dmabuf->buf.fourcc =3D plane.drm_format;
> +    dmabuf->buf.modifier =3D plane.drm_format_mod;
>      dmabuf->buf.fd     =3D fd;
>      if (plane_type =3D=3D DRM_PLANE_TYPE_CURSOR) {
>          vfio_display_update_cursor(dmabuf, &plane);
> --
> 2.18.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

