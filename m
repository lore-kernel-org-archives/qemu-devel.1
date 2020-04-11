Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC14C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 11:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D219D2084D
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 11:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMfuiDkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D219D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNEBB-0004YH-Uo
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 07:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jNEAS-00043T-TW
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 07:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jNEAR-0006hx-9B
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 07:19:20 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34947)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>)
 id 1jNEAR-0006hH-20; Sat, 11 Apr 2020 07:19:19 -0400
Received: by mail-pl1-x641.google.com with SMTP id y12so1237681pll.2;
 Sat, 11 Apr 2020 04:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zxr9acLS1kIsvx6fJUrku+NbDXqC+0CqEQEoiMrJtMc=;
 b=oMfuiDkJUJ+9qQ6JBhagS/7kXQThaqEd5YEOTw4kgCe/+OaIohk9g3b/D7hiEUXNbB
 rucfzX5jbOrzsiVe9oDKykXyzuCp1Lky+AO634ZVukHuV4gLOkb4sy/gBZXbgOm3XWMK
 9oNRh6y9Z72h9D3NKOjxu6q+DWoGHqO8j6J79qA1sx9iLG6jdLhyxJEqmsQjDU2hbmB9
 x6A2B49o4huS1F5XRrNZ8G/b6/PF8u0sKvfbGy13BbLXuWrAlyR9te5wE5mNDt3JoIHn
 Z3sspjQx+xRsNQgSsbwlygs1YsS7C6Tw4grIV2jSyj+Q1GSVWU8E7nO4XX2aZvK32sXP
 UePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zxr9acLS1kIsvx6fJUrku+NbDXqC+0CqEQEoiMrJtMc=;
 b=pwpOrld5G15V6l7vg+3Ki3dH+FJItLH3Z4O/nTy4C+m9rVozLgzk3+Qy4qGy8G2Aid
 HrUs2Wi++8hqOy4hhVVENzjskTE9O1yozAeO46pM+dFbU8KWdse6/OBpq3ghP3HtUxQU
 xPUM7ITvGVlGbmpgwrf8OKoJa7eImJRsgMBfwHOL/T8N6irKUJiEvJfD46T71wZBFibf
 uwfDKQSbJvydzyU/mj0yoA6HpuAWsd1CyF/nN1RlPzSxv8BuRijS8g8JopKG0a1HyqxQ
 K7+7tyDKkmvWjFbeuEgeC3PNyHdIogkHCwKQHLDUMNCeOEJS+N+PmTzUHzctUirksNGk
 stoQ==
X-Gm-Message-State: AGi0PuZycEKKJ0ILTVxy1N+TnfuutXnVMTzTU8mlsXmGvXiO1w350z+t
 Xdof8ujQKV1rEwlyA/B2BmMljF+8aJCE+XOQ760=
X-Google-Smtp-Source: APiQypKtuND1T6Ai6yXSOUP1mrKcbQqsBAkkY+wEnLLa1r3cZNXFZFZkgrBSN+/9ID3h/TRV89Uc7+cKZ7Wytpb9LyU=
X-Received: by 2002:a17:902:7288:: with SMTP id
 d8mr8346782pll.52.1586603957546; 
 Sat, 11 Apr 2020 04:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200404042108.389635-1-dnbrdsky@gmail.com>
 <20200404042108.389635-3-dnbrdsky@gmail.com>
In-Reply-To: <20200404042108.389635-3-dnbrdsky@gmail.com>
From: Daniel Brodsky <dnbrdsky@gmail.com>
Date: Sat, 11 Apr 2020 04:19:06 -0700
Message-ID: <CA+ZmoZVJhyuXbbUJHTQdFZKA6+WqYUgnxEXF0y-nq0=aK4cpww@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] lockable: replaced locks with lock guard macros
 where appropriate
To: danbrodsky <dnbrdsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "open list:iSCSI" <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Peter Lieven <pl@kamp.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 3, 2020 at 9:21 PM <dnbrdsky@gmail.com> wrote:
>
> From: Daniel Brodsky <dnbrdsky@gmail.com>
>
> - ran regexp "qemu_mutex_lock\(.*\).*\n.*if" to find targets
> - replaced result with QEMU_LOCK_GUARD if all unlocks at function end
> - replaced result with WITH_QEMU_LOCK_GUARD if unlock not at end
>
> Signed-off-by: Daniel Brodsky <dnbrdsky@gmail.com>
> ---
>  block/iscsi.c         |  7 ++----
>  block/nfs.c           | 51 ++++++++++++++++++++-----------------------
>  cpus-common.c         | 14 +++++-------
>  hw/display/qxl.c      | 43 +++++++++++++++++-------------------
>  hw/vfio/platform.c    |  5 ++---
>  migration/migration.c |  3 +--
>  migration/multifd.c   |  8 +++----
>  migration/ram.c       |  3 +--
>  monitor/misc.c        |  4 +---
>  ui/spice-display.c    | 14 ++++++------
>  util/log.c            |  4 ++--
>  util/qemu-timer.c     | 17 +++++++--------
>  util/rcu.c            |  8 +++----
>  util/thread-pool.c    |  3 +--
>  util/vfio-helpers.c   |  5 ++---

Just making sure this patch didn't get lost.
ping http://patchwork.ozlabs.org/patch/1266336/

