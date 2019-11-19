Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6E5C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 21:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B41622460
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 21:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIkORf4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B41622460
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXAqN-0000ip-Gy
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 16:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXApZ-0000F0-S7
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 16:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXApY-0000fQ-QC
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 16:14:37 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iXApY-0000ew-Ls; Tue, 19 Nov 2019 16:14:36 -0500
Received: by mail-ot1-x342.google.com with SMTP id u13so19267899ote.0;
 Tue, 19 Nov 2019 13:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5kLHM8TQ5/O7kPY4swsk0dWV0XDJjoLYUtMLArDZwz0=;
 b=YIkORf4qZdW5paTDVJvN54lP16h2Zh2wFfykZ/hjAUCTW6TT/k0gfUlFrK9gQjfoSZ
 gQfXtgci9iV82cWMJvRGQMRn22iUTKk3Tp+q+kT4BHDgeXO2tHsIWBVfyMUBIcmB8K/A
 r/pZm2JJQHvSmnrJ1HWbllcuLlLx9oSnKbjXQtQRpCkxM/answOqu051xiB6M3jIkoe0
 FawpG1Idf167iPaYH0ncZKOEYK4W0x2qgLBw+Qq6bE/XovEbCrOqV/tN5ThpjFvdI89Z
 E2IO1Z9OxkfVp/t8NDcNtsLLziaIEWBkrf5Go89+IuUNjFXxCUfjiTbNPoLWrTF+TEMT
 La5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5kLHM8TQ5/O7kPY4swsk0dWV0XDJjoLYUtMLArDZwz0=;
 b=kP54gtv+YOUYaaoIEogHYT4miQ+caJR7Yx0FrMFrHP7pbWn8QP44rsqgdOauWhR71Z
 4snXhMMKNwXbk8hHC8JTKI4Pi9C56Luprq8+j5/r32ZSFzNZcEfvzD7blj8kykDV7VqD
 JwGrrqDZsMmsDvZ44qSIOlKvCqgqYb69fHlkdl/mmoh++9tp+g2racbGcK3h6Uyc1d77
 621Q1mX5UL6HdsMBPkHYiAkO3pXaPltR0hM/KJqKH1Q5Pb78P2c5x49DNrjwmqqJSbU9
 N0os4ZLjNNWqELXUeSfsKTWm106ngWSIglU/pLKhWQzfGYdpcebg5UN0piUBDAfsHsMU
 jRlQ==
X-Gm-Message-State: APjAAAXch8mn1ZaTCBrTtxkk5IB8j3EHTD6ZWV2i1zRXXZuZEMEweavF
 VEvXiEGrXg4gkzwUPILlkPGBxzQFZojr4B1kKpw=
X-Google-Smtp-Source: APXvYqzeMVtuz+45anvPbjuByBE2lwRk6WORf5+jyfOhVn95JKtpSxR21NS2Yz2H3URJW7QtmqnNtT8+mty/KZfjlVw=
X-Received: by 2002:a05:6830:81:: with SMTP id a1mr5258027oto.64.1574198075451; 
 Tue, 19 Nov 2019 13:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20191119204551.240792-1-stefanha@redhat.com>
In-Reply-To: <20191119204551.240792-1-stefanha@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 19 Nov 2019 22:14:24 +0100
Message-ID: <CAL1e-=ibQBWUzUZvsvSWCZ5SwFk5T+b2P94D068W8G_taWVASg@mail.gmail.com>
Subject: Re: [PULL for-4.2-rc2 0/2] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:bochs" <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 19, 2019 at 9:46 PM Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
>
> The following changes since commit f086f22d6c068ba151b0f6e81e75a64f130df7=
12:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-fixes-20191118=
.0' into staging (2019-11-18 21:35:48 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 6b904f1a528a6d8c21f7fbdeab13b9603d1b6df7:
>
>   hw/mips/gt64xxx: Remove dynamic field width from trace events (2019-11-=
19 16:17:05 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> Tracing fixes for MIPS.
>
> ----------------------------------------------------------------
>

Hello, Stefan, Philippe, Peter.

This appears to be a duplicate of the pull request sent today by Philippe
(and already applied by Peter just hours ago):

https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg02894.html

The patches from the two pull requests appear to be identical, except
some minor details in commit messages: Stefan's versions contain
"Message-Id:" identifiers, while Philippe's don't (my suggestion to
Philippe is to include "Message-Id:" for all patches that are part of any
pull request in future; this can be achieved effortlessly/automatically
by applying patches using patchwork).

In summary, for this very situation, it looks to me we are all set, no need
for Peter to process this pull request.

Regards,
Aleksandar

> Philippe Mathieu-Daud=C3=A9 (2):
>   hw/block/pflash: Remove dynamic field width from trace events
>   hw/mips/gt64xxx: Remove dynamic field width from trace events
>
>  hw/block/pflash_cfi01.c |  8 ++++----
>  hw/block/pflash_cfi02.c |  8 ++++----
>  hw/block/trace-events   |  8 ++++----
>  hw/mips/gt64xxx_pci.c   | 16 ++++++++--------
>  hw/mips/trace-events    |  4 ++--
>  5 files changed, 22 insertions(+), 22 deletions(-)
>
> --
> 2.23.0
>
>

