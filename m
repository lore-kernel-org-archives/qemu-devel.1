Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803E9C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487DD218A3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lUjwbnEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487DD218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hinUa-00006B-Jy
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 18:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46673)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hinGD-0007C9-1U
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hinGA-0005J7-3m
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:57:52 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:39618)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hinG9-0005HP-Sl
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:57:50 -0400
Received: by mail-oi1-x233.google.com with SMTP id m202so3346590oig.6
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rJdVnIKhWEniOpY8ZEqecWB+/NnBQ+GpKMeZOMYBlYQ=;
 b=lUjwbnEQ3WfnOZcqKE0uFpTnLNF/oXd0CRI3rEfd6Hly0IDv/c0dTAz2m1oZEDYfUo
 0GCW+Um8z1N+ZNvZ1hPimWZ0qxdlMJwgzqJBgUs7Z2OIo6A0OhS4pR5D8Vol34+Z02sQ
 i9rewm3L77yhnpNoACr5Pilca0PZmOHIaDpKM98QlKPuaKE3VMflZkyV13vwlr8A5yZ/
 u7ec5xq9Uhe0n4LcVtsHNvKIiaskZ9qKJD+ERdj1khrraHrEr2CwBTC+L8k5BYvUx6Jk
 Qz4VBWqPTNy5wAI2qPerTqybXrdLF2ImIKEGMrwayCNCZbjAGpi54/dfLSw9LsMYHIyj
 0Zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rJdVnIKhWEniOpY8ZEqecWB+/NnBQ+GpKMeZOMYBlYQ=;
 b=i4dpbvjLsUHizGKZ7HivEJLrpJWNihEJP5uC7OPYYNMWoP+AWGt/rGePAo4N3xp7vq
 U15pzctI56rultyPg/B1n+ows1j7E5eEcXWQTHPsT9dArV1gTbKOuLr6W7L4tOkn/QGx
 QeJ9f9trpoA9rwCGfrGoGiSGNKUIS/+G4IsXC833LaKSjEVT+G00FJw23Q6JVg5RT5gU
 m0iFYl3zu4Y2Gna6ZZNze61UGzvdGHAGVZsITxuQqrTIn7BDFaiN9c4cLFY/N0iQWYPF
 0yVbXVri8vlm8bRyo95vk6rjlJC1yokIY/EXp3yM/pP/s2z5wzbbFZUFBEd6wai8g2J4
 yMBg==
X-Gm-Message-State: APjAAAVXFkoyR4b/OgNQ7d7Y0BPhAQu6Qr9luNRhqfJSOpqsixBLuV+2
 ZDA3lyKi83Qp4wCXgUW47sM4eZZyat/ghKgvt7aPQQ==
X-Google-Smtp-Source: APXvYqwVEgHeP/hBCd6QCWiVynol/1o0Zgooo5O2GZ4RCBideLBPFV3s4XfAlEQ50FWxThPNfHTqvDu5lULDyZTwjQI=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr449079oic.170.1562191068118; 
 Wed, 03 Jul 2019 14:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <1562085328-5126-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1562085328-5126-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Jul 2019 22:57:36 +0100
Message-ID: <CAFEAcA8fr6-sdeTY3m=mO+nCRvBH3pqKHh1B8aXK3D7Ta=DSAw@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
Subject: Re: [Qemu-devel] [PULL 00/12] MIPS queue for July 2nd, 2019
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 17:35, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit d247c8e7f4fc856abf799c37ca9818514ddb08b7:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190701' into staging (2019-07-02 11:48:39 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-jul-02-2019
>
> for you to fetch changes up to 698c5752c4e618dc17b4c78dfa566896c7bce5ef:
>
>   target/mips: Correct helper for MSA FCLASS.<W|D> instructions (2019-07-02 14:20:42 +0200)
>
> ----------------------------------------------------------------
>
> MIPS queue for July 2nd, 2019
>
> Note:
>
>   - a checkpatch warning on updating MAINTAINERS should be ignored
>
> Highlights:
>
>   - introduced limited Kconfig support for MIPS machines
>   - updated "machine-none" tests
>   - cleaned up translate.c and msa_helper.c
>   - minor MSA emulation improvements
>   - updated MSA tests
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

