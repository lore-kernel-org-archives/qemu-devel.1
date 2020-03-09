Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F98C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32AF222C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2tRITAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32AF222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBLX0-0004qt-4E
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBLVv-00049R-9z
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBLVu-0007MW-4v
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:44:23 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBLVt-0007Lk-U7
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:44:22 -0400
Received: by mail-oi1-x241.google.com with SMTP id g6so10837035oiy.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vsbxzOYE0aVq29heeEadFUFvp2hO7sl6c9V+gJlGK1U=;
 b=A2tRITAHhIIEJ4IpYm3rHTDk46dcAlRMUAh1jEsr3/QcrxEZbZj1e5sn/6ZIoe4G/C
 XY3DrCvI2YIj+6LJmnT9bSnA408qHbihPrTxanf19ACGXs7I8iwdm8rUBC7ZB4kze54m
 Ifm8n73lUQRXaVv4gpUpBdm5qARMi8XmPle0XGthAIYBGsZQpkIxHxO4RGeMtmZsLcc1
 I0zppwHe+RNe/ZimUcOObMQLkpxUL+kDSM6Zlef7JedrRpkWA9A3B5cKEB0N/OGOFbu0
 zvjwzVntIRaWXIx+iLgQ0h7NooK7RzB5LA7tEIog7tyKluuHDMcvTrilgQ2uojXA7AR8
 1mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vsbxzOYE0aVq29heeEadFUFvp2hO7sl6c9V+gJlGK1U=;
 b=Fv09Pz6xmy+xubj044Z2Uuwv8xG0UtAeSMzlF1JzrGidShQzQeW5SYv2f/q/nwxFOO
 hDvcPdK4FxdkhmDkwl/6T2i4VWu6AJ/VwWI3QvB7H3MiIqiFqE3yZMnO/85JCGhoppY1
 vyZl69Yrutfqm3tO0gJ6HTWD1ffeuOAk3CC7opgq56nnZ9uk2y5j4OZKOBoOq+Er+TF7
 CBWxAd6Evv3MMlxQutuAzCxXYi6mKaLvgAHHODi7jvw9MDmR2ceEKxQroHxk+o0MM/Aw
 YiPY9aU0ymZyDB0J8Um7CeBVPTIs0Kj0CkQfHBgLd+1eP0GGg74LZAJX9USAFhOB1OHo
 FXUg==
X-Gm-Message-State: ANhLgQ1ePQhv40UN52/Rqosciu21uAF6MV4QQSzn5wpeVxX0UxFW70QF
 Jyt38+VtAnMXFf3jN0BYcUvY9wAcJQBtpbiN+6aBxQ==
X-Google-Smtp-Source: ADFU+vvBQPDKSS6q7Z59q1no5LH02dLE+Qs5gB3uirpjuOFNbpElnEaPnhpWHWYCYvHBdGBLHxeGHkO6PulyNTSlsfg=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr149238oiy.170.1583772260918; 
 Mon, 09 Mar 2020 09:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200309150837.3193387-1-laurent@vivier.eu>
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 16:44:08 +0000
Message-ID: <CAFEAcA_ZjyuCb3gZUXe1MN9PkN5D8hD7SLPoX0-sp231hVQV2g@mail.gmail.com>
Subject: Re: [PULL 00/33] Trivial branch patches
To: Laurent Vivier <laurent@vivier.eu>
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 at 15:09, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 7a5853cec479a448edae0fb2aaf4e2f78c9c774d:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-03-09 10:32:53 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>
> for you to fetch changes up to 916c92503bd5348a33e561db600d8894bde636bb:
>
>   monitor/hmp-cmds: Remove redundant statement in hmp_rocker_of_dpa_groups() (2020-03-09 15:59:31 +0100)
>
> ----------------------------------------------------------------
> - includes cleanup
> - reduce .data footprint
> - fix warnings reported by Clang static code analyzer
> - fix dp8393x part lost in merge
> - update git.orderfile and rules.mak
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

