Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F31C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12787206C1
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9hyIBoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12787206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hudou-0003Go-Ak
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 10:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35183)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hudky-00040E-5y
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hudkw-0006sL-Vq
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:14:36 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hudkw-0006rf-Q5
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:14:34 -0400
Received: by mail-ot1-x343.google.com with SMTP id z23so57051834ote.13
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=n8SHgUc4aq89SRdOQDE2eq9z/HeMitta89Jp4js9lTU=;
 b=B9hyIBoqPD6RXFYMf/2Fmg6yDl6MW2wbaXKR17MsXMpsfcgJhh6TIAKfFMK5IhGfeZ
 ePWsmhDY5QtBpm6Jd9F3q8qIiI0JoQQf86lSXoslR32Ln3OkNz2dPHXEy8CQ1/tYhNAM
 /rpMGXZeSnzcMiEymkgGJ0ImmV76S72ib3P6v0O0UCDWq8PRul6eWsxTvErAru8hkcoi
 WHai/Fh27+jGrAJt4Qj24Fdaaj/R+94ZujT7MThX7aBeYvcOCZr5FdC1MAK+s+Tl4ITa
 UTYE6RKhLpeTwT6IqshZ8O/opIYvakTsnEy6lvqsW9yHnvk9g39NyE4a9d69nMEk8lV/
 KSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=n8SHgUc4aq89SRdOQDE2eq9z/HeMitta89Jp4js9lTU=;
 b=qsgNJs7HB/LQfIgsmhcn0Uhv3YJuOWuLb2G/i/cuHQunYmmh/vVov8XbaO/T1Fl/eZ
 zdeb1d0DEH3JMy3q6M5qwB1UBouq1U4LFsJW2WW5gmL9P8yUBPF+cb4sZAGac9vKmjZE
 TiZFrRRQPmqCcMCCp3tL9Y1u1zXg8w+sUxRFewTbxQM6cFk1GiHArFoFLtzYIuub57mv
 Lg8qvW2eqNbAA9g9E+04sHAW2Ed4dJlezwLlvQmJ7T5mDwbTBj84lpv5A34xbFisV/w/
 tgRGdDY/GN6WezDSONzdLzLOPxUCMisPnVGHWnkC4BXej09fQo0PHUdpp5THh/N+GCmt
 HeRg==
X-Gm-Message-State: APjAAAWaNcJ8y95gVtUubQMPQ3zAS6YnPkykHMUGdcY3yEqpaKRsg1iJ
 TXJ33pOY5iAY5rImd8g0mOkwoviKtoN2GILThULSSw==
X-Google-Smtp-Source: APXvYqx/fD5NNVBGbL+BumrUIzX01eEYRW/Y1wLk1PvvdAYJQ+ag7gT9ryIb2l6nCtZOxT4dryTQBsEBwbO+VvtCL9M=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr30442940otk.221.1565014473935; 
 Mon, 05 Aug 2019 07:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190803082517.15035-1-philmd@redhat.com>
 <CAFEAcA_cPDdwXkSra_8vxE8c9M2y91s5FvpB7sZh12xF-LPUWA@mail.gmail.com>
 <a4158e8a-d67f-52b5-c082-681d21ac2599@redhat.com>
 <19158743-5f00-f89c-d9af-5b991a581b6c@redhat.com>
In-Reply-To: <19158743-5f00-f89c-d9af-5b991a581b6c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Aug 2019 15:14:23 +0100
Message-ID: <CAFEAcA9zm-JXkzG05oHAfXQpEnW4x+Bi13TA7Hr1KQtEXSHWvg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 0/1] EDK2 firmware patches
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
Cc: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Aug 2019 at 15:11, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Hi Peter,
>
> On 8/5/19 3:13 PM, Michal Pr=C3=ADvozn=C3=ADk wrote:
> > On 8/3/19 12:22 PM, Peter Maydell wrote:
> >> On Sat, 3 Aug 2019 at 09:26, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
> >>>
> >>> The following changes since commit 9bcf2dfa163f67b0fec6ee0fe88ad5dc5d=
69dc59:
> >>>
> >>>   Merge remote-tracking branch 'remotes/elmarco/tags/slirp-CVE-2019-1=
4378-pull-request' into staging (2019-08-02 13:06:03 +0100)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>   https://gitlab.com/philmd/qemu.git tags/edk2-next-20190803
> >>>
> >>> for you to fetch changes up to 177cd674d6203d3c1a98e170ea56c5a904ac4c=
e8:
> >>>
> >>>   Makefile: remove DESTDIR from firmware file content (2019-08-03 09:=
52:32 +0200)
> >>>
> >>> ----------------------------------------------------------------
> >>> A harmless build-sys patch that fixes a regression affecting Linux
> >>> distributions packaging QEMU.
> >>>
> >>> ----------------------------------------------------------------
> >>>
> >>> Olaf Hering (1):
> >>>   Makefile: remove DESTDIR from firmware file content
> >>
> >> Is this pullreq intended for 4.1 ?
>
> Sorry, I was not sure how to comment on the pullreq cover (everything
> between the '---' lines get include in the merge commit description).

Depends on your workflow. For me my pull-request-creation
script creates a bunch of files which will be the emails
to be sent out, and I can manually edit the 'cover letter'
email before sending everything.

> This fix a regression introduced during the current development cycle.
> Already 3 different distributions hit this issue and complained (Suse,
> ArchLinux and Fedora).
> This is not a critical/security issue and distributions can easily
> backport this patch, but since there is a RC4 planned, it would be nice
> regarding distributors to fix this if possible.

OK, sounds good -- I just wanted to check. I've pushed the
pullreq to master.

thanks
-- PMM

