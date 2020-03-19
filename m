Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F105EC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 16:25:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1AB2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 16:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD0jlXLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1AB2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jExyv-0003E3-WB
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 12:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jExyK-0002oA-8B
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jExyJ-0001r8-91
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:24:40 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jExyJ-0001or-1e
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:24:39 -0400
Received: by mail-oi1-x241.google.com with SMTP id k18so3318403oib.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 09:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gUDJYzj/F5aBYDPQLsPUh27R1m3IXrm+6iH7QYNaTmQ=;
 b=RD0jlXLlUiNEu5kXKJKN/0CBUOfrajUW5bHv7LEPA5OcQu1+nws0hGGuugts+UuyGr
 DDSrHkIl7mYfCJi8kE+PVhq0UrEQrLiGVSnl758bE5VZUss1789J/Njd3ZdH4kyAYvYr
 4+h92/YL3e9dAmwmRMSI4QFjbnsMhHGqCwFZFMiO0FgCdj7cUEUcIYT8cRha7YfU/8C0
 ACO/y/a+nvVeXryhrrA1/e18PzLZ3jCdVQH4IrVx/HwdvrNkoT8C3Cw19eAhLcBa/07G
 ovtFOoSG54ZZfW4436UGd3iAIXIs7BqNq8tzGRWPM5xIu9fx0Qj9qGFSjC8aikDmUYFL
 FjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gUDJYzj/F5aBYDPQLsPUh27R1m3IXrm+6iH7QYNaTmQ=;
 b=B+UYq6qy6lCFRi1lplKcAuhPfOxOz4k4NLFEgFjUQb6scgINsoxJeVM+/ewxLJLY+/
 8fAt47DxtXxJZWpb3iMMc5Xs9jXR1I9D33jSqJez5tMVBXtFCKHqYdBkXX86xDN415D3
 Df5ZUlFJmi8h/id+4R28jXDgmI4NYK8kEZsS1TjOR7Sw2UUwP+69oWcezNahHj6BHuDF
 luZC0ni4IvLPb3otDiZtpBvZYWbMNTKaCktBn5UgfSR4Xz0JBokO/+vUPIn+VxrdVzt5
 AWDjRP+AtWcfkBydlkoQsGpJ/r+fOd/2ZGVAV+zYC8me/TscCzKo5OQg7gP+euRcTqZ3
 T0Eg==
X-Gm-Message-State: ANhLgQ1mk/fBQMI9cbqszIxFWhbaRCYsBhgesnTQeOqmM5hYHd1gI5Za
 +wuDJYw2UbB+6OLpADsm3G0POdOaB6q5uDAuWFxvvA==
X-Google-Smtp-Source: ADFU+vuZ9G+bN+uitssOzTW93XOdoynDipQkPzB4M3Aow16wObc385j/8h5sjMQ+dzMLBGbhOJwr3DJNUyRLxvMWwPc=
X-Received: by 2002:a54:478c:: with SMTP id o12mr2868623oic.106.1584635078206; 
 Thu, 19 Mar 2020 09:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <1579227117-6310-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <994d96ac-ce43-9ff5-7212-eda6e12264fb@vivier.eu>
In-Reply-To: <994d96ac-ce43-9ff5-7212-eda6e12264fb@vivier.eu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 19 Mar 2020 17:24:26 +0100
Message-ID: <CAL1e-=jOUxOKHFdVa06TpDwsbicKyGrn8mJ=dJtRcaAX6sFriQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] linux-user: Fix some issues in termbits.h files
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> I think we should first introduce a linux-user/generic/termbits.h as we
> have an asm-generic/termbits.h in the kernel and use it with all the
> targets except alpha, mips, hppa, sparc and xtensa.
>
> I think this linux-user/generic/termbits.h could be copied from
> linux-user/openrisc/termbits.h (without the ioctl definitions)
>
> Then you could update the remaining ones.
>

I agree with you, Laurent, that would be the cleanest
implementation.

However, I think it requires at least several days of meticulous
dev work, that I can't afford at this moment. May I ask you to
accept this series as is for 5.0, as a sort of bridge towards
the implementation you described? It certainly fixes a majority
of termbits-related bugs, many of them remained latent just
by fact that XXX and TARGET_XXX were identical. The most
affected targets, xtensa, mips and alpha should be cleaned up
by this series wrt termbits, and for great majority of issues
are cleaned up for all platforms.

I just don't have enough time resources to additionally
devote to this problem.

Sincerely,
Aleksandar

> Thanks,
> Laurent
>

