Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5179C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 14:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBBE215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 14:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fg0U8usU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBBE215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59sA-0008B1-HR
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 10:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i59rX-0007g4-8X
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 10:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i59rS-0000Pj-26
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 10:32:50 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:34215)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i59rR-0000PM-RF
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 10:32:46 -0400
Received: by mail-ot1-x32f.google.com with SMTP id c7so16996366otp.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5UyvRAHntucO6SNaPXVZz/4/abhwLE5K7LZciVLsYLo=;
 b=fg0U8usUc7V2ZyXQdMJy4eTLiXjISMBCjJoHeshxefWM/khIvVdaS63LmjsVSkksSJ
 u1rG1YtVqweHCcplqwUNPWXtv3twH4j3+vRalye3QcRGBiLpTSeTCeaC5AiHh0VxL0CA
 xGoox4fV9UNid9i4V9dFL/P+xhev9sdltT/DITwQuBR/BKTBrTqH8FpsMEX6+XXbuQQO
 Hg8Wchx9LLcDzwF/MgeTwOYk0zpKRr1JkM+6E/rssqGkPOt0Dt0H1aiwqzNo7ehEPhfE
 B8I03xqsaGH9ODJDx2cKVEnJ22YXCaLfK+1OUdEsgwDmmluyKtEk43LeT+xwfWKoGEvD
 Rbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5UyvRAHntucO6SNaPXVZz/4/abhwLE5K7LZciVLsYLo=;
 b=KNINBMtYxH2z6+Y/rUVsOThe5rbuOCjpEnTg2F23kvPcP1fYpLT95t8jDrUEsk04EZ
 UoH0ha87UQeMxBEUTLGGGVZJLSn8CF5kkiXnxdH3xQxAjg6C1ZTpx3UC4kgoexzVcWy+
 Hyg6dowXB/kP++vHQugnjnpOP9O3ww45N2SA5csm1Pqk0jy+2MpG88Dgs6T6qXKqdnaE
 wDVz/snWo/JACSZSpluFIIAIwn9QKjqPQM034YWxoKjS7gcIwP/SL0E+eJbotkNIOaQ1
 czWXRaNsFnHOZbwb3pbzu77mb1dU1HSkEJgtZOFOYhbxYLdiflWOWq+L2/lNlqMyaOOY
 rKWw==
X-Gm-Message-State: APjAAAUaedOO9TmeebFeE+LiFRI23WDqHpBsKQnaoa42gAkOv44oFWd6
 /KRiQBnyEDHn80UM0D6N4wSqEVVu1OaQJjYjqJwmYg==
X-Google-Smtp-Source: APXvYqwR5sBXb4S58ja9ItQcmqqRheg5wbXMRajRaPe5Uj4pAR5/e8dul0dEdftT8jSPJxT3sXGglQOiGdpMGGiAFLg=
X-Received: by 2002:a05:6830:1bc3:: with SMTP id
 v3mr9595203ota.97.1567521164448; 
 Tue, 03 Sep 2019 07:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190828115332.28760-1-kraxel@redhat.com>
In-Reply-To: <20190828115332.28760-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 15:32:33 +0100
Message-ID: <CAFEAcA-_VFPgtMfmQeMYjTe+LePPQR-t7e43LQi=apiNU2o9_g@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
Subject: Re: [Qemu-devel] [PULL 0/2] Audio 20190828 patches
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
Cc: Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Aug 2019 at 12:55, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 23919ddfd56135cad3cb468a8f54d5a595f024=
f4:
>
>   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20190827' i=
nto staging (2019-08-27 15:52:36 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20190828-pull-request
>
> for you to fetch changes up to 4b3b7793e18e1e3edb90bbc21112e875f9ff826d:
>
>   audio: omitting audiodev=3D parameter is only deprecated (2019-08-28 11=
:57:45 +0200)
>
> ----------------------------------------------------------------
> audio: two little fixes.
>
> ----------------------------------------------------------------
>
> K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n (2):
>   audio: fix invalid malloc size in audio_create_pdos
>   audio: omitting audiodev=3D parameter is only deprecated


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

