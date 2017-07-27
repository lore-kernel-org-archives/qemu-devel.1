Received: from eggs.gnu.org ([2001:4830:134:3::10]:59490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1daecq-0002Kd-5p
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1daecp-0004RQ-9z
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:58:32 -0400
Received: from manul.sfritsch.de ([2a01:4f8:172:195f:112::2]:43226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1daecp-0004R0-4E
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:58:31 -0400
Date: Thu, 27 Jul 2017 10:58:29 +0200 (CEST)
From: Stefan Fritsch <sf@sfritsch.de>
In-Reply-To: <alpine.DEB.2.11.1707201417270.21661@manul.sfritsch.de>
Message-ID: <alpine.DEB.2.11.1707271056530.31093@manul.sfritsch.de>
References: <1500541371-24788-1-git-send-email-sf@sfritsch.de>
	<1500541371-24788-9-git-send-email-sf@sfritsch.de>
	<CAJ+F1C+F2kKjQWT=tcRBbiYCfb+6FMWmBMOih8XiiB+C2Ov0FA@mail.gmail.com>
	<alpine.DEB.2.11.1707201417270.21661@manul.sfritsch.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [Qemu-devel] [PATCH v2 8/8] usb-ccid: Reduce logging at level
 WARN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Thu, 20 Jul 2017, Stefan Fritsch wrote:

> Thanks for the review.
> 
> On Thu, 20 Jul 2017, Marc-André Lureau wrote:
> 
> > On Thu, Jul 20, 2017 at 11:04 AM Stefan Fritsch <sf@sfritsch.de> wrote:
> > 
> > > From: Stefan Fritsch <stefan_fritsch@genua.de>
> > >
> > > Change all DPRINTF()s using (1 == WARN) to use symbolic
> > > constants. Most of these DPRINTFs are now only logging at higher log
> > > levels.
> > >
> > > This allows to use ccid's debug level 1 == WARN in normal operation.


> > >      case ClassInterfaceRequest | CCID_CONTROL_GET_DATA_RATES:
> > > -        DPRINTF(s, 1, "ccid_control get data rates UNIMPLEMENTED\n");
> > > +        DPRINTF(s, D_INFO, "ccid_control get data rates UNIMPLEMENTED\n");
> > >          p->status = USB_RET_STALL;
> > >          break;
> > >
> > 
> > WARN was quite appropriate for unimplemented code reached, no?
> 
> True. I will re-check if these messages are triggered during normal 
> operation for us.

I don't see them even with WARN. I will make all your suggested adjustions 
in the next version of the patchset.

Cheers,
Stefan
