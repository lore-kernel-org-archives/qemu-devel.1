Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D1AC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629D52086A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YuZ724ud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629D52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKP8f-0003d5-K4
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 11:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iKOy0-0007oF-88
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iKOxx-0006jp-R8
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:42:31 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46018)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iKOxx-0006jE-EI
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:42:29 -0400
Received: by mail-ot1-x343.google.com with SMTP id 41so17321605oti.12
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CHucFATY68OQojVz+Gz+AsVy0wRGchooF6iN/kOLZaA=;
 b=YuZ724udH3C35J3vU/2cOdGwg7lkZsh2uHZcAOs1mut6mjGlzeSajWOQGBBdxmrCAM
 w/bHPr6+yT31IDBrPx9IHD67jNUpTxQZcb0e//NBgSiRzM8IuJ65dLSHJjkDsQkbeEJa
 pJsl6tD32fj09ewesiHAoHxwBhfZt/rlIlWhzI8d2zXn+3rY/fBeqFoH0SNYAVepS/or
 UeWldh74v8aTKERFh5dXhpeHmtv5xgru1NjmpOPGxQqKBkbI7J+fOac72a3ir4OFbB8m
 53kfwtELg8tWyDwMRVgS0wJOLSy892FVQ2NgjeTc1em6CkYEeOy7MTp9gbe+/4tsjjW+
 leuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CHucFATY68OQojVz+Gz+AsVy0wRGchooF6iN/kOLZaA=;
 b=I0JWURq1eslV25vxlcWS+jP8s2dWAE3wvlP9juVzCdn+tMsF+IWePLjp6YEZLaNGGC
 oV7vFi1vTE2yHSsSRPjA7aduVL0FnTsMgtct/w98WCW1hCWMZwKM/od9E0ZASMvWay/y
 j+Q3ZssgTw2mEDXxGXC2g2MwQ9Qaxci9nQrQlRHETz4IEIrwQ328zxSCWKKDuu9AgSQp
 rDTWtkiGE8/uBs/TreQ9qzfeVGqLk06WpUZ16mi5BVgasI5VKvv0o5xvc2A3yenB0raE
 oIjfUI4CO2ca5ey4afyqBV5X4ayMbQuQM4OVabj3poghu9WbKjNzAqH7MsrxFb1Nk6HK
 xZFw==
X-Gm-Message-State: APjAAAUbBGzklolADkWD/6afOjD0A9p1zYPg90WviKhqx+BFtyCSMpVO
 8W775i7yo4mwIMvei/C2J+n402/1hfaZd6ix7hdtqQ==
X-Google-Smtp-Source: APXvYqxD3QmeBWaW/DTk9yHrEbl6sWbAyMf729euq4sccT0JXxWujW2M/ITO5EabkCY6CxUEwz/xFK8oKd3zpDaytU0=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr29754889otg.91.1571154148208; 
 Tue, 15 Oct 2019 08:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191014085709.26812-1-stefanha@redhat.com>
 <CAFEAcA_tPs_hfO3GVSf2CsYTFvBH5-RWe+JsR5vfqkh5HjAVNQ@mail.gmail.com>
 <f13e94c3-5ebc-3c55-3c3d-d9cef9233514@redhat.com>
In-Reply-To: <f13e94c3-5ebc-3c55-3c3d-d9cef9233514@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2019 16:42:17 +0100
Message-ID: <CAFEAcA8NR3HL6uqRE4ZMfzXPU=BMi3ZWO3RiMwn4VKOS_uWRsw@mail.gmail.com>
Subject: Re: [PULL 0/2] Tracing patches
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Fam Zheng <fam@euphon.net>, Qemu-block <qemu-block@nongnu.org>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Oct 2019 at 16:38, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 10/15/19 2:24 PM, Peter Maydell wrote:
> > On Mon, 14 Oct 2019 at 09:57, Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >>
> >> The following changes since commit 98b2e3c9ab3abfe476a2b02f8f51813edb9=
0e72d:
> >>
> >>    Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-requ=
est' into staging (2019-10-08 16:08:35 +0100)
> >>
> >> are available in the Git repository at:
> >>
> >>    https://github.com/stefanha/qemu.git tags/tracing-pull-request
> >>
> >> for you to fetch changes up to a1f4fc951a277c49a25418cafb028ec5529707f=
a:
> >>
> >>    trace: avoid "is" with a literal Python 3.8 warnings (2019-10-14 09=
:54:46 +0100)
> >>
> >> ----------------------------------------------------------------
> >> Pull request
> >>
> >> ----------------------------------------------------------------
> >>
> >> Stefan Hajnoczi (2):
> >>    trace: add --group=3Dall to tracing.txt
> >>    trace: avoid "is" with a literal Python 3.8 warnings
> >>
> >
> >
> > Applied, thanks.
>
> Buh, v2 missed :(

Oops. I don't necessarily notice updated pullreq versions unless
somebody follows up to the v1 coverletter to say the pull is out of date.

thanks
-- PMM

