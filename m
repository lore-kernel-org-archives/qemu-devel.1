Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1BFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 21:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E1521739
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 21:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BD41emc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E1521739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwCKu-0006eX-0U
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 16:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iwCKA-00066l-V7
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 16:53:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iwCK9-00070v-RU
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 16:53:38 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:46161)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iwCK9-00070K-JO
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 16:53:37 -0500
Received: by mail-lf1-x144.google.com with SMTP id z26so7435952lfg.13
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 13:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FSxUlbHmoPGnQ/ALbAy10kMhC8x7z+0r4aZNKHWbKYA=;
 b=BD41emc9LoQV4Xy4DZGlJu0Ys31e8oxdapeFEUTHe8zKFn2Nq/x7WTmWWVb6MWSDW1
 mZfiJWB6t4gE9X9l5rTgghqY7oR5BXhNSNEDKCcE1n3reldgschENjpdCdChy2FXTNPX
 86GZhEpBpN2ozKuWrO+5LG2qn4/0lcKhRKtXvldr+xwf3vvCh1eLZjrWAkan7qun4cQL
 bp3ucpzxMOFBMKGNToajBHNH2+TYkSv1XEysdIWe7BGddP6ReIrLoLnXErMS1CkWBetU
 c4+lFxMETTHUNW/7tyhV7EtzfFiWomV/DWidEmPNleObqTCRWWuJUhYzaEwvphicx4J4
 1+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FSxUlbHmoPGnQ/ALbAy10kMhC8x7z+0r4aZNKHWbKYA=;
 b=ewGPq/4yyV86FSTRY2TVRufzdOwPgjvrw/80+aZwFGN4hO0wHg0H5W0RcndGYMYYaq
 /IcYcb5rpQkNIh0ppSEPSvThTXVLECFf/AwPb9mb5NnnvKQplbRfrE7sOcoNkw+J9+y0
 PJKNKL5Bm35ZRTlUvO3hXLxOLCsKq3Pk7fY6YfTvyHUCMUqUI9cFdq/SudTmoFLVI2Zb
 VJMW8QmlM/M3j2RKDAuhxQ178/A6EZD/znEVJwpikVneGSBSa79d2onCSCwLK5/1cdCP
 WnUZ5Q159QTbhIBVFmc8jC2Izf/YCA3wWvU/7/sg9g+SsXJrhRK7FMi/9tPVfc0N0ID3
 0iWA==
X-Gm-Message-State: APjAAAUUwWukRc0QwMmJJXofuK7OnAeakxkLumvgyZ9MIFV5qsh6XLgm
 tv+/8OC2cQVolKcP7rKnBKno1XU4Nv5RCg2pjkHmSg==
X-Google-Smtp-Source: APXvYqw6ss0nj1wiAs+TIdoZ4Q7VohIpf3e8HiiLe8JAB9XJcMz4dZ9z5TdCsg9+J1a7y2cDLZLVpoFsOO7VgO9t69U=
X-Received: by 2002:a05:6512:1cc:: with SMTP id
 f12mr446681lfp.128.1580162016053; 
 Mon, 27 Jan 2020 13:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20200124165335.422-1-robert.foley@linaro.org>
 <20200124165335.422-8-robert.foley@linaro.org>
 <87imkxeyew.fsf@linaro.org>
 <CAEyhzFtRV_4oss4gxYJi5ojGrXvNZExXfM+Ae-idLqidtcPpcQ@mail.gmail.com>
 <20200127172716.xvfkyhqznjlxefgn@kamzik.brq.redhat.com>
 <CAEyhzFs9-b4QzemPGY9+3KABV_maq7iCQ1u7m-HKcHWjTN3Cug@mail.gmail.com>
 <87d0b4fytx.fsf@linaro.org>
In-Reply-To: <87d0b4fytx.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 27 Jan 2020 16:53:25 -0500
Message-ID: <CAEyhzFvf8uArzwC4=o3WZWx5V1qDyAiq_y=nNarSw=9rNTkYug@mail.gmail.com>
Subject: Re: [PATCH 7/8] tests/vm: Added a new script for ubuntu.aarch64.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: fam@euphon.net, Peter Puhov <peter.puhov@linaro.org>,
 Andrew Jones <drjones@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jan 2020 at 15:07, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Robert Foley <robert.foley@linaro.org> writes:
>
> > Hi Drew,
> >
> > On Mon, 27 Jan 2020 at 12:27, Andrew Jones <drjones@redhat.com> wrote:
> >
> >> >
> >> > I suppose we could check the version of QEMU and use the above
> >> > defaults only for earlier versions of QEMU.
> >> > This is something we will probably move to aarch64vm.py since it is =
common.
> >>
> >> What versions of QEMU do these tests *have* to support? Because we cou=
ld
> >> just skip the tests for QEMU that doesn't support cpu=3Dmax,gic-versio=
n=3Dmax.
> >> 'max' is indeed the nicest selection for using the same command line o=
n
> >> KVM (gicv2 and gicv3 hosts) and TCG.
> >
> > I believe these test scripts which build/launch the VM have to support
> > the older version of QEMU since
> > this is the version of QEMU currently used when these VMs are
> > launched.  I don't know the history on
> > this, but it seems intentional that we use one older/different version
> > of QEMU to launch the VM,
>
> Well we defer to the system QEMU as it should be stable. It can be
> overridden with the QEMU environment variable which worked well enough
> when we only had VMs of one architecture. Perhaps we needs a new way to
> say "use the appropriate QEMU from this build"?

Good idea.  This is a pretty common use case and it makes sense to
make it easy to use.
I will add some support for this in my patch series.

Thanks & Regards,
-Rob
>
> > while we test the 'current' build of QEMU inside the VM.
> > It also seems like a 'nice to have' to automatically support the
> > latest version where we could
> > use max as you pointed out.
> >
> > Thanks & Regards,
> > -Rob
>
>
> --
> Alex Benn=C3=A9e

