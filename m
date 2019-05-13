Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCD0C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 16:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2200E21019
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 16:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2200E21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60072 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQDfE-0000pK-3N
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 12:18:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hQDdz-0000IL-8D
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hQDdy-0007pU-2I
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:17:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hQDdx-0007l7-Qu
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:17:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id f37so18337862edb.13
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 09:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=nRxuZ8iZ6u0ZlWBgUOQj9VVFXzZHN68tXZRk3DjzP6w=;
	b=SrKryQC0tXQQZ+qYngBKxIf4DGqmxXF+2JmVG8n2/eQbxyqOM4bh4VkxjtUBzxdTds
	fJW8b86ncAAwbs9rCeUq5gBgWsupqHpoQ8Xhf4Vjss+5TDkdAAJ1BzVJYc1Z+EarX+uz
	mlh+68YrTaTVs/C4Dz4rbZGIpCHU20DWrz8xpXKOS0bTWWq7HKEKpUH3Hbix7xvBX/yI
	afF002CfmGZDxeSKyF02r1vf0ovQOcuJkNYenOubxMiqO7wsVHLCyKFF4fmyAD6gajD/
	Rc3kK8rV5HjC64XmPqphGeOT1Ze6Gh84+oZYiRBwptVwX5/IcC4UkR1qQvpSPq5eAaHa
	JS4w==
X-Gm-Message-State: APjAAAWM0GjACWcuvH8TuYajzaAlIXcvTkDpXWLnzfXakKlCmA/cs/LB
	NxDxEeEw8EIjnBdFwS5e0OCnFefpB7/DCbCHpjk5xA==
X-Google-Smtp-Source: APXvYqwWLMztybmPOhwaYtkvii3A6db5Jm7eRiiJkMt5A0JSjZ+B4tvlMGrCU/Xloc9ENSAzte8vVshq3YlHuwl0Gmk=
X-Received: by 2002:a50:a951:: with SMTP id m17mr29361506edc.79.1557764254528; 
	Mon, 13 May 2019 09:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190401141222.30034-1-lvivier@redhat.com>
	<6f3c5f49-9be7-85cb-d693-d608135975b5@redhat.com>
	<b8d003fb-1d53-3723-4eef-b39a3d965bc0@redhat.com>
In-Reply-To: <b8d003fb-1d53-3723-4eef-b39a3d965bc0@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 May 2019 17:17:21 +0100
Message-ID: <CABgObfbmhGSA9BRSHMiCsn8VMfPejHCYc=QU9HnmforWvxH+zw@mail.gmail.com>
To: Laurent Vivier <lvivier@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.208.66
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 0/5] build: cleanup in Makefile.objs
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>, "Hajnoczi,
	Stefan" <stefanha@redhat.com>,
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Will send it out this week.

Paolo


Il lun 13 mag 2019, 16:18 Laurent Vivier <lvivier@redhat.com> ha scritto:

> On 02/04/2019 10:08, Paolo Bonzini wrote:
> > On 01/04/19 16:12, Laurent Vivier wrote:
> >> This cleanup removes hardware objects from the list of files to be
> >> built for linux-user only targets.
> >>
> >> It also builds traces files only when the related file is built.
> >>
> >> Tested with all combinations of --{disable,enable}-{system,user,tools}
> >>
> >> v3:
> >>    - don't move hw/display to CONFIG_BLOCK section
> >> v2:
> >>    - add CONFIG_TOOLS and CONFIG_BLOCK
> >>    - replace GENERATED_FILES by generated-files-y
> >>      and use generated-files-${CONFIG_TRACE_UST} and
> >>      generated-files-${CONFIG_SOFTMMU}
> >>    - move chardev-obj-y from SUBDIR_RULES to SOFTMMU_SUBDIR_RULES
> >>    - use $(CONFIG_BLOCK) in tests/Makefile.include
> >>    - disable qemu-ga with linux-user only
> >>
> >> Laurent Vivier (5):
> >>    trace: only include trace-event-subdirs when they are needed
> >>    build: replace GENERATED_FILES by generated-files-y
> >>    configure: qemu-ga is only needed with softmmu targets
> >>    build: chardev is only needed for softmmu targets
> >>    build: don't build hardware objects with linux-user
> >>
> >>   Makefile                   |  43 +++++++-------
> >>   Makefile.objs              |  22 ++++---
> >>   Makefile.target            |   6 +-
> >>   configure                  |   4 +-
> >>   target/s390x/Makefile.objs |   2 +-
> >>   tests/Makefile.include     | 116 ++++++++++++++++++-------------------
> >>   6 files changed, 102 insertions(+), 91 deletions(-)
> >>
> >
> > Queued for 4.1, thanks.
>
> Any news?
>
> Thanks,
> Laurent
>
>
