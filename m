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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54045C18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B53205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAo0J9V9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B53205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40016 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTOmU-0000LH-91
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 06:47:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hTOkW-000744-9i
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hTOkU-00009e-S1
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:45:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hTOkU-0008WC-Ip
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:45:30 -0400
Received: by mail-wr1-x442.google.com with SMTP id w13so1703619wru.11
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 03:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=cwjr/ubji2MyKG7+uME2+OXJWIwW00QW2XK8biJl0jE=;
	b=rAo0J9V9qo1AGpLlsUEWyWiueJcktA+1yChtMcimCn4lgaLdZZp40R9FbSibvT9QOZ
	JJqYEt4UlJ65XNWcxIYYziD0k2XCJ+t4YD5EGNamOYnm73i5fp1Yov7fmznntFfURBTd
	Lzb5nFMsXA5SO8/P5qheoheur2CdkCW95+eW2mwaNynlvPBojUKntuw/KmMkiaYJvQxA
	gyLxtjRarvvHJY57vVhp2QuzlCfqwMMXjgkPNXvguGK1t3N2GdnRpwP2VUVjMtVRfoR6
	JTpy6k/TaKNJ7z2tytygjOMC5o83Ef2pDj9ux6mCeT1PnPPU6JcqWYrvVrnXIjQigoa5
	vQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=cwjr/ubji2MyKG7+uME2+OXJWIwW00QW2XK8biJl0jE=;
	b=LVPBSvqHsdEdfxMUoVBVrLmqpTr1nRSP48KLc3ErmEn7dpQI9vciYp6vL9DOpO8YpY
	bQgiBRTRsrA2txDMjjscJ6SRg3Xlxd1AbHAFZL99WCPMo+4wmrDbDps7iXoy8oeT/lYE
	7fKE4NTGiu3zX4WH5U0UmWn2/ke14h4p1Ue5OosCWhpkux41TNPZhxppY/NvaCSEoa/i
	hxNArixYuIrFYGClG+T3VtFyK/Kl9mpJkNIWY0V8Gea63t1oMxaUsKu1YBbMC7lWRlDa
	krwRXeXkNBJk/JQCA+rfHKvg9b+hNmwH/vKz9ErV478dxF9RH6zMbNwQNJeG7QLmbuc0
	BriQ==
X-Gm-Message-State: APjAAAXKiWEeeEA4YagyYr/3neslYVgFEvtHTrYqMqRhbhfx+zri1VPQ
	YL8RrvW717nNjhERreQ3yKizEimQ2QBMocXYWCjaxtwGsh0=
X-Google-Smtp-Source: APXvYqz/T8JUhNGq2iJHaNW+EUOynZ2SRg+NxmRmwqjnImTIaHfOUwfjwujGnT2khU6SDFnWT0/v/3iS5bgfCxxYkSs=
X-Received: by 2002:adf:83c5:: with SMTP id 63mr24157592wre.33.1558521925504; 
	Wed, 22 May 2019 03:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190522095821.15240-1-kraxel@redhat.com>
	<20190522095821.15240-2-kraxel@redhat.com>
In-Reply-To: <20190522095821.15240-2-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 May 2019 12:45:14 +0200
Message-ID: <CAJ+F1CLgMeDN3YwQ8=6hbGXbS9K7+RPxh6YV4TSe3O3TcZUgCA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 1/3] console: add dmabuf modifier field.
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
> dmabufs can have a format modifier (DRM_FORMAT_MOD_*) which is used for
> tiled layouts for example.  Add a field to QemuDmaBuf so we can carry
> around that information.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/ui/console.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index fef900db76a5..f9816968487c 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -175,6 +175,7 @@ typedef struct QemuDmaBuf {
>      uint32_t  height;
>      uint32_t  stride;
>      uint32_t  fourcc;
> +    uint64_t  modifier;
>      uint32_t  texture;
>      bool      y0_top;
>  } QemuDmaBuf;
> --
> 2.18.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

