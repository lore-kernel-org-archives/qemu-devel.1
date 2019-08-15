Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29F5C31E40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEFD52133F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wBfVWNCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFD52133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyBkW-00080z-Gw
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 05:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyBjj-0007Tq-7C
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyBjh-0004t7-U0
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:07:59 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34623)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyBjh-0004se-OM
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:07:57 -0400
Received: by mail-oi1-x243.google.com with SMTP id l12so1120117oil.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 02:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CksL2Rd8GnSo3oAgBusZJpqmaVBK/FhSThWunfJd6U8=;
 b=wBfVWNCIF/AWEHegT+JPYKK6a4HIaZP3I1jhQew9szqgD9HlDKsGSUlCWihykMCYAt
 vSh8lsruvcBoQJ6oLgXbQ1LjPUtHqTJKaBL1P9YvMc1z7NGiMqqSI54AIS6vMuBQfd7y
 KXerwzfBwOEacOkY+JdMNbSV83KiHF2AiHLovwVJdOMg9oHu9ytzrIQ3k38GhehkJ6ot
 e1Fjq7BewKJSioMey66/nDjcZSxAkp7np4RH/xNzD8gQMcRz184Vt3S7QEX1sdK8Xf/8
 7A+1V5HEk2vOXUi4IsW9mW+R10tPk2PLMjzKWRsEW5gtIg4DqOTHIF72VD7IdfbRsdhF
 7p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CksL2Rd8GnSo3oAgBusZJpqmaVBK/FhSThWunfJd6U8=;
 b=GkGbh+M1KwhShd6YjCMXSbfMk0igJExypv5qmdeDqn+4ggegn6lCgxYWTCUE1AyJlW
 1OuaJxC8fZiGM49rceaW76fxCd4v2MVfYOJfd2QmN19eC6Yddsx8NFMs0W+8iEUvVGis
 SXyeKaODCeSzgpYhX51czekcLDfZh4ig6JqNqLI2FWfAO6dYo2lWBIF2/DSPzf4vBzg1
 1rFs+2Xl2tcp3qMm9PhLLSXwLJr2MJtAtrNDqwwvu+0ZIOnr4nQ1STUGXiVIkPmaC+YX
 M1uUcnXum0/SR1qkRRwpcAMgah9VBiDX6EmsMGGXWD+VnBtcumnQvFwxouiJ+jAx2Kbd
 sbCg==
X-Gm-Message-State: APjAAAVVWzzQBKJyxLQ1XGxWPJBF/CwQcFWXIhfOeU2cK1XnozFy/ye6
 2VKZbPZpZ9WBUfFV19lRDi2ztOz2lo/sqzl8+bF77w==
X-Google-Smtp-Source: APXvYqwjmNZ3wh2syUcMDloczheJykmHZIm94YuTV3VF6bJW5JR447sxx9AIPERtJjAK/51s9ST+ubiN4TeUiHJz1sc=
X-Received: by 2002:aca:4a57:: with SMTP id x84mr918050oia.170.1565860076715; 
 Thu, 15 Aug 2019 02:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <97a6ae9f-2845-4a3c-2a31-367787622268@c-sky.com>
 <CAKmqyKMqCKS_-rxZ2WYEn+m2gDom27rd2f2FCe0LmVs9brPcAQ@mail.gmail.com>
 <c502163b-ed8a-89d1-6437-9b0f49e88a84@c-sky.com>
 <CAKmqyKM5zneojhPe57h1+h3pav5kQxFaMnhNiwWRUa=nbzS3Ag@mail.gmail.com>
 <CAL1e-=hVLQWThYSm78bTCbQPfAABjx_rG9nEa9gV6PvSN8ge2w@mail.gmail.com>
In-Reply-To: <CAL1e-=hVLQWThYSm78bTCbQPfAABjx_rG9nEa9gV6PvSN8ge2w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Aug 2019 10:07:45 +0100
Message-ID: <CAFEAcA9bDU4AWetkR4w4WLUzMW_MMy0CsVa5SibWqf85RyaX5g@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] RISC-V: Vector && DSP Extension
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, bastian@mail.uni-paderborn.de,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Alistair Francis <alistair23@gmail.com>, LIU ZhiWei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Aug 2019 at 09:53, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> > We can accept draft
> > extensions in QEMU as long as they are disabled by default.

> Hi, Alistair, Palmer,
>
> Is this an official stance of QEMU community, or perhaps Alistair's
> personal judgement, or maybe a rule within risv subcomunity?

Alistair asked on a previous thread; my view was:
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03364.html
and nobody else spoke up disagreeing (summary: should at least be
disabled-by-default and only enabled by setting an explicit
property whose name should start with the 'x-' prefix).

In general QEMU does sometimes introduce experimental extensions
(we've had them in the block layer, for example) and so the 'x-'
property to enable them is a reasonably established convention.
I think it's a reasonable compromise to allow this sort of work
to start and not have to live out-of-tree for a long time, without
confusing users or getting into a situation where some QEMU
versions behave differently or to obsolete drafts of a spec
without it being clear from the command line that experimental
extensions are being enabled.

There is also an element of "submaintainer judgement" to be applied
here -- upstream is probably not the place for a draft extension
to be implemented if it is:
 * still fast moving or subject to major changes of design direction
 * major changes to the codebase (especially if it requires
   changes to core code) that might later need to be redone
   entirely differently
 * still experimental

thanks
-- PMM

