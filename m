Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED353C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C19215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LWY76hES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C19215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2uE-0003eT-TH
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iT2t3-0002ao-KL
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iT2t2-0001Ao-4n
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:57:09 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iT2t1-0001AH-Uo
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:57:08 -0500
Received: by mail-ot1-x343.google.com with SMTP id c19so4934693otr.11
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 03:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pt9jM0ZgRZF1S9dyazVMLVKSMK/CHuHefTWif+R5QjA=;
 b=LWY76hESzkj6/Dmf8Q+1+fE3sd3EpbL5EFDixNeiUFvbs6BhaO+ZMUw/trljUWBEsn
 uCoxUtfDhkZOi5rJxc7wVxE5jcZZrGN40Fk0Shlx1tQgBYTmMZFfQE6vFVHxm/MAYPhw
 h3hvkkKha49ZL0AN4OnxpOsuy5HA3A4gQOO+FZghrv0fBsLUwzVlYlC0sm9a/Urnwe1y
 BD/ZO7XxbXdG8byRwVljIoZDbmeLpFVGNzn3Pm03mIpDhuQ0dlioqffgHhbHufS+sYJm
 mwISLkTpmTCFy01BttBOu4qLw7ypFjwonDc2VN1PSOXkRtJMPn2L/HpqLwDAfXE35lif
 yRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pt9jM0ZgRZF1S9dyazVMLVKSMK/CHuHefTWif+R5QjA=;
 b=ji2koS2Gj6ovTimgF5XwbAh7r3U2Rqy1e/EPSFRAsnZINdLWyFbNBKllL9kbQO3h1q
 oQv8Vz90cQaac9vEr7fVrLuHX877t+pF0zzDBP2OQPxJGBFETmPXmRVQTYriAqX8c0jW
 mIpiLIa1hsiQeWRpASBu354bSjWbMnE/79Xb2UiJczS+EosJ/yC3SVyGt4YJLmijnbqT
 ATDfj3G7u7jTFXn1YAPFIOi3/wl4cfMXxLID6NfTMI8pB9fort5rGDnV0VTFVFQmOTDj
 qO183IhQgXN79IpHVufLg97IvAzejeIpgtkEVmHNdgpz6PaH/n18aay4MpWSixBRSMTd
 TXbw==
X-Gm-Message-State: APjAAAXNcR8LmZpoz9tEF8Hss+HBfE+TZv9AttySbGk0+D1aqTXeVReB
 G50Z38V/9Qk5ogazLdtuGhbwdfxLS9CrJ2G/32zm5Q==
X-Google-Smtp-Source: APXvYqx/xF6RrVHhtEVeTRq4HFs2s5W7J9Nd0Rmtjw0h/wgG07+u1zdgbqriHN0GyMvjMa2rV0PalHGy/BsMUfkrTeU=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr8607162otg.232.1573214226998; 
 Fri, 08 Nov 2019 03:57:06 -0800 (PST)
MIME-Version: 1.0
References: <20191108095942.401225-1-stefanha@redhat.com>
 <20191108095942.401225-3-stefanha@redhat.com>
 <CAFEAcA8b_POWyCWERMaT2mKZxrYA+RDoaLCHtO=pS28f-SCZ3w@mail.gmail.com>
 <CAJSP0QWoSNk7NmC+AjgWQenyKLw6H5wqHay8C-1evQ8QTrSJ6Q@mail.gmail.com>
In-Reply-To: <CAJSP0QWoSNk7NmC+AjgWQenyKLw6H5wqHay8C-1evQ8QTrSJ6Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2019 11:56:55 +0000
Message-ID: <CAFEAcA9t7ZBDo_4LF=vHDySyA_uvVVpxJd2kHV6UZW0ca1dtdw@mail.gmail.com>
Subject: Re: [PATCH 2/3] docs: build a global index page
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Daniel Berrange <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 Nov 2019 at 11:39, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Fri, Nov 8, 2019 at 11:52 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> > So the reason I went for the odd "run sphinx multiple times"
> > approach was because we don't want to ship 'devel' to users,
> > and as far as I could tell there was no way to have a
> > single-invocation build of the docs not include it in
> > eg the index/search (which would then be broken when
> > we don't install devel/ as part of 'make install').
> > Does this patchset result in a set of installed docs
> > that don't have dangling references ?
>
> You are right:
>  * The hidden documents are included in the navigation bar (different
> from the table of contents).
>  * The search index (which install-doc omits!) includes content from
> the hidden documents.
>
> I have asked on #sphinx-doc.  Let's see if there is a solution.

FWIW, this is the thread where I asked on the sphinx-users
list about the best way to handle "multiple manuals but we
only ship a subset":

https://www.mail-archive.com/sphinx-users@googlegroups.com/msg03224.html

> It might be possible to hack docs/config.py to exclude devel/ when run
> from make install-sphinxdocs
> (https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-exclude_patterns).
> This requires building the docs again at install time but the
> advantage is we get a single searchable set of documentation.

Yeah, if you're willing to build the docs twice (once for local
and once for installed) that also works. I'd prefer not to
do build work at 'make install' time, though -- if we want
to do this we should build them twice at 'make' time and
install just the right one.

thanks
-- PMM

