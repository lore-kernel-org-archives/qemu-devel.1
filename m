Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EDFC2D0EC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 22:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34AC020730
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 22:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qVa6ALr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AC020730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLwU2-0006UD-Aq
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 18:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLwTD-00060A-VW
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 18:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLwTC-0003cC-Dt
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 18:13:23 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:32972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLwTC-0003YO-0f
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 18:13:22 -0400
Received: by mail-ot1-x335.google.com with SMTP id 22so4888708otf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 15:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UsucZV2y4UQhnbWExsDrnLUHUp7t4hWaxJQR+dm5YB0=;
 b=qVa6ALr5fdVfw5RQj+3nwlG3to5V1muPSNWzv+1ud+0++smo014WiINhRbPC47P/GU
 GpAKac1pzYFeoljc9z0Gpyhk4uDrGXq+rwwvCAWBoVTF6S1yAXTRjzCsaJPNUOTbnjL9
 1N6tX/V1Dm254M2DiG8GLQuWfGVi+4ZiNmEBcHQRgwl8X5eg0+o+pUD0W/OeuPjmkux8
 QBRMVtXZHd9tuedTGn3ULAdtJ3RBHOCi/H33PD3TPKwLl2LK0pKFKRIo9ik4Y70TfmvC
 PvLLR0nZvsoGNvjztzfL+iFiTH4+/eWLHbKZ+mY41F/9SjPa37LRC8qFrxqlr9hxLB+K
 jbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UsucZV2y4UQhnbWExsDrnLUHUp7t4hWaxJQR+dm5YB0=;
 b=XJdDIBPbCxpQdcRCcbK7ULd8pxDoKdKJHX+e/+cc6oBTdQdo2dLzgiT12WLx6q6n0C
 NKGX+3v8xjakCHroQzXPdskF0GcsUgCHy72KVoRtFVjJScZNrqHm7IYAsCdp2fEL2Eo8
 JUeN4zotfhDjXJzvaKZs7hN7UKQbFd4uPxUtN6JfkPi3pfUNQIkCFwEkiDQinqKbzx/J
 sva5odhg2kH44FzhEPBRGhgH/HvTVwrx+e6QbGuaRsOCMF5wh90ShtC3gl0Da9wjn9hc
 kzgmztdJ63JfJh0FVYWCX3FGXNfm6xBhoy7XOZDAKYjNhoqu9uRbjF+qymCyRoYzWrLs
 mQ9A==
X-Gm-Message-State: AGi0Pub2ljqaN3ZGG2T48tqnFzAElEXXE6LLracpnAkeoH4j3NtYDFjG
 pbRPy7ngXd1b+gv0C+osyAYtPewJElT54Bx+PLWkTA==
X-Google-Smtp-Source: APiQypJO5PIalsjHvFFY4soy4e95dDkD3FbpPRxZt6v+uixweK4EOPShFfD5bn/HRjoBdTpZ3XaM+liwVqgiOU3sxNA=
X-Received: by 2002:a05:6830:11d5:: with SMTP id
 v21mr3468057otq.91.1586297599245; 
 Tue, 07 Apr 2020 15:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200407155118.20139-1-alex.bennee@linaro.org>
In-Reply-To: <20200407155118.20139-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Apr 2020 23:13:08 +0100
Message-ID: <CAFEAcA_YM-eFewESuVCM--waDUHMEsf2y7uKd0Qvy0Lc8rE9DQ@mail.gmail.com>
Subject: Re: [PULL for 5.0-rc2 00/13] various fixes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
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

On Tue, 7 Apr 2020 at 16:51, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The following changes since commit 53ef8a92eb04ee19640f5aad3bff36cd4a36c2=
50:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
00406' into staging (2020-04-06 12:36:45 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-misc-fixes-070420-1
>
> for you to fetch changes up to cce743abbf398a324879039cd582349b36da0ea6:
>
>   tcg/i386: Fix %r12 guest_base initialization (2020-04-07 16:19:49 +0100=
)
>
> ----------------------------------------------------------------
> Various fixes:
>
>   - add .github repo lockdown config
>   - better handle missing symbols in elf-ops
>   - protect fcntl64 with #ifdef
>   - remove unused macros from test
>   - fix handling of /proc/self/maps
>   - avoid BAD_SHIFT in x80 softfloat
>   - properly terminate on .hex EOF
>   - fix configure probe on windows cross build
>   - fix %r12 guest_base initialization



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

