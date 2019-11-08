Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F8BC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6B821848
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8iO6i6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6B821848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2Mq-0000NQ-DJ
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iT2MC-0008Pb-5l
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iT2MB-0003n2-6G
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:23:12 -0500
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:35218)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iT2MB-0003mo-2b
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:23:11 -0500
Received: by mail-qv1-xf44.google.com with SMTP id y18so2042243qve.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 03:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mbBbjjj3rYoOsEgKB4/GVW2NvCSqFBTulzzQEuMxeX4=;
 b=C8iO6i6x1ZDdpxISn2UkGJeDHE0ljR4SCF6g5hDM+kVRk8W1zSEuQoGARvoZAKgnEk
 uePPfoFrtFIWjCBKei4LUVkRQvadkAwgTyH9/HrSBvHMOMFWbnt1w8nD0MXYdTSHVWC2
 IXzbxqdt3U5UBZkvwI3qmBQCVTT01w3Fz4ZSvwEz/zGkWuxeayFWT1gA9Qri3RDr5D6W
 DqaDEu6U9wxEkSk/DxheN7ZEUtIv4F7FWfxJ542pMK+3R+w24L/8iYVHNBRkQgcDTsqK
 B0JNVJScngqvyCaepf/V3ne0dgAJhnZLEiJMxMtq60JXywxf4058vTlDSL/9tYVA63kg
 evsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mbBbjjj3rYoOsEgKB4/GVW2NvCSqFBTulzzQEuMxeX4=;
 b=EuCA+SYIAllCusEFNYAivMh5BAYdjUc/KL+U0waC516ZZvH01EbqilAXGRDeeu0WdZ
 CElfcn6UE2ZFha6QGo52NpzgD54zS5KubkF/FiCqUDAKnLN7ahqzhA9VF1QMVbPdZmTM
 nHt1eQjDwKHKo/7w9Yhx3fF2dj78C4WacPEEgsAU9spfxSuv44LC2uSDMoCgrivK9go7
 atEGLULaPDZNv0Q4C/hnF9Ivf/gasSfTGT5wePHFi8JZavio2fexqSRM6ByLPxe72RWZ
 buOVC+/+UuM4D19uZpQjkEV3pHRUzGN/KT4DNG8uxpH5fNt48rCcArefxeW+Y+6mG1jR
 BmyQ==
X-Gm-Message-State: APjAAAXOzPvu5AlzL1ZGbQZyUL9ZPHVhb4P6Md0Nb5G3gWC2KJ/NoWz8
 7gZFKpJRauBGBmh/cXVPB7hfD9Eh+pvGiK3BbbA=
X-Google-Smtp-Source: APXvYqyzqtwZLZtOjgBZPEzhUa4K2oVTzaSVpB2DCuSrA/u5kV9inC2JOIEzbn6GvIjkAJQuKSsPCrVZkTTtJAbxwS0=
X-Received: by 2002:a0c:9637:: with SMTP id 52mr8623861qvx.174.1573212190352; 
 Fri, 08 Nov 2019 03:23:10 -0800 (PST)
MIME-Version: 1.0
References: <20191108100526.401847-1-stefanha@redhat.com>
 <77573e2e-2508-9386-89b8-d44b9e7f2ade@redhat.com>
In-Reply-To: <77573e2e-2508-9386-89b8-d44b9e7f2ade@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 8 Nov 2019 12:22:59 +0100
Message-ID: <CAJSP0QXv=vYc8thTYWaOs93wVdJjD8cJnkEbXfxw8E+q6g82sQ@mail.gmail.com>
Subject: Re: [qemu-web PATCH] documentation: link to nightly documentation
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 8, 2019 at 11:45 AM Thomas Huth <thuth@redhat.com> wrote:
> On 08/11/2019 11.05, Stefan Hajnoczi wrote:
> > Link to the documentation built from qemu.git/master once a day.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > This depends on qemu.git "[PATCH 0/3] docs: build an index page for the
> > HTML docs".  We need that in order to build index.html.
> >
> >   documentation.md | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/documentation.md b/documentation.md
> > index f4ef9f4..662750c 100644
> > --- a/documentation.md
> > +++ b/documentation.md
> > @@ -3,6 +3,8 @@ title: QEMU documentation
> >   permalink: /documentation/
> >   ---
> >
> > +The latest development version documentation is available [here](https://wiki.qemu.org/docs/index.html).
>
> Why are we using wiki.qemu.org here? Generated docs are not part of the
> Wiki, so this sounds confusing to me... Shouldn't this put somewhere on
> the main www.qemu.org domain instead?

Thanks for bringing this up.  The docs are now available at
https://qemu.org/docs/master/.

Stefan

