Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BE0C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F722183F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F722183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53556 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbpZn-0001YG-6a
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48391)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hbpQ2-0003io-DF
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hbpPy-0008VR-Rh
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:51:12 -0400
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:46900)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hbpPw-0008PS-Ll
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:51:09 -0400
Received: from player687.ha.ovh.net (unknown [10.109.143.24])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 7C8EE10AC8D
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 18:51:01 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 3EF966D2D0C2;
 Fri, 14 Jun 2019 16:50:56 +0000 (UTC)
Date: Fri, 14 Jun 2019 18:50:54 +0200
From: Greg Kurz <groug@kaod.org>
To: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <20190614185054.6f12ab30@bahia.lan>
In-Reply-To: <alpine.DEB.2.21.1906140844150.2072@sstabellini-ThinkPad-T480s>
References: <155912548463.2019004.3515830305299809902.stgit@bahia.lan>
 <20190529125926.GD2126@perard.uk.xensource.com>
 <20190605121056.0e784daf@bahia.lab.toulouse-stg.fr.ibm.com>
 <c85d973ca2d444678e8fdc86a4cd6f4f@AMSPEX02CL03.citrite.net>
 <20190614101621.098742e2@bahia.lan>
 <c2c63dd46c684b1bb0f2e342a085d93d@AMSPEX02CL03.citrite.net>
 <alpine.DEB.2.21.1906140844150.2072@sstabellini-ThinkPad-T480s>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15020630660099643825
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeiuddguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.40.148
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
 Paul Durrant <Paul.Durrant@citrix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Jun 2019 08:44:26 -0700 (PDT)
Stefano Stabellini <sstabellini@kernel.org> wrote:

> On Fri, 14 Jun 2019, Paul Durrant wrote:
> > > -----Original Message-----
> > > From: Greg Kurz [mailto:groug@kaod.org]
> > > Sent: 14 June 2019 09:16
> > > To: Paul Durrant <Paul.Durrant@citrix.com>
> > > Cc: Anthony Perard <anthony.perard@citrix.com>; qemu-devel@nongnu.org; Stefano Stabellini
> > > <sstabellini@kernel.org>
> > > Subject: Re: [PATCH] MAINTAINERS: Change maintership of Xen code under hw/9pfs
> > > 
> > > On Wed, 5 Jun 2019 10:12:05 +0000
> > > Paul Durrant <Paul.Durrant@citrix.com> wrote:
> > >   
> > > > > -----Original Message-----
> > > > > From: Greg Kurz [mailto:groug@kaod.org]
> > > > > Sent: 05 June 2019 11:11
> > > > > To: Anthony Perard <anthony.perard@citrix.com>
> > > > > Cc: qemu-devel@nongnu.org; Stefano Stabellini <sstabellini@kernel.org>; Paul Durrant
> > > > > <Paul.Durrant@citrix.com>
> > > > > Subject: Re: [PATCH] MAINTAINERS: Change maintership of Xen code under hw/9pfs
> > > > >
> > > > > On Wed, 29 May 2019 13:59:26 +0100
> > > > > Anthony PERARD <anthony.perard@citrix.com> wrote:
> > > > >  
> > > > > > On Wed, May 29, 2019 at 12:24:44PM +0200, Greg Kurz wrote:  
> > > > > > > Xen folks are the actual maintainers for this.
> > > > > > >
> > > > > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > > > ---
> > > > > > >  MAINTAINERS |    3 ++-
> > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > > index 1f5f8b7a2c37..d00380641796 100644
> > > > > > > --- a/MAINTAINERS
> > > > > > > +++ b/MAINTAINERS
> > > > > > > @@ -411,7 +411,7 @@ M: Paul Durrant <paul.durrant@citrix.com>
> > > > > > >  L: xen-devel@lists.xenproject.org
> > > > > > >  S: Supported
> > > > > > >  F: */xen*
> > > > > > > -F: hw/9pfs/xen-9p-backend.c
> > > > > > > +F: hw/9pfs/xen-9p*
> > > > > > >  F: hw/char/xen_console.c
> > > > > > >  F: hw/display/xenfb.c
> > > > > > >  F: hw/net/xen_nic.c
> > > > > > > @@ -1505,6 +1505,7 @@ virtio-9p
> > > > > > >  M: Greg Kurz <groug@kaod.org>
> > > > > > >  S: Supported
> > > > > > >  F: hw/9pfs/
> > > > > > > +X: hw/9pfs/xen-9p*
> > > > > > >  F: fsdev/
> > > > > > >  F: tests/virtio-9p-test.c
> > > > > > >  T: git https://github.com/gkurz/qemu.git 9p-next
> > > > > > >  
> > > > > >
> > > > > > Acked-by: Anthony PERARD <anthony.perard@citrix.com>
> > > > > >
> > > > > > Thanks,
> > > > > >  
> > > > >
> > > > > Ping ?
> > > > >
> > > > > I'd rather also get an ack from Stefano and Paul before merging this.
> > > > >  
> > > >
> > > > Fine by me...
> > > >
> > > > Acked-by: Paul Durrant <paul.durrant@citrix.com>
> > > >  
> > > 
> > > Hi,
> > > 
> > > I'd prefer to also get an ack from Stefano but it seems that he hasn't posted
> > > anything to qemu-devel@ since last January... Any suggestion how I should go
> > > forward with this ?
> > >   
> > 
> > Yes, I think it would be prudent to get an ack from Stefano. I'll ping him on IRC and see if I can get a response.  
> 
> I am still here!
> 

Great ! :)

> Acked-by: Stefano Stabellini <sstabellini@kernel.org>

Thanks !

Markus, Xen maintainers,

All needed Acked-by have been provided. I don't plan to send a 9pfs PR
anytime soon. Can this go through someone else's tree please ?

Cheers,

--
Greg

