Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED19C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 07:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792E020656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 07:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=loon.com header.i=@loon.com header.b="ImPpvV2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792E020656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49388 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOd9F-0000Co-KY
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 03:07:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ek@google.com>) id 1hOVSW-0007hI-8c
	for qemu-devel@nongnu.org; Wed, 08 May 2019 18:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ek@google.com>) id 1hOVSV-0006qR-6E
	for qemu-devel@nongnu.org; Wed, 08 May 2019 18:54:44 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:45143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ek@google.com>) id 1hOVSU-0006oo-GD
	for qemu-devel@nongnu.org; Wed, 08 May 2019 18:54:43 -0400
Received: by mail-io1-xd43.google.com with SMTP id b3so83259iob.12
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 15:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loon.com; s=google;
	h=mime-version:references:in-reply-to:reply-to:from:date:message-id
	:subject:to:cc;
	bh=D6eGTuHc4GZTPaJIPefcbVCh7sBCUwyeK8Auqtu9Yvo=;
	b=ImPpvV2qlFWCmbuy4psIjjqhm7JH1yf+DpvYk0c7xWfQYaCv6UZHNLM4RBB+tNEcMk
	6FCsJ5S0zsPVIxGDa27ntp+AS9hVn8X2U5LGBO2t2PBBVAqcsx3ThFtWyWtn8YhcsLqv
	uzm5QipNab/j9FSZ15ZDaGCsOg7URgYxFCg5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
	:from:date:message-id:subject:to:cc;
	bh=D6eGTuHc4GZTPaJIPefcbVCh7sBCUwyeK8Auqtu9Yvo=;
	b=QWp5iDJ9N5kqWlrHTZbzEdd2IwcjEXJVmuoJfwaUfSl8IDI6ifdfnqvwujy2Br5VT6
	oG1GAiAEyaYuS/+FhqzcSWvz5dnkbjIBnhfJgU0FGG7HDeqNFL5FG7aNgX4nDYNrDksA
	mOf2uoaJSMajaVaxfP/Bkgcq4FR9oBgELdD+VoiwVEHyVSX+0lLT3Ve++pODxdJ5On13
	XGpPPnV2rkoT0DKJLQMaW/vZxqf+wAJehMgLKbXKWWt1U3Kjatbl+e06j3JvhBzy31cc
	71mdyIiBpdN+F9LmkfD7BekQYnyl4mM8rRROO4MPsonIysOqGGzDdIcAjRWMw6UZrZdV
	4Gsw==
X-Gm-Message-State: APjAAAW+fU3RgS3tsjX54eIKLCpZuxiiA6/luVVQ/k1zZC9jhZ6TQAFo
	FpAjsOJscdWW4Er5KdA8KcrALZZY+9VhdFWSgz4EfQ==
X-Google-Smtp-Source: APXvYqyQyV0FSnUapgVF3wFz/gS0+YakSmJsuag5PBtZCSHK5dLNDd8abSBLedg2su+kkl14CYTjnFVSdzfQAod0SXI=
X-Received: by 2002:a5d:8608:: with SMTP id f8mr420205iol.62.1557356078908;
	Wed, 08 May 2019 15:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190423222005.246981-1-ek@google.com>
	<CAFEAcA_C4BQgYmZrzFZ_bwWVWcfcV1NF_PWp1wHsvqB9iPu0kQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_C4BQgYmZrzFZ_bwWVWcfcV1NF_PWp1wHsvqB9iPu0kQ@mail.gmail.com>
From: Erik Kline <ek@loon.com>
Date: Wed, 8 May 2019 15:54:27 -0700
Message-ID: <CAAedzxpgv9A9cFbsDynCcZKxyDkQ0dL+m60ckwWcfD=j8TmSHw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d43
X-Mailman-Approved-At: Thu, 09 May 2019 03:05:16 -0400
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
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
Reply-To: ek@loon.com
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Anything else I need to do?

On Wed, 24 Apr 2019 at 02:10, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 23 Apr 2019 at 23:28, Erik Kline via Qemu-devel
> <qemu-devel@nongnu.org> wrote:
> >
> > Signed-off-by: Erik Kline <ek@google.com>
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1814352
> > ---
> >  linux-user/ioctls.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> > index ae8951625f..37501f575c 100644
> > --- a/linux-user/ioctls.h
> > +++ b/linux-user/ioctls.h
> > @@ -178,7 +178,7 @@
> >  #endif /* CONFIG_USBFS */
> >
> >    IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
> > -  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(TYPE_INT))
> > +  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
> >    IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R,
> MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
> >    IOCTL(SIOCSIFFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
> >    IOCTL(SIOCGIFADDR, IOC_W | IOC_R,
> MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
> > --
> > 2.21.0.593.g511ec345e18-goog
> >
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> thanks
> -- PMM
>
