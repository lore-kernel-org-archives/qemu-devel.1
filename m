Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B92C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7A8206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kINBphIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7A8206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwJH-0001Fn-0g
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itwHW-0007Xm-Ow
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:21:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itwHT-0008HZ-LL
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:21:34 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:38930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itwHT-0008Gu-CA
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:21:31 -0500
Received: by mail-ot1-x332.google.com with SMTP id 77so3427898oty.6
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 08:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4TR6vE8k7eDQ6HPG/5GiFCR2eFak5SyjjzyY8HlfFAI=;
 b=kINBphIbK+uCW6iBhJCkam/CvboXLwC7KJ2BZAX3JcMfp9TcjzuB9MJ6j9WH7wg29b
 JmI1Cpga0yYtwv+ferhXQOpkU6gQaT+zb/NF2pso2RgirJy+7F4mVKIi2NVODyLAFYtl
 kSPST3iYp/nflwjTJPHvS3gskI3FayfSU+5MfOB30TpzbbzD3xGrjSeihEC9AHnKPfMV
 og6/RptMCubKAMSOoFfdPnAxbs8oLbCwiiApXybCUCxTg/ckXFsuetZ2vxPhChYaeshN
 ogsKLQ9MzKjovN5TX8pLadrKkUsHKGjxuJLV+IzTu7kRAN3J+0bXGLmoyB0efu6Zimnr
 zDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4TR6vE8k7eDQ6HPG/5GiFCR2eFak5SyjjzyY8HlfFAI=;
 b=cDlmOVqGWA3yCA+D2FD8bVvgXFzRRRmjPogw5e5zgcACqr5axqTiAOkzmEOmN1C3jw
 K0YEz3YhYVydHrLEHNwW7nMW3eUJhqdDiddYSsANl5sOl+pJmcctwAVpFBewo5LaANTd
 Nxwo1RcMXTAGVYg7ZfqPCHX3F1LlFqRQpUADjWWH/AsV9VfGebXnJUH40I7aLyXiL4RD
 ULYTXRGBtlnTXZ07f7QtIW+cl0EZhEg0jQ6ZfNSO/yo3iO2P3alszaa/O5qG4MQj2bWb
 ldURu7+8ZI1R9DtzrVrjg7rGwF9mBAUbP8bXNYJHC5gAVBOmrnjZ8mQ/viUxMoHV4wEp
 SQPQ==
X-Gm-Message-State: APjAAAWIrcjObFHw8wENYcLjBukgch+G5NAXDwd3KsHLVVe/9WO4rVNS
 FUO6rjChEy/4xrKgIO3UJRE2co1+xbf54dVSLmSB8w==
X-Google-Smtp-Source: APXvYqxl594lmkxysTQL6UMKYFL7zwralPiNeV//+qpc/5gFprlOmVrP8Ay5JFGDWblZiRBdzoPu14ftmKRSCLauOms=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr4129014otq.135.1579623689833; 
 Tue, 21 Jan 2020 08:21:29 -0800 (PST)
MIME-Version: 1.0
References: <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org> <20200121143658.GB597037@redhat.com>
 <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
In-Reply-To: <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jan 2020 16:21:18 +0000
Message-ID: <CAFEAcA-C5Kvp-tUZfXSeAiFAHW-YXb+ddwFqyo5Y=0ziPhFbDA@mail.gmail.com>
Subject: Re: Integrating QOM into QAPI
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jan 2020 at 15:11, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> There are plenty of refactoring to do. The problem when touching the
> whole code-base, imho, is review time. It may take a couple of
> hours/days to come up with a cocci/spatch, and make various patches
> here and there. But it takes often weeks and a lot of constant push to
> various folks to get all the reviews (as seens by the qdev prop-ptr
> series earlier for example). How can we better address whole code-base
> changes?

It depends. If it's literally just a cocci/spatch mechanical
transformation, I think we should be OK with reviewing that
transform and then applying it; we don't need to get acks
from every submaintainer for that kind of thing. The
prop-ptr series was harder work because it required making
active non-mechanical changes to various devices, which
means the specific changes needed review.

PS: thanks for pushing that prop-ptr work through and
especially the serial device part which was both awkward
and definitely needed.

thanks
-- PMM

