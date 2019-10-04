Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1B0C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75164215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PyJ7QMp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75164215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGNND-000858-KW
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 09:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iGNKD-0005zQ-OU
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iGNKC-0005dG-AB
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:08:49 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42854)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iGNKC-0005dA-3l
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:08:48 -0400
Received: by mail-oi1-x241.google.com with SMTP id i185so5661728oif.9
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 06:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cge93y4c4xtpqt6eoYcp/l2SUgz0ao7goumIqvRoTB8=;
 b=PyJ7QMp8I/ccwJH9Tzo8rjulQUINtLoFqunLhCAs2gzKNbBTRAviN0alSVMP5B0mFY
 HXyR/06G5/SG7NeICErcywmyph9mS1MTplbk9/onpnXbWkHj1a9zrslaqxD0ngGJAi4e
 gvTOzd/QUWBi7poK3b01STDc2IIAgyw8doTelRccRLHrMO2ZNlnXXqNL26kGQxzkXmIn
 0gNjvYA9jRizDQ0SQ6qt+eOSYG1ax7qjUtRk6kRjguWcyoZZFIvzVBbqpLRJjIMAxwO5
 /L838OVHPT9J8BdA2ExVSevjbLmaL1lQgJleZXv/gaeVqGqTh/xGDKXTl63k0cav3qg+
 lE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cge93y4c4xtpqt6eoYcp/l2SUgz0ao7goumIqvRoTB8=;
 b=UaViM3wwDOltfg9FWxvCNBF76SEXEr5WNhJc/dOzF1XIqzcxRyEN1LbYQ9XCjekfao
 Qj+mPpTpp0PVGx5Mv9epiv54Wb+ioxOv5FVeYvabcFZyuytQH1d945Px15NvwJygLWex
 +h+mkrO1BYkHmkrTD0cgfmfnsXFXNW3ueov96JdKyb8DdTrCHHg7SZ5llEetVr8lyG2J
 0P2pr7UXTzhCj0l/pOLk22pfErwdk5WM3aMiCxzPmycUA62ACnzzF4DqGwY3akY7EjGj
 aqzNtq4YD3lblM2bVxYuY9anAtGXBfPa+cweBt6iuoZiOl8vhyqsAMneEagPdWK/3+2m
 Ntyg==
X-Gm-Message-State: APjAAAVhVIT8ouUA/F6+lOtdprKVcSE7mnZx5DjH2OAQ1HzC3hkfCzHF
 kfH/gTQfuY8f3b/meoGf3D6VhwuqYn5/wgHRk+xJtA==
X-Google-Smtp-Source: APXvYqzbtY7hX1uqbpZbiC+X47oJQVZFLnv0Z2wNK7XsHQeyQEADIZsH3k2F81dvIR5CvgFrA2rYuVF3OPkHV54+Ly8=
X-Received: by 2002:aca:f54d:: with SMTP id t74mr7298432oih.170.1570194527022; 
 Fri, 04 Oct 2019 06:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <874l13qmvb.fsf@dusky.pond.sub.org>
 <20191004130242.27267-1-g.lettieri@iet.unipi.it>
In-Reply-To: <20191004130242.27267-1-g.lettieri@iet.unipi.it>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2019 14:08:36 +0100
Message-ID: <CAFEAcA8ut__ruS4yEMT7-qCKu+BFihFwhaNoq7L1cdoqxpXx6g@mail.gmail.com>
Subject: Re: [PATCH] netmap: support git-submodule build otption
To: Giuseppe Lettieri <g.lettieri@iet.unipi.it>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Stefan Hajnoczi <stefanha@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Oct 2019 at 14:03, Giuseppe Lettieri <g.lettieri@iet.unipi.it> wrote:
>
> From: Giuseppe Lettieri <giuseppe.lettieri@unipi.it>
>
> With this patch, netmap support can be enabled with
> the following options to the configure script:
>
>   --enable-netmap[=system]
>
>         Use the host system netmap installation.
>         Fail if not found.
>
>   --enable-netmap=git
>
>         clone the official netmap repository on
>         github (mostly useful for CI)
>
> Signed-off-by: Giuseppe Lettieri <giuseppe.lettieri@unipi.it>
> ---
>  .gitmodules |  3 +++
>  configure   | 64 +++++++++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 58 insertions(+), 9 deletions(-)
>
> diff --git a/.gitmodules b/.gitmodules
> index c5c474169d..bf75dbc5e3 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -58,3 +58,6 @@
>  [submodule "roms/opensbi"]
>         path = roms/opensbi
>         url =   https://git.qemu.org/git/opensbi.git
> +[submodule "netmap"]
> +       path = netmap
> +       url = https://github.com/luigirizzo/netmap.git

Hi; this patch seems to be missing the rationale for why
we want to do this. New submodules:
 * should always be on git.qemu.org (we need to mirror them
in case the original upstream vanishes)
 * need a strong justification for why they're required
(ie why we can't just use whatever the system-provided
version of the library is, or fall back to not providing
the feature if the library isn't present)

Basically new submodules are a pain so we seek to minimize
the use of them.

thanks
-- PMM

