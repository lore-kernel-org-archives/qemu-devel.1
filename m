Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417C9C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1427620868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="frFvyeq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1427620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1lO-0007mu-7S
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 10:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59044)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1lD-0007Od-Ky
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1lC-00061z-Gf
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:15:23 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:44978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hn1lC-00060L-8R
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:15:22 -0400
Received: by mail-oi1-x22e.google.com with SMTP id e189so12687259oib.11
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Gp/6W37eMu5xDWcpktiKvddaDspKVZ0ts4TydiZK6QI=;
 b=frFvyeq4migi0E1WkLYG1HiN+tKaskBFIwsV3sAJ3JnhCHNFY5eLeimrq57WbqiEgp
 obVXNjhrPhIcu69u3iBQ6VNVBP9CtgxDKLHd1R58yb7EIZKpWqhQ/AFdLvjWG8Pd5eDY
 hFOnV9+Vtm9yL+PL41aa8n9d4pxCGoneqHp/S9oWfrA+e+zxlrwr4LrESP88iKH78G2M
 KmtIwiygOjPOU1JX4l83igz1yhZzosCF2Bad9uCGa/e2mjRLMVI34hMKWUC6JTK9U7a4
 FFn/vRNmhaPSnz8RiqHN9O2NKSuTOS2bDmvoTJZptzvcGbrNS5y2gY2JLcF5XBSxGwaO
 0rOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Gp/6W37eMu5xDWcpktiKvddaDspKVZ0ts4TydiZK6QI=;
 b=gHZtlWObrL312iGymFOyKczHVhjgnzZqx3dPHhW6Nly/HnAVGOxSyR6ByM1r37KG30
 SyWTlrg5yc/Y8TZUH6Bo6fANqNI933r2NtHKoME4Fltx1JsH3Fde8V4NgOrqSNeoru2m
 XBgB10NJnD0y4geraSEJsr5QKF0vrAgjViUz2RcF0JZxfz8GyPjVdFCUwwYj2lgS9AOZ
 MA+KM5RGMDdOoGTXgWa1I9U7JiquDqsjiBmiFMsY7KEJpEmdatE6kNrZSGdQgFEMyJ6X
 TWo6mKhtEYaxB/LJaJcG62DEp6/NQa9JKh/Ib0o9eLiLOmjepjyiE9iIZspkZDjxx6lI
 ombA==
X-Gm-Message-State: APjAAAVbkS6KYphXYv+GL+upG4WKUQ+GGy+U8PwVg376vjyD/gtph2TB
 0IQp6P+YvQCpCIFIR0M+qUKWgNo8MIXDNUYbUNABag==
X-Google-Smtp-Source: APXvYqyITPH1BL31hWkIofgCPOhmOJSR/zZZzx8+YHCeQpjANnfXdMX8Nh9PiXRJu8Jaa0Jizr6CWwcZD6jERXrUdlM=
X-Received: by 2002:aca:5cd7:: with SMTP id
 q206mr12037960oib.146.1563200120863; 
 Mon, 15 Jul 2019 07:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190712143207.4214-1-quintela@redhat.com>
 <CAFEAcA-ydNS072OH7CyGNq2+sESgonW-8QSJdNYJq6zW-rYjUQ@mail.gmail.com>
 <CAFEAcA9ncjtGdc8CZOJBDBRtzEU8oL7YicVg5PtyiiO2O4z51w@mail.gmail.com>
 <87zhlf76pk.fsf@trasno.org>
 <CAFEAcA_9tVQht7bp9_yrFEhQ74ye6LBNjEYK_nftCWsKMrOohw@mail.gmail.com>
 <87pnmb75i3.fsf@trasno.org>
In-Reply-To: <87pnmb75i3.fsf@trasno.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jul 2019 15:15:09 +0100
Message-ID: <CAFEAcA-Y4kcY54pmPydUATFEzBYd5ptQQoUgVQYfOVJhLu5goQ@mail.gmail.com>
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Subject: Re: [Qemu-devel] [PULL 00/19] Migration patches
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jul 2019 at 15:10, Juan Quintela <quintela@redhat.com> wrote:
> PS.  BTW, did you launched by hand the guests with valgrind, or there is
>      a trick that I am missing for launching a qtest with valgrind?

I quoted the command line I used:

QTEST_QEMU_BINARY='valgrind aarch64-softmmu/qemu-system-aarch64'
tests/migration-test -v -p '/aarch64/migration/multifd/tcp'

(https://wiki.qemu.org/Features/QTest lists this and some other
things you might want to do with qtest tests.)

thanks
-- PMM

