Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DDAC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100DF2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPj5hUUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100DF2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzgzz-0002eR-K9
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hzgVm-0004ny-6j
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hzgVk-0003uN-PD
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:11:45 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40125)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hzgVk-0003tw-He
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:11:44 -0400
Received: by mail-ot1-x341.google.com with SMTP id c34so1416100otb.7
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 05:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kraGL6AAogDI5tKiZZ9eP3rLlWrkCtki3pPE+hk2RN4=;
 b=xPj5hUUHVGfEzo+VlkGpNXmXxCao44BvJw0f8A6SbSGm3Q0TnFRusSv9S+9ahEtczZ
 ZHgjp/jzve2kYWvB+905lF5X6LnlQKEYE0sXKBd/MfYfzfKif0UBJB5+LmoPNqC+68kb
 LivjwXH+mNjbth9c3wR3T3CmXPB01arzhbSOT49yq7LWnjz/B38NEX+j9uqRvJbDFE6v
 wb+SGrEIoY26jQrkYhi8dFefr3822UTsPg/7Wdgob6sSYhct8eVvFuBsWSWMyClVAlPY
 dzIxahplK5eQb24BkUUX4Tq9Ok8o2BkACboJjx5I5sDfL7CO5rzAt3M+qxRejFAJY5YQ
 CNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kraGL6AAogDI5tKiZZ9eP3rLlWrkCtki3pPE+hk2RN4=;
 b=rOGG4bm2pEFckhUnb9OVxdRc0xhN0lCagOqB8z1oqbOueo6rkmDCpodLRD9KRsB5hq
 71T8LdRvK36UdQ+bktdoWX5JZJN2yq2bAPp4UeYzuwUT5Up94okDeLde4TdwJOqdEORF
 Gxu35tkoJzd1ggKK4IIqeeg/PHkqgxFYutWjDebYtUargKaLu0jYg1fTQMs+Va0J5TwU
 HrK7X7HcNydvoupztDkVvb+xDiro9EwGaRcFzqHMX6xoCzlPxGZNzZg7rQp0qrWWMdpU
 LkrBBt5odsubgCyBeY3OGg7unfSG7NS347+EDstsQxfIAwNHykdD35bSq+tAvF82/1we
 +5nw==
X-Gm-Message-State: APjAAAVpEWe2wQu81Nz5FaysiGtkSRsQQ5lI/t/D/Uv2J/DkCRNYTxxO
 vCR9bbS0hDh5BxL5Qm+VZ0HYoG0mgm0ede5koRbGgQ==
X-Google-Smtp-Source: APXvYqyx4G8pWxl1jbYqUIMTQaPJi3SCmGVhcA22CZIbRmu+1rQv4x75Q4bUTeVjQgI+xawIsXTHSKEs1KSonaaxHWk=
X-Received: by 2002:a05:6830:2103:: with SMTP id
 i3mr18382989otc.135.1566216703618; 
 Mon, 19 Aug 2019 05:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <8fb538f3-dfdd-b427-727a-2e7c2120da09@gmail.com>
 <20e800e8-846b-a9c3-f840-826238b0818f@redhat.com>
In-Reply-To: <20e800e8-846b-a9c3-f840-826238b0818f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Aug 2019 13:11:32 +0100
Message-ID: <CAFEAcA9xbPGSezS60cg6WzqpDR1u38aE0bXL_6pLs+H1TK3Ddw@mail.gmail.com>
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [qemu-s390x] linux-user: s390x issue on Fedora 30
 (dynamic library loader?)
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 17 Aug 2019 at 17:14, David Hildenbrand <david@redhat.com> wrote:
>
> On 17.08.19 17:59, David Hildenbrand wrote:
> > Hi everybody,
> >
> > I was just trying to run qemu-s390x (linux-user) with a very simple
> > binary (gzip + lib/ld64.so.1, compiled under Fedora 27). This used to
> > work just fine a while ago (especially when I was working on vector
> > instructions using QEMU v3.1). However, now I can't get past a SEGFAULT
> > in the dynamic library loader (I assume it is trying to locate glibc). I
> > tried a couple of other binaries that definitely used to work (from
> > Fedora 30).
> >
> > I checked QEMU v4.1, v4.0 and v3.1. All are broken for me. Which is
> > weird - because it used to work :/
> >
> > I remember that I was running Fedora 29 the last time I had it running,
> > so my gut feeling is that this is related to some other system library
> > (but which?). I am running on an up-to-date Fedora 30 x86-64 now.
> >
> > Any ideas? Has this been reported already? (not sure if this is a Fedora
> > 30 issue)

I'm pretty sure the problem you've run into is a long standing
bug in the glibc dynamic loader. It cannot cope with the ld.so.cache
being for the wrong endianness. (Correct endianness but incorrect
architecture it correctly detects and ignores). The result is that
running a linux-user QEMU dynamic binary for big-endian on little-endian
like this will crash in the dynamic loader unless you arrange that it can't
find the host's ld.so.cache somehow, eg:
 (a) run inside a chroot
 (b) create an empty /etc/ld.so.cache file inside the -L directory

The ideal fix would be if somebody cared enough to track down
and fix the ld.so bug.

Compare:
https://bugs.launchpad.net/qemu/+bug/1701798
https://bugs.launchpad.net/qemu/+bug/1835693

thanks
-- PMM

