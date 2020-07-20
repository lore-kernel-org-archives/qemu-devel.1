Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636C3C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 23:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2942080D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 23:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIChtKLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2942080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxf6b-0002Jx-DU
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 19:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jxf60-0001sW-Ab; Mon, 20 Jul 2020 19:21:20 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:45953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jxf5y-0002CL-IU; Mon, 20 Jul 2020 19:21:20 -0400
Received: by mail-io1-xd41.google.com with SMTP id e64so19425406iof.12;
 Mon, 20 Jul 2020 16:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rFBhgINNlJ6GuKDyOev5puWMRyBRkyz3ArJkP6pxiz8=;
 b=MIChtKLsM4ODl7MituXLFrwnmpE9uurZYIdLn82Q4HmgLpvw+ai3xdm1M+v7nPQ3xU
 kg1gy8uvH0kZH7O1WNDOSFUQzIPZDxBK0yzhmNEmJ5CtK3p6M55cbXuts9WucvmwcQf9
 8Y3rvCPbNvNZ1QBWvMF8c7IU2vfS9OZiEaWUkvMwiNyN9kJppYwsIS2G3mhFAdfb1Wa9
 UlXg48d/xdJLGBv24285FVPF/QQqvtu9/9OZrjsFeIqZNxRdbzuK166ACy4GqjxQWr2x
 wxtQc4ybYb91O1nFu/3cThTJDDfqsw20mmoR3JhkpUoTlwYqmBS8DJpfiBXjTvlRnNRK
 ODmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rFBhgINNlJ6GuKDyOev5puWMRyBRkyz3ArJkP6pxiz8=;
 b=Y3eWthEeBKdX7B0+DQdfPwItja1TQYY4vx8kL+24a1ujgV8yqoXsHIRNQZT+H+dPbT
 Jf4iXVOpOXJR91X9D0ka5maSnc0ma9Tzb7+n7s4hLKSKZOOkBkyqB2DrcVA3/4e/ZTFi
 37/bCYypW0VV0C0sEri84ogOPRGc+rDSpMFflHeBVlIRkyEolGVIstpO0LbkKerJsluN
 U6nb5gyWWtCMZTfQlJVfHn0qNk8j5i/xAavfupwDxp1HHuMsr/KU89VzpmX6IDdilSVG
 Vx4JiOGJ7TMzPmzr8Q++6XkYY3/bDO5Y/pNJ0iit2Hq4FNp66sOlrFETFnXHNCYzTW8C
 o8ng==
X-Gm-Message-State: AOAM530f2Fkuf3ddTplpMIT9BJOQBtPpf9fM7Wt7eFBRhUu7HCpr1PES
 4vyV+pvw1TQq5zc5YGm74Efqe8Kp0DAnRXdqzGs=
X-Google-Smtp-Source: ABdhPJz+7GtKB8GCkNotLBdaEcYr6D26fZVKplbdsejWPMLiIaZj9XkcCQ6oo0RtyaLMVIZik2vsLwd2kpOEXedykdw=
X-Received: by 2002:a6b:8dd1:: with SMTP id
 p200mr25230083iod.118.1595287276945; 
 Mon, 20 Jul 2020 16:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200718002027.82300-1-jrtc27@jrtc27.com>
 <20200718004934.83174-1-jrtc27@jrtc27.com>
 <569659ed-7b03-7440-9167-855e92301f13@amsat.org>
 <92816800-F7B8-45CB-9863-96B8DF526D29@jrtc27.com>
 <CAFEAcA-EHOVEQLGaF_wu3d-LVvC3+bDHo0=xyvzG+769Kus7WQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-EHOVEQLGaF_wu3d-LVvC3+bDHo0=xyvzG+769Kus7WQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Jul 2020 16:11:11 -0700
Message-ID: <CAKmqyKNLL+kDtPXOHd_oSXXLi2P7Zemfu6fPtk9DWd4xKDNWbg@mail.gmail.com>
Subject: Re: [PATCH v2] goldfish_rtc: Fix non-atomic read behaviour of
 TIME_LOW/TIME_HIGH
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup Patel <anup.patel@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Jessica Clarke <jrtc27@jrtc27.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 18, 2020 at 11:09 AM Peter Maydell <peter.maydell@linaro.org> w=
rote:
>
> On Sat, 18 Jul 2020 at 15:45, Jessica Clarke <jrtc27@jrtc27.com> wrote:
> > On 18 Jul 2020, at 08:42, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> > > Maybe easier to cache the whole u64, this matches RTC_ALARM_LOW /
> > > RTC_ALARM_HIGH pattern (goldfish_rtc_vmstate change not included):
> >
> > We could, but why waste space storing an extra 32 bits you never need?
> > I don't think saving all 64 bits makes it any easier to read, I'd
> > personally even argue it makes it slightly less obvious what's going on=
.
>
> You could go either way. (The original Google-written version
> of this device model went for store-the-whole-u64:
> https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-=
2.0-release/hw/android/goldfish/timer.c
> but we don't need to follow their implementation.)
> Since "save the high half" is the version you've written
> and tested, I vote we go with that :-)
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Applied to the RISC-V tree, this looks like a bug worth fixing for 5.1
so I'll send a PR soon.

>
> NB: this is a migration compatibility break for the risc-v
> 'virt' board : up to Alistair whether that's OK or if the
> more awkward compat-maintaining vmstate subsection is worth
> the effort.

I think it's ok

Alistair

>
> thanks
> -- PMM
>

