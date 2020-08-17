Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82F9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 06:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B49220758
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 06:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VaMYB0aa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B49220758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7Yxq-0001T6-Qk
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 02:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@amarulasolutions.com>)
 id 1k7Yx7-0000yL-I3
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 02:49:05 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@amarulasolutions.com>)
 id 1k7Yx5-0007h7-DO
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 02:49:05 -0400
Received: by mail-wm1-x344.google.com with SMTP id 184so12975793wmb.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2020 23:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f1dXXEx+zcgacnXjK5zJ/p3PlgB59prxUayqJL0AVL4=;
 b=VaMYB0aa/LjglP7jy0/D3DgGezt+GU8ne8TT1zVTzCo9btbUZ2zXpx9L+JkSoeXOrz
 pOV4cgGCPDTL4Be5LbEpWKRX7qZkSfMieFL1utPedUzJXiWjKuOvjWti2lahU24cttgx
 uq+WouGaaj1lVP0sm0Ns5L3NK0ZBzqXV6G4+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f1dXXEx+zcgacnXjK5zJ/p3PlgB59prxUayqJL0AVL4=;
 b=XlQxxrbO4VLra6mSBlXnpQd9hvLIdwmnvVi3b7maLli9Xl0f7dalqN+ZysOVxwQ/MM
 4kxyperaTQzsPNWwmXIqUjhzhsFYS7JQE6QHbwauIsMg/IcsjKHYcibRd9RguxFau+xo
 GVI4p5CVLsLql8lGSRuK3vbmr/kqCklOsu9Vd/7jMS2O3986mh8ui3aCAt9YQaXoASQZ
 u0daXMnq0DsLpP+ujFFYL0hHRoy3dTf5g8poT/6/u3OuYj91XCPY3K416ydgb0bNvzxy
 YzGRpFmqYM5YTZnUmK7CeYYO037Tv5EP4/5Zoyl2XHSQXk8p/ZLQtJAuHc0qNj/LVthH
 oTkg==
X-Gm-Message-State: AOAM532tOiEoMOGioJNmJQr/GSjcHnq9xv9DeAyLSyOJgVsVfe1KpSUI
 ocStM7PyyFvLduZZagMfnC6K8AX3RO8NFnZ9D6ixdQ==
X-Google-Smtp-Source: ABdhPJxWH//JS4tAkdC5W/BimvNdkRP9P8NAmO1P+jQ5moUQiaQDb+yTfhGD44SZPGSb2+7G0/eGyZ7i/eAeu94QLz0=
X-Received: by 2002:a1c:2d95:: with SMTP id t143mr12771797wmt.44.1597646940722; 
 Sun, 16 Aug 2020 23:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200812152149.260163-1-michael@amarulasolutions.com>
 <20200817064701.o3q3plnjhzyz3s42@sirius.home.kraxel.org>
In-Reply-To: <20200817064701.o3q3plnjhzyz3s42@sirius.home.kraxel.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 17 Aug 2020 08:48:49 +0200
Message-ID: <CAOf5uwn94gZPZXChFDXWZ-1w0jOY_SxRqzF4Mk8hrtLq-r3yCg@mail.gmail.com>
Subject: Re: [PATCH] hw: dev-wacom: Support wacom tablet emulation in linux
 qemu
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=michael@amarulasolutions.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd

On Mon, Aug 17, 2020 at 8:47 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Wed, Aug 12, 2020 at 05:21:49PM +0200, Michael Trimarchi wrote:
> > Linux need to fill up the hid descriptor in order to let
> > the driver be emulated. This patch was tested on top of
> > qemu 4.2.0 and recent linux kernel.
> >
> > modprobe wacom.ko
> > evtest tool
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> >  hw/usb/dev-wacom.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >
> > diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
> > index 8aba44b8bc..fe95699672 100644
> > --- a/hw/usb/dev-wacom.c
> > +++ b/hw/usb/dev-wacom.c
> > @@ -259,6 +259,64 @@ static void usb_wacom_handle_reset(USBDevice *dev)
> >      s->mode = WACOM_MODE_HID;
> >  }
> >
> > +static const uint8_t qemu_wacom_hid_report_descriptor[] = {
> > +     0x05, 0x01,
> > +     0x09, 0x02,
>
> Where does this come from?  Created from scratch?  Copied from real

No, there are dump of several descriptor on github. I will put in the
commit message

> wacom tablet?  Any chance this can get descriptive comments like the
> other report descriptors (see dev-hid.c)?

Yes, no problem. I will study a bit more. How was working before?

Michael

>
> thanks,
>   Gerd
>


-- 
Michael Nazzareno Trimarchi
Amarula Solutions BV
COO Co-Founder
Cruquiuskade 47 Amsterdam 1018 AM NL
T. +31(0)851119172
M. +39(0)3479132170
[`as] https://www.amarulasolutions.com

