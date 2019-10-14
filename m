Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B66EC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F3220663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nc9A2T9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F3220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54527 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK48E-0001Qj-UN
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2x1-0005nK-CS
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2x0-0002vn-88
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:12:03 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:35090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2x0-0002vc-25
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:12:02 -0400
Received: by mail-ot1-x329.google.com with SMTP id z6so14283408otb.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PPx9wOFTY5bJVo7Que9niwAVqXrZsqQ2yIApFOHBdqA=;
 b=nc9A2T9xjXLCPK5RO5hpMEIYeUwUQR+ES+tlHw4m2AnrzCObSIUcc3ic4BOW7KBN8/
 wm1bnh8sTLYY38VCArSzmHuiEgETIAO8q2KqEngzSNWsjiPfY8doxkIA1PHQfLP4/0fr
 +HIQklAj73SmDjtEeJYhAqapfuGAK0C3ftFQFfs14sC2f3cUB2WKdXl2W6fy8DZCNoy2
 eOq8EOd0VbAviOJyteS3G+UCV6S7PSpSs/SmJJz4Yd+DSkNvzaJFump1w4/n0fKYAqMn
 HKBRUW3d+aV75WWvuaQsTMjODR71Ph1lt4hB2b+SWsZlGM/dtnAWdC4dQDNrscDGPUJO
 VmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PPx9wOFTY5bJVo7Que9niwAVqXrZsqQ2yIApFOHBdqA=;
 b=ERaL1fc3ckD+Vnv9WC1Dq/Ohjw1i0QoKUTcHDmyIuqmFJGo8OkbcsNlq74l4/r607T
 N0+6LhUR2f0qFs2GJiIE6KIGvqNyzjCVb2+ccs24doqRC7Ft/x5GtzXZbydLHrG7AKWt
 WKJAOFD4IK40wizrjF4axVwcMeJ7aVcbbtccVOFQM1IdRX8NCFZ2O/25r39shGE2xgl6
 XjDY5rle+ot6hLT9qgUblpyxlyyeezpBXnQCcq3tzF1W4p+P00xzzIMnGNp4V2v16Cer
 SEd0KSA4cDvKXUJQVR/aRp7Syctk+KAivHhsSoihcX1E1wYuLHPeN3hKClwsLmnCSuma
 Lx9A==
X-Gm-Message-State: APjAAAWiX6Bq7l5fikODSAXx0Rzwgkn9GT2Ns0070/HQP/Ly7lovAH7r
 Xhk18FmuNkI567IF46gdH29W1tI088e7qYi34FXslA==
X-Google-Smtp-Source: APXvYqxLehv93Su3YEgEsC3aQr+AFDxm30dlqqiiR6atrtJ+iZOS+IdEK3AmVyiNAp5o44R/HtRL0rSU+qBYOEr9GlI=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr25326890otj.135.1571069521157; 
 Mon, 14 Oct 2019 09:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191011212550.27269-1-jsnow@redhat.com>
In-Reply-To: <20191011212550.27269-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2019 17:11:49 +0100
Message-ID: <CAFEAcA9SRYsn10rTGsHM4hCPYbSxY=kuAnoiqbDBkCOYFzg8YQ@mail.gmail.com>
Subject: Re: [PULL 00/19] Bitmaps patches
To: John Snow <jsnow@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Libvirt <libvir-list@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 at 22:26, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit 98b2e3c9ab3abfe476a2b02f8f51813edb90e72d:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-10-08 16:08:35 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request
>
> for you to fetch changes up to b97d9a1014b61dd0980e7f4a0c9ca1e3b0aaa761:
>
>   dirty-bitmaps: remove deprecated autoload parameter (2019-10-09 17:02:45 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>

Hi -- this has a conflict in block/backup.c -- could you fix up
and resend, please ?

thanks
-- PMM

