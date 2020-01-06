Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15BDC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A92420731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VquWLChL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A92420731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUYs-0005BA-NE
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioUYD-0004fr-Rg
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:44:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioUYC-0006R4-JD
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:44:17 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:45813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioUYC-0006Qp-Dy
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:44:16 -0500
Received: by mail-oi1-x229.google.com with SMTP id n16so12085297oie.12
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 07:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cnXLeEww/UxELA+FfCliH5roA0WLKxxsejw5QZT5e98=;
 b=VquWLChLNAKF8UNe1FYJfLhrEbozxTmpSNarX13ltUKzyt0IpVuHcY9uPC05/5TNml
 zNkmZ2N/JAEaOv+2I09qkEE857dHtD5C3Hp0L7ZjYEeCu7JTh+0qSivMG7vYI1ZfZl3M
 vwRRI7/abpvWqRu22xdVMP3hI52XbGPsD7JFvl0ceToyjmFqTc7ekEJ6bPcf0fmx5l5S
 opVdCQJQ9RZ+UQhB25LuyivXatfiZHdX2FTdlIcQkKrOoMidQ1aocuYR53hHKaMCir/e
 hABAvjcYh/dC5UqDuhFp8Nf2LJswqjk7ZpFszW9ISs4LL6URxqePB0gNJZyiDNqtDc8W
 L6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cnXLeEww/UxELA+FfCliH5roA0WLKxxsejw5QZT5e98=;
 b=T/juqybRKuI/2M07G9FFE2532uizD8D0a/OxRy8lqg582eXzI6v6q9z6GSsSSxaSyx
 JzDpm30jsq08oY9DiSN9xaV12m4nr8wK/XySrnW6EMtvX+NyVLm9uDEAVaUNxHIfjFbE
 L8tk9SWsAzmql5Pez49Eyea01xZmzkUmT0QnxzoNAmiIIM0XD5js28jiOL9UEOi4l5e0
 1+9HCGMpOPIczubuFQNBzbsX+yzcTmeUB6E26pDUbiY6R7UN0xG62EAFbRFWPkd11HZc
 HCd6oF2a1uwEyrtKDO1OzTkwjGSTip/xKwNcwtDQTt18mq2d1+PwrHF3assMqGRZzl+e
 ogtQ==
X-Gm-Message-State: APjAAAUS+ASnN0TzvvOWYvo+Ud8r7e7iNf5WfddO7p5Ck3/KGIS98oPa
 Hm5i9r6Vgz0XEyc8+G0A4hG2cx8lv92r4ubeTNE0VQ==
X-Google-Smtp-Source: APXvYqxlF9dJtTlzWo0eEniIkgS+MwDqs3r9K8n8OkcFNsGNw5Cocp01RRkwJoFjzfDhCglYR/diowowABMf6AWJbn0=
X-Received: by 2002:aca:570d:: with SMTP id l13mr5423595oib.146.1578325455513; 
 Mon, 06 Jan 2020 07:44:15 -0800 (PST)
MIME-Version: 1.0
References: <20200103090853.1014627-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200103090853.1014627-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 15:44:04 +0000
Message-ID: <CAFEAcA9LzQeevZyvYU0sqMGBNQedh2L4rh8S5EK9+TyewQvmug@mail.gmail.com>
Subject: Re: [PULL v2 0/7] Screendump patches
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jan 2020 at 09:09, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit dd5b0f95490883cd8bc7d070db8de70d5c979c=
bc:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20191219' into =
staging (2019-12-20 16:37:07 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/screendump-pull-request
>
> for you to fetch changes up to 53a61ecbb16b28c707f0b126193d226a25c28cb2:
>
>   screendump: use qemu_unlink() (2020-01-02 16:29:32 +0400)
>
> ----------------------------------------------------------------
> console: screendump improvements
>
> Hi,
>
> The following patches have been extracted from the "[PATCH v6 00/25]
> monitor: add asynchronous command type", as they are
> reviewable/mergeable independantly.
>
> They introduce some internal API changes, and fix
> qemu_open()/qemu_close()/unlink() misusages which should be quite
> harmless.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

