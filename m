Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6570EC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39AC822D6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39AC822D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Bpl-0003c0-4O
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 17:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1i0BXg-0003Lu-Ni
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1i0BXc-00085G-S4
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:19:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45954)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1i0BXa-00082o-SA
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:19:44 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5499BC059B7C
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 21:19:40 +0000 (UTC)
Received: by mail-ot1-f70.google.com with SMTP id g6so74331otq.13
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yPQ2BEyhFVu5FROpUdygX4Qc3ac0b32DOATgMloyvvQ=;
 b=Q9jaUfi99TrvMdQnFMoM3Gh9ehRwvGAWg/fIQRKhlWpZ91yFHgoK/1ybuUWrnInbWd
 BcK1kpt2b/VivSorwvgDfiCfXldvP7T10X4RBbDOiD5Qedy2fC1cFUnb1NVQDDhJQJh7
 csGvAGhGvgv/MYtjp3AnsnjGX50IBUHlNRpY8uNlOT++XjhHHuYGMW0PkKONV4GsGiSA
 5SOTLGDOz0mS+dCvY7/5VNu1V8JnhbEHa1NS0O1aOv3cVmpXJL9tqxk90YPyBU3O3yX1
 QsZczyD/+fpohM25xsgOBYkf63CCpNhMUm4mOlgvQgigRdRpXJfR13Sv0lAfH1SNN32q
 Uz6A==
X-Gm-Message-State: APjAAAXBWPrk4tT5CcauDG7qKC+qeHt1H758GBkPmXqr3BrxtIhs+04b
 u+HHea41zc6zlSb5j5lz3Dww9mggW85PDgj8vf0gmrcHTjBiTfm56CdaSG7Ar0yTuuk16eyNG5A
 lA38z7D6RI1GXXoXv+LUaSypBnipUoXs=
X-Received: by 2002:aca:1714:: with SMTP id j20mr1417535oii.135.1566335979199; 
 Tue, 20 Aug 2019 14:19:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzVRcJj4QM7SsWgYnjM2sWFZnOrB7+lU96xn/yeyVGM8QiY5zvRX05Q9Kmam22t/dWaiLT6ywJBj2o21W9sX1U=
X-Received: by 2002:aca:1714:: with SMTP id j20mr1417511oii.135.1566335978785; 
 Tue, 20 Aug 2019 14:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190815185024.7010-1-eblake@redhat.com>
 <104559cd-a1dc-2b2c-8992-689cbdd0f827@virtuozzo.com>
 <22c4c265-91fc-3639-4a4e-2fffe426ce68@virtuozzo.com>
 <3f1fa92e-af18-87f8-3149-7c11bd186e64@redhat.com>
 <CAMRbyytdGmsoLbg_i=zbbkrkWpAW+jAvUAiwmJEO3MGXpvrTaA@mail.gmail.com>
 <847b1ef7-0f9d-fd7a-3c0c-368f5d862ecb@redhat.com>
In-Reply-To: <847b1ef7-0f9d-fd7a-3c0c-368f5d862ecb@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Wed, 21 Aug 2019 00:19:27 +0300
Message-ID: <CAMRbyyv272b83sx8m=kt740+6Pz6c0baUU=xKRNq_Eud1maZbw@mail.gmail.com>
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

On Mon, Aug 19, 2019 at 9:04 PM Eric Blake <eblake@redhat.com> wrote:

> On 8/17/19 8:31 PM, Nir Soffer wrote:
> >>> Also, for qemu-nbd, shouldn't we allow -e only together with -r ?
> >>
> >> I'm reluctant to; it might break whatever existing user is okay exposing
> >> it (although such users are questionable, so maybe we can argue they
> >> were already broken).  Maybe it's time to start a deprecation cycle?
> >>
> >
> > man qemu-nbd (on Centos 7.6) says:
> >
> >        -e, --shared=num
> >            Allow up to num clients to share the device (default 1)
> >
> > I see that in qemu-img 4.1 there is a note about consistency with
> writers:
> >
> >        -e, --shared=num
> >            Allow up to num clients to share the device (default 1). Safe
> > for readers, but for now, consistency is not guaranteed between multiple
> > writers.
> > But it is not clear what are the consistency guarantees.
> >
> > Supporting multiple writers is important. oVirt is giving the user a URL
> > (since 4.3), and the user
> > can use multiple connections using the same URL, each having a connection
> > to the same qemu-nbd
> > socket. I know that some backup vendors tried to use multiple connections
> > to speed up backups, and
> > they may try to do this also for restore.
> >
> > An interesting use case would be using multiple connections on client
> side
> > to write in parallel to
> > same image, when every client is writing different ranges.
>
> Good to know.
>
> >
> > Do we have real issue in qemu-nbd serving multiple clients writing to
> > different parts of
> > the same image?
>
> If a server advertises multi-conn on a writable image, then clients have
> stronger guarantees about behavior on what happens with flush on one
> client vs. write in another, to the point that you can make some better
> assumptions about image consistency, including what one client will read
> after another has written.  But as long as multiple clients only ever
> access distinct portions of the disk, then multi-conn is not important
> to that client (whether for reading or for writing).
>

Thanks for making this clear. I think we need to document this in oVirt,
so users will be careful about using multiple connections.



>
> So it sounds like I have no reason to deprecate qemu-nbd -e 2, even for
> writable images.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>
