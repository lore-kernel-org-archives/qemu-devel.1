Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C28EC35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B36421775
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OrO15+Ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B36421775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Pqr-0003fy-6D
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j0Pl9-0000ep-9C
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 08:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j0Pl8-0000nC-9b
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 08:02:55 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j0Pl8-0000mh-3g
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 08:02:54 -0500
Received: by mail-oi1-x244.google.com with SMTP id a22so4793148oid.13
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 05:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ticawza4Abt+ODcV/2R06hYS6ay9d1PUPqXEuIBK5o0=;
 b=OrO15+LlXwVHQBd46W40w55vOK+namnDj+H5YfBGErizLrgfKz2Rd/pPtCkiz9G1AV
 hd/uoXiO/mYrobUnieVA15W9VtC2NRTtt/OWD9PIpkAJp7D0sTQ+5Wa7OnIfQL2STBvS
 EqyI5Vwr3OLPicuBBJPHCg/pVGiSCxr8XlqpoohB0J7uXnAfqWIwAy/rua4zYHXZtzHI
 j2JWlFVHzzbeMucMCDcaQR0UbznlzwtEYpnH/3DztJfdyTOQV7Qc56pnKxjy9xoI0vGD
 zTvi00NyX79U/47GJeAkHtLXk0XJli2S1/q6oFFwfgdybEZJ3cKIDvjJ0GDv8fimKNE+
 /krQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ticawza4Abt+ODcV/2R06hYS6ay9d1PUPqXEuIBK5o0=;
 b=uVs18IJJKTwdXoQxGzmtpsFEReAI3JBExp9/RgktJeyfDkLhrEa5h1NhyfSga0AxEd
 54cGAKqSMa7JbZheZbGQ134AJgVMi8QtW7EUQAaOq+p7dixW2NwsQaUR/nIVGOnxi3pz
 6xLfCmm4h3AoOutuh1z8s8rzkIlUuyzr8mo8gV05G+8Bt379+zfzOr40yu5aopldWk6D
 N7VU/cpVHTgZMjtMiXTVpQ23GoQdxRl/Pq5GPFuVjdrFwiXzi9INS64INkaiTwLefmpa
 7XRsNjRg3y7luaMXqM/cfyrdoRITOm0qNfBx41m3mMjsNJ0prCpaqzSRg6CG4nx6dpWw
 gHRg==
X-Gm-Message-State: APjAAAUZmzIJ0PO7fJgMT7PWHuuoZV6d/NEvihvAaUW/DpErq/VO6qg7
 6g8tw5+0dunG+2WY6WnSPy0DHEy3ZnQCDAKSSje5Jg==
X-Google-Smtp-Source: APXvYqyTDWD1eFtPr2cen92aUb7Zsivfi53JKYbHwUaG4jgfBgDSNvubu3Goj29+1SrAjtAW44COycBnhOxyho8eq+8=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr5099803oic.48.1581166972862; 
 Sat, 08 Feb 2020 05:02:52 -0800 (PST)
MIME-Version: 1.0
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
 <a87e5634-903d-2ad5-4f33-b65f77703302@redhat.com>
 <20200207193429.GB13258@localhost.localdomain>
In-Reply-To: <20200207193429.GB13258@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 8 Feb 2020 13:02:41 +0000
Message-ID: <CAFEAcA8dF+1a3zjw2MBVfD5k5U4EeU21iOik1mhKqg1ubicA6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 19:34, Cleber Rosa <crosa@redhat.com> wrote:
> Also, the build and make steps worked fine without `--disable-gnutls`.
> I was trying to not carry over any "exception" type of arguments,
> unless they proved to be necessary.  Maybe Peter can give some more
> info about this (should it be kept or not)?

A lot of those config options are random historical accident:
I probably added in the configure option to work around something
years back and then never bothered to undo it. I agree that if we
don't need to pass that option to run on whatever OS the CI
job is running on we shouldn't keep it.

More generally, I don't think we should worry much about
exactly replicating the fine detail of the various configurations I
currently run on x86. If we basically cover:
 * a debug build
 * a non-debug build
 * a linux-user --static build
 * a clang build with the sanitizers enabled [+]
 * windows crossbuilds
 * a --disable-tcg build
 * an --enable-tci-interpreter build
 * and at least one of the above is done as an "incremental"
   build and one as a "make clean and then build"
then that's the same coverage we have today.

[+] my scripts do this by hand by passing a lot of extra cflags,
but IIRC configure now supports a simple 'enable sanitizers'
option of some kind, which would be OK too

thanks
-- PMM

