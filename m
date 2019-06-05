Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F66C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 10:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41649206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 10:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41649206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38600 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYSvN-0002de-I1
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 06:13:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hYSsr-0001Ft-L6
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 06:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hYSsq-0000Xf-AM
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 06:11:05 -0400
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:34864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hYSsq-0000W9-4B
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 06:11:04 -0400
Received: from player718.ha.ovh.net (unknown [10.109.143.232])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 5452F5CD66
	for <qemu-devel@nongnu.org>; Wed,  5 Jun 2019 12:11:01 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player718.ha.ovh.net (Postfix) with ESMTPSA id 8F7336711EF1;
	Wed,  5 Jun 2019 10:10:57 +0000 (UTC)
Date: Wed, 5 Jun 2019 12:10:56 +0200
From: Greg Kurz <groug@kaod.org>
To: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190605121056.0e784daf@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190529125926.GD2126@perard.uk.xensource.com>
References: <155912548463.2019004.3515830305299809902.stgit@bahia.lan>
	<20190529125926.GD2126@perard.uk.xensource.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10751218210659998157
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudegvddgvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.105
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Change maintership of Xen
 code under hw/9pfs
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org,
	Paul Durrant <paul.durrant@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 May 2019 13:59:26 +0100
Anthony PERARD <anthony.perard@citrix.com> wrote:

> On Wed, May 29, 2019 at 12:24:44PM +0200, Greg Kurz wrote:
> > Xen folks are the actual maintainers for this.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  MAINTAINERS |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1f5f8b7a2c37..d00380641796 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -411,7 +411,7 @@ M: Paul Durrant <paul.durrant@citrix.com>
> >  L: xen-devel@lists.xenproject.org
> >  S: Supported
> >  F: */xen*
> > -F: hw/9pfs/xen-9p-backend.c
> > +F: hw/9pfs/xen-9p*
> >  F: hw/char/xen_console.c
> >  F: hw/display/xenfb.c
> >  F: hw/net/xen_nic.c
> > @@ -1505,6 +1505,7 @@ virtio-9p
> >  M: Greg Kurz <groug@kaod.org>
> >  S: Supported
> >  F: hw/9pfs/
> > +X: hw/9pfs/xen-9p*
> >  F: fsdev/
> >  F: tests/virtio-9p-test.c
> >  T: git https://github.com/gkurz/qemu.git 9p-next
> >   
> 
> Acked-by: Anthony PERARD <anthony.perard@citrix.com>
> 
> Thanks,
> 

Ping ?

I'd rather also get an ack from Stefano and Paul before merging this.

Cheers,

--
Greg

