Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047C4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE992072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tm05GPIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE992072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juxA5-0004c7-2f
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 08:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jux9J-0004B4-Il
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:01:34 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jux9E-0005Ff-NM
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:01:32 -0400
Received: by mail-ot1-x343.google.com with SMTP id h13so9321997otr.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 05:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UaXyOk68a5gcosj74OO+OA+DhCLddBoiel4AAOfI788=;
 b=tm05GPIel2nfkn5fKtbdF1QePkZ7GJTDO1slXdvDQpKhSlTqq9HW/Qm3FL1n71KQ7w
 1Y9kCbeVeL0WOgJSKpNtppjE6kVNVj+7ADKYNUl38dyLR+uCaIuC2lsY6gT/aW4wY3DS
 1EFsNWB3CHegMsZeRrbSBWg1GvEuAfplZlHgtlrAqE+ZXSjJdBM5EJ141jvj90KCkvvm
 9pSNJpqz1YOtRHm0kxZHRj6H+DXQSmMQxkKaWr19q+QiUOjtyETIx7SjFZHxAoJAOR/S
 GOSheRjmR+la88+Z6cgnu7BGEGaY86jcaFZyKqw8EO+ieD1jhzyzjXMSqIzyl1arC9Iv
 Yn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UaXyOk68a5gcosj74OO+OA+DhCLddBoiel4AAOfI788=;
 b=LZ9OF8gUPkBBV7aT98JwLGisQSbXx1/qNzsE5Rl9JqSRQFtEtoOQc7aht47W/PpPjM
 yazfJBaW/Sa+u4a8OKLan6CECxNyM4Ir7Zq6kZcxzF22WyzvbmWI+fDp+3gHjyXpvUGP
 kW9I2MqPDpylgzN+/luxGbWWQljj49y0q6uHIdpJZVR/LSMAa1HQ5Wwe3nuP/1PulGDS
 d8gGX/l62IG0JuRVxKPKQt5Arf7ZO7zMRF2yWcqMfRgkTrSJXv87qyQkHNFdfDCzxvIe
 +8jKMdt+opvpS8k8sAERCNIBvbPzwrCCj1Jd2tfd56gETAGyrQ3d2pjVyGToq5fBswgK
 qdTg==
X-Gm-Message-State: AOAM531Ydati9otTumC5s7SMiWFynd6Vk9cKjE0NqpvmmeXAePEETM3i
 rZCYtAfAwKyVib9rtSz/ZQjWM2x548ycsik17iJNVA==
X-Google-Smtp-Source: ABdhPJxoGbsjgdnUEsEJmlqSNg1sdUnbTakFJAmebxp4bSc72P587/6LbNxZIMzy5dDaf/bSDldIj1FZ8kX/JTJEC0o=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr62695347oto.135.1594641686791; 
 Mon, 13 Jul 2020 05:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200713082424.2947383-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200713082424.2947383-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2020 13:01:15 +0100
Message-ID: <CAFEAcA8z0jv8zihqHVt2OLemPHH8RniTCiYOm0BsggZxs81Gbw@mail.gmail.com>
Subject: Re: [PULL 0/8] Chardev patches
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 at 09:25, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit d34498309cff7560ac90c422c56e3137e6a64b=
19:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/avr-port-20200=
711' into staging (2020-07-11 19:27:59 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/chardev-pull-request
>
> for you to fetch changes up to 30827bad3852fd85d86995e7ccab429679442889:
>
>   chardev: Extract system emulation specific code (2020-07-13 11:59:47 +0=
400)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Li Feng (1):
>   char-socket: initialize reconnect timer only when the timer doesn't
>     start
>
> Marc-Andr=C3=A9 Lureau (2):
>   chardev: don't abort on attempt to add duplicated chardev
>   char: fix use-after-free with dup chardev & reconnect
>
> Philippe Mathieu-Daud=C3=A9 (5):
>   monitor/misc: Remove unused "chardev/char-mux.h" include
>   tests/test-char: Remove unused "chardev/char-mux.h" include
>   chardev: Restrict msmouse / wctablet / testdev to system emulation
>   chardev: Reduce "char-mux.h" scope, rename it "chardev-internal.h"
>   chardev: Extract system emulation specific code


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

