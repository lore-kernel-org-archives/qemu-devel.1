Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFEDC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 16:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E415206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 16:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E415206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34620 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEGNe-0002cq-Qd
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 12:47:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hEGMd-0002AP-MU
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hEGMc-0002GK-FH
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:46:19 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:47004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hEGMc-0002Fo-9s
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:46:18 -0400
Received: by mail-qt1-f196.google.com with SMTP id z17so3594597qts.13
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 09:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=wTZgbHHgkuc02Ro6e9QqtN7TkTJsuUpWH/R1Yu8H+2c=;
	b=FJbGdIwKf13PqJ0yD78IyjwPA2atPAIgQVZQA0Rksf2OV4A6DmIQjpD6bxOPTKvv3c
	mwhgZaaDVB0OqIh7eGTMp0OHmmA95OMWkZYFB/4bvBQ12fefLwPgyUdzZWiSyJC3rUTd
	WMzQvzKQrng1mr9kmh9CkYeTDwgBhbtq+mK8ibOhZUIkS2ernKpnhl/EACHMKqgnwUDX
	KMSw8lupI36w+2Or1/UUyMPHZSJ7Y70lup2KB+Sucp8Ol6b17vkf29omSDqjorjb0yBc
	VoEkBwm0nHDISfJ1/Psce99dHVrcaaIWwWhFIWHKDZdU4fcLHFeUNIIC3W0K62cnDa/n
	trew==
X-Gm-Message-State: APjAAAXumZtmhiteKIpALnL/rRF/bLVZjZ2d3nAvPQ/os+EZ/HjbLCnM
	+KTZEnXT+DmzZg3i7GH70YR5sQ==
X-Google-Smtp-Source: APXvYqzo2oB9aEeCxQF7UkVfHE1VMd09kGpmcV7fL9Txo0VqCS7eRqZuS9unOq1Egz2WPuNxoQfPtw==
X-Received: by 2002:a0c:d167:: with SMTP id c36mr26941640qvh.1.1554914776715; 
	Wed, 10 Apr 2019 09:46:16 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	h24sm24983836qte.50.2019.04.10.09.46.13
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 10 Apr 2019 09:46:15 -0700 (PDT)
Date: Wed, 10 Apr 2019 12:46:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190410124114-mutt-send-email-mst@kernel.org>
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-3-pagupta@redhat.com>
	<20190410091216-mutt-send-email-mst@kernel.org>
	<127904196.20807948.1554904981681.JavaMail.zimbra@redhat.com>
	<20190410163139.4a04175e.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190410163139.4a04175e.cohuck@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.196
Subject: Re: [Qemu-devel] [PATCH v5 2/5] virtio-pmem: Add virtio pmem driver
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
Cc: Pankaj Gupta <pagupta@redhat.com>, jack@suse.cz, kvm@vger.kernel.org,
	david@redhat.com, jasowang@redhat.com, david@fromorbit.com,
	qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
	adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org,
	aarcange@redhat.com, dave jiang <dave.jiang@intel.com>,
	linux-nvdimm@lists.01.org,
	vishal l verma <vishal.l.verma@intel.com>, willy@infradead.org,
	hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com,
	linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl,
	riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>,
	stefanha@redhat.com, imammedo@redhat.com,
	dan j williams <dan.j.williams@intel.com>,
	lcapitulino@redhat.com, kwolf@redhat.com, nilal@redhat.com,
	tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
	darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410164612.KljWEe7cG8i5qCOhT0pZa_9cVqVInIrRaQZNx8AEWrE@z>

On Wed, Apr 10, 2019 at 04:31:39PM +0200, Cornelia Huck wrote:
> On Wed, 10 Apr 2019 10:03:01 -0400 (EDT)
> Pankaj Gupta <pagupta@redhat.com> wrote:
> 
> > > 
> > > On Wed, Apr 10, 2019 at 09:38:22AM +0530, Pankaj Gupta wrote:  
> > > > This patch adds virtio-pmem driver for KVM guest.
> > > > 
> > > > Guest reads the persistent memory range information from
> > > > Qemu over VIRTIO and registers it on nvdimm_bus. It also
> > > > creates a nd_region object with the persistent memory
> > > > range information so that existing 'nvdimm/pmem' driver
> > > > can reserve this into system memory map. This way
> > > > 'virtio-pmem' driver uses existing functionality of pmem
> > > > driver to register persistent memory compatible for DAX
> > > > capable filesystems.
> > > > 
> > > > This also provides function to perform guest flush over
> > > > VIRTIO from 'pmem' driver when userspace performs flush
> > > > on DAX memory range.
> > > > 
> > > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> 
> > > > diff --git a/include/uapi/linux/virtio_ids.h
> > > > b/include/uapi/linux/virtio_ids.h
> > > > index 6d5c3b2d4f4d..346389565ac1 100644
> > > > --- a/include/uapi/linux/virtio_ids.h
> > > > +++ b/include/uapi/linux/virtio_ids.h
> > > > @@ -43,5 +43,6 @@
> > > >  #define VIRTIO_ID_INPUT        18 /* virtio input */
> > > >  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
> > > >  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> > > > +#define VIRTIO_ID_PMEM         25 /* virtio pmem */
> > > >  
> > > >  #endif /* _LINUX_VIRTIO_IDS_H */  
> > > 
> > > Didn't Paolo point out someone is using 25 for audio?  
> > 
> > 
> > Sorry! I did not notice this.
> > 
> > > 
> > > Please, reserve an ID with the Virtio TC before using it.  
> > 
> > I thought I requested[1] ID 25.
> > 
> > [1] https://github.com/oasis-tcs/virtio-spec/issues/38
> > [2] https://lists.oasis-open.org/archives/virtio-dev/201805/threads.html
> > 
> > In that case I will send request for next available ID i.e 26?
> 
> Have the folks using this for audio sent a reservation request as well?
> If not, I'd say the first requester should get the id...

No but I think they ship their's already. No one ships pmem
so it's less pain for everyone if we just skip 25.

> (And yes, we need to be quicker with voting on/applying id
> reservations :/)

We can't vote on what was not proposed for a vote.
At the moment that responsibility is with the commented
once discussion on the comment has taken place.

I think what's missing is a description of the process
in the README. Want to write it up and post it?

-- 
MST

