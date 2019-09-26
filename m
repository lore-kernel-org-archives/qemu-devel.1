Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE19FC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:15:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89608222C0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqrrvBz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89608222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDPrq-0001ae-KK
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 05:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDPr1-0000vC-Om
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDPqw-0001b1-Nv
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:14:23 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:44510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDPqv-0001Ws-Pz
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:14:22 -0400
Received: by mail-oi1-f174.google.com with SMTP id w6so1431323oie.11
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 02:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KR1wdXkGTw+YMOUW8wFyYFP7wAiivsrtcTG5HouEJDM=;
 b=OqrrvBz74sgTQ/Kjr0xp7HTqQoLQB2FKEaIN0mIPhRxTvg8UZZV3BH784jokfWvUjz
 x3wmGTPx8lodgpu6LBCvhO/BqM+cSJCnTLtwagTLkSId2Ydv4ZEh+sIR2toJgCwqsS+m
 52hiAfMda9J64QDl7qZFNeWPFu4WA6pfIFTt29t4JqncJZu43zqEIISfJ3kESkJHdcnM
 gA2HOBM9HJb7K+wDFl/Lc1AUGGum/gsLOgukqMs9YYcvFI7OL7vxb40tAzIcowAR0ALz
 Il6NmmcND4gLSJ1EwOoAU2tYzjxfPjrr8jQ8ZOXu3WaVKyIfrEqBN8gM3Vllw7+zB7Vk
 0GJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KR1wdXkGTw+YMOUW8wFyYFP7wAiivsrtcTG5HouEJDM=;
 b=rmK975ys8o26/ZT/OriwHxlEHw1dKprdbfAWW5X7iMtWnchPZJ6h9GgQWQ25FAvjm/
 KHJuE+aQVEA0M1cN5Ln0mhgcAdxrFxXhl1gKU4ZsZGaq2xOoem1s2fz7ss3NiuWHXRoO
 sOLWB5HT9mf9LkpTTz3+rqHheI9sulgevKxpmzoZxdEk90jWjCWqE6HvCdJC9krrCqBW
 15q55JlQUK9ypOArvbkqN7BLGRSOuXaYUOZQpQ96lVvusX/XVD1+HnKxAMPuv14n+O3j
 i0cD1AraQZw/5fRPzpSNu2v9LTrRVJ97bmxSE4fAYMbu2v5vW2btrBEL2LwqsP5uCcOg
 v+3g==
X-Gm-Message-State: APjAAAX/7Eyu2pdm9ZWrXvva8yFe47xQ6lzJwDaTP9+Oimj7jJfnmalO
 rfJV5fPMVyPhJS2vkXkg+LrA6gnIi8b88NVXJrzIUA==
X-Google-Smtp-Source: APXvYqySKcgo6pIyvIUJnbc5b6eW9LZ1GIIBTeBwVUTpMoUn3nFfQw8CUhoBootLp/KC5uwENPJ/m1r/0eLAl+PGYvQ=
X-Received: by 2002:aca:f54d:: with SMTP id t74mr1877107oih.170.1569489199793; 
 Thu, 26 Sep 2019 02:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190924123334.30645-1-armbru@redhat.com>
In-Reply-To: <20190924123334.30645-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Sep 2019 10:13:07 +0100
Message-ID: <CAFEAcA-YmoS2OJe0GadukFtmoAFJ=LeOYWijSzmgfz+TND1jOQ@mail.gmail.com>
Subject: Re: [PULL 00/37] QAPI patches for 2019-09-24
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.174
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

On Tue, 24 Sep 2019 at 13:42, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 2f93a3ecdd3bb060bd04f698ccafe66efd98563a:
>
>   Merge remote-tracking branch 'remotes/davidhildenbrand/tags/s390x-tcg-2019-09-23' into staging (2019-09-23 15:44:52 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-09-24
>
> for you to fetch changes up to 56176412e7fcfae1c69e4426d94e856b75358231:
>
>   qapi: Assert .visit() and .check_clash() run only after .check() (2019-09-24 14:07:23 +0200)
>
> ----------------------------------------------------------------
> QAPI patches for 2019-09-24
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

