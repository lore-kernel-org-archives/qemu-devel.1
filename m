Received: from eggs.gnu.org ([2001:4830:134:3::10]:33453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dUSzI-0008Ox-Nn
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dUSzF-0000RO-Ib
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dUSzF-0000R2-BN
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:05 -0400
Message-ID: <1499671202.23551.10.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 10 Jul 2017 09:20:02 +0200
In-Reply-To: <a58a7cf7-a079-2799-ac99-696b85ecc654@suse.de>
References: <1499234355-138591-1-git-send-email-agraf@suse.de>
	<87bmozb7hj.fsf@dusky.pond.sub.org>
	<a58a7cf7-a079-2799-ac99-696b85ecc654@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vnc: Set default kbd delay to 10ms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, 2017-07-06 at 09:08 +0200, Alexander Graf wrote:
> 
> On 05.07.17 10:42, Markus Armbruster wrote:
> > Alexander Graf <agraf@suse.de> writes:
> > 
> > > The default keyboard delay time in the input layer is 10ms. I
> > > don't know
> > 
> > Do you mean "is 1ms"?
> 
> Yes, of course :). Sorry.

Given the last paragraph of the commit message 10ms looks correct.  If
you change it to 1ms you also want to change "input layer" to "vnc
server" ...

Or, better, move the last paragraph (which points out the inconsistency
 between input layer and vnc server defaults) to the top, then it's
easier to read I guess.

cheers,
  Gerd

> 
> Alex
> 
> > 
> > > how that number came to be, but empirical tests on some OpenQA
> > > driven ARM
> > > systems show that 10ms really is a reasonable default number for
> > > the delay.
> > > 
> > > With the current 1ms we're constantly typing faster than the
> > > guest receives
> > > keyboard events from our XHCI attached USB HID device.
> > > 
> > > This patch moves the delay to 10ms. That way our default is much
> > > safer (good!)
> > > and also consistent with the input layer default (also good!).
> > > 
> > > Signed-off-by: Alexander Graf <agraf@suse.de>
