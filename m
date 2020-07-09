Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02534C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1058206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vnzdGOA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1058206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtToh-0003W3-1s
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtTnw-0002eh-Bp
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:29:24 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35]:33478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtTnu-0008Ax-85
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:29:23 -0400
Received: by mail-oo1-xc35.google.com with SMTP id d125so260452oob.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 03:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iQE/OQRi77+QgEmAJ5kMuEMxsjni2x5PluiUdEsGx70=;
 b=vnzdGOA/ddB+4qEa4Q6xuoNMUlqTr9SOMvfVvAEky4g0XW0VXgVzLTeKLm8qerW8U3
 aXRZcAYNOuSq7LHU92yqf+phwzBUjlQoVGYiHI5JJcyqfw7C9vlbAzVneZoiesySslVw
 cPCch443tSa+MRjgTFC4GZEcu/V1G1qIGjb/qlaEW82qyYjWgMaSLDeGfwqfMH6jrhbk
 MGVar7YkaigXe+fewQi5/FDoQ/1ZyKOKSUs63e8fhLz5D+rSndNFPabXdWMqLMXlYBwo
 hx6I8lTat4oO1meh9FLc7ybsovPnO/NibQIHcq0EafAOXzICuK8dLoNUpSVooUwMT41r
 NG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iQE/OQRi77+QgEmAJ5kMuEMxsjni2x5PluiUdEsGx70=;
 b=CiQOcgT5kNZRDuG/y8r2WqnffC/ajf4Z42Paik8IZTz5hucfzo/J1prnPm3X7nfsGA
 3EGQklEBd2VtE3aER3SlxwiWOWiZUWkWWKTh6bQCAoqhEdfgZBcQvX0PPPju0/QH65yt
 nLT5kXjvr3jPmmwap9NYA9kUsG+/J2NXHGDospbyszUlge5+zhsGkYL13yreciZxNGNi
 GT8ziha5jwT8s0gFYCKZ5TtDqhr989KlZbDbzpUs97TQ+LJGfOw/LXarBnioWTCoK39V
 ZONF5f6Jx19zg3uXlozipQYiGbZCIWxOolPM97M4LbIkK5PLAY9KNYBwgQUALd+gEahR
 +F5Q==
X-Gm-Message-State: AOAM5332BEk8EJfCe3ElkerQvSz9Gv963uJ9TvHWnFh4wXM1+Qqskp0/
 R2608UXLSrDZ0eoYyTfR00Wh+aSQxpcGV5uIn9a6mQ==
X-Google-Smtp-Source: ABdhPJwKDfQdjQ9vruhSaFZblYLoOYIRYwfrs3JAo0MBsilSUaB9UCyZ/HmaucBLzCwbluU7GO9H3wzPH3eaUJv8C50=
X-Received: by 2002:a4a:2f15:: with SMTP id p21mr53989380oop.20.1594290560668; 
 Thu, 09 Jul 2020 03:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200706200559.160209-1-laurent@vivier.eu>
In-Reply-To: <20200706200559.160209-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 11:29:09 +0100
Message-ID: <CAFEAcA_H+rR32KhWBsSk8rjp1JwUVthqxyxKaS9FmqFzCT5CDw@mail.gmail.com>
Subject: Re: [PULL 0/3] M68k next patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc35.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jul 2020 at 21:06, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 64f0ad8ad8e13257e7c912df470d46784b55c3fd:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2020-07-02' into staging (2020-07-02 15:54:09 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-next-pull-request
>
> for you to fetch changes up to d159dd058c7dc48a9291fde92eaae52a9f26a4d1:
>
>   softfloat,m68k: disable floatx80_invalid_encoding() for m68k (2020-07-06 21:41:52 +0200)
>
> ----------------------------------------------------------------
> m68k pull-request 20200706
>
> disable floatx80_invalid_encoding() for m68k
> fix m68k_cpu_get_phys_page_debug()
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

