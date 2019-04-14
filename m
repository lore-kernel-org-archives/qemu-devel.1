Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DCAC10F13
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 13:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06CD12084E
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 13:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CD12084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35829 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFfAh-00071E-7A
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 09:27:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hFf91-00060l-DV
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 09:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hFf3f-0004pu-0x
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 09:20:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hFf3c-0004dn-DF
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 09:20:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so18140067wrn.11
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 06:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=+JCu9jp6pX+rN5fcdF00BKykPK9xM8XiK/F7+feNu/w=;
	b=gNwZ3s8BzL3LjE7IzZLzqJ2/KMmlGuex+bFccJWETS5xBmtl6Jsa49SlELSgW6aIb1
	JwQZQV+x7LYnMohJprPlIGwTMIsoC/dVYKr8v9The69UGB/K/nXclkNGz6bBRc44vGDa
	jqdx47t/r7UEqrT2E8DLrFISjSACYp9hc9Xv0HvuKtW4+/HcKT4HCqojtvIjTvB70Zei
	PqX3rYheUNDAwm/qS72po1F/pf+PF6buiLXBE7F0ElFmOnmKCTsPBpWKOaJcOYhNb3oL
	vT+4QBKHXMKm1P/HMZ9fRJGJBGVWPdpa5qFh9lT/og6CExst9LNGRFFDLhS959aVyuOc
	UkGQ==
X-Gm-Message-State: APjAAAW5BwCrta2H5F3gNex+JGafnYlEjFLbwbu5JU4HFn3y5sReigOA
	IjCNQZhuWJKxn+q4YalelGyXAg==
X-Google-Smtp-Source: APXvYqxm8IKAlhJAHETeeu9VpJktOrL4qUpYeyLR+4w0TYTp9MrOItZl32n+BLKERCQdkZYpeC7jGw==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr8683467wru.117.1555248012824; 
	Sun, 14 Apr 2019 06:20:12 -0700 (PDT)
Received: from steredhat.homenet.telecomitalia.it
	(host35-203-static.12-87-b.business.telecomitalia.it. [87.12.203.35])
	by smtp.gmail.com with ESMTPSA id
	v184sm27983367wma.6.2019.04.14.06.20.10
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sun, 14 Apr 2019 06:20:11 -0700 (PDT)
Date: Sun, 14 Apr 2019 15:20:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: dillaman@redhat.com
Message-ID:
 <20190414132008.uxoia6avdpp4jov6@steredhat.homenet.telecomitalia.it>
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
	<CA+aFP1AMzNjWtMeGy4MpWBa26qxShgciYkcEZ8mkSmDrtCvfqA@mail.gmail.com>
	<20190411130245.ltfyp7d2dfe2cr3h@steredhat>
	<CA+aFP1B7ZZ_xwNOfMbKUzEjYbMH=9dJstLYEyVq4LphPR81u0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CA+aFP1B7ZZ_xwNOfMbKUzEjYbMH=9dJstLYEyVq4LphPR81u0Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
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
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190414132008.z67mtUzC1QO-BVE3ShUICGNtSkHnHhnA5PdXP_FMe9M@z>

On Thu, Apr 11, 2019 at 01:06:49PM -0400, Jason Dillaman wrote:
> On Thu, Apr 11, 2019 at 9:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > On Thu, Apr 11, 2019 at 08:35:44AM -0400, Jason Dillaman wrote:
> > > On Thu, Apr 11, 2019 at 7:00 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > >
> > > > RBD APIs don't allow us to write more than the size set with rbd_create()
> > > > or rbd_resize().
> > > > In order to support growing images (eg. qcow2), we resize the image
> > > > before RW operations that exceed the current size.
> > >
> > > What's the use-case for storing qcow2 images within a RBD image? RBD
> > > images are already thinly provisioned, they support snapshots, they
> > > can form a parent/child linked image hierarchy.
> > >
> >
> > Hi Jason,
> > I understand your point of view, maybe one use case could be if you have
> > a qcow2 image and you want to put it in the rdb pool without convert it.
> >
> > I'm going through this BZ [1] and I'll ask if they have other
> > use cases in mind.
> 
> Assuming no good use-cases, perhaps it would just be better to make
> the qemu-img error messages more clear.
> 

Hi Jason,
I asked about use-cases and they want to use qcow2 on rbd in order to
take advantage of these qcow2 features [1]: external snapshots,
Copy-on-write, and optional compression and encryption.

Maybe the more interesting are external snapshots and Copy-on-write,
since encryption can be achieved with LUKS and rbd should support
compression for a specified pool.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1171007#c13

Cheers,
Stefano

