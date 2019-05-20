Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E21C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 649C9206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDLf1ayW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649C9206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSfJ5-0002nP-MW
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 06:14:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hSfIJ-0002W8-Fw
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hSfIF-0000vZ-Iw
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:13:21 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hSfIE-0000uN-4c
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:13:18 -0400
Received: by mail-ot1-x343.google.com with SMTP id i2so7084334otr.9
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 03:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=hFondwTf/mbIiDfm9refisRF+6f+d7y2jllju5O5trM=;
	b=gDLf1ayWap+owbwyB6n0NWQeRdZtgGzNPo457/n73vwx9ph9gHnQ4PncdZmsc0clD5
	rVQuxJFPI0jql9Vj9TvTK5stMP91a4VueLporPmCyi+isjtisyyrXj2UZPx62JD/S3D/
	l7WuyKS7MJ2kKeKbTztSAj3vpzx7zBRW5vlDpUOgjgVKL7/ERTTFECKLVzc2gQGCn0JG
	pobYHTObY27iE2pXlnTwhwmyPS3dCaj3/tiHEMeqykQ39eg2tu23mZbqX7wxjyshGZwh
	oXVgjxtee6auldkn3UfpufQwF8VrDFH5Qe3YudgzecIRm32gCOsOHdy/6Bb9eOt7ymhs
	oOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=hFondwTf/mbIiDfm9refisRF+6f+d7y2jllju5O5trM=;
	b=YInMUTavJAzQxdPOvU/ZDgbv31LVk47xduFPjwTG2Vblgx1kB63q+mt8Ng/oHs73Ik
	VuGKKrWEbu0XJKnkh+yniiKHMSfbZVrCCj8UOZh1RxAWphlUNviTUL0jch6xIpLIY42z
	5FeqZRLK1palgPPHvsgmT2dYMnmvJ1ovniQd0Zu4kQz1qNZ+UOHdK9AWgQdMiHF3nEtq
	u1Xw4CNDoSBtRsU03VmPKHs3v0n9aa0J0GUk/9eSPWIn0Orh8nHvToBENNnlz6Hhxrwi
	VvGkUp86TEIDaGUSFdlrdeTopSeiyEeqZioGhbP+xiGFJDYEqKjXhAmCavBi3lOAnaR5
	JyKA==
X-Gm-Message-State: APjAAAUec1Ry3b/Z1hNBHwEWgKqHbEVKLfsf/K5C4mwlOdZ2NHsS/Ce2
	KZihac+2J64dDof0/B+rqfnpsPofUOnAthkkwP4=
X-Google-Smtp-Source: APXvYqxFyMoroRmefIM6TyQeTCAJWHbvnkPyiOdskq877EmAlmDpORNqSjaPKPgkU3NLFyoDKYMsRaC7SakiQm9aubk=
X-Received: by 2002:a9d:7858:: with SMTP id c24mr135138otm.64.1558347196094;
	Mon, 20 May 2019 03:13:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Mon, 20 May 2019 03:13:15
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Mon, 20 May 2019 03:13:15
	-0700 (PDT)
In-Reply-To: <CAFEAcA_W6i42hSCOYMVicyNg3x1tZJM347wc0d=9Am=ZtHgjJQ@mail.gmail.com>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
	<CAFEAcA_W6i42hSCOYMVicyNg3x1tZJM347wc0d=9Am=ZtHgjJQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 20 May 2019 12:13:15 +0200
Message-ID: <CAL1e-=ii6jzU9YwhoEXZH4+QBYus+pndgzHTTMXYU-o30g4nsQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v7 00/74] linux-user: Split do_syscall
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 20, 2019 11:43 AM, "Peter Maydell" <peter.maydell@linaro.org> wrote:
>
> On Sun, 19 May 2019 at 21:39, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Based-on: <20190519201953.20161-1-richard.henderson@linaro.org>
> > Aka "linux-user: path, clone, sparc, shmat fixes"
> >
> > Version 6 was
> > https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg04794.html
> >
> > Since v5, I've fixed the ioctl failure that Laurent found, and
> > have done a few more syscalls.
> >
> > I've tried to do more testing with LTP, but it's a really annoying
> > testsuite.  There are at least 3 tests that hang forever (before
> > and after this patch set), and the host kernel's OOM handler kills
> > my login session, ending the test run.  This seems to be different
> > behaviour than I was seeing in January, when I did have test runs
> > that completed successfully.
>
> If these are different from the ones we're already skipping
> in the skiplist documented at https://wiki.qemu.org/Testing/LTP
> we should update that wiki page to also skip these new
> hanging-tests (and whatever it is that eats all the memory).
>

Peter, yes, it is definitely different. It has been a moving target lately.
May I suggest that we use a stable version of QEMU, and a stable version of
LTP, and create a skiplist for such stable configuration, include it in the
docs, explicitely noting used versions? We can continue doing that for each
QEMU release and whatever the latest LTP would be at the moment of that
QEMU release (maybe even keeping the previous skiplists - which could be
useful for debugging).

Regards,
Aleksandar

> thanks
> -- PMM
>
