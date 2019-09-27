Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C87C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4016920872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBTy3hwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4016920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDtpE-00059Y-Rv
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrtF-0003n0-W6
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 11:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrtD-0006oU-Pr
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 11:10:37 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDrtD-0006o2-8t
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 11:10:35 -0400
Received: by mail-oi1-x242.google.com with SMTP id o205so5442628oib.12
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oDB8EllkV6hJE5Q1W0qZoUXhMkoU9z/410kgIlQT1Zk=;
 b=FBTy3hwEJpjZh6BKYr4V7hj72pVNA4L4oHSPuG+b0W0noxdZquYJImprKEIiBWN86i
 DJsFXQU92/avbtFclrnwIXTk4lzGv3+YD0gCYNqJxP8CkRgitVOAg8L3rsVwG5P1lo8K
 Wh4D5is9AnPYgM0TRgKWi54SuW1UGBYlfeAwsvgy4xgd6k2Fkfday9ZrP5YYayDsR0ie
 lMQxWVVMZVlzMpKxNMF/iwrWxxXqOv+pppKql2J+f5725OStRFZOF2g/MRlkzdEX5rlT
 wT27SUdtLrbKQtXl33q+qHudrRl2I3tR23pydK8QK6AGUZd7BYZgOXgMgjeteR0qPZar
 MAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oDB8EllkV6hJE5Q1W0qZoUXhMkoU9z/410kgIlQT1Zk=;
 b=WhXXDwMne1gmDSqGsu2wmPdoNVOuzB07f9kQQyZZeKSTcykZxtu7kLx3SgdsvgV1d2
 hVS/Lmb8tg0orHwNDzxQq6du/WE6tpcZ0L9VqPfxXbPKtvq8fVFn3eMqLHynlaLy5UH1
 ynYp4zoNsIDNvg4Sml+akcIfEiOAwcNifRYXKSNpc8dePj+lqvI/nt0P+YDZGj6DhFQ7
 iWORUgIPrs1nuDGiV8uoYgQfbe/Z6OlthIJ/8AHth1FLGv4Kk8qT62g8AeVaYOu/j3VE
 XSVn9I+qg3lHjhy1RM0l6+TwDHRJuvF1VJwNIDJaO6u2Ada6X7UpIiOgASa2u8KbUqGD
 IORw==
X-Gm-Message-State: APjAAAXdRpaFPhH9+unkRIZ5zEDQetl7U2fSheg0fktgystx6Iqq+EHV
 jtrdGazltIxuR2EDcxHW974qRGDPd3BhAhCZzX06ig==
X-Google-Smtp-Source: APXvYqwIuuIQSyOzTDZdjqcqdDTL6IdiaZfRmLa2GPYWwcM/SxkTdSrGMrtjyhh0vE1b3y9YdmoVAlrYzYzqVHrsIiI=
X-Received: by 2002:aca:53d4:: with SMTP id h203mr7231655oib.146.1569597034055; 
 Fri, 27 Sep 2019 08:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567750222.git.alistair@alistair23.me>
 <CAFEAcA8gLzitZ8OKU+Ht79fsU1BOguxEu9FvafD0vjR9cJKx7A@mail.gmail.com>
 <acd9fbba-71af-47b1-911c-f8b88e806cac@www.fastmail.com>
In-Reply-To: <acd9fbba-71af-47b1-911c-f8b88e806cac@www.fastmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2019 16:10:22 +0100
Message-ID: <CAFEAcA9XEkMaZTut4zp+43e3WDhRMu3HQrwvpUYOTziR=nbwyw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/6] Add the STM32F405 and Netduino Plus 2
 machine
To: Alistair <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Sep 2019 at 15:07, Alistair <alistair@alistair23.me> wrote:
>
> On Wed, Sep 11, 2019, at 11:49 AM, Peter Maydell wrote:
> > On Fri, 6 Sep 2019 at 07:10, Alistair Francis <alistair@alistair23.me> wrote:
> > > Now that the Arm-M4 CPU has been added to QEMU we can add the Netduino
> > > Plus 2 machine. This is very similar to the STM32F205 and Netduino 2 SoC
> > > and machine.

> > What are the changes for setting initial SP and PC for?
>
> If it's not set the the guest code jumps into some broken address and crashes at boot.

If this happens then something else is wrong. The CPU
should be reading the initial SP and PC from the vector
table that's in the guest image. If it's not doing that
then we need to figure out why (perhaps we're not setting
the correct value for the vector table base register?)

thanks
-- PMM

