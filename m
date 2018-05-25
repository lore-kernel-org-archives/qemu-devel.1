Received: from eggs.gnu.org ([2001:4830:134:3::10]:35186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fMCzs-0000FS-NB
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fMCzp-0007pF-Kl
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:43:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60350 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fMCzp-0007p5-G7
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:43:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6F1A4071188
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 13:43:04 +0000 (UTC)
Date: Fri, 25 May 2018 15:43:03 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180525134303.qugv3kiqxjbmumoq@sirius.home.kraxel.org>
References: <20180525092004.13241-1-kraxel@redhat.com>
	<87zi0ot27i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zi0ot27i.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] usb: update docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

> > diff --git a/docs/usb2.txt b/docs/usb2.txt
> > index 09df45b5b1..1b0e62d187 100644
> > --- a/docs/usb2.txt
> > +++ b/docs/usb2.txt
> > @@ -1,6 +1,26 @@
> >  
> > -USB 2.0 Quick Start
> > -===================
> > +USB Quick Start
> 
> Would you like to renamed the file from usb2.txt to usb.txt, too?

Good question.  At least I link to qemu cgit now and then when refering
to qemu documentation.  Renaming the file would break the links ...

> > +===============
> > +
> > +xhci controller support
> > +-----------------------
> > +
> > +Qemu has xhci host adapter support.  The xhci hardware design is much
> > +more virtualization-friendly when compared to ehci and uhci, thus xhci
> > +emulation uses less resources (especially cpu).  So if your guest
> > +supports xhci (which should be the case for any operating system
> > +released in recent years) I recommend using it:
> 
> I'm afraid "recent years" won't age gracefully.  Perhaps "after 2011 or
> so"?

Makes sense.

> > @@ -47,29 +67,15 @@ specifies the first port the controller should attach to, which is
>    Companion controller support
>    ----------------------------
> 
>    Companion controller support has been added recently.  The operational
> 
> For a value of "recently" :)  Rephrase the first sentence?

Well, to be exact pretty much all ehci/uhci text could use a major
rework.  Left that for another day ...

cheers,
  Gerd
