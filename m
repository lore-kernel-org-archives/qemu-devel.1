Received: from eggs.gnu.org ([2001:4830:134:3::10]:49016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFnxq-0004h3-2a
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 16:14:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFnxm-0005X5-SF
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 16:14:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFnxm-0005Vw-MC
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 16:14:14 -0500
Date: Fri, 17 Nov 2017 22:14:12 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171117211412.ar4d4z52um2uq7c7@sirius.home.kraxel.org>
References: <mailman.8273.1510914667.27993.qemu-devel@nongnu.org>
	<50461419-2FB0-4A94-A6E6-4EFB459FF39D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50461419-2FB0-4A94-A6E6-4EFB459FF39D@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 02/24] sdl: remove -alt-grab and -ctrl-grab
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Nov 17, 2017 at 11:06:12AM -0500, Programmingkid wrote:
> 
> > With absolute pointer devices such as usb-tablet being widely used
> > mouse grabs (for relative pointing devices) should be rarely needed
> > these days.  So the benefit of the options to configure the hotkey
> > modifiers for grab (and other actions) seems questionable.  Which
> > is expecially true for the -ctrl-grab which isn't handled in the
> > handle_keyup() code.
> 
> So does this mean you are against a patch that would allow the user to
> chose a key to act as a mouse ungrab key?

I don't consider it a top priority, and given there I have lots of other
things to do I most likely wouldn't implement that.  But I wouldn't
object if someone comes up with a sane implementation.

What we have right now is just a big mess though, both in code and the
user interface.  First, these are toplevel command line options.  It
belongs to -display though.  Second, it's two hard-coded names for two
hard-coded variations.  So it's not like you can configure much.  On top
of that the names are not exactly intuitive.  And it works with SDL only.

cheers,
  Gerd
