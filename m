Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1C3C33CA3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:03:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A31820848
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fmtpvtPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A31820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwlC-0002iT-Lk
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 11:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ipwa2-0008O2-MM
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ipwa1-0006GR-AD
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:52:10 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:39802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ipwa1-0006Bn-0p
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:52:09 -0500
Received: by mail-ot1-x329.google.com with SMTP id 77so2377580oty.6
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 07:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K07ZzTAF68Y2I+3NIwyL6+gcFgb1Nh3c8Oexhix9uYw=;
 b=fmtpvtPnIwSF3dfnWAoJ+w3otGlFki1eTJcfb0AuEUoXwisiEOHcQb9VofaYnTtuYu
 zHRXACMmmH4N87YEoyS6HfW5ajEUcltdr/o1IhNH28cqQp5hEXD+rbBcce6+NqeJ1M1Z
 VnO/FB4SpfvEfMT/vr9Ik7RDwW0YTeQxYbjgrNYjJIFX/akAnhSbmU4+WR0hG27cYad8
 MgGVdD5c95+LbqhktDO3io1V82rGkkzhzZOgm4Nz8f6T/59vCwZlYiHJdjKoxQEKxxEh
 RczKdP6Vxh1/nD8/pPb+L1Ql6kZaBvVzEMA3MCa9xOZq3mJexky4TdYx/8kQx41SrNDT
 29/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K07ZzTAF68Y2I+3NIwyL6+gcFgb1Nh3c8Oexhix9uYw=;
 b=c/CoCtD3eCJzcOxYJtZHtmwDaT9+P92UydT8xK5o/UHCcZijSoh60m1AH736GPjl4C
 ITdoIGMy3WUdUX/ZnQutqec9j3gk5OwmJJaHsZwnxKo4bRhZkI2e+WyJfxayB9soS8iN
 DVx8idR44Yzkn1HwARjvHTz2/UaMCrxMefmbREjLmy5uc9VAdcxu7Csul62QD29Ac9GM
 UnFoUaVXL3+1YgLhwpFQNmjzm4zV1CDeQx9oOmJngmvchuBafVVFW7zDCMQySueEhJ7b
 CFoKBZWxHq6496DNlg0usgVMNe3Cc2ov0prkIvuHLV3UzFRz9upRaTiYSp6XuEvMkSFp
 gkxQ==
X-Gm-Message-State: APjAAAWwtjtiPQGsuwMpS0m50noN9xOxEYcnzMoxm9RFKzvDnUW4n7Kr
 RqnRzdhP/zqspXJAyhZrbj1j/xRTeely+t9nW8SH0VWIeWM=
X-Google-Smtp-Source: APXvYqwmDdUUgeIx/hgno0phQDanWGTHvJubUF9EjYFkeUUlhMVqHcjyFz4LULfpBXylMHgtJPmVx2O7z3xn+pyjcsw=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr3194240otq.135.1578671528019; 
 Fri, 10 Jan 2020 07:52:08 -0800 (PST)
MIME-Version: 1.0
References: <20200108034523.17349-1-richard.henderson@linaro.org>
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2020 15:51:57 +0000
Message-ID: <CAFEAcA9P_3enu_M-55aoqWScFFAhw=Jfs92+vCc+yY-2nXUehA@mail.gmail.com>
Subject: Re: [PULL 00/41] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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

On Wed, 8 Jan 2020 at 03:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 035eed4c0d257c905a556fa0f4865a0c077b4e7f:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/q800-for-5.0-pull-request' into staging (2020-01-07 17:08:21 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20200108
>
> for you to fetch changes up to 5e7ef51cbe47e726f76bfbc208e167085cf398c4:
>
>   MAINTAINERS: Replace Claudio Fontana for tcg/aarch64 (2020-01-08 11:54:12 +1100)
>
> ----------------------------------------------------------------
> Improve -static and -pie linking
> Add cpu_{ld,st}*_mmuidx_ra
> Remove MMU_MODE*_SUFFIX
> Move tcg headers under include/

This makes the x86-64 'ls' binary in the linux-user-tests
tarball segfault:

/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/x86_64-linux-user/qemu-x86_64
-L ./gnemul/qemu-x86_64 x86_64/ls -l dummyfile
qemu: uncaught target signal 11 (Segmentation fault) - core dumped

(probably
http://people.linaro.org/~peter.maydell/linux-user-test-modified-pmm.tgz
if you don't have a copy to hand)

thanks
-- PMM

