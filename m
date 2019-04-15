Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBBAC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 08:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F327C206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 08:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F327C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46401 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFwci-0003AV-B4
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 04:05:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hFwbv-0002mc-Fo
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hFwbu-0005TY-Dr
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:05:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hFwbr-0005RX-Ld; Mon, 15 Apr 2019 04:04:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CFE2D81DFE;
	Mon, 15 Apr 2019 08:04:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-113.ams2.redhat.com
	[10.36.117.113])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D2105D9C9;
	Mon, 15 Apr 2019 08:04:54 +0000 (UTC)
Date: Mon, 15 Apr 2019 10:04:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: dillaman@redhat.com
Message-ID: <20190415080452.GA6031@localhost.localdomain>
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
	<CA+aFP1AMzNjWtMeGy4MpWBa26qxShgciYkcEZ8mkSmDrtCvfqA@mail.gmail.com>
	<20190411130245.ltfyp7d2dfe2cr3h@steredhat>
	<CA+aFP1B7ZZ_xwNOfMbKUzEjYbMH=9dJstLYEyVq4LphPR81u0Q@mail.gmail.com>
	<20190414132008.uxoia6avdpp4jov6@steredhat.homenet.telecomitalia.it>
	<CA+aFP1D8VYcnwWpB=4PzAdBKr+YK-r8bSwzKKUCkH7jT3kVvoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CA+aFP1D8VYcnwWpB=4PzAdBKr+YK-r8bSwzKKUCkH7jT3kVvoQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 15 Apr 2019 08:04:57 +0000 (UTC)
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
Cc: Josh Durgin <jdurgin@redhat.com>, Max Reitz <mreitz@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
	Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415080452.iqKDdcgA_Z_VSyPuPdnVUy98NXG1t4_vVhBlu508_0k@z>

Am 14.04.2019 um 17:14 hat Jason Dillaman geschrieben:
> On Sun, Apr 14, 2019 at 9:20 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > On Thu, Apr 11, 2019 at 01:06:49PM -0400, Jason Dillaman wrote:
> > > On Thu, Apr 11, 2019 at 9:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > >
> > > > On Thu, Apr 11, 2019 at 08:35:44AM -0400, Jason Dillaman wrote:
> > > > > On Thu, Apr 11, 2019 at 7:00 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > > > >
> > > > > > RBD APIs don't allow us to write more than the size set with rbd_create()
> > > > > > or rbd_resize().
> > > > > > In order to support growing images (eg. qcow2), we resize the image
> > > > > > before RW operations that exceed the current size.
> > > > >
> > > > > What's the use-case for storing qcow2 images within a RBD image? RBD
> > > > > images are already thinly provisioned, they support snapshots, they
> > > > > can form a parent/child linked image hierarchy.
> > > > >
> > > >
> > > > Hi Jason,
> > > > I understand your point of view, maybe one use case could be if you have
> > > > a qcow2 image and you want to put it in the rdb pool without convert it.
> > > >
> > > > I'm going through this BZ [1] and I'll ask if they have other
> > > > use cases in mind.
> > >
> > > Assuming no good use-cases, perhaps it would just be better to make
> > > the qemu-img error messages more clear.
> > >
> >
> > Hi Jason,
> > I asked about use-cases and they want to use qcow2 on rbd in order to
> > take advantage of these qcow2 features [1]: external snapshots,
> > Copy-on-write, and optional compression and encryption.
> >
> > Maybe the more interesting are external snapshots and Copy-on-write,
> 
> Copy-on-write is natively supported by RBD. The concept of external
> snapshots seems similar to just automating the process of creating a
> new copy-on-write image. Compression is also supported by Ceph on the
> cluster side by recent releases.

I think a potential actual use case could be persistent dirty bitmaps
for incremental backup. Though maybe that would be better served by
using the rbd image just as a raw external data file and keeping the
qcow2 metadata on a filesystem.

How fast is rbd_resize()? Does automatically resizing for every write
request actually work reasonably well in practice? If it does, there is
probably little reason not to allow it, even if the use cases are rather
obscure.

Kevin

