Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882F0C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D62207C4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGH4/YvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D62207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbO6N-0004Gn-Gq
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 08:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andy.shevchenko@gmail.com>)
 id 1jbO1A-0003cb-6H
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:40:16 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:40235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andy.shevchenko@gmail.com>)
 id 1jbO19-0000DW-AU
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:40:15 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ci23so1221316pjb.5
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sTd7gk/F5t8+90VdVmPMqwcUDImsEOyU6Dtdpqgy9Wk=;
 b=lGH4/YvXzbpg8mnazKXwowykaaS/FaFJK6zRzmFMUwq3bPrXqelmSJhJjUCx4kt5gR
 FdWwuYsZxumG2p8fXPW0Ug2kqYvwBuDnWQuqFKAWpPtK4IkzaxNPuUE10/fBXRRkPOqd
 YXAUI7Z2mLoTYZjKY3IVwNmLA/R3iJ+vKrs/dZk/jzRVIlCek4Y89X9j6BqPB7m5IFj7
 y7AkQbFwVCVc5LqYoEZz8hIF8F2XyP3NcPV7395PBQM4+uuaWpNZQ+HZNPGjkHI6jPSg
 RrG08I60wNO3l368r3lFotMz4aasm2cXaAztzC2c3TLWFnBTqHnwnSe+jMTsTyHeGvRH
 rnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sTd7gk/F5t8+90VdVmPMqwcUDImsEOyU6Dtdpqgy9Wk=;
 b=qka+3s5bT2PLXfU8xscI4zqqPTUjp2dYb0tgeGtiqopOi7akvI0mGC29+OvM3K5Kiw
 XRUjaN4lx1jGef4U4kFJkF7vRvIo4WNdze60ZdVT7xwqENFIi6hBGqg/S15QQ8ONKwjl
 jKuyGOL4xOZo0FIXDl0BpTTqUYmUqJ73gX4D1FPLZGjwaXInfvEJ8u035RNJQLl7z3Jn
 Ll8f92kaQKCXTD5HpnqFCeEc+z8Jkra26H2uUea6S16xo04XejIK7jXp79kTSSIWxh8y
 hlavpKDWhcnz5j0X2LeG1LTtyf5q+fyGQAjkoe6eiEJ3xwZkA7rCd9nkJLRJZMRU5O21
 t4VA==
X-Gm-Message-State: AOAM5318o9Eap/Q0dPpdXhecQTMpU0shKexE5EcxIKMJX4pGVPVeBKFu
 L/VgMyAdbFdaFMVHA1bXT5EKJ5RqsQ8RF5JpUY8=
X-Google-Smtp-Source: ABdhPJx/Cl6q3jd3Y0UMnwozkcZAjDceOt2Er4TDCLYHyDTi6gqB77pGxZs0hLGbAvpCUV1znVIZxUUk8EW37tNIpcg=
X-Received: by 2002:a17:90b:113:: with SMTP id
 p19mr5377909pjz.129.1589978413555; 
 Wed, 20 May 2020 05:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200511145257.22970-1-geert+renesas@glider.be>
 <20200520121420.GA1867563@smile.fi.intel.com>
 <CAMuHMdW9EsRLYYTL0pd-PqqZs5WcUfK8i2uceNwJnSvAQKuVgw@mail.gmail.com>
In-Reply-To: <CAMuHMdW9EsRLYYTL0pd-PqqZs5WcUfK8i2uceNwJnSvAQKuVgw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 20 May 2020 15:40:02 +0300
Message-ID: <CAHp75Vc9=1cD81TDuaGuFQpBcHaKqEZKv8tA7ZGBbDJ6MKq6kw@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] gpio: Add GPIO Aggregator
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=andy.shevchenko@gmail.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Phil Reid <preid@electromag.com.au>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 3:38 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, May 20, 2020 at 2:14 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Mon, May 11, 2020 at 04:52:51PM +0200, Geert Uytterhoeven wrote:

...

> > Sorry for late reply, recently noticed this nice idea.
> > The comment I have is, please, can we reuse bitmap parse algorithm and syntax?
> > We have too many different formats and parsers in the kernel and bitmap's one
> > seems suitable here.
>
> Thank you, I wasn't aware of that.
>
> Which one do you mean? The documentation seems to be confusing,
> and incomplete.
> My first guess was bitmap_parse(), but that one assumes hex values?
> And given it processes the unsigned long bitmap in u32 chunks, I guess
> it doesn't work as expected on big-endian 64-bit?
>
> bitmap_parselist() looks more suitable, and the format seems to be
> compatible with what's currently used, so it won't change ABI.
> Is that the one you propose?

Yes, sorry for the confusion.

> > (Despite other small clean ups, like strstrip() use)
>
> Aka strim()? There are too many of them, to know all of them by heart ;-)

The difference between them is __must_check flag. But yes.

-- 
With Best Regards,
Andy Shevchenko

