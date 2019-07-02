Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCE2C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E932184C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cc6Ry1oQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E932184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiOJn-0007M0-Cm
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 15:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51459)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiLpy-0008UH-BJ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiLpw-000465-9m
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:40:58 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:46223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiLpw-00043C-3S
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:40:56 -0400
Received: by mail-oi1-x22b.google.com with SMTP id 65so13573820oid.13
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 09:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0l24OgP6hB0OoyS7BLn0bCSJvF5zWio/gBvfTgVo4mM=;
 b=cc6Ry1oQAdqjqBfYvB9+fbxzr0L8xD+We118K6gSCXhFx4DJfndOWMVaTKAar9WgNF
 txkI90xYMAX35uMytYhckus1XuwFNfIneKqMhckPM6Zws0EJ7D0h/ic4GFVC+olIXBG3
 8ebg4VHwWY8yQzd4+HKR+CFMmisRR3Ifb96QJmJ+3TKn3sNfo/ctOfHFATydZsaiU5tI
 5sNi/4w+ci106AqJuScUnqp29bwLn+q8SL3FcMHWwjhT6OORRcEAVaEh/eEka0H1mlee
 LCj5OPmbqtOrl7sTx9Uo/7SbDgbVKdYDfyv6OGMjkwF0m59uyHrKQS93+gY7U6thuK+i
 PXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0l24OgP6hB0OoyS7BLn0bCSJvF5zWio/gBvfTgVo4mM=;
 b=XVq+DFoE8GHz1M0LjZrRtcpCLDPyriTDal3ZEOh1VxA6kpj0XNIOWljiy9D6m1txlz
 VaRJwCyaNHTys2zcVLj3arRuoniKKbJJqrGFyqovszw9+zZEYiSlM6RIG7VDvdtVV4X2
 P02WQvL1kwmo6cS3XCjq6jg/LSsHdxyiy9SKjgLlnBQLz2M3wdDoZ1TaiIGin2rEO9Mg
 Md9u3HPEP7EO5gt4yi4uoaHm/bQyFJHDKWCyWwSEPzmorGq8dm3MtY96SzE7UC5ft9nW
 nvea1vmRr4zbGVce+eKOJO1dBMIP+/cJ6l/klI3Ii4kHn4TKiVNYOsvNe0XXjkiCIGMz
 3gLA==
X-Gm-Message-State: APjAAAXcfI8NeHu4/YDqZ5iRfJliKsi5kNMlaYkpvZROetqKcEYcpv/Q
 Tp1naHt5tHYmjXxUGThuw9Byd3EiKx1u/GHQ77iqHg==
X-Google-Smtp-Source: APXvYqypw6eEtvFgw8UeE6R38jSClcLbuGQiKRXNdULrq5O5aGVgAD6Ho7NfO4yD9GNh6WykuuQHDKCYEm0ONB5XtWg=
X-Received: by 2002:aca:6185:: with SMTP id v127mr3763130oib.163.1562085654583; 
 Tue, 02 Jul 2019 09:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
In-Reply-To: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 17:40:43 +0100
Message-ID: <CAFEAcA_L2_BJPvpVvNpi-mHkXg-VE-eeyiguWOaqs6AwT_nOYA@mail.gmail.com>
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22b
Subject: Re: [Qemu-devel] [PULL 00/17] Net patches
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

On Tue, 2 Jul 2019 at 03:31, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7c6:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2019-07-01 17:40:32 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 0e8818f023616677416840d6ddc880db8de3c967:
>
>   migration/colo.c: Add missed filter notify for Xen COLO. (2019-07-02 10:21:07 +0800)
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

