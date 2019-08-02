Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36054C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 10:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6511206A3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 10:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gazmgTIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6511206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htUfK-0002BR-5Q
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 06:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35331)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htUeb-0001Iw-TJ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htUea-0002th-1g
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:19:17 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htUeY-0002sZ-BW
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:19:15 -0400
Received: by mail-ot1-x341.google.com with SMTP id r6so77603425oti.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 03:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CBj75lFA57f2J1yI4wtEZHmkv33qyDls4xFWV4h1JJo=;
 b=gazmgTIoda2o5W9skJj4AtaT4830K/bJ3zgldbkZaaQ1+hskjWWAnu+veW3k8ZJrJz
 +3yXXqGw79X4/92uhErJ23sam7i29QY92gbHcXM2C/oZX1x/xIn2/XaAjb/plVWvlxG4
 o5/bEt1MczwKcZzE0+3lTf5CuSxq/XqJ4tkJuUOLRawENUgn+l4BYY/GxM6Q1zbpLTTk
 VDPFw9AsfkIbmJf8IOQinJjp62J4f3HyNmZcLPNtVaX3nxpI5e9cltfVJgYCfDGbdvhn
 8wAJxQFuoDO11DXTEAX/k45Z2ZROiRcYBU+XvP/hFzMy9KUaZ3JHZkSTkBdvkjrKq7mu
 E17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CBj75lFA57f2J1yI4wtEZHmkv33qyDls4xFWV4h1JJo=;
 b=nQxcv4a/gR1cbQsNBdKWBbHefhUs7q4SkVn4sOFQiFAzQYYPKjj+9SFNb1OwRMxsMF
 P7H7zU0xKYe3EACEC1NbwFfC+c9TPx7EaZgLbmRbzwyvr2DNT6Fk3WIFyicSqn5p1lTy
 Vq2tGzesMqGDPWlh/L5cs32ctsapDinu2Rhr1WS2JYNUsvYU6az+Bi9sFw1sSiD4UETT
 pSTpou2RAA3WH00VgzVxxCB4iDp3vDOMTBbjH60Vevx4nvaPRTxAMmH5wSleGX8q00yu
 9JCkZM6NPhZcC4CZuVCBbijM17Hbh/W5kS2Yiqz9QQFcbTRfPnThDcuW+/Yav2a3Qmhb
 o4zA==
X-Gm-Message-State: APjAAAWuJC1sTwK1MjClGm8ngbNvUy9qfjO6gzXEfie0HVzzI5yJv3oV
 rWXRFSXvIyCD3S63qgU7Ilw86RNvN+ef1le8INDkXA==
X-Google-Smtp-Source: APXvYqw0UFu9LR0pf7XEnqgmGOnaEvo0t/5AoopZywuaZ9CWFU8E/TpvjB/WR7Qtxvl/jjFxNEhEzCDDV6kQrREO+Bk=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr8408191otj.97.1564741152743; 
 Fri, 02 Aug 2019 03:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <156452993884.16169.12168229409049273970@sif>
 <3c6ebc55-9416-a467-cfbe-73d2df6a64f2@redhat.com>
 <CAFEAcA9Vs=N_kaO1_DHM=Azttp=1Ju=bKFMU3iZdt6-+J=Oq4Q@mail.gmail.com>
In-Reply-To: <CAFEAcA9Vs=N_kaO1_DHM=Azttp=1Ju=bKFMU3iZdt6-+J=Oq4Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Aug 2019 11:19:01 +0100
Message-ID: <CAFEAcA-dcHzyH0ojrpbKuq-NALToxRLjCwz9MiZqNfN2=xLLsA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 4.1.0-rc3 is now available
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Samuel Thibault <samuel.thibault@gnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 31 Jul 2019 at 19:17, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Wed, 31 Jul 2019 at 19:05, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
> >
> > >   Unless there are any release critical bugs discovered, this
> > >   will be the last release candidate before final release of 4.1.0
> > >   on the 6th August. Otherwise we'll do an rc4 and release on
> > >   the 13th August.
> >
> > We forgot to update the slirp submodule :(
>
> Were there any RC bugs in it?

Ping! If we want to put this into an rc4 can we have a
pull request with a justification on the mailing list
sooner rather than later, please?

thanks
-- PMM

