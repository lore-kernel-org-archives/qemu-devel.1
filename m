Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC7CC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0FF2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZM2Nnfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0FF2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hboaI-0008Hj-5X
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58619)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sstabellini@kernel.org>) id 1hboNT-00086Q-Ij
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sstabellini@kernel.org>) id 1hboNS-0004HK-8i
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59682)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sstabellini@kernel.org>)
 id 1hboNR-0004Fh-Ph
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:44:30 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 807A22173C;
 Fri, 14 Jun 2019 15:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1560527067;
 bh=H5sBhEsnpXpuEm12t4z5a4PsuSj7UCejtvDZISrfJHg=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=rZM2NnfeGInrLmm8edourRfXsFWBmWJ7tveTFbZi37AgGATdh+wkvBLz3Q9qjavAg
 gMQgjKpbnjGj8hXwoZyzusv3RLmcetaqH/wBZ4d1C1rWyArQIqHuUxK5smKJ97T7J7
 uO0M+ZbKLYUEki3X/uqVG7rs5yRIMDVYHGF+m6m8=
Date: Fri, 14 Jun 2019 08:44:26 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Paul Durrant <Paul.Durrant@citrix.com>
In-Reply-To: <c2c63dd46c684b1bb0f2e342a085d93d@AMSPEX02CL03.citrite.net>
Message-ID: <alpine.DEB.2.21.1906140844150.2072@sstabellini-ThinkPad-T480s>
References: <155912548463.2019004.3515830305299809902.stgit@bahia.lan>
 <20190529125926.GD2126@perard.uk.xensource.com>
 <20190605121056.0e784daf@bahia.lab.toulouse-stg.fr.ibm.com>
 <c85d973ca2d444678e8fdc86a4cd6f4f@AMSPEX02CL03.citrite.net>
 <20190614101621.098742e2@bahia.lan>
 <c2c63dd46c684b1bb0f2e342a085d93d@AMSPEX02CL03.citrite.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Change maintership of Xen
 code under hw/9pfs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, 'Greg Kurz' <groug@kaod.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Jun 2019, Paul Durrant wrote:
> > -----Original Message-----
> > From: Greg Kurz [mailto:groug@kaod.org]
> > Sent: 14 June 2019 09:16
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: Anthony Perard <anthony.perard@citrix.com>; qemu-devel@nongnu.org; Stefano Stabellini
> > <sstabellini@kernel.org>
> > Subject: Re: [PATCH] MAINTAINERS: Change maintership of Xen code under hw/9pfs
> > 
> > On Wed, 5 Jun 2019 10:12:05 +0000
> > Paul Durrant <Paul.Durrant@citrix.com> wrote:
> > 
> > > > -----Original Message-----
> > > > From: Greg Kurz [mailto:groug@kaod.org]
> > > > Sent: 05 June 2019 11:11
> > > > To: Anthony Perard <anthony.perard@citrix.com>
> > > > Cc: qemu-devel@nongnu.org; Stefano Stabellini <sstabellini@kernel.org>; Paul Durrant
> > > > <Paul.Durrant@citrix.com>
> > > > Subject: Re: [PATCH] MAINTAINERS: Change maintership of Xen code under hw/9pfs
> > > >
> > > > On Wed, 29 May 2019 13:59:26 +0100
> > > > Anthony PERARD <anthony.perard@citrix.com> wrote:
> > > >
> > > > > On Wed, May 29, 2019 at 12:24:44PM +0200, Greg Kurz wrote:
> > > > > > Xen folks are the actual maintainers for this.
> > > > > >
> > > > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > > ---
> > > > > >  MAINTAINERS |    3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > index 1f5f8b7a2c37..d00380641796 100644
> > > > > > --- a/MAINTAINERS
> > > > > > +++ b/MAINTAINERS
> > > > > > @@ -411,7 +411,7 @@ M: Paul Durrant <paul.durrant@citrix.com>
> > > > > >  L: xen-devel@lists.xenproject.org
> > > > > >  S: Supported
> > > > > >  F: */xen*
> > > > > > -F: hw/9pfs/xen-9p-backend.c
> > > > > > +F: hw/9pfs/xen-9p*
> > > > > >  F: hw/char/xen_console.c
> > > > > >  F: hw/display/xenfb.c
> > > > > >  F: hw/net/xen_nic.c
> > > > > > @@ -1505,6 +1505,7 @@ virtio-9p
> > > > > >  M: Greg Kurz <groug@kaod.org>
> > > > > >  S: Supported
> > > > > >  F: hw/9pfs/
> > > > > > +X: hw/9pfs/xen-9p*
> > > > > >  F: fsdev/
> > > > > >  F: tests/virtio-9p-test.c
> > > > > >  T: git https://github.com/gkurz/qemu.git 9p-next
> > > > > >
> > > > >
> > > > > Acked-by: Anthony PERARD <anthony.perard@citrix.com>
> > > > >
> > > > > Thanks,
> > > > >
> > > >
> > > > Ping ?
> > > >
> > > > I'd rather also get an ack from Stefano and Paul before merging this.
> > > >
> > >
> > > Fine by me...
> > >
> > > Acked-by: Paul Durrant <paul.durrant@citrix.com>
> > >
> > 
> > Hi,
> > 
> > I'd prefer to also get an ack from Stefano but it seems that he hasn't posted
> > anything to qemu-devel@ since last January... Any suggestion how I should go
> > forward with this ?
> > 
> 
> Yes, I think it would be prudent to get an ack from Stefano. I'll ping him on IRC and see if I can get a response.

I am still here!

Acked-by: Stefano Stabellini <sstabellini@kernel.org>

