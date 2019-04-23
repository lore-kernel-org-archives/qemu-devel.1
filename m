Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA60C282E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 08:30:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185E620645
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 08:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185E620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50011 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIqok-0002zu-9U
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 04:30:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hIqle-0000Z9-Gz
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hIqld-00079f-9V
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:27:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hIqld-00078O-2O
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:27:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so17521846wmf.1
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 01:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=F5AmBFD9YfIVC/u57h88Iu+ecKNl9F63Y2JxuBy4lyw=;
	b=P8FfvDbbks1YHar4s5k2mh+x8znrAt2++sGPSYGndXxBGr6AhB1iQTLGcpq7pmLUY6
	XPYssB0WH1zKa/ptviHuK6UXg9DpNOOtUJKirfo1TPygwCdGnNVPzg7Fb4LF5apiG9wQ
	3jyaiRiParKAngUTaLx5WrfqrB8FLX/AZrDQHAmu4lmhnTwgpi8cimLSgFYHf8DFVbP5
	vMMWmMyNajXxn+iUnykYhBea8InJUjB1DvTlhDtCV2wUjZPLg44A8iEgvNaBAb10aZ61
	qUy6wxVaTN+qqdl8YiWCyBP7i4pRPdXkZOOLkE23i5cXfhA/Q3aAfMnXC1AgMVyRlKax
	gIvQ==
X-Gm-Message-State: APjAAAWHcGYb/cxr4AGQFe7/+JSUY0ID9xhuK1o/F6/c74mxohDptQkC
	BbruKrToHoKMRKpVeYeunyULYA==
X-Google-Smtp-Source: APXvYqzU8H/bDe8NTTYK80aWUlWqnyVyhIn7nj7xKu9l5e05tUHzvwke4tMpIZvNUoVbhv/nO5TO+w==
X-Received: by 2002:a1c:6889:: with SMTP id d131mr1300337wmc.114.1556008022963;
	Tue, 23 Apr 2019 01:27:02 -0700 (PDT)
Received: from steredhat (c-113-80.cust-q.wadsl.it. [212.43.113.80])
	by smtp.gmail.com with ESMTPSA id
	a10sm3899811wro.67.2019.04.23.01.27.01
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 23 Apr 2019 01:27:02 -0700 (PDT)
Date: Tue, 23 Apr 2019 10:26:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190423082657.mzulhihpv6rhgiww@steredhat>
References: <CA+aFP1AMzNjWtMeGy4MpWBa26qxShgciYkcEZ8mkSmDrtCvfqA@mail.gmail.com>
	<20190411130245.ltfyp7d2dfe2cr3h@steredhat>
	<CA+aFP1B7ZZ_xwNOfMbKUzEjYbMH=9dJstLYEyVq4LphPR81u0Q@mail.gmail.com>
	<20190414132008.uxoia6avdpp4jov6@steredhat.homenet.telecomitalia.it>
	<CA+aFP1D8VYcnwWpB=4PzAdBKr+YK-r8bSwzKKUCkH7jT3kVvoQ@mail.gmail.com>
	<20190415080452.GA6031@localhost.localdomain>
	<20190417073438.r57lemi6emu4x3ld@steredhat>
	<20190417080443.GA8330@localhost.localdomain>
	<20190419122356.7dmwwdbtnzgimydw@steredhat>
	<20190423075619.GB9041@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190423075619.GB9041@localhost.localdomain>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
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
Message-ID: <20190423082657.AZJoE1vIX3_VZ0P8DqCTx4Mk19p819D20e3qtsbX0YI@z>

On Tue, Apr 23, 2019 at 09:56:19AM +0200, Kevin Wolf wrote:
> Am 19.04.2019 um 14:23 hat Stefano Garzarella geschrieben:
> > Hi Kevin,
> > 
> > On Wed, Apr 17, 2019 at 10:04:43AM +0200, Kevin Wolf wrote:
> > > Am 17.04.2019 um 09:34 hat Stefano Garzarella geschrieben:
> > > > On Mon, Apr 15, 2019 at 10:04:52AM +0200, Kevin Wolf wrote:
> > > > > 
> > > > > I think a potential actual use case could be persistent dirty bitmaps
> > > > > for incremental backup. Though maybe that would be better served by
> > > > > using the rbd image just as a raw external data file and keeping the
> > > > > qcow2 metadata on a filesystem.
> > > > 
> > > > Thanks to point it out! I'll take a look to understand how to keep
> > > > metadata separated from the data.
> > > 
> > > I'd consider the feature still experimental, but for local files, it
> > > works like this:
> > > 
> > >     qemu-img create -f qcow2 -o data_file=test.raw test.qcow2 4G
> > > 
> > > And then just use test.qcow2. As long as you can put everything you need
> > > into an rbd URL, the same approach should work. Otherwise, you may need
> > > to use QMP blockdev-create on creation and possibly the data-file option
> > > of the qcow2 driver for opening.
> > 
> > Very interesting, I'll try to add this support also in the rbd driver.
> 
> I don't understand - what is the thing you want to add to the rbd driver?
> qcow2 doesn't need special protocol driver support for doing this, and I
> don't think the QEMU rbd driver has any metadata that could be split off.
> 

Oh sorry, I didn't understand that was completely independent from the
protocol.

> > > > > How fast is rbd_resize()? Does automatically resizing for every write
> > > > > request actually work reasonably well in practice? If it does, there is
> > > > > probably little reason not to allow it, even if the use cases are rather
> > > > > obscure.
> > > > 
> > > > I'll try to measure the percentage of the time spent in the rbd_resize.
> > > > 
> > > > Another solution could be to pass to the rbd driver the virtual size of
> > > > the image and resize it only one time also if the preallocation is
> > > > disabled, because RBD will not allocate blocks but IIUC it only set the max
> > > > size.
> > > > 
> > > > Do you think make sense? Is it feasible?
> > > 
> > > In theory yes, though it requires modification of every driver that
> > > should be usable together with rbd (i.e. ideally all of the drivers). If
> > > automatic resize works good enough, I'd prefer that
> > 
> > I did some tests and it seems that the cost of rbd_resize() is
> > negligible. IIUC it only updates the metadata without allocating any
> > blocks (if we are growing, like that case).
> > 
> > Anyway the automatic resize will not affect the current use-case (raw
> > images on rbd), where the file size is set during the creation, so I
> > think there should not be side effects with this patch.
> 
> Okay, sounds good.
> 
> > I'm also adding the support for preallocation (i.e. full) in the rbd
> > driver that can be useful for qcow2 images.
> > 
> > If you prefer I can resend this patch with the preallocation series.
> 
> Let's keep seperate things separate. Huge patch series are always harder
> to handle.

Okay, thanks for the suggestion!

Should this patch go through your tree?

Thanks,
Stefano

