Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE0FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:33:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574932082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a58g9bV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574932082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7eOL-0006cJ-DS
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 07:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7eLf-0005N4-8R
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7eLe-00029E-20
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:30:15 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:46060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7eLd-00028y-Tz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:30:14 -0400
Received: by mail-ot1-x331.google.com with SMTP id 41so14186503oti.12
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 04:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NNGTWEOqqh+MYcRjV/doadHDdI/BMmSTgBnaIKcgyWE=;
 b=a58g9bV4vgUlBpNGDJ9sLFl9jJo4i78W1+SG+tEVyXAHHHN0okuqyv5Jfu0Lg0eywY
 UPlh85jlsgdMzWfxECCCbPvvBtU4Klh6U7m5D2hXcmx4TmYy0Cg0kxnZFqBGU0EhJKVn
 PxH26gFTvPqlIFBGE8KUyH/bE4zJFMZTCjOck0RXDk3Wmfj3NvAHv9bbqFhLl3/aZUdz
 IL5kUk4JNT14WlWVo/P3FN/cFOKe1tuP4uRiXncUIRSGMvDLCZlHw/2iydMwVvKNSLo2
 48hqnPJuT2gA1OBSHO70jMEF+Ywux7330APy/AaK2spe3PPUgiyOdylCf9s9G2ff7RaM
 vBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NNGTWEOqqh+MYcRjV/doadHDdI/BMmSTgBnaIKcgyWE=;
 b=W2I1fcDUuyZ4udZ7mlY3p3GpzXodufc1xS+rIvW76Ilse1W5jFWC6haQ0NXfPV/nfU
 VZ5b/ZGk+NY3YoI/eYiwKXkpvSEw4hXxv21PxEYXJv+imt3s32VFIegKvhKBQkwucrr6
 BrAT0a7kTve/vy3qn9NVwTJEAmcXDrBZRxQkhSKYSzHKy7mhJSS8heDWQZ2Yua+FVymj
 UVZE+8EpNUrN23JvMIGzyhI/lkKKv9LlPVEFGRqiu8U9cBrmQNVB3YGSTd+z94LE7vJm
 BUXb/+isv+SkodicqMn2v4Ra29bx6C8p5HfqM6DGVzl5Z5Sig+OTCUm2AKk1cJ+UFCh+
 oDKQ==
X-Gm-Message-State: APjAAAUZ3h5UYNju9sEoNZvJLzo+TS5WcLIZMRFsaK0GJcK3eXcHFlgg
 k616Rl2QGtOBjY26cil/n9xdZyVNkYWCc0U8ya1SEA==
X-Google-Smtp-Source: APXvYqwTQ0yr56VkV+R4ZSN5flpYunPKtl6iWv45miG9VK2FDUgttGGDZPslGL/MvXU5zlWWDE5pJiQOZgGSLZcUCG8=
X-Received: by 2002:a9d:7504:: with SMTP id r4mr24142751otk.221.1568115012732; 
 Tue, 10 Sep 2019 04:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190910084349.28817-1-alex.bennee@linaro.org>
 <CAFEAcA_rB21=KXr_kJinkeDa0i3=LAhAYDg50YQC_7v07TKXjA@mail.gmail.com>
 <87lfuw1jcw.fsf@linaro.org>
In-Reply-To: <87lfuw1jcw.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2019 12:30:01 +0100
Message-ID: <CAFEAcA-SfK8rX58sdH2naok4NWP8Nm3Wi3-tnbNyOQ961xwgpw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
Subject: Re: [Qemu-devel] [PULL 00/45] testing updates (fixes, upgrades,
 caching)
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

On Tue, 10 Sep 2019 at 12:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Hi; this seems to break 'check-tcg' (for a linux-user static config):
> >
> > [...]
> >   CHECK   debian-ppc64-cross
> >   BUILD   ppc64-linux-user guest-tests with docker qemu:debian-ppc64-cr=
oss
> >   RUN     tests for ppc64
> >   TEST    test-mmap (default) on ppc64
> >   TEST    sha1 on ppc64
> >   TEST    linux-test on ppc64
> >   TEST    testthread on ppc64
> >   BUILD   TCG tests for ppc64abi32-linux-user
> >   BUILD   ppc64abi32-linux-user guest-tests with powerpc-linux-gnu-gcc
> >   RUN     TCG tests for ppc64abi32-linux-user
> >   BUILD   ppc64abi32-linux-user guest-tests with powerpc-linux-gnu-gcc
> >   RUN     tests for ppc64abi32
> >   TEST    test-mmap (default) on ppc64abi32
> >   TEST    sha1 on ppc64abi32
> >   TEST    linux-test on ppc64abi32
> > qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> > timeout: the monitored command dumped core
> > Segmentation fault
> > ../Makefile.target:116: recipe for target 'run-linux-test' failed
>
> What host are you running on? Mine doesn't run because it has no way of
> building those tests.

x86-64 Ubuntu 18.04.3 LTS (bionic).

thanks
-- PMM

