Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B0CC10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 08:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671EF206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 08:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671EF206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48729 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGfZo-0000pK-Is
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 04:05:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hGfYw-0000PF-5x
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 04:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hGfYv-0005jw-7Q
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 04:04:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51445)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hGfYo-0005ek-Is; Wed, 17 Apr 2019 04:04:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAE7337E85;
	Wed, 17 Apr 2019 08:04:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-131.ams2.redhat.com
	[10.36.117.131])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D1D5B5D9C8;
	Wed, 17 Apr 2019 08:04:44 +0000 (UTC)
Date: Wed, 17 Apr 2019 10:04:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190417080443.GA8330@localhost.localdomain>
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
	<CA+aFP1AMzNjWtMeGy4MpWBa26qxShgciYkcEZ8mkSmDrtCvfqA@mail.gmail.com>
	<20190411130245.ltfyp7d2dfe2cr3h@steredhat>
	<CA+aFP1B7ZZ_xwNOfMbKUzEjYbMH=9dJstLYEyVq4LphPR81u0Q@mail.gmail.com>
	<20190414132008.uxoia6avdpp4jov6@steredhat.homenet.telecomitalia.it>
	<CA+aFP1D8VYcnwWpB=4PzAdBKr+YK-r8bSwzKKUCkH7jT3kVvoQ@mail.gmail.com>
	<20190415080452.GA6031@localhost.localdomain>
	<20190417073438.r57lemi6emu4x3ld@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190417073438.r57lemi6emu4x3ld@steredhat>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 17 Apr 2019 08:04:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Message-ID: <20190417080443.0dOjedWWyuJY10bcTPUNnwLrbmGcNac9_d-FClsdOSw@z>

Am 17.04.2019 um 09:34 hat Stefano Garzarella geschrieben:
> On Mon, Apr 15, 2019 at 10:04:52AM +0200, Kevin Wolf wrote:
> > 
> > I think a potential actual use case could be persistent dirty bitmaps
> > for incremental backup. Though maybe that would be better served by
> > using the rbd image just as a raw external data file and keeping the
> > qcow2 metadata on a filesystem.
> 
> Thanks to point it out! I'll take a look to understand how to keep
> metadata separated from the data.

I'd consider the feature still experimental, but for local files, it
works like this:

    qemu-img create -f qcow2 -o data_file=test.raw test.qcow2 4G

And then just use test.qcow2. As long as you can put everything you need
into an rbd URL, the same approach should work. Otherwise, you may need
to use QMP blockdev-create on creation and possibly the data-file option
of the qcow2 driver for opening.

> > How fast is rbd_resize()? Does automatically resizing for every write
> > request actually work reasonably well in practice? If it does, there is
> > probably little reason not to allow it, even if the use cases are rather
> > obscure.
> 
> I'll try to measure the percentage of the time spent in the rbd_resize.
> 
> Another solution could be to pass to the rbd driver the virtual size of
> the image and resize it only one time also if the preallocation is
> disabled, because RBD will not allocate blocks but IIUC it only set the max
> size.
> 
> Do you think make sense? Is it feasible?

In theory yes, though it requires modification of every driver that
should be usable together with rbd (i.e. ideally all of the drivers). If
automatic resize works good enough, I'd prefer that.

Kevin

