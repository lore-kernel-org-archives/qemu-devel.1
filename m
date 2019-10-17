Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F1CFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A416C2082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jr5HsdGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A416C2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL3e5-0002Qs-LB
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 07:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL3cy-0001di-4D
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL3cu-0006UZ-W7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:07:31 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:33092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL3cu-0006UB-Mz
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:07:28 -0400
Received: by mail-ot1-x32d.google.com with SMTP id 60so1540682otu.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 04:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yflYfJZdpSKhQehPVlDVeDVRRiv3m808csZYgjO5bms=;
 b=jr5HsdGrRrfJSB06fD2yUiUNHRD32B2WOTwUe03U9NrEwv2e21XcUHWoUBh8K0tA8N
 733CdLwsDC7Kyx15+CSFgMr/eB504AuGKCPGOD5ASW2u9W/o8rLq3DO1KiGTtWMH1K8G
 dn+dgauq05MVwKZMNA2DHxM+Ku6R7NIVgvddEMOmoYEAfAL9Y2QQs1ova86tCyNgS1on
 ACVCrdICn5eSZvFThNa7lxaPRDpUnfRgD1g7uI8XkYsp3Bjcgqx3+Ih0f5h3ZMOFk32/
 sI8M3nNmd1GL/HDhkkBoE30CHgqXve71GJmT4ZEw7sUQ9FTTTsKt1JIqX4vNe/XhZyjp
 G8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yflYfJZdpSKhQehPVlDVeDVRRiv3m808csZYgjO5bms=;
 b=jdBq65ERtfGOUB5N14qt1nNwnE4JJqnZGnPZZRXJdGfEdIYmSY9DEBM3wvU+d8fU1p
 D08v6URvXlytlZ0srsjmydv+cikbYhJgSWVZbjVETgRP+kvsOaT2tC+H2+vpez2nnRYT
 mBloCFwD5rOqiIQoq2vMP7SKW67z7b0ThFu9G9L7rznfcmV4QpD9Tq1qHmYliy1Inzll
 fg8pAvXu8MoQfql2isiDy9z8Gm1TdC/csTDAprirDBxeQPsToa2KMNkDuj2K8YdxYarV
 8sNi0D0BNvlYqWXlbMeECMjIz3+blE0DBonW4Ym4AARm+e5VtRKQwEYTRscr45MeOU2b
 AQ2A==
X-Gm-Message-State: APjAAAWlVeu+c4mt8n+PGQgaMtbx9tq1keAsSmu8R4OBOY+aw9+jnPMp
 jOFZ39L/rBbkhFZkC88slH7W6LnOXiZBFhAiMHAB1A==
X-Google-Smtp-Source: APXvYqw/WcprTWHR98a2x8irlreUGYTyOvmQDHbvyg8qac4fIHWaDqtBb8x4BEsy6NcNGEEZ2TAP44ID3V1cBtI/pHw=
X-Received: by 2002:a05:6830:4c1:: with SMTP id
 s1mr2615801otd.232.1571310447420; 
 Thu, 17 Oct 2019 04:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191014192909.16044-1-jsnow@redhat.com>
In-Reply-To: <20191014192909.16044-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 12:07:16 +0100
Message-ID: <CAFEAcA91Yr3g5V9GdV5FbctQjQG5MiCgf7mk-MnsYmdx+63TYg@mail.gmail.com>
Subject: Re: [PULL v2 00/19] Bitmaps patches
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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

On Mon, 14 Oct 2019 at 20:29, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit c760cb77e511eb05094df67c1b30029a952efa35:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20191011a' into staging (2019-10-14 16:09:52 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request
>
> for you to fetch changes up to b2ca29ee390743c42a6062d44ee3b10fb51f9fa6:
>
>   dirty-bitmaps: remove deprecated autoload parameter (2019-10-14 15:28:17 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------

Hi; this pullreq fails on some hosts on the newly added iotest 260
with an "AF_UNIX path too long" error:
https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04063.html

Max tells me that this is a known problem (a fix is in the works)
but that for the moment we've chosen not to add any python based
tests to the 'auto' group, so that this AF_UNIX issue doesn't
affect "make check". Could you respin the pullreq with the
new iotest(s?) not in the 'auto' group, please?

thanks
-- PMM

