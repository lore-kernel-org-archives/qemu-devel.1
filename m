Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF89C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D667821882
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s2V/mrcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D667821882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSn0j-0007JS-Rn
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 14:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSmzx-0006iZ-3X
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSmzw-0003Mg-2B
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:59:13 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSmzv-0003MS-SB
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:59:12 -0500
Received: by mail-ot1-x343.google.com with SMTP id t4so2981753otr.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 10:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AElnjW/mYcAgwrm29I7AGnbwBtUppvQcO+f64czNZGM=;
 b=s2V/mrcyxNJTIeYuio+bsngsARa2kDzDpttLRtzJ2fN+WxkVe2D97yShaFMvWvqgy4
 ci2N7kwOv23L6ZV26kU6ttJ+LZz/hc7nrMJfOvRmMV5KGpzbmaJwrKB6RplAQgOJdGgc
 LqXAfxy4wNRJDVFPpr3Rb6/jFV9JGldVRNfns1vt/DGz5PMHoGWAPVGIXOMHBU1QrBL9
 IymkPligk4ZeOMbMqml0RuYtjcwVpKkbeWB4CI18p4hJs4l83j94Q+d4Ih5B5J1TSRbs
 exw9tYr+wtsfPOI/qHol7DEc0iibaVO4gRty7pZ2xqd3L4axxHjV0BoLmq+wg/xs5e1K
 dLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AElnjW/mYcAgwrm29I7AGnbwBtUppvQcO+f64czNZGM=;
 b=lt2U8tRptQy9JAekfdt/iHJekIC4xRL3Vs3Aa3IZYqBSwt5h48yjVzn3uRgKt22LOi
 tfmx1PXbA9MLNqzGKdWTmprroAzhZSq4rrrZw2PjqNOwLcy/jX5BoSTtm7zgZNjCfEJ8
 221ark2oZPBGe1oY797cVAWlYqvSMVXpQYSgPY74VAO0GGfU4d62zvb7B3uS6xxSctw/
 z8XKarjfeq6Nt/ajeMaEtP0K1lcVMiJudlhoGoTKrU+uiewXicn5ku7gUSK9Ad/e72PK
 WXH1s7ZcP3Qrj/k5LntOjAH8Rn2fDjST2prfnXuqKwbUAyQTdo8dL5BmoJTisapiHByS
 yPOg==
X-Gm-Message-State: APjAAAWqEO+5aLSk4DNcYM83tv9sVEhi63EeR1TKXZLLj93Xv+DdceEF
 1LdZnFGItmHwrFr7zPus13h/ChPpcGpAe1fWnNB05g==
X-Google-Smtp-Source: APXvYqzp2DXwmpqy8Y3P2etHDBa7cKtTjcZ3kc4LBJTUuTMd9LkcECO0YxLIH9ya53T9YGR7DppSdYHvpL17KH3SZP0=
X-Received: by 2002:a05:6830:1386:: with SMTP id
 d6mr4302524otq.135.1573153151052; 
 Thu, 07 Nov 2019 10:59:11 -0800 (PST)
MIME-Version: 1.0
References: <20191107085525.30902-1-kraxel@redhat.com>
 <CAFEAcA-N=c5ghYz3y9vaG0yx-rAGHLdFUcxqWf4vnW7uX37LiQ@mail.gmail.com>
 <418ce09f-cb48-b338-24b0-c6f9a3efcf08@redhat.com>
In-Reply-To: <418ce09f-cb48-b338-24b0-c6f9a3efcf08@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2019 18:59:00 +0000
Message-ID: <CAFEAcA92kap7uvkmwW_SKqh18gW_qtAqnOoLyJYRjYBssSs_tw@mail.gmail.com>
Subject: Re: [PULL 0/1] Usb 20191107 patches
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 Nov 2019 at 18:57, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Hi Peter,
>
> On 11/7/19 7:26 PM, Peter Maydell wrote:
> > On Thu, 7 Nov 2019 at 08:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >>
> >> The following changes since commit 412fbef3d076c43e56451bacb28c4544858=
c66a3:
> >>
> >>    Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-nex=
t-pull-request' into staging (2019-11-05 20:17:11 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>    git://git.kraxel.org/qemu tags/usb-20191107-pull-request
> >>
> >> for you to fetch changes up to 1dfe2b91dcb1633d0ba450a8139d53006e700a9=
b:
> >>
> >>    usb-host: add option to allow all resets. (2019-11-06 13:26:04 +010=
0)
> >>
> >> ----------------------------------------------------------------
> >> usb: fix for usb-host
> >>
> >> ----------------------------------------------------------------
> >>
> >> Gerd Hoffmann (1):
> >>    usb-host: add option to allow all resets.
> >>
> >>   hw/usb/host-libusb.c | 13 +++++++++----
> >>   1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > This didn't quite make rc0 but it'll go in for rc1.
>
> Won't this make bisection confusing?

No, why should it?

thanks
-- PMM

