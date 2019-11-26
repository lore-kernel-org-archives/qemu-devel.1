Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7D3C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 15:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B3CD20722
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 15:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LpULihF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3CD20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZcV5-0007iz-IN
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 10:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZcUH-0007JC-5n
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZcUG-0001M9-27
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:10:44 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZcUD-0001KG-Ti
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:10:42 -0500
Received: by mail-oi1-x241.google.com with SMTP id l136so1326169oig.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 07:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o+6i7S7bkjA+IdORysQqX8ryUb5TwKtPadVMD1uHCjc=;
 b=LpULihF7aUWCFf0ngbYE++bfvuSPBfI2Bfoj7vvUDG9Pzrk6K4cVkq0sgKLBuS9jr7
 5lhe6xvSuadQh2ISpch1zdoZzTJgNS7hY02/JnV2WJp9kV2jNvZNmx/NBPAB5HWvDFHe
 Z3B2C8KL8lKuk5RttKI9Wv15pRCvgVe9klYBMlrEBdNyo2LVsBuF6/n+ulG/zKJGTqCL
 SNa2Mev4FUR6NnVdxh5bi4tVCqlvGwDcy82mmnYIxQe3YHpWLUxLxu4I3Nsu4OtPAlsN
 svWMv/bwPLcXDXfOQWsowJux0W9elwqjstZmhIXkkiTXLChlM4pIZOTc/NswCX/1IDfX
 Oejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o+6i7S7bkjA+IdORysQqX8ryUb5TwKtPadVMD1uHCjc=;
 b=AVRoQHDMZD710OPr/9F6bxpaKaDVX7kbVsOE19KeSqyxa9HZozmTS4hIGK7vtovN4T
 rVMERV2AemF0txpADx9G7q3xxhTeHO/DZOgEe+pz69IQUGk0VcohkpqoSixAPUG6N6sB
 Q9LFfzwN3F03d2aBKdShjdI+FBmJ7ZlXilbb7g4d5UJZczU6RLFacv8Vic3gp8PFfyoI
 qjjr3H46SRnkc15Sqy99wQViFQYda4EFbAd5fudVjkbxQ9A+Ll/5IyQfXDwlwjJxJgV9
 hSZ7HeqhQWsVR+vteTzrSrsk5SAwGQpaXI9mmuA/XVaskzDEzM4g6ZbbDZPaaInKP5uB
 Rorg==
X-Gm-Message-State: APjAAAU8x6ellzVHVX1JL6viAClmiVKHj1bDVIJMsIYWaW0pO4E+8phS
 6rjur5SaNMIAmpUv38i3CNpGjm6p1hej0tOQUPvJeA==
X-Google-Smtp-Source: APXvYqwz5XMsmhYWpKPiQdjZfV/lKOzXWhpxEtvIxzcQ2qC1+5nmILiMhBugdlKt0R5nkcxEhs/3xdf2cX8pZn2E1ps=
X-Received: by 2002:aca:a9d4:: with SMTP id s203mr3833969oie.146.1574781038852; 
 Tue, 26 Nov 2019 07:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20191125163014.16789-1-laurent@vivier.eu>
In-Reply-To: <20191125163014.16789-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2019 15:10:27 +0000
Message-ID: <CAFEAcA9XJz=8ZT_Hvb+7rhbx88BJ-qsUAmOx53aifm9=rgK9GQ@mail.gmail.com>
Subject: Re: [PULL 0/1] Linux user for 4.2 patches
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 25 Nov 2019 at 16:34, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 2061735ff09f9d5e67c501a96227b470e7de69b1:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2019-11-21 17:18:40 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.2-pull-request
>
> for you to fetch changes up to d1e26707410067891ab5199f7e9d09afa2fbc0f6:
>
>   linux-user: fix translation of statx structures (2019-11-25 12:57:58 +0100)
>
> ----------------------------------------------------------------
> fix translation of statx structures
>
> ----------------------------------------------------------------
>
> Ariadne Conill (1):
>   linux-user: fix translation of statx structures
>
>  linux-user/syscall.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

