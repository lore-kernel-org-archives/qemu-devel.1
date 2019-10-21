Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3A4CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94FA220659
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qBXGcRJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FA220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMake-0003ce-RI
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMajc-0002ei-QF
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMajb-0004kZ-KP
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:40:44 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46844)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMajb-0004jK-Fa
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:40:43 -0400
Received: by mail-oi1-x243.google.com with SMTP id k25so11564808oiw.13
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Frybj9IsGbOQcU/DpPzTqp/1SYmu7NsvsEffHw12Xlk=;
 b=qBXGcRJnELvsZXORBcinwvvHhQgD8ip4RmuNVzZY6yYsB3yoV2c8Q2TCKF7rS2S4Gi
 3lbD9uadBe/zB9pCyIw0qf0IxZlpOwjVjauicel0ARTNvBbcalC/WU6D4/mFsa15ySas
 U0AB6ZuZb7QnpM+aKwhTAMil87ERHzzBNSzejot05WM5NB+1QuzWh5NX+wIgKBz7brRi
 dWi21W6jCsqFyKDWwE2jYcNSGCpgP/XueAy0xN4mGXt3LNrrLJdWwhHcXCS8jN5QJKH3
 3Y3yg9/ekYl9xCDZWo7NozY3DsU6iHtD8azrUv5f+wiWkvrUvd2WFAhEjBJaOZkvU1zF
 00Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Frybj9IsGbOQcU/DpPzTqp/1SYmu7NsvsEffHw12Xlk=;
 b=NWABGlpDFDKaf9K62UQsYEMyU65571uobAdW4SvgcyBg2cEHvi96VYUBJgc/Y8AOp3
 J2TF9RJIcrIbPFfhat3l+V1mHpF9i0HxijoZ+RsevumisSY94RzE8Jjn4LdrHlwpqNs2
 zPMUCX9Nh56PWuPBPbwLRiT2moDFESr4UIdJhkpR+tqbqlgvw+7J+8vTaVqQZK7tqVBq
 o2V31lAA3IXPCuzoNhNxUHAYoaMRNY2gX0n36j4lXj0BwEPjdt3+l+8fsMaegtdZgSo7
 zRpUsGyhz8+OVXdCApeZZfjSh+RhyjO3VvqFv+eUB+NPDbu6uyG579Jbop6rBP5Sso4/
 FC5w==
X-Gm-Message-State: APjAAAVqmkPYnfKQE6feCwYMbShaV6rolEnIRu9MOjYyHI3AaCRZE0Pf
 k7laOb0xiNW46V/J0mn+GAaBuKxEZsVjkCPa2D5PMGJiMIs=
X-Google-Smtp-Source: APXvYqxaukc2NYLksMQj6F8WyrnsKTY0FbM+8D8JL0E3NNi+egnXS5+fXqlHDhDqb47vkoN5UxpdzNLyMeQLedVKUSI=
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr20087568oic.98.1571676042324; 
 Mon, 21 Oct 2019 09:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <60a0d510-b693-0ed7-560f-e70904d9574d@redhat.com>
 <9925b761-6d9b-2361-1697-a8a726b2ef21@redhat.com>
 <2848d03e-4aa6-d74e-14fe-afa9fd107171@linaro.org>
In-Reply-To: <2848d03e-4aa6-d74e-14fe-afa9fd107171@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2019 17:40:31 +0100
Message-ID: <CAFEAcA9g3W23krU8yiuYrfVp7CVGEoBDuQofoLYcoo=Cqi48KQ@mail.gmail.com>
Subject: Re: s390x/qemu-user: TODO /home/dhildenb/git/qemu/tcg/tci.c:859:
 tcg_qemu_tb_exec()
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 at 17:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/17/19 4:01 AM, Thomas Huth wrote:
> > On 17/10/2019 12.02, David Hildenbrand wrote:
> >> Hi,
> >>
> >> I'm currently trying to run Fedora 31 under qemu-user
> >> (https://github.com/fedora-cloud/docker-brew-fedora/tree/8a81f67271e959dfc8f8a888b161bbd540b7a83b/s390x)
> >> in order to debug  a vector instruction issue.
> >>
> >> Strangely, when trying to chroot into above rootfs and running
> >> /bin/bash, I get
> >>
> >> t460s: ~/f31  $ sudo chroot . ./qemu-s390x  /bin/bash
> >> TODO /home/dhildenb/git/qemu/tcg/tci.c:859: tcg_qemu_tb_exec()
> >> /home/dhildenb/git/qemu/tcg/tci.c:859: tcg fatal error
> >> Aborted
> >
> > That's likely the issue which might be fixed by Stefan's patch here:
> >
> > https://patchwork.ozlabs.org/patch/1083601/
> >
> > ... unfortunately, this has never been merged into master. Stefan, any
> > chance that you could finally get this upstream?
>
> Oops.  Sorry about that.  Queued.

Er, you had review comments on it the first time round.
Doesn't it need a v2 to be posted with those fixed ?

thanks
-- PMM

