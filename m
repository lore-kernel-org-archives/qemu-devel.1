Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEF6C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222472089E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222472089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48075 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM7o7-0004rp-BI
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 05:15:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hM7nI-0004WO-Az
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hM7my-0007hO-LH
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:14:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hM7me-0006tM-TI
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:13:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so2201415wrr.13
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 02:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=vvFEIl7DU83KmuJ1H5TgksA5dUYVlmX0aiGoidKKB58=;
	b=Y0Bw0X8xwxZcKpIPsj5NbBWv5Uq/in89ZsjIKgLBiylwDC/Fkw8VI+yiuMeubCzTIZ
	c/6InCO7ePdl7xT6to+Cije1yo+pzgyqcJWTwy0qRQ2xBxy1IIU10XuwVfEZBgXh1uEW
	AF3bebavquZkdN6gTDDuUiggJIns4wlMsr+Cxr4m9yF+YDPyciKY1N06UZf6iIIi3z3w
	ThG1IVTh97Vo/QYz9Qwu75BlpvP//qRcerBO17JeHkplQBS/meuml+Gm4+8E1RCr4n5Z
	O29I1rgL+yDBRIziLK2VeovJ1r0V0fF3kpbG0WIzd+MRT/eYWRmS0XDFsJPfMcTc1qeY
	rQaQ==
X-Gm-Message-State: APjAAAUdPbKwZQSWcIEFV+qGpnxjn3E3UqAuTLE+VGUqlCA8Vz8D/3V5
	oHhD69V20C92ZLv915nVOZ02zw==
X-Google-Smtp-Source: APXvYqwgoy0JslPk1/QXztmO2yordzndsjKq8cmou5ui3L9mFaeCltL4f+BLR/xWJHrLnO1F8CaHUA==
X-Received: by 2002:adf:df88:: with SMTP id z8mr1837656wrl.209.1556788318250; 
	Thu, 02 May 2019 02:11:58 -0700 (PDT)
Received: from steredhat (host103-125-dynamic.46-79-r.retail.telecomitalia.it.
	[79.46.125.103]) by smtp.gmail.com with ESMTPSA id
	g185sm6870889wmf.30.2019.05.02.02.11.56
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 02:11:57 -0700 (PDT)
Date: Thu, 2 May 2019 11:11:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190502091154.y34h7qvm6ubta632@steredhat>
References: <20190423125706.26989-1-vsementsov@virtuozzo.com>
	<20190423125706.26989-3-vsementsov@virtuozzo.com>
	<20190430092437.jbecehdkqa4zdavd@steredhat>
	<4dabb261-f2d1-b6e0-8d97-ace159b87a54@virtuozzo.com>
	<20190430110918.GF5607@linux.fritz.box>
	<2c8b3197-316d-7215-9284-6f1e986a0803@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <2c8b3197-316d-7215-9284-6f1e986a0803@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v5 2/3] block/io: bdrv_pdiscard: support
 int64_t bytes parameter
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
Cc: Kevin Wolf <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502091154.5mQGH0Qsps6rOLhP_f6mGfaCoNBG4l5ZeBBCLKiix1w@z>

On Tue, Apr 30, 2019 at 10:41:02AM -0500, Eric Blake wrote:
> On 4/30/19 6:09 AM, Kevin Wolf wrote:
> > Am 30.04.2019 um 12:03 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> 30.04.2019 12:24, Stefano Garzarella wrote:
> >>> On Tue, Apr 23, 2019 at 03:57:05PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> >>>> This fixes at least one overflow in qcow2_process_discards, which
> >>>> passes 64bit region length to bdrv_pdiscard where bytes (or sectors in
> >>>> the past) parameter is int since its introduction in 0b919fae.
> >>>>
> >>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> >>>> -    if (!bs || !bs->drv) {
> >>>> +    if (!bs || !bs->drv || !bdrv_is_inserted(bs)) {
> >>>
> >>> Should we describe this change in the commit message?
> >>
> >> Honestly, don't want to resend the series for this.
> > 
> > I haven't reviewed the patches yet, but if this remains the only thing
> > to change, it can be updated while applying the series if we have a
> > specific proposal for a new commit message.
> 
> How about:
> 
> This fixes at least one overflow in qcow2_process_discards, which was
> inadvertently truncating a 64-bit region length to the bdrv_pdiscard
> 'int bytes' parameter (previously bdrv_discard's 'int sectors') since
> its introduction in 0b919fae.
> 
> By inlining the remaining portions of bdrv_check_byte_request() that are
> still independent from the code previously validating a 32-bit request,
> we can drop the call to that function. A request larger than 31 bits (or
> the driver's max discard limit, if specified) is still split into
> smaller chunks by the block layer before reaching the driver.
> 

That sounds good to me!

Thanks,
Stefano

