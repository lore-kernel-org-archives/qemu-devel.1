Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800F3C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494352076A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sv+rcriD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494352076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOja6-0002IZ-Ef
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 11:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOjYC-0000Th-0O
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOjY9-0000dS-H6
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:02:03 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34359)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOjY9-0000d4-C6
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:02:01 -0400
Received: by mail-ot1-x343.google.com with SMTP id m2so215719otr.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YK66YhURrsXMAxQ3bPhXBDbtExnnUVezEkD2nlDY/uw=;
 b=sv+rcriDA15onJ4VnZo9IjtRX/5qAFLHxT3pLtvIxubaNudB2E9yj9o30rV0jf412H
 TM9mba1lLtHylvUoyqV4ZnDkRmWAitzXZ1EoVDR+b+2mwHmJ+alAQAmvJH6ne3febnv6
 t3RQrUUxa0Tj2FY4kGR2pA964E1VH0XUr88AAkJ3/5rdL6Q9iecDVV3IdCPTfBlSq4L6
 0EZDXbBvFrlSKCHiyd6Im4Y4BxFFxaOmT5TqUidZxEcr9X1rDtP7yg52/872OiTkfD2f
 cowWVtYE4UO162JMZtu1Vuxb+T/YOJ2DHXHEj9MQjXmvCAWv47Py0wpAQTbiFyfBXQu2
 qCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YK66YhURrsXMAxQ3bPhXBDbtExnnUVezEkD2nlDY/uw=;
 b=MyG6BAN7nqGHPI+3R+siLgevgQyEQ+aZcZn+0ELGEm1g+A8kBC/7NmsSF6+bIR9yTQ
 Mrfbc0C4FdcMv10Tsopr1NyLHBSZVGUr0br5CWATX1wo2zW/HFXzcX1AkuiyyjnsQ5yT
 KpuyNU8iwfAF0+8aZhCUnhZUrF8FnQV47wVXiw0rl/mdivu/b0GDM7N72twMcAJfRnxi
 gcfYDK7NhnsdCGcUyMB4wRTO2oe93Mq2lwzlyHt65hyQLOn/wXjCz0fyMTCeC5rfdk/h
 +mhdcW2onhHyUf3IxAwrUHm8e3dBk5JgF3wMSREegNqtOQrEKoUJWhbdAxHrq9tuYOoj
 WZpA==
X-Gm-Message-State: AGi0PuZSZ0XCyDCEiKTxSdsh6wNBTwOfOjze7+dxWKVJBiduBzJ7AOBm
 4/N1NCstPDNf3PvtkWdfXZPD22sTD2gfTqKfwiA4Ow==
X-Google-Smtp-Source: APiQypIthDh/CPu3UN51x5dTXGFwk6zquj/Wch0vt5XUQwbq7KhPSoswJQ11ttiXN5T5QByHJqFkaHUHZg+stD+x4Uo=
X-Received: by 2002:a4a:890b:: with SMTP id f11mr22863705ooi.85.1586962920310; 
 Wed, 15 Apr 2020 08:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200413220100.18628-1-f4bug@amsat.org>
In-Reply-To: <20200413220100.18628-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Apr 2020 16:01:48 +0100
Message-ID: <CAFEAcA8kF1dhR0k2kgEr-KxBspxcqLXxVqWcMadDns3-SYKrAQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 v2] hw/display/sm501: Avoid heap overflow in
 sm501_2d_operation()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-stable <qemu-stable@nongnu.org>,
 Zhang Zi Ming <1015138407@qq.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Apr 2020 at 23:01, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Zhang Zi Ming reported a heap overflow in the Drawing Engine of
> the SM501 companion chip model, in particular in the COPY_AREA()
> macro in sm501_2d_operation().
>
> Add a simple check to avoid the heap overflow.

> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index de0ab9d977..902acb3875 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -726,6 +726,12 @@ static void sm501_2d_operation(SM501State *s)
>      int crt =3D (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
>      int fb_len =3D get_width(s, crt) * get_height(s, crt) * get_bpp(s, c=
rt);
>
> +    if (rtl && (src_x < operation_width || src_y < operation_height)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "sm501: Illegal RTL address (%i, =
%i)\n",
> +                      src_x, src_y);
> +        return;
> +    }

This does fix an issue, but I have a feeling that there are
other possible guest register value combinations that might
cause us to index off one end or the other of the local_mem.

The SM501 datasheet is entirely unhelpful on this question, but
my suggestion is that we should convert the code so that instead
of operating directly on pointers into the middle of the local_mem
buffer all the accesses to local_mem go via functions which mask
off the high bits of the index. That effectively means that the
behaviour if we index off the end of the graphics memory is
that we just wrap round to the start of it. It should be fairly
easy to be confident that the code isn't accessing off the end
of the array and it might even be what the hardware actually does
(since it would correspond to 'use low bits of the address to
index the ram, ignore high bits')...

thanks
-- PMM

