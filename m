Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E136C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25AFC208CA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ps7j/Jic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25AFC208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33812 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb6TZ-0005UN-Cj
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 12:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56957)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hb6RS-0003Yq-4U
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hb6RQ-0003iT-SQ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:49:42 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:39484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hb6RQ-0003Wb-Jt
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:49:40 -0400
Received: by mail-oi1-x22a.google.com with SMTP id m202so12196583oig.6
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ODkLG0WAiDu171EFyK5YD/iZHw4diKu/NNbGZoUDDek=;
 b=ps7j/Jicr56F567y4Htl7QnPoDv1anl75K4t9QTGYHZoP1EOl/u9OgpjNxKdSkq8Eu
 +QgkXCKWPun6n3nuCab3YfcOTqXImXJPMEn1gdRqANOZzxDPP3zSyNKrEL0xT2LAHeqh
 znwn3c6EI6GTyiE6dO7UGc0ha5JXxjwBQX5yfPdw9tGnxssyd6uVfQfNvKwDjdzryuOl
 Im07D079DNzWnJvt2qCNccL6tQ9cNh2fOoH9MtckoZ/a31fn2y832jgEceSWWauq33Wh
 UMjSYILsiac6w7dITIF//pTdAJ2r5up5NALDmNvgqbBEV5hRE5nYAnRqmWhjc7x6D6af
 l1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ODkLG0WAiDu171EFyK5YD/iZHw4diKu/NNbGZoUDDek=;
 b=GVLn2sRy5/UAeOuPNviV7C1s9v8LkEl5Bgwnip3cLCWkQsz+Bcpp7XtPzJ8bK5pKsJ
 SBoyWQHWcNwTKkphWjWqyH49SKbqYRS/8cQf5ML6I6OuzIZJvpwYHUWI9A0PSagOppqH
 3kKCM1XiGS/Z4YzdcVw7WcSADKraihvQRE/5d+rSIVEPn2fk643qTTmbwUIac476C/g5
 cS/65uj8fzGdYHNb+NHNb6bztOKbbM1wkFuR0dmasE49zss7l6L5UDIGjOC0RU1JlHk5
 F7fC5uIM3AECqDK29L+nJf1Qka19BTYbQdp2uL1Mvh08QLhxUE+tEA78x5mU69dk3DN7
 7oQQ==
X-Gm-Message-State: APjAAAVfDP6e1kTOOvpdehiGrlIt9CNlAEy/If+4dJt2mcY4nuLCMTxd
 Vk6ore7xiUN6hOqv1LmHQx2h1cPPmr2paUgmzShpIg==
X-Google-Smtp-Source: APXvYqxCo8fNqy+H1sxKQxETSwEX+YER3J0MN3jRtqwc1xS+m7Cyb3A9wUvzU2UUCnY1Z+ysUz1WKDSaFDs+fae8zGY=
X-Received: by 2002:a05:6808:8f1:: with SMTP id
 d17mr99353oic.170.1560358174380; 
 Wed, 12 Jun 2019 09:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190612111949.25117-1-alex.bennee@linaro.org>
 <CAFEAcA9cKcTpyU_SpzVH91JnQfU2g14bNuk_oWkObbbYYxdXQw@mail.gmail.com>
 <CAHDbmO0+DV0EP=xrHfXa8SUFC5TWWZvwPOE_D0ZpT8c0SPnoNw@mail.gmail.com>
In-Reply-To: <CAHDbmO0+DV0EP=xrHfXa8SUFC5TWWZvwPOE_D0ZpT8c0SPnoNw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Jun 2019 17:49:23 +0100
Message-ID: <CAFEAcA_KjH9hnO4FaXU=iX1FAbNGumxi-=5hwNKbe99SK73ptA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
Subject: Re: [Qemu-devel] [PULL v2 00/52] testing, gdbstub and cputlb fixes
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

On Wed, 12 Jun 2019 at 17:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> It looks like it's still trying to use the system QEMU (which is
> broken for this in hackbox) to launch. Is there a built
> qemu-system-x86_64 in your build directory?

No -- the build process here is just make -C build vm-build-openbsd
(etc) on a configured tree. I can add the 'do a local built in
this tree' step to my scripts, but I wonder if maybe the test
target should depend on something so it gets built before it's used?

PS: NetBSD worked fine.

thanks
-- PMM

