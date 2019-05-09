Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078F8C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EFA2089E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EFA2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54433 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOixX-0007y6-5E
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:19:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hOiwF-0007Mp-E4
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hOiwE-0006xs-0Z
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:18:19 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:41725)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hOiwD-0006ry-Qp
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:18:17 -0400
Received: from player694.ha.ovh.net (unknown [10.108.35.12])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id D1B00FB092
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 15:18:07 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player694.ha.ovh.net (Postfix) with ESMTPSA id 070C8580A8F1;
	Thu,  9 May 2019 13:18:04 +0000 (UTC)
Date: Thu, 9 May 2019 15:18:04 +0200
From: Greg Kurz <groug@kaod.org>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190509151804.56cd4179@bahia.lan>
In-Reply-To: <2a5ac8c4-60d3-2246-54ca-678ed7a6f988@redhat.com>
References: <155721868351.451636.16735088470797960209.stgit@bahia.lan>
	<155721871721.451636.4261205814714842408.stgit@bahia.lan>
	<2a5ac8c4-60d3-2246-54ca-678ed7a6f988@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2922554684110641458
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrkeeigddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.34.219
Subject: Re: [Qemu-devel] [PATCH 6/6] virtfs: Fix documentation of -fsdev
 and -virtfs
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 May 2019 17:54:42 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 07/05/2019 10.45, Greg Kurz wrote:
> > This fixes several things:
> > - add "id" description to -virtfs documentation
> > - split the description into several lines in both usage and documentation
> >   for accurateness and clarity
> > - add documentation and usage of the synth fsdriver
> > - add "throttling.*" description to -fsdev local
> > - add some missing periods
> > 
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1581976
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  qemu-options.hx |   84 +++++++++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 60 insertions(+), 24 deletions(-)
> > 
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 9c5cc2e6bf70..975342dfbd66 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -1232,26 +1232,35 @@ the write back by pressing @key{C-a s} (@pxref{disk_images}).
> >  ETEXI
> >  
> >  DEF("fsdev", HAS_ARG, QEMU_OPTION_fsdev,
> > -    "-fsdev fsdriver,id=id[,path=path,][security_model={mapped-xattr|mapped-file|passthrough|none}]\n"
> > -    " [,writeout=immediate][,readonly][,socket=socket|sock_fd=sock_fd][,fmode=fmode][,dmode=dmode]\n"
> > +    "-fsdev local,id=id,path=path,security_model=mapped-xattr|mapped-file|passthrough|none\n"
> > +    " [,writeout=immediate][,readonly][,fmode=fmode][,dmode=dmode]\n"
> >      " [[,throttling.bps-total=b]|[[,throttling.bps-read=r][,throttling.bps-write=w]]]\n"
> >      " [[,throttling.iops-total=i]|[[,throttling.iops-read=r][,throttling.iops-write=w]]]\n"
> >      " [[,throttling.bps-total-max=bm]|[[,throttling.bps-read-max=rm][,throttling.bps-write-max=wm]]]\n"
> >      " [[,throttling.iops-total-max=im]|[[,throttling.iops-read-max=irm][,throttling.iops-write-max=iwm]]]\n"
> > -    " [[,throttling.iops-size=is]]\n",
> > +    " [[,throttling.iops-size=is]]\n"
> > +    "-fsdev proxy,id=id,socket=socket[,writeout=immediate][,readonly]\n"
> > +    "-fsdev proxy,id=id,sock_fd=sock_fd[,writeout=immediate][,readonly]\n"
> > +    "-fsdev synth,id=id\n",
> >      QEMU_ARCH_ALL)
> >  
> >  STEXI
> >  
> > -@item -fsdev @var{fsdriver},id=@var{id},path=@var{path},[security_model=@var{security_model}][,writeout=@var{writeout}][,readonly][,socket=@var{socket}|sock_fd=@var{sock_fd}][,fmode=@var{fmode}][,dmode=@var{dmode}]
> > +@item -fsdev local,id=@var{id},path=@var{path},security_model=@var{security_model} [,writeout=@var{writeout}][,readonly][,fmode=@var{fmode}][,dmode=@var{dmode}] [,throttling.@var{option}=@var{value}[,throttling.@var{option}=@var{value}[,...]]]
> > +@itemx -fsdev proxy,id=@var{id},socket=@var{socket}[,writeout=@var{writeout}][,readonly]
> > +@itemx -fsdev proxy,id=@var{id},sock_fd=@var{sock_fd}[,writeout=@var{writeout}][,readonly]
> > +@itemx -fsdev synth,id=@var{id}[,readonly]
> >  @findex -fsdev
> >  Define a new file system device. Valid options are:
> >  @table @option
> > -@item @var{fsdriver}
> > -This option specifies the fs driver backend to use.
> > -Currently "local" and "proxy" file system drivers are supported.
> > +@item local
> > +Accesses to the filesystem are done by QEMU.
> > +@item proxy
> > +Accesses to the filesystem are done by virtfs-proxy-helper(1).
> > +@item synth
> > +Synthetic filesystem, only used by QTests.
> >  @item id=@var{id}
> > -Specifies identifier for this device
> > +Specifies identifier for this device.
> >  @item path=@var{path}
> >  Specifies the export path for the file system device. Files under
> >  this path will be available to the 9p client on the guest.
> > @@ -1279,17 +1288,33 @@ Enables exporting 9p share as a readonly mount for guests. By default
> >  read-write access is given.
> >  @item socket=@var{socket}
> >  Enables proxy filesystem driver to use passed socket file for communicating
> > -with virtfs-proxy-helper
> > +with virtfs-proxy-helper(1).  
> 
> Why did you add a "(1)" after each virtfs-proxy-helper?
> 

Oops forgot to mention that in the changelog... We have a manual page for the
virtfs-proxy-helper command, and IIUC this is the way for a manual page to
reference another one. Makes sense ?

> ... apart from that, the modifications look fine to me (but as mentioned
> earlier, I'm not an expert in this area, so not sure whether that counts
> ;-))
> 

I'm confident about the content, so if this looks fine to you, I'm good :)

>  Thomas


