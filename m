Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678B2C10F13
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 15:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322DB2084E
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 15:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322DB2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36776 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFgs1-0001nP-8G
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 11:16:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1hFgqY-0000v1-BM
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 11:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1hFgqX-0003m2-68
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 11:15:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1hFgqW-0003ku-RN
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 11:15:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id u57so11750637edm.3
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 08:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
	:from:date:message-id:subject:to:cc;
	bh=6ahkj+NtfJxT8lE3LLPL9Cp26HGaUyHLRb80IETSV7s=;
	b=dB3PpHvXQIa8Ie6xVcGrD5RMZ+o7IHMMqMXG6dy8NJzwMG0xW5HwoVlynPREXh/+gO
	YYA8Y3MeCbss22ulaKSv3Kl/BiVp88e8GevJ7ax/ulyNGCqo2O9g+/J5mTU+NDinxdfI
	A7N0K8IzmYCpCehLR/uQPD+zUMbOaiQTuZWFxuZheikprYVlP+lYfWAH6fsgAd3noOkG
	q/kHS0Dc8zeDJif+L99en5GYGWqXCpq8EjzEXHVfWtXdcyvT3cjKa2x+/bZ2HgJxIauF
	mfhsTHp77Oo1LXFW6z7kAaJ/5hUSFYrGl9IKeJfHTOVnfFcsyFXE1EmSbZ5C819DUCk/
	4k+A==
X-Gm-Message-State: APjAAAUoarJ2WsKbghwDRjJrelhJKarnoyC9oU4qMprtFTyrbzxuU2IN
	AKSeNpHr3ZirxJ21g0vKS53PSTH9lD2p+YoGKJ/9JQ==
X-Google-Smtp-Source: APXvYqzPMbk42ToVuWRfD1tlcBvnJ4QK8NZBIbvJqd62gl3QSWH5/8hVvOYpFufsUmseFosi2UWSgxrVi4tJIFE2k6U=
X-Received: by 2002:a17:906:3612:: with SMTP id
	q18mr37648354ejb.147.1555254902568; 
	Sun, 14 Apr 2019 08:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
	<CA+aFP1AMzNjWtMeGy4MpWBa26qxShgciYkcEZ8mkSmDrtCvfqA@mail.gmail.com>
	<20190411130245.ltfyp7d2dfe2cr3h@steredhat>
	<CA+aFP1B7ZZ_xwNOfMbKUzEjYbMH=9dJstLYEyVq4LphPR81u0Q@mail.gmail.com>
	<20190414132008.uxoia6avdpp4jov6@steredhat.homenet.telecomitalia.it>
In-Reply-To: <20190414132008.uxoia6avdpp4jov6@steredhat.homenet.telecomitalia.it>
From: Jason Dillaman <jdillama@redhat.com>
Date: Sun, 14 Apr 2019 11:14:49 -0400
Message-ID:
 <CA+aFP1D8VYcnwWpB=4PzAdBKr+YK-r8bSwzKKUCkH7jT3kVvoQ@mail.gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.208.66
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
Reply-To: dillaman@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
	qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>, dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190414151449.jqYhuY5NfmNwdazRfebEIpQvlh3WWEwPaIvP-CoLW_M@z>

On Sun, Apr 14, 2019 at 9:20 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, Apr 11, 2019 at 01:06:49PM -0400, Jason Dillaman wrote:
> > On Thu, Apr 11, 2019 at 9:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > >
> > > On Thu, Apr 11, 2019 at 08:35:44AM -0400, Jason Dillaman wrote:
> > > > On Thu, Apr 11, 2019 at 7:00 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > > >
> > > > > RBD APIs don't allow us to write more than the size set with rbd_create()
> > > > > or rbd_resize().
> > > > > In order to support growing images (eg. qcow2), we resize the image
> > > > > before RW operations that exceed the current size.
> > > >
> > > > What's the use-case for storing qcow2 images within a RBD image? RBD
> > > > images are already thinly provisioned, they support snapshots, they
> > > > can form a parent/child linked image hierarchy.
> > > >
> > >
> > > Hi Jason,
> > > I understand your point of view, maybe one use case could be if you have
> > > a qcow2 image and you want to put it in the rdb pool without convert it.
> > >
> > > I'm going through this BZ [1] and I'll ask if they have other
> > > use cases in mind.
> >
> > Assuming no good use-cases, perhaps it would just be better to make
> > the qemu-img error messages more clear.
> >
>
> Hi Jason,
> I asked about use-cases and they want to use qcow2 on rbd in order to
> take advantage of these qcow2 features [1]: external snapshots,
> Copy-on-write, and optional compression and encryption.
>
> Maybe the more interesting are external snapshots and Copy-on-write,

Copy-on-write is natively supported by RBD. The concept of external
snapshots seems similar to just automating the process of creating a
new copy-on-write image. Compression is also supported by Ceph on the
cluster side by recent releases.

> since encryption can be achieved with LUKS and rbd should support
> compression for a specified pool.
>
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1171007#c13
>
> Cheers,
> Stefano



-- 
Jason

