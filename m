Received: from eggs.gnu.org ([2001:4830:134:3::10]:43705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cXp8x-0004Rr-V3
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 08:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cXp8s-0003JY-OD
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 08:03:43 -0500
Received: from mo69.mail-out.ovh.net ([178.32.228.69]:48693)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cXp8s-0003JS-HQ
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 08:03:38 -0500
Received: from player798.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 93BB418043
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 14:03:35 +0100 (CET)
Date: Sun, 29 Jan 2017 14:03:29 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170129140329.3646dee3@bahia.lan>
In-Reply-To: <CAC2QTZZaaMgiiJbXgnLzBF+02=XnzKsofP7fwK7oF56maXY8Gg@mail.gmail.com>
References: <1485422212-31546-1-git-send-email-ashijeetacharya@gmail.com>
	<20170128194157.0c82cc8a@bahia.lan>
	<CAC2QTZZaaMgiiJbXgnLzBF+02=XnzKsofP7fwK7oF56maXY8Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migrate: Migration aborts abruptly for
 machine "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Sun, 29 Jan 2017 01:06:47 +0530
Ashijeet Acharya <ashijeetacharya@gmail.com> wrote:

> On Sun, Jan 29, 2017 at 12:11 AM, Greg Kurz <groug@kaod.org> wrote:
> > On Thu, 26 Jan 2017 14:46:52 +0530
> > Ashijeet Acharya <ashijeetacharya@gmail.com> wrote:
> >  
> >> Migration of a "none" machine with no RAM crashes abruptly as
> >> bitmap_new() fails and thus aborts. Instead, place a check for
> >> last_ram_offset() being '0' at the start of ram_save_setup() and
> >> error out with a meaningful error message.
> >>
> >> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> >> ---  
> >  
> 
> cc'ing Paolo in : I had an IRC chat with him and he has a very
> interesting twist in the tale to add here.
> 
> > Maybe a naive question: why a "none" machine with zero RAM should fail to
> > migrate ?  
> 
> Assuming you are referring to why its failing ATM; it fails because

My question was more: why deciding to fail migration instead of fixing the
crash ? One would naively think that no RAM is *just* less state to
migrate... but maybe the current code assumes that a machine always has
RAM.

> g_try_malloc0() inside bitmap_try_new() returns a NULL pointer for
> zero bits and thus the check for NULL inside bitmap_new() becomes true
> and it aborts. Check bitmap_new() for convenience.
> 
> Ignore the noise if you already knew this! :-)
> 

I hadn't checked, thanks for the details.

Cheers.

--
Greg

> Ashijeet
