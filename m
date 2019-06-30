Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BC9C5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 15:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B8720673
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 15:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZA2GWzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B8720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhc4O-0002Z8-L3
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 11:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39794)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhc01-00024h-IQ
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 11:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhc00-0003Zl-90
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 11:44:17 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hhc00-0003ZL-2q
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 11:44:16 -0400
Received: by mail-oi1-x243.google.com with SMTP id u15so7850173oiv.0
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 08:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=HrUXhP//J1oXi+bN9l9j8VqJqdQhS3u3IPqqNTJ3CII=;
 b=ZZA2GWztz1medE6UYRVHnzKfVt+qetzLneDg5OgGO/F6FLIO1Q4s0sG6SFxbt3WZNf
 CUtYYlVD6SPQi3DD69aZQNnoLoEM6BqEuP8d8Q6X4Caj+AXCQw2/Hsv670nI9WPN/mQy
 lMTCMFa7fGsj0NFNO/AJixrw8i32I09WIsEyo4+fOuaY2jqJHTuKPpOjBKUtolZsWkrv
 MFyVIcmkcdMOLYoV45YpFEcj/urYtfWMfr1XnqK+t4E+GjBFq1OLnfdad0LYvWbnOZ2k
 7wKkMFfiJwYve7YHsMfrVCu7ZDjuJf/v+OtIsgzm9Xi9hQmjF43SRuLHCPxLjATUraZ3
 O68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=HrUXhP//J1oXi+bN9l9j8VqJqdQhS3u3IPqqNTJ3CII=;
 b=Pte98FGOIhYNw/duhRCOJnhvLj6weoYLGooVDCjx+zUC19XL8wVKJVtVhkB/WY1+bV
 dTWUUpnk70CPBCcHt25P2Mws0haKSkW3NF33Ntk7VkMR5r+HElwQtsdNcEsrhoNDVJVA
 3E+Ev7YykLhDdCwQSxfJphkMina1v5j46oAykZf5wbdN195TdHkEumwswQ007v2LLu3b
 +WKRZXBcmxV4lrjvyEUTr0/B6kcrUj3fcfn5uJnU8inPvozCfCDWCQxVdYlkznm+2gfx
 xDIwOeBFLwtaYjWiKA9I37DS3fkSaOwYnRDMoFwjrYjyOalepA982XSaL6I1QPG8gQ20
 2pug==
X-Gm-Message-State: APjAAAWH5w9cwKiotRALdYHjstbuJxg0o/0XCNmxILKHcqkINHbHipDV
 xqfBltmdykv0IPu89UL/sJVG+Z1t/evketzO0ik=
X-Google-Smtp-Source: APXvYqyxC8hu9/El0tP07dYkfgDEPDYhFcPxGIUoZ4PmfQEJXev7YklOW4RmHlA1/3y4Qu/A9p/VfqWHpn1EC8h9eNY=
X-Received: by 2002:aca:abd8:: with SMTP id u207mr4112106oie.136.1561909455091; 
 Sun, 30 Jun 2019 08:44:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Sun, 30 Jun 2019 08:44:14
 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Sun, 30 Jun 2019 08:44:14
 -0700 (PDT)
In-Reply-To: <CAFyWVaaQX4MG+76+vt-2qvGq7JeZcJFyXZp9Nw+xuwWLc=pHHA@mail.gmail.com>
References: <1561718618-20218-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1561718618-20218-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=gMvPy9SEQicj1d=X0cSu84WuiNXbtacOS5zJoqyXQv+A@mail.gmail.com>
 <CAFyWVaaQX4MG+76+vt-2qvGq7JeZcJFyXZp9Nw+xuwWLc=pHHA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 30 Jun 2019 17:44:14 +0200
Message-ID: <CAL1e-=h4Xa9etY=-MGXUT-v=TK8LyNL542RmDezt3pHmPeDs=A@mail.gmail.com>
To: Jim Wilson <jimw@sifive.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v16 1/5] linux-user: Add support for
 translation of statx() syscall
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org,
 amarkovic@wavecomp.com, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 29, 2019 6:06 AM, "Jim Wilson" <jimw@sifive.com> wrote:
>
> On Fri, Jun 28, 2019 at 5:53 PM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> > This patch went trough several transformations in last few days, and I
am a little worried that we forgot the primary reasons/scenarios why want
it in the first place. In that light, may I ask you to recheck this latest
version of the patch, v16, against your scenarios (you mentioned earlier
you have two significantly different flavors of your scenario, one with
Ubuntu 16, and another with Ubuntu 19)?
>
> My use case is that I want 32-bit RISC-V user mode to work.  This
> requires a riscv syscall list patch that Palmer Dabbelt added to his
> patch set, and the statx patch that is part of your patch set.  The
> statx strace support is not required for this use case, but should be
> added for completeness as all of the other stat family functions have
> strace support, so statx should too.  Since the statx strace patch
> needs statx macros that old systems don't have, I test on Ubuntu 16
> (no host statx) and Ubuntu 19 (with host statx).  On Ubuntu 19, statx
> strace should be fully pretty printed.  On Ubuntu 16, qemu should
> still build despite the missing macros, and statx strace should be
> partially pretty printed because of the missing macros.
>
> I removed the old patches, updated qemu, added the new patches,
> rebuilt qemu, and reran the gcc testsuite for rv32/rv64 Ubuntu 16/19
> and it still works as expected.  I also manually checked strace for
> rv32/rv64 Ubuntu 16/19 and that also still works as expected.  So this
> looks good to me.
>

Thanks a bunch, Jim! Laurent, based on all the info, it looks to me v16 is
the way to go. Aleksandar R. can test his nanoMips scenarios later on,
since nanoMips user mode is not integrated yet anyway, but I hope
everything is fine there too.

Thanks again to all involved!

Aleksandar

> I'm leaving on a trip tomorrow, and only taking one laptop with me, so
> I won't have access to my Ubuntu 19 machine anymore.
>
> Jim
