Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F24C282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 12:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F9E21929
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 12:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F9E21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56068 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHSa0-0001UC-J7
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 08:25:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hHSYm-0000mn-GF
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 08:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hHSYl-0002UA-Er
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 08:24:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hHSYk-0002P1-L1
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 08:24:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so6738724wra.12
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 05:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=ptQpz8we1ujwI55yyQQ6lZ+vJdjxDaoNUgTFKEV0mJQ=;
	b=T3G6xhgn1WcZd8sv38zNsu5U86Sg7EMrVZTuME0PAM1yNt2IJkVViGujvKEIlxISww
	GDGMPnfDM0QcdF/4ENMervRCs6M4JiWs/orZEptMfWbIIj0vNnCyh/nOmOoJevjdHySF
	vb5K2Y3ih+edfME2+zlRlam4CFhDHxrZ/BAQNZT7Sv1fnWKWKh2H8W674sALpzo+f54u
	KiXhIMVN0Vm6XrLHOB0Y52FZyYFFcp6lNP/JJUOTXc0+s5CssSc0+Z88UuKtOFPst4Z3
	9dxkGb43ZoB6oU+zkO3DE+snQQGai4DmekQr5dkcp+tNlhPnuCi5vHRKX7HhJCItxtuA
	ZQvQ==
X-Gm-Message-State: APjAAAV6GLVYdG+MZvqrJih85vdxhQUmVUDkk9qjK2YflYk5XQJrop05
	6zGUI3hFsDXWMEX2e41sND0qFQ==
X-Google-Smtp-Source: APXvYqwMNUMoyi2Q0O6Mblj1b7MsGjyLHO7y9GHVQIjKMsw78Rs3kPgkkFsuQlMkMG2iB9zgIM0zkA==
X-Received: by 2002:adf:e443:: with SMTP id t3mr2924189wrm.257.1555676639850; 
	Fri, 19 Apr 2019 05:23:59 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it.
	[87.12.203.35])
	by smtp.gmail.com with ESMTPSA id a6sm5660023wrp.49.2019.04.19.05.23.58
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 19 Apr 2019 05:23:59 -0700 (PDT)
Date: Fri, 19 Apr 2019 14:23:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190419122356.7dmwwdbtnzgimydw@steredhat>
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
	<CA+aFP1AMzNjWtMeGy4MpWBa26qxShgciYkcEZ8mkSmDrtCvfqA@mail.gmail.com>
	<20190411130245.ltfyp7d2dfe2cr3h@steredhat>
	<CA+aFP1B7ZZ_xwNOfMbKUzEjYbMH=9dJstLYEyVq4LphPR81u0Q@mail.gmail.com>
	<20190414132008.uxoia6avdpp4jov6@steredhat.homenet.telecomitalia.it>
	<CA+aFP1D8VYcnwWpB=4PzAdBKr+YK-r8bSwzKKUCkH7jT3kVvoQ@mail.gmail.com>
	<20190415080452.GA6031@localhost.localdomain>
	<20190417073438.r57lemi6emu4x3ld@steredhat>
	<20190417080443.GA8330@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190417080443.GA8330@localhost.localdomain>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] block/rbd: increase dynamically
 the image size
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
Cc: Josh Durgin <jdurgin@redhat.com>, dillaman@redhat.com,
	qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419122356.5GdLHiUYJTsO4a4cqjFKWMeGQfVF2qjrW3dIGJrzlKQ@z>

Hi Kevin,

On Wed, Apr 17, 2019 at 10:04:43AM +0200, Kevin Wolf wrote:
> Am 17.04.2019 um 09:34 hat Stefano Garzarella geschrieben:
> > On Mon, Apr 15, 2019 at 10:04:52AM +0200, Kevin Wolf wrote:
> > > 
> > > I think a potential actual use case could be persistent dirty bitmaps
> > > for incremental backup. Though maybe that would be better served by
> > > using the rbd image just as a raw external data file and keeping the
> > > qcow2 metadata on a filesystem.
> > 
> > Thanks to point it out! I'll take a look to understand how to keep
> > metadata separated from the data.
> 
> I'd consider the feature still experimental, but for local files, it
> works like this:
> 
>     qemu-img create -f qcow2 -o data_file=test.raw test.qcow2 4G
> 
> And then just use test.qcow2. As long as you can put everything you need
> into an rbd URL, the same approach should work. Otherwise, you may need
> to use QMP blockdev-create on creation and possibly the data-file option
> of the qcow2 driver for opening.
>

Very interesting, I'll try to add this support also in the rbd driver.

> > > How fast is rbd_resize()? Does automatically resizing for every write
> > > request actually work reasonably well in practice? If it does, there is
> > > probably little reason not to allow it, even if the use cases are rather
> > > obscure.
> > 
> > I'll try to measure the percentage of the time spent in the rbd_resize.
> > 
> > Another solution could be to pass to the rbd driver the virtual size of
> > the image and resize it only one time also if the preallocation is
> > disabled, because RBD will not allocate blocks but IIUC it only set the max
> > size.
> > 
> > Do you think make sense? Is it feasible?
> 
> In theory yes, though it requires modification of every driver that
> should be usable together with rbd (i.e. ideally all of the drivers). If
> automatic resize works good enough, I'd prefer that

I did some tests and it seems that the cost of rbd_resize() is
negligible. IIUC it only updates the metadata without allocating any
blocks (if we are growing, like that case).

Anyway the automatic resize will not affect the current use-case (raw
images on rbd), where the file size is set during the creation, so I
think there should not be side effects with this patch.

I'm also adding the support for preallocation (i.e. full) in the rbd
driver that can be useful for qcow2 images.

If you prefer I can resend this patch with the preallocation series.

Thanks,
Stefano

