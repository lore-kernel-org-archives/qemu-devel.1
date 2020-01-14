Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A319CC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728D92465B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VbWdfXzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728D92465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJ1i-00029P-6i
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1irIyy-0007Qd-4F
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1irIyw-0007NR-OG
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:59:32 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1irIyw-0007NC-Gr
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:59:30 -0500
Received: by mail-ot1-x344.google.com with SMTP id r27so12031063otc.8
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 01:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b2DiuJpfAtGeAoUNzZ4klHYPKsCmGPyrHxskQkSSgUg=;
 b=VbWdfXzWosBz2rt7Q96OtBBGxyjJ23tVF22pL0vbVpHsN/sf6yyejPrAGzrRtedjuW
 ZQHqq2nT/tA64qyWt0KEVT0QgUHMSCiEi1G3yko153Uh8/nFZQdl2Uep832aroOMao2g
 BVGAUjG/viB/jNfQ8wcC/SodObiyxgQpfhUAQMZZRvdNZEp6RwqFtnL3Cc41Y1zmH3or
 A65ytUyeEXZ/2i8rlL9dgGLArVbDEVwIlFzEaQcL+sTwgPBZR5MrdyPshQTvWJQEQdak
 va3VuOc3ZyfPSqDt61Heu+Bw8KvD/rV9i0b8KzIXjuOBu/0X0smWgrOiHVfL8vqkypxa
 29QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b2DiuJpfAtGeAoUNzZ4klHYPKsCmGPyrHxskQkSSgUg=;
 b=C70qc5rJZu0wQO25+nUwjZQ9RYeSgTg7QqGKH8MAv0BLABXOthk9v8xaLYk2L2hNd6
 km5PElLkPEzdh9iw+1+M4UudP6N0aro+sEcNexRlZwiGVR88XCnGQkngO/aR41xHdX7O
 J7q0rsZLen1TeaHzQlH9/chq1IcGbJVaImRolgMnh9LekzAwJzHz9mSNMo/zq1rL4J+W
 /NnsIGc1gZr1zaWWIwVirO8sXGYw2xzvOjffeE763DB49Yc5ofvn0PNgcPRMxaVTh6io
 RWoezSrGuOU+cvbZnKOVgkX/FLTgP+it8sbon6Aojjk5qsZEou9R78hiaG/xdpHiJl2P
 y54Q==
X-Gm-Message-State: APjAAAVheZ3MLiB5vTa0tpgZms3fmX7pvP0oKXj+atUjFtss+tyc/iKH
 qj+uSB+laGgsZ8oPoFyRQ1Cao+ul2850dgpLW6pp2ZkOg80=
X-Google-Smtp-Source: APXvYqztqi7IYRauvmq7P68h1Pbh39F85X1I1e1h+naKZZKMOViZ/q4V76RDrMrKEJu7EOga9JMCLvnITBC03NhBqLE=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr16615430ota.232.1578995969450; 
 Tue, 14 Jan 2020 01:59:29 -0800 (PST)
MIME-Version: 1.0
References: <11d88b2741eac3f634d5aed9e3355c974b533f7b.camel@kernel.crashing.org>
In-Reply-To: <11d88b2741eac3f634d5aed9e3355c974b533f7b.camel@kernel.crashing.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jan 2020 09:59:18 +0000
Message-ID: <CAFEAcA-A_caQgwi5DzExdZChoTg-Qa73hq7Ho7dPLiN633Yj1Q@mail.gmail.com>
Subject: Re: Semihosting, arm, riscv, ppc and common code
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Packard <keithp@keithp.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jan 2020 at 06:29, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Hi Folks !
>
> So I started "porting" over (read: copying) the arm semihosting code to
> ppc to mimmic what Keith did for risv (mostly for picolibc support).
>
> I noticed that the bulk of arm-semi.c (or riscv-semi.c) is trivially
> made completely generic by doing a couple of changes:

Note that semihosting is not a "here's a handy QEMU feature"
thing. It's an architecture-specific API and ABI, which should
be defined somewhere in a standard external to QEMU.
You need to start by having a definition for PPC of what
semihosting is. If you're starting from scratch there, there
are some important things you should do differently to Arm --
there is no benefit to repeating the mistakes of API definition
that we made! Most notably, you want to specify and require
that any unrecognized semihosting call function fails in a
clean and detectable way; you also should have a semihosting
function for "ask for a feature bit mask" so you don't need
the silly magic-filename approach Arm had to go for. You
also want to standardize what the errno values are, which Arm
forgot to do and which makes the errno handling in the spec
pretty useless.

TLDR: don't start by writing code, start by writing the *API/ABI spec*.
I tried to push the RISCV folks in this direction as well.

thanks
-- PMM

