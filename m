Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCC1C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B1D4214D8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F27UrldN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1D4214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioWQs-0005OI-Ey
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioWQH-0004xD-Op
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:44:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioWQG-0005a7-56
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:44:13 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:43540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioWQF-0005Ze-Vj
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:44:12 -0500
Received: by mail-oi1-x22e.google.com with SMTP id p125so14275196oif.10
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 09:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P7eHAz5mcNcroFfxygl3II5gVJOFkCaM9qNK+ynFwA0=;
 b=F27UrldNyTGJXW/LMRYzhHmqwcLsm5RX5g3/rIy9KcRTxtKJSCnhXpCCzTMtBsBfTC
 x8bD6SQZkN9rzpPPCtZGYkUw9srSzojAUDTAodofRvuWpoIRZ6s82haOJ1eYWzYcV+IH
 h1jXC9qcbBM10douwFgb0/V/bH2gRw5g3SwySg2SEoFioQPLxOX+cbPIbxba9yAS6zPE
 wqKm4U97Tl3HZ9mNjxHU9sP5ik5Q3NNJfjN1lYqpUXbgdcJiaydFr3s1LTYbmDNB97zZ
 uk9FtXK6ekM/1mE5IlcE77R2M89si2q8gHFOlbZQ/Sw+ke/ei1jPgQyWiKVFL0FKaA0/
 kT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P7eHAz5mcNcroFfxygl3II5gVJOFkCaM9qNK+ynFwA0=;
 b=LEQq55wHBP3TZrr4yqAZBFgiPLJBUglMfoDTLgL+PXRjWGfXpBT/xo1E5GseIWebgt
 qENA+6p2VixKBL3y5FJEC03WjBJY4kdrmY8/iL0amh2pLON1aZXqxDAQL6UaRfWBOFKw
 aB77refYEdvQDTp9MjBQGDIY8eT9R6rpFLb/DiFYso/dG62n97j9o7m1dQ1hVp3YME/C
 xoq/v7I76ET+ma7UtnpvIgnEOhLDI3VDxQRe5QVp1hyloW/hklHzxogzZxZTkNrE6P3h
 e6zNTVcZehK9a/FT5E+jzlF936/1T0ZvbfYN3tt57bP9gTjIxLVClnXrX+2bMj4r55Dp
 bukQ==
X-Gm-Message-State: APjAAAX2/Rw1Ipdw9Ny9mj2RJs/OnLZZmAVGJQdTOQCnw66oMP5hb8o+
 qp7ZTfWaYhK+p4End0X8Dqd4j7omrYm39ZYSp0ZOJvmCiN4=
X-Google-Smtp-Source: APXvYqxzlFhmJUc4I2HUvERs+J8JR4sGCkLxS2oJL+IShD0CaJZpjt2NwIIHLF1cSMR6Y+/ycyV1bprGUiI3eCgosRY=
X-Received: by 2002:aca:570d:: with SMTP id l13mr5763711oib.146.1578332651156; 
 Mon, 06 Jan 2020 09:44:11 -0800 (PST)
MIME-Version: 1.0
References: <20200106125236.24132-1-kraxel@redhat.com>
In-Reply-To: <20200106125236.24132-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 17:44:00 +0000
Message-ID: <CAFEAcA-bB7f3NSvtzb-qhg-WKeDN9f8RNgp97NEbZBNhufNSFw@mail.gmail.com>
Subject: Re: [PULL 0/6] Audio 20200106 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jan 2020 at 12:54, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit f0dcfddecee8b860e015bb07d67cfcbdfbfd51d9:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-01-03 17:18:08 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20200106-pull-request
>
> for you to fetch changes up to 40ad46d3cc463fab5a23db466f77e37aff23f927:
>
>   audio: fix integer overflow (2020-01-06 08:47:16 +0100)
>
> ----------------------------------------------------------------
> audio: bugfixes.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

