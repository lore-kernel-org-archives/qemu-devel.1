Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BECC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 339FA20772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyUIzuAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339FA20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqwHa-0005Rh-Dm
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 06:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jqwGT-0004XS-NL
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:16:25 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jqwGP-0006bE-Qt
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:16:19 -0400
Received: by mail-oi1-x244.google.com with SMTP id e4so15090585oib.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 03:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UWN2LvMR4+wZKOGbBatXV5yL1BBFMAl4Muf3y1lL4VU=;
 b=QyUIzuAFvOCWP+lznnzFPMNBMEHhzwywbqlFYnbs9mLGfsiqmC56K4FptLnzjKtIxc
 qoMn7P6y/4QWNO8WNNK9SpWUZ2DF04KcALOcUtnkd1S+KLiDJvLRkVwVZIWUPMeixwyM
 LF6uv0sRx/H0kdkKXEt3WCSEfO9ri2MQFElf9K7420YNJRFw/8SELzjUs7VZtaHmUjbX
 YLb8UmmpTNGd7vnaEixJYEFUH5g3r0qt9DSyxnN0kTcIHqh0/Um9WtLfeqixzHZfssk2
 zFxtdYQVYswGk5xGMrN9t2bsItCjHUf64p/VfbIQMVgyLb/9IdWrE/DLMjSAxqIJBrqL
 uzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UWN2LvMR4+wZKOGbBatXV5yL1BBFMAl4Muf3y1lL4VU=;
 b=kfSwaUO+fnc95Zhs8pEvCkt+/hOdH2niQ014TYw/ozdVfJ6s38YCdudBdt7qGSxunL
 TC5ssjPU9pQ4/iP9QspyD7csG20Ve/Wumm3pbaggPazCEPla1ODSGZxZ5py9SMsZMm0+
 XXuIV0c4f1wkLS8zTpaST14Ppb9DKI9So9yeKuwf3wDv6l3GyNflzx1VNZDbUcIZSyKy
 dEWmn2tOalqsp6aNceIJ4oTtzaWd9egVesfYGGP8nZi7eMj5zfJ3c6kuax38WC5YKeIg
 1O2wHH9/hF+qC6JKlfDu7YYvW1n+YbnFAf7ePKseZ7piovZIg7vZnHgCwvUP/8hvISCx
 PZRQ==
X-Gm-Message-State: AOAM531WBaXZDJy9GzGmvkpbom5xORADiqpL7oBdymisV8X/loRFgIOb
 U9cKXib63TfuliBKQOuTKWB8fY9uwQVCec5hZM+tmw==
X-Google-Smtp-Source: ABdhPJxbzjlruOCoq8IbtVLyY0giPeAMXEZaqyz7ZguoqedKo5cevd1SuUfOfC7vXlIe+kM2SajY35eGAXK3VDVwJjc=
X-Received: by 2002:a54:4694:: with SMTP id k20mr22543911oic.146.1593684975090; 
 Thu, 02 Jul 2020 03:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140938.17566-1-drjones@redhat.com>
 <20200629140938.17566-4-drjones@redhat.com>
 <20200702055245-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200702055245-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Jul 2020 11:16:03 +0100
Message-ID: <CAFEAcA8EWAnXQ_9_S_7G0yY5EUJp0qshEPmpVuFf8943qfzn4Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/arm/virt-acpi-build: Only expose flash on older
 machine types
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jones <drjones@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 ard.biesheuvel@arm.com, Igor Mammedov <imammedo@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Jul 2020 at 10:53, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jun 29, 2020 at 04:09:37PM +0200, Andrew Jones wrote:
> > The flash device is exclusively for the host-controlled firmware, so
> > we should not expose it to the OS. Exposing it risks the OS messing
> > with it, which could break firmware runtime services and surprise the
> > OS when all its changes disappear after reboot.
> >
> > As firmware needs the device and uses DT, we leave the device exposed
> > there. It's up to firmware to remove the nodes from DT before sending
> > it on to the OS. However, there's no need to force firmware to remove
> > tables from ACPI (which it doesn't know how to do anyway), so we
> > simply don't add the tables in the first place. But, as we've been
> > adding the tables for quite some time and don't want to change the
> > default hardware exposed to versioned machines, then we only stop
> > exposing the flash device tables for 5.1 and later machine types.
> >
> > Suggested-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> > Suggested-by: Laszlo Ersek <lersek@redhat.com>
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
>
> So who's merging this? Mostly ACPI things so I guess my tree?
> If so can I get acks from ARM maintainers pls?

This is on my to-look-at queue but in theory I'm on holiday this week :-)

-- PMM

