Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B2FECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F97F214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwViSre+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F97F214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL3aN-0007CL-DP
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 07:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL3Xp-0005PB-V2
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL3Xo-0004bx-4y
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:02:13 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38486)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL3Xn-0004bR-MN
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:02:11 -0400
Received: by mail-ot1-x341.google.com with SMTP id e11so1503210otl.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 04:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wy6z/9IYH6VJTvm+8SyXRWMlDA5S6JAqstIePYsS06s=;
 b=EwViSre+XwgvgxTsb0S00DXGOeg6dSCLWdSBPW9r5mhmUvPB7r1LEwhFgs0V5b6SrW
 IieM+aTfw8FXDUbwz2mVZMtV7XkOajniZMgX+XxeikO6tnouqnNEtcnuwMOrglvkbW9U
 sQa1fmvbX5FbGFwSMdp9FfQ+cCWQNtg6JZwxsPcAV3m18QZePBNNvaQtiNIMiGXhlEV+
 aM7d3iCV14AjA/Yshn0+I42v8scLR4XFwyYa2nhw4n6KIGpMysgURfG9rF2ZOu4mhy1I
 eYN0JHsLqsWMqzQl0/FBCbY28boNgQN3OjOFfIsXpBynJNTEPPahqBlfngJYbbWm5cNy
 CeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wy6z/9IYH6VJTvm+8SyXRWMlDA5S6JAqstIePYsS06s=;
 b=FTBxpjs4a4w22N/2w/wJOwlDBZqsT8hguJWH9X/4o1y5N4NZHigprmFc6nJ9Y5npYU
 EO32fSUmPbxtbGXw6C2X9Rv7DnP1vZqZEQVMpVCLY4s4hpIcQki1FJDP/+ZdIWzskuZ0
 mMtamJGHmUjJFk3euuRh0BLLi7LqicxVc4EeMY3Yy7w+UlGE5L/nZjqJ4EAsfK5HRCDd
 /BNE4J1gALKGAu5H42s1z12MH6WAmWRejj03ArvPXM01IwGVWxwACVbovehZKKJRaABf
 t89QRXaQ+uIe/P4ywWT1CbQwu6MTaV754KJkHW3hiSAjgmuzqYq+fzmZUoHmDhpESnQ0
 Sixg==
X-Gm-Message-State: APjAAAX0ePloN7XnPcSNtC+Yuc4KV2hZpCK7hGSVBF7s74c4sDlLbT6F
 VH1Wq8IE+CYqIHbXWmlEyKnfS1/v/OXjgasi6n1BjQ==
X-Google-Smtp-Source: APXvYqzTnnqSlScS7C7jtqGJgjmOZ1/xfrxa1tn73U4CeRujNmUmC7xRinDsGDPOBXr+XKCebM+/zHrl81QR3kzf0sg=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr2495082otj.135.1571310130468; 
 Thu, 17 Oct 2019 04:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-jutAw2KFBDX9v=Q7LQ8_Mj0AHB79wi74hoW6J81fbhw@mail.gmail.com>
 <71badd7c-a9f0-ef91-5477-623389aa52fd@redhat.com>
 <CAFEAcA-0aYLbEoWf_ZeTxoLdKNaeFESyiuHi5KYG9kdUWaAJtg@mail.gmail.com>
 <1b52f4fb-c8e7-ecbd-9db4-32e7e9c5f1b5@redhat.com>
In-Reply-To: <1b52f4fb-c8e7-ecbd-9db4-32e7e9c5f1b5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 12:01:59 +0100
Message-ID: <CAFEAcA8xi5DLiErOfjm4PeGmtV15886ERY=6K7YSMq5onoMnMw@mail.gmail.com>
Subject: Re: iotest 260 failure (linux host): "OSError: AF_UNIX path too long"
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 at 11:20, Max Reitz <mreitz@redhat.com> wrote:
>
> On 17.10.19 12:04, Peter Maydell wrote:
> > On Thu, 17 Oct 2019 at 10:53, Max Reitz <mreitz@redhat.com> wrote:
> >>
> >> On 17.10.19 11:51, Peter Maydell wrote:
> >>> I just got this iotest 260 failure processing an
> >>> unrelated merge on my x86-64 Ubuntu box. I assume
> >>> it's an intermittent (have just kicked off a retry) but
> >>> post the backtrace in case it's of interest:
> >>
> >> I hope it=E2=80=99s intermittent, although I presume it might not be.
> >
> > It has indeed failed again. Is there some way to get the
> > build to pick a shorter test directory name, or to get
> > 'make check' to skip the iotests, so I can proceed with
> > testing until that fix lands?
>
> Yes, you can set the $TEST_DIR environment variable to a shorter scratch
> path.

Thanks, that works. It turns out that it wasn't "an unrelated
merge", I was confused. It's a merge that adds iotest 260,
which is why I hadn't seen the failure before.

-- PMM

