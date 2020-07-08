Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17864C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 20:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95D52063A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 20:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hK1dKwVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95D52063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtGr7-0002Ni-1D
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 16:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtGq6-0001U3-A3
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 16:38:46 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:33836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtGq3-00047R-RA
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 16:38:45 -0400
Received: by mail-ot1-x335.google.com with SMTP id e90so149036ote.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 13:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/lmBDDErMQnsqblwuLfnwYJ2dac4d6WimZDvDORMbgo=;
 b=hK1dKwVuZgic2h+hbw6LhEwlW27UpxpOx0cEtkhLi9W87K0lMoNF6Hj/CIaD75r5Mt
 uhj5+qePwGOQpGhXKN4KV5l4xD7LfnA7UqnOd9BO96v1SVkPpMuGDRrJ0R8ox0L2UZtK
 h3Wg7PSpNkI6oQFIHsy/v0OH1FeFIH733nl+HVj/e7Dz0x04tiMA/aM5XP5x5RVSQ2K/
 rUFxNStEXEajYaba7cFfJxlgw5ZlmfDGtqklIA0xbnK0jbiKkED9CySWIhdlHqzTYCyi
 qo2bczE7eq4kHtxO61QECJF0AcMhydzGIa5q8XtsqBuvryriMI3VDEVA1mYS4UmzkCT3
 ko2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/lmBDDErMQnsqblwuLfnwYJ2dac4d6WimZDvDORMbgo=;
 b=qhaIzz7HJ8RjJZyP0YuUNYhXTRok8Mk43bDUYCXKgYsX0SCMOvw7tNfhbGCF51jMhh
 eZZHk8QqS2Pc67k3+Hq8C1mivZmO1MIAubMQl28U0I7PAk/L+uStEAYUtHvgYjEMPrMj
 dCZaqN4cUFZt1UNUKEglIAGmelt6l26F27Vn3+NF3nETGxFmSZT6K9AR2vgbRZYYs1B0
 jwBfiZ7ENkun42uKoxcYjpQT9QU9j8tVOdanRZbwXxAEnupaLZ018Yv9nobjaQFScs2n
 9bon0bWOO+R9kjJN2bayKOZ9siZ+L/x+WBjVtdmzSsUNDFpNuUbbLNwHQt10kV88emTb
 R5nA==
X-Gm-Message-State: AOAM532bwmLohn+VxyqpQRurgwFLpklAynau0BNHOs+WZ5wZTfInVz4G
 4lYAouYPfLTs/ZdN5ol4c8JF5kloFXW8WR16WTwb/eeSRlU=
X-Google-Smtp-Source: ABdhPJxbWdQvjC5iQxp2q/BLcZSltb7SEryfJSFxKAQY793MpjFMOR9KkGGgnHvMaAZB4QQLnpPpZrkW0l4QB+CGBHI=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr43788605otk.221.1594240721077; 
 Wed, 08 Jul 2020 13:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200706192921.1154-1-kraxel@redhat.com>
In-Reply-To: <20200706192921.1154-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Jul 2020 21:38:29 +0100
Message-ID: <CAFEAcA9O=D95JHkZcRGFUi8+hoUe=j1xYy4vN5uv59pYYm9Dow@mail.gmail.com>
Subject: Re: [PULL 00/20] Audio 20200706 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jul 2020 at 20:31, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit eb6490f544388dd24c0d054a96dd304bc7284450:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200703' into staging (2020-07-04 16:08:41 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20200706-pull-request
>
> for you to fetch changes up to 2336172d9b396b4fa4483712f5560a563c25352f:
>
>   audio: set default value for pcspk.iobase property (2020-07-06 17:01:11 +0200)
>
> ----------------------------------------------------------------
> audio: deprecate -soundhw
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

