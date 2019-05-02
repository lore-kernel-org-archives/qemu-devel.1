Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B17C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 17:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5296320652
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 17:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpxnTTgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5296320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56728 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMFwX-0005iZ-7O
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 13:56:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMFvd-0005JZ-5u
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMFvc-0003hP-8m
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:55:29 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hMFva-0003eG-EQ; Thu, 02 May 2019 13:55:28 -0400
Received: by mail-lj1-x242.google.com with SMTP id q10so3011400ljc.6;
	Thu, 02 May 2019 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=KswWI8+pfLiwNgYhU2PtnZM9a908yJwPs/eQ/QEyeAE=;
	b=jpxnTTgwW1wh9w7QtcBMnM/4xhY6GZLqlgXkbXuPTeLVzkHY4wBJDuP7G9z0fbfAW9
	gWRflwkyKcWpj/zTgZKjKFmqpysdscuaalmBqsbT6exBXjPQUN5r5foFaYMXXwxzwa0c
	jOMMs1y6h1lFUiaM8Rvg3odHF8++TD2+CNoTJFfTE9TMH6vC3ugW/b/Td3I6b10BmFof
	6tSqzGLbwbi/gDmf7yE675rkvkriw4Rtk1/jFL+mHDbAnDj58qeX6mYySuY55IGMK004
	kur4tUSf4CZAFlGWncRLgY/5ABOwrmLq5vik2AdzL/iWPhKaIjwkftnuwGEUYg5FxUi8
	SMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=KswWI8+pfLiwNgYhU2PtnZM9a908yJwPs/eQ/QEyeAE=;
	b=eNvrcYMCFI1QGqPJdg6+vhXuMsXtG/N3KrrJF4GWroX1uKIoJMUovd2wmLib8PMA9Y
	AIkn2w3VsdoSxLFXCS+ZW2cukJrwTiavh/bg7LRBPFWv1HMkE3Pw41JheKGXxyX/h/1Q
	LNUy5Vo2sikrUc9GwIIj2blcxZ1OnmNkFCGLDIwEJN40P3u64h8P6Oci9Unnpx00BBG6
	gVEU/I5kW9H6xrJPUY6ZzHPN5Hv+BeCiiZ53RqCwDoHXOAuwbA5oAuprxVIXSqcUQEcW
	gwElZcIbDeww48GMErEczCrOAugE263Yv+oIPnpvtnYnTlxiZO9IUWoLmJzb9hjpyoB0
	oZZg==
X-Gm-Message-State: APjAAAXJdJqAQWjWGtgAtwmbWZoMiGODuunsEStFZv6AeQ5X5ToK/33n
	o8In31HtmcspB5f/XjgMiAyM5sCDUfv647nlk7Q=
X-Google-Smtp-Source: APXvYqx1J6WesXbPLWdTf1bqw1Ks9xcHlMSVSqJ+NHDQ3DjwrAsjkCFIqUVA+ny+Xrj16eHM/KzkB94nSvfwjgjOJ64=
X-Received: by 2002:a2e:2b8c:: with SMTP id r12mr2819123ljr.115.1556819723870; 
	Thu, 02 May 2019 10:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<ff51c73e3095fa503d14aafece54f8565fe99900.1556666645.git.alistair.francis@wdc.com>
	<0d585793-20a8-8dc8-98fa-13789113f672@linaro.org>
In-Reply-To: <0d585793-20a8-8dc8-98fa-13789113f672@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 May 2019 10:53:26 -0700
Message-ID:
 <CAKmqyKNFxWDd1f-87+fODFP363Ttb3AvixLv=EWQNZj38XCjaw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v2 2/5] hw/usb/hcd-xhci: Fix GCC 9 build
 warning
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"laurent@vivier.eu" <laurent@vivier.eu>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502175326.zslHDnngrVhZsyCaWD24tvnczy6tv6YXb9o6V3GJ8Pc@z>

On Wed, May 1, 2019 at 7:12 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/30/19 4:28 PM, Alistair Francis wrote:
> >      for (i = 0; i < usbports; i++) {
> > +        g_assert(i < MAX(MAXPORTS_2, MAXPORTS_3));
>
> I would hope that it works to move this out of the loop:
>
>   g_assert(usbports <= MAX(MAXPORTS_2, MAXPORTS_3));

Yes, that also works. I have updated the patch.

Alistair

>
>
> r~

