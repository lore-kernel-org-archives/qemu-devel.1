Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009F2C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 07:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C82032176F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 07:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82032176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48405 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGf6V-0004dZ-Jz
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 03:35:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hGf5h-0004Hl-G9
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 03:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hGf5g-0000gB-L5
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 03:34:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hGf5g-0000fT-Cw
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 03:34:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id w16so557648wrl.1
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 00:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=iM8DLr5Lvu6IUmWNjiXCHWTWQBqnAcKPDs+WCTayPto=;
	b=leAew5+l6JodGAhl6TSdh18MyB+u7kSrzyjWyxSUirWuJd0Sr5IMQXVQx2W2y1KVEw
	+e9VqiG4tVgwaMoVO4lDg4Br1T6YvM9gamUOPeSBLts5ALnGvl51IV/7GtwvawJ9mceT
	GFY2zGmHQX6UYqnwzc1rO7XwRutFc3WGricpKHmn3ibrvoD3Dg2cxYwGYbvXYo8mx5Zf
	ex4xrSVTxq8jcqplTYNkL8WzC0pGjoq4r2E6+M9E98cFnxNXcxFhqQaT0MIbfEcV6TXp
	EW+pSwuB9giiOAt0zlgZwyeKcexi4BhxxLsEYKx+b6rLs2hA3auziNpP2aAQlEzA/q+o
	ALtA==
X-Gm-Message-State: APjAAAWxvvhrLSUST6rRfxd5Jnh089n6niyjcmeSL9NrJsGU/iVNIvRi
	oV0OCy3ykxf1Ha/Bz5Mjmu6roA==
X-Google-Smtp-Source: APXvYqzEbXdBzA7/plTkCty5PcWyMLMGqLIAuJGEItGlb0/8DCDpxEnseYWb082lXwkaMU7Fz0mzXw==
X-Received: by 2002:a5d:5108:: with SMTP id s8mr7265680wrt.99.1555486482552;
	Wed, 17 Apr 2019 00:34:42 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it.
	[87.12.203.35]) by smtp.gmail.com with ESMTPSA id
	y5sm44533218wrw.23.2019.04.17.00.34.41
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 17 Apr 2019 00:34:41 -0700 (PDT)
Date: Wed, 17 Apr 2019 09:34:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190417073438.r57lemi6emu4x3ld@steredhat>
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
	<CA+aFP1AMzNjWtMeGy4MpWBa26qxShgciYkcEZ8mkSmDrtCvfqA@mail.gmail.com>
	<20190411130245.ltfyp7d2dfe2cr3h@steredhat>
	<CA+aFP1B7ZZ_xwNOfMbKUzEjYbMH=9dJstLYEyVq4LphPR81u0Q@mail.gmail.com>
	<20190414132008.uxoia6avdpp4jov6@steredhat.homenet.telecomitalia.it>
	<CA+aFP1D8VYcnwWpB=4PzAdBKr+YK-r8bSwzKKUCkH7jT3kVvoQ@mail.gmail.com>
	<20190415080452.GA6031@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190415080452.GA6031@localhost.localdomain>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
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
Message-ID: <20190417073438.hAZ9jwvJ9bIo2DZ4wEl_DgomOHQv_4rlBAY1BF6NFpg@z>

On Mon, Apr 15, 2019 at 10:04:52AM +0200, Kevin Wolf wrote:
> 
> I think a potential actual use case could be persistent dirty bitmaps
> for incremental backup. Though maybe that would be better served by
> using the rbd image just as a raw external data file and keeping the
> qcow2 metadata on a filesystem.

Thanks to point it out! I'll take a look to understand how to keep
metadata separated from the data.

> 
> How fast is rbd_resize()? Does automatically resizing for every write
> request actually work reasonably well in practice? If it does, there is
> probably little reason not to allow it, even if the use cases are rather
> obscure.

I'll try to measure the percentage of the time spent in the rbd_resize.

Another solution could be to pass to the rbd driver the virtual size of
the image and resize it only one time also if the preallocation is
disabled, because RBD will not allocate blocks but IIUC it only set the max
size.

Do you think make sense? Is it feasible?

Thanks,
Stefano

