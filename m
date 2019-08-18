Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AC1C3A59B
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 01:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC9D2173B
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 01:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC9D2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzA3u-0002ao-2z
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 21:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1hzA3F-00026P-Pu
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 21:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1hzA3E-000593-0F
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 21:32:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1hzA3D-000588-OY
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 21:32:07 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 03D013DBC2
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 01:32:06 +0000 (UTC)
Received: by mail-ot1-f70.google.com with SMTP id a26so6526792otl.1
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2019 18:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SSzxOaM90Uqsz9r2its47BsJIi5iDQgj0dQmD+Dgy40=;
 b=WdExO+j1DK3IInqqeK62m4fytaeuFRBjeQ9ecKH0dL+0HaCGFHvcq5NksghP6h7RbS
 8h/h1mKKOd0lCpf32Q+ZvO4DyV8Ha41W4A6zxEJM38hPF2VOtOdsKN6RYNs0Uf61fwOP
 MOuvDqc159p0o06j3zRiEa4hPa5s8SD5YPbVIw0yKZ+QUESXQYr5f2Ui33Bx4FF/yObS
 fyJAV7i8co1sA1zv7+hdyezVVDxCl4RUy1bEnC3BRe7CkStTt6rIZmbYFfhfgctGk08e
 3EF2PHJMnnNT1dsHA3XwndQDfLO1dnE+gTI2CdCkooaT4KOazyJCu1B07yl08/dRbFsE
 gk2Q==
X-Gm-Message-State: APjAAAWh9AtL1BTfTgCWu7uWa5EYMWdvQbv+/2typ+0RVLN37IvtHK8c
 6hNSAvq/0P/SuDAhbkIRVJqjqmXVvjKc/Nv6EN8DxO3V1RgZVxo12X9kuBPG4gNNL3jg5QztR0t
 wr8Habuk4QYuRd+C9b+Odt7f9Ob5W7S8=
X-Received: by 2002:aca:4083:: with SMTP id n125mr3520150oia.106.1566091925392; 
 Sat, 17 Aug 2019 18:32:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzxxdi5i+RYC5hQWV6gGKcgvKOeenmms6AzhvKw4I9ALJvByVwLifmCC1CXUJHaUjSqm8TQitVFzKNqjPfinYE=
X-Received: by 2002:aca:4083:: with SMTP id n125mr3520141oia.106.1566091925070; 
 Sat, 17 Aug 2019 18:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190815185024.7010-1-eblake@redhat.com>
 <104559cd-a1dc-2b2c-8992-689cbdd0f827@virtuozzo.com>
 <22c4c265-91fc-3639-4a4e-2fffe426ce68@virtuozzo.com>
 <3f1fa92e-af18-87f8-3149-7c11bd186e64@redhat.com>
In-Reply-To: <3f1fa92e-af18-87f8-3149-7c11bd186e64@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sun, 18 Aug 2019 04:31:53 +0300
Message-ID: <CAMRbyytdGmsoLbg_i=zbbkrkWpAW+jAvUAiwmJEO3MGXpvrTaA@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nbd: Advertise multi-conn for
 shared read-only connections
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
Cc: Kevin Wolf <kwolf@redhat.com>, Daniel Erez <derez@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 17, 2019 at 5:30 PM Eric Blake <eblake@redhat.com> wrote:

> On 8/16/19 5:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>
> >>> +++ b/blockdev-nbd.c
> >>> @@ -189,7 +189,7 @@ void qmp_nbd_server_add(const char *device, bool
> has_name, const char *name,
> >>>       }
> >>>
> >>>       exp = nbd_export_new(bs, 0, len, name, NULL, bitmap,
> >>> -                         writable ? 0 : NBD_FLAG_READ_ONLY,
> >>> +                         writable ? 0 : NBD_FLAG_READ_ONLY, true,
> >>
> >> s/true/!writable ?
> >
> > Oh, I see, John already noticed this, it's checked in nbd_export_new
> anyway..
>
> Still, since two reviewers have caught it, I'm fixing it :)
>
>
> >>> @@ -1486,6 +1486,8 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
> uint64_t dev_offset,
> >>>       perm = BLK_PERM_CONSISTENT_READ;
> >>>       if ((nbdflags & NBD_FLAG_READ_ONLY) == 0) {
> >>>           perm |= BLK_PERM_WRITE;
> >>> +    } else if (shared) {
> >>> +        nbdflags |= NBD_FLAG_CAN_MULTI_CONN;
> >
> > For me it looks a bit strange: we already have nbdflags parameter for
> nbd_export_new(), why
> > to add a separate boolean to pass one of nbdflags flags?
>
> Because I want to get rid of the nbdflags in my next patch.
>
> >
> > Also, for qemu-nbd, shouldn't we allow -e only together with -r ?
>
> I'm reluctant to; it might break whatever existing user is okay exposing
> it (although such users are questionable, so maybe we can argue they
> were already broken).  Maybe it's time to start a deprecation cycle?
>

man qemu-nbd (on Centos 7.6) says:

       -e, --shared=num
           Allow up to num clients to share the device (default 1)

I see that in qemu-img 4.1 there is a note about consistency with writers:

       -e, --shared=num
           Allow up to num clients to share the device (default 1). Safe
for readers, but for now, consistency is not guaranteed between multiple
writers.
But it is not clear what are the consistency guarantees.

Supporting multiple writers is important. oVirt is giving the user a URL
(since 4.3), and the user
can use multiple connections using the same URL, each having a connection
to the same qemu-nbd
socket. I know that some backup vendors tried to use multiple connections
to speed up backups, and
they may try to do this also for restore.

An interesting use case would be using multiple connections on client side
to write in parallel to
same image, when every client is writing different ranges.

Do we have real issue in qemu-nbd serving multiple clients writing to
different parts of
the same image?

Nir
