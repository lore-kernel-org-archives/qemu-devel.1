Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1725C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 13:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8CC2133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 13:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8CC2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48599 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEZMw-0006kc-IS
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 09:03:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hEZLw-0006Mi-4L
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hEZLv-0006u8-5F
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:02:52 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hEZLu-0006tH-S6
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:02:51 -0400
Received: by mail-wr1-f44.google.com with SMTP id t17so7206456wrw.13
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 06:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=+G7cUDchi5ttDfW+Na33fg9Zzb58vliE1Ng/MbMDd8Q=;
	b=JRgHEp8lu4ZyOfCp3iJ2glgygV+OXGCiWWHK0UV5VBRKCt3ghPch9Omr7zoro58p2/
	qMqUIUGq2IdK/IhFQL/LexC/rhtbYP589yYwa49r14gSwi0nJREV4kTwIOfmgpCl99ig
	DjxYSYjmXYZOAdO4kTZIhhAJRYCQH8YpdgsueqvyMCId5qYxjGv4W2a/7tE7OI2Fv0o/
	OxMPUva3ApGloiySGwigCuFA2IY18JHnlAd0EkCKhfr9474rGu05ZK8Ecvzjxv1Wn1rc
	eaZ3oaDcob7r68dSxEt6LJ+qBbSpGllfTgZg6Jeqvu1agcxyxc1dcbPjSfrmihVGY/Gt
	RYRw==
X-Gm-Message-State: APjAAAWjwaTXFsuADqKIihi3FpWZF9M8YnT83yH8NGFMzUoCYBH6u2Pe
	Imz5UZwK1hZB4XzwLneL3EM5jA==
X-Google-Smtp-Source: APXvYqzuqLaRLh33Mp7mv8F5wIpnAffLchBeY1mnyWcXpfiMcPmh2lX0diQT1W8LY1FrOtvGNI9Zpw==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr8901033wrw.174.1554987768988; 
	Thu, 11 Apr 2019 06:02:48 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it.
	[87.12.203.35]) by smtp.gmail.com with ESMTPSA id
	z84sm5848635wmg.24.2019.04.11.06.02.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 11 Apr 2019 06:02:48 -0700 (PDT)
Date: Thu, 11 Apr 2019 15:02:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: dillaman@redhat.com
Message-ID: <20190411130245.ltfyp7d2dfe2cr3h@steredhat>
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
	<CA+aFP1AMzNjWtMeGy4MpWBa26qxShgciYkcEZ8mkSmDrtCvfqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CA+aFP1AMzNjWtMeGy4MpWBa26qxShgciYkcEZ8mkSmDrtCvfqA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.44
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
Message-ID: <20190411130245.DgoQisN-TA6VPRkUNOVvFMxTg5nUs-o1Y-pcz7odjC0@z>

On Thu, Apr 11, 2019 at 08:35:44AM -0400, Jason Dillaman wrote:
> On Thu, Apr 11, 2019 at 7:00 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > RBD APIs don't allow us to write more than the size set with rbd_create()
> > or rbd_resize().
> > In order to support growing images (eg. qcow2), we resize the image
> > before RW operations that exceed the current size.
> 
> What's the use-case for storing qcow2 images within a RBD image? RBD
> images are already thinly provisioned, they support snapshots, they
> can form a parent/child linked image hierarchy.
> 

Hi Jason,
I understand your point of view, maybe one use case could be if you have
a qcow2 image and you want to put it in the rdb pool without convert it.

I'm going through this BZ [1] and I'll ask if they have other
use cases in mind.

Anyway, if we want to support only raw format on RBD driver, maybe we
should return something different from current behaviour, also avoiding
to create the image:

$ qemu-img create -f qcow2 rbd:test/qcow.img 1G
  qemu-img: rbd:test/qcow.img: Could not write qcow2 header: Invalid argument

What do you think?

Thanks,
Stefano

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1171007

